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
	local hostages = managers.groupai:state():police_hostage_count()
	local hostages_allowed = 0
	for u_key, u_data in pairs(managers.groupai:state():all_player_criminals()) do
		if u_data.unit:base().is_local_player then
			if managers.player:has_category_upgrade("player", "intimidate_enemies") then
				hostages_allowed = hostages_allowed + 1
			end
		elseif u_data.unit:base():upgrade_value("player", "intimidate_enemies") then
			hostages_allowed = hostages_allowed + 1
		end
	end

	if hostages > hostages_allowed then
		if not managers.job:current_job_id() == "pal" then
			data.brain:begin_alarm_pager()
		end
	end
end