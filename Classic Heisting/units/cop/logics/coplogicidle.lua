function CopLogicIdle._chk_relocate( data )
	if data.objective and data.objective.type == "follow" then
		
		if data.is_converted then
			if TeamAILogicIdle._check_should_relocate( data, data.internal_data, data.objective ) then
				data.objective.in_place = nil
				CopLogicIdle._exit( data.unit, "travel" )
				return true
			end
			return
		end
		
		local relocate
		local follow_unit = data.objective.follow_unit
		
		local advance_pos = follow_unit:brain() and follow_unit:brain():is_advancing()
		local follow_unit_pos = advance_pos or data.m_pos
		
		if data.objective.relocated_to and mvector3.equal( data.objective.relocated_to, follow_unit_pos ) then
			-- we have already relocated to this pos
			return
		end
		
		if data.objective.distance and data.objective.distance < mvector3.distance(data.m_pos, follow_unit_pos) then
			--print( "relocating due to distance" )
			relocate = true
		end
		
		if not relocate then
			local ray_params = {
				tracker_from = data.unit:movement():nav_tracker(),
				pos_to = follow_unit_pos
			}
			local ray_res = managers.navigation:raycast( ray_params )
			if ray_res then
				--print( "relocating due to obstacle" )
				relocate = true
			end
		end
		if relocate then
			data.objective.in_place = nil
			data.objective.nav_seg = follow_unit:movement():nav_tracker():nav_segment()
			data.objective.relocated_to = mvector3.copy( follow_unit_pos )
			CopLogicBase._exit( data.unit, "travel" )
			return true
		end
	end
end

function CopLogicIdle.on_intimidated(data, amount, aggressor_unit)
    local surrender = false
    local my_data = data.internal_data
    data.t = TimerManager:game():time()
    if not aggressor_unit:movement():team().foes[data.unit:movement():team().id] then
        return
    end
    if managers.groupai:state():has_room_for_police_hostage() then
        local i_am_special = managers.groupai:state():is_enemy_special(data.unit)
        local required_skill = i_am_special and "intimidate_specials" or "intimidate_enemies"
        local aggressor_can_intimidate
        local aggressor_intimidation_mul = 1
        if aggressor_unit:base().is_local_player then
            log("can intimidate? " .. tostring(aggressor_can_intimidate))
            aggressor_can_intimidate = managers.player:has_category_upgrade("player", required_skill)
            aggressor_intimidation_mul = aggressor_intimidation_mul * managers.player:upgrade_value("player", "empowered_intimidation_mul", 1) * managers.player:upgrade_value("player", "intimidation_multiplier", 1)
        else
            aggressor_can_intimidate = aggressor_unit:base():upgrade_value("player", required_skill)
            aggressor_intimidation_mul = aggressor_intimidation_mul * (aggressor_unit:base():upgrade_value("player", "empowered_intimidation_mul") or 1) * (aggressor_unit:base():upgrade_value("player", "intimidation_multiplier") or 1)
        end
        print("aggressor_can_intimidate", aggressor_can_intimidate, "required_skill", required_skill, "is_local_player", aggressor_unit:base().is_local_player)
        if aggressor_can_intimidate then
            local hold_chance = CopLogicBase._evaluate_reason_to_surrender(data, my_data, aggressor_unit)
            if hold_chance then
				--suggested and done by MiamiCenter
                if managers.player:has_category_upgrade("player", "intimidate_range_mul") and managers.groupai:state():whisper_mode() then
                  hold_chance = hold_chance * 0.5
                end
				--

                hold_chance = hold_chance ^ aggressor_intimidation_mul
                if hold_chance >= 1 then
                else
                    local rand_nr = math.random()
                    print("and the winner is: hold_chance", hold_chance, "rand_nr", rand_nr, "rand_nr > hold_chance", hold_chance < rand_nr)
                    if hold_chance < rand_nr then
                        surrender = true
                    end
                end
            end
        end
        if surrender then
            CopLogicIdle._surrender(data, amount, aggressor_unit)
        else
            data.unit:brain():on_surrender_chance()
        end
    end
    CopLogicBase.identify_attention_obj_instant(data, aggressor_unit:key())
    managers.groupai:state():criminal_spotted(aggressor_unit)
    return surrender
end