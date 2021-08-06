function CivilianLogicSurrender.on_tied(data, aggressor_unit, not_tied, can_flee)
	local my_data = data.internal_data
	if data.is_tied then
		return
	end

	data.cannot_flee = not can_flee

	if not_tied then
		if data.has_outline then
			data.unit:contour():remove("highlight")
			data.has_outline = nil
		end
		data.unit:inventory():destroy_all_items()
		if my_data.interaction_active then
			data.unit:interaction():set_active(false, true)
			my_data.interaction_active = nil
		end
		data.unit:character_damage():drop_pickup()
		data.unit:character_damage():set_pickup(nil)
	else
		local action_data = {
			type = "act",
			body_part = 1,
			variant = "tied",
			blocks = {
				light_hurt = -1,
				hurt = -1,
				heavy_hurt = -1,
				hurt_sick = -1,
				walk = -1
			}
		}
		local action_res = data.unit:brain():action_request(action_data)
		if action_res then
			managers.groupai:state():on_hostage_state(true, data.key, nil, nil)
			my_data.is_hostage = true
			data.is_tied = true
			my_data.aggressor_id = aggressor_unit:base():id()

			data.unit:interaction():set_tweak_data("hostage_move")
			data.unit:interaction():set_active(true, true)

			if data.has_outline then
				data.unit:contour():remove("highlight")
				data.has_outline = nil
			end

			data.unit:inventory():destroy_all_items()
			managers.groupai:state():on_civilian_tied(data.unit:key())
			data.unit:base():set_slot(data.unit, 22)

			if data.unit:movement() then
				data.unit:movement():remove_giveaway()
			end

			if my_data.interaction_active then
				data.unit:interaction():set_active(false, true)
				my_data.interaction_active = nil
			end

			data.unit:character_damage():drop_pickup()
			data.unit:character_damage():set_pickup(nil)

			if data.unit:unit_data().mission_element then
				data.unit:unit_data().mission_element:event("tied", data.unit)
			end

			CivilianLogicFlee._chk_add_delayed_rescue_SO(data, my_data)

			if aggressor_unit == managers.player:player_unit() then
				managers.statistics:tied({
					name = data.unit:base()._tweak_table
				})
			else
				aggressor_unit:network():send_to_unit({
					"statistics_tied",
					data.unit:base()._tweak_table
				})
			end

			managers.groupai:state():on_criminal_suspicion_progress(nil, data.unit, nil)
		end
	end
end