local math_random = math.random

local react_combat = AIAttentionObject.REACT_COMBAT

Hooks:PostHook(CopLogicAttack, "_upd_combat_movement", "RR_upd_combat_movement", function(data)
	local chatter = data.char_tweak.chatter
	if chatter and data.internal_data.flank_cover and chatter.look_for_angle and not data.is_converted then
		managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, "look_for_angle") -- I'll try and flank 'em!
	end
end)

Hooks:PostHook(CopLogicAttack, "_chk_request_action_walk_to_cover_shoot_pos", "RR_chk_request_action_walk_to_cover_shoot_pos", function(data)
	local chatter = data.char_tweak.chatter
	if chatter and (chatter.push or chatter.go_go) and not data.is_converted and data.internal_data.advancing then
		managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, math_random() > 0.5 and "push" or "go_go") -- Puuuush! / Go, Go!
	end
end)

Hooks:PreHook(CopLogicAttack, "action_complete_clbk", "RR_action_complete_clbk", function(data, action)
	local chatter = data.char_tweak.chatter
	if action:type() == "walk" and data.internal_data.moving_to_cover and action:expired() and chatter and (chatter.inpos or chatter.ready) and not data.is_converted then
		managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, math_random() > 0.5 and "ready" or "inpos") -- Ready! / I'm in position!
	end
end)

function CopLogicAttack.aim_allow_fire(shoot, aim, data, my_data) -- doesn't really work as a posthook
	local focus_enemy = data.attention_obj

	if shoot then
		if not my_data.firing then
			data.unit:movement():set_allow_fire(true)

			my_data.firing = true

			local chatter = data.char_tweak.chatter
			if not data.unit:in_slot(16) and not data.is_converted and chatter and chatter.aggressive then
				if not data.unit:base():has_tag("special") then 
					if data.unit:base():has_tag("law") and data.unit:base()._tweak_table ~= "gensec" and data.unit:base()._tweak_table ~= "security" then
						if managers.groupai:state():chk_assault_active_atm() and chatter.open_fire then
							managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, "open_fire")
						else
							managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, "aggressive")
						end
					end
				elseif not data.unit:base():has_tag("tank") and data.unit:base():has_tag("medic") then
					managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, "aggressive")
				elseif data.unit:base():has_tag("shield") and (not my_data.shield_knock_cooldown or my_data.shield_knock_cooldown < data.t) then
					if tweak_data:difficulty_to_index(Global.game_settings.difficulty) >= 8 then
						data.unit:sound():play("hos_shield_indication_sound_terminator_style", nil, true)
					else
						data.unit:sound():play("shield_identification", nil, true)
					end

					my_data.shield_knock_cooldown = data.t + math_random(6, 12)
				else
					managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, "contact")
				end
			end
		end
	elseif my_data.firing then
		data.unit:movement():set_allow_fire(false)

		my_data.firing = nil
	end
end

local excluded_deployables = {
	["trip_mine"] = true,
	["sentry"] = true,
	["sentry_gun_silent"] = true,
}

Hooks:PostHook(CopLogicAttack, "_upd_aim", "RR_upd_aim", function(data)
	local focus_enemy = data.attention_obj
	local chatter = data.char_tweak.chatter
	if chatter and focus_enemy and react_combat <= focus_enemy.reaction and focus_enemy.verified and not data.unit:in_slot(16) and not data.is_converted then
		if focus_enemy.is_person then 
			if chatter.reload and (focus_enemy.is_local_player and focus_enemy.unit:movement():current_state():_is_reloading() or focus_enemy.is_husk_player and focus_enemy.unit:anim_data().reload) then
				managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, "reload")
			else 		
				local equipment = managers.criminals:character_peer_id_by_unit(focus_enemy.unit)
				equipment = equipment and managers.player:get_synced_deployable_equipment(equipment)
				if equipment and equipment.deployable and equipment.amount > 0 and chatter[equipment.deployable] and not excluded_deployables[equipment.deployable] then
					managers.groupai:state():chk_say_enemy_chatter(data.unit, data.m_pos, equipment.deployable)
				end
			end
		end
	end
end)