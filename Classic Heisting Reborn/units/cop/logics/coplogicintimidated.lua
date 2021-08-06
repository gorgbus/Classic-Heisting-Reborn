function CopLogicIntimidated._start_action_hands_up(data)
	local my_data = data.internal_data
	local anim_name = "hands_up"
	local action_data = {
		clamp_to_graph = true,
		type = "act",
		body_part = 1,
		variant = anim_name,
		blocks = {
			light_hurt = -1,
			hurt = -1,
			heavy_hurt = -1,
			walk = -1
		}
	}
	my_data.act_action = data.unit:brain():action_request(action_data)
end

function CopLogicIntimidated._chk_begin_alarm_pager(data)
end