function ExperienceManager:get_job_xp_by_stars(stars)
	local job_completion = {
		7500,
		10000,
		15000,
		20000,
		25000,
		30000,
		40000
	}
	
	local amount = 0

	if _G.ch_settings.settings.lower_grind then
		amount = tweak_data:get_value("experience_manager", "job_completion", stars)
	else
		amount = job_completion[stars]
	end
	return amount
end

function ExperienceManager:get_stage_xp_by_stars(stars)
	local amount = tweak_data:get_value("experience_manager", "stage_completion", stars)
	return amount
end

function ExperienceManager:get_xp_by_params(params)
	local job_id = params.job_id
	local job_stars = params.job_stars or 0
	local difficulty_stars = params.difficulty_stars or params.risk_stars or 0
	local job_and_difficulty_stars = job_stars + difficulty_stars
	local success = params.success
	local num_winners = params.num_winners or 1
	local on_last_stage = params.on_last_stage
	local personal_win = params.personal_win
	local player_stars = params.player_stars or managers.experience:level_to_stars() or 0
	local level_id = params.level_id or false
	local ignore_heat = params.ignore_heat
	local current_job_stage = params.current_stage or 1
	local pro_job_multiplier = params.professional and tweak_data:get_value("experience_manager", "pro_job_multiplier") or 1
	local days_multiplier = 1 --params.professional and tweak_data:get_value("experience_manager", "pro_day_multiplier", current_job_stage) or tweak_data:get_value("experience_manager", "day_multiplier", current_job_stage)
	local ghost_multiplier = 1 + (managers.job:get_ghost_bonus() or 0)
	local total_stars = math.min(job_stars, player_stars)
	local total_difficulty_stars = difficulty_stars
	local xp_multiplier = managers.experience:get_contract_difficulty_multiplier(total_difficulty_stars)
	local contract_xp = 0
	local total_xp = 0
	local stage_xp_dissect = 0
	local job_xp_dissect = 0
	local level_limit_dissect = 0
	local risk_dissect = 0
	local failed_level_dissect = 0
	local personal_win_dissect = 0
	local alive_crew_dissect = 0
	local skill_dissect = 0
	local base_xp = 0
	local days_dissect = 0
	local job_heat_dissect = 0
	local base_heat_dissect = 0
	local risk_heat_dissect = 0
	local ghost_dissect = 0
	local ghost_base_dissect = 0
	local ghost_risk_dissect = 0
	local infamy_dissect = 0
	local extra_bonus_dissect = 0
	local gage_assignment_dissect = 0
	local bonus_mutators_dissect = 0
	local mission_xp_dissect = 0
	if _G.ch_settings.settings.lower_grind then
		days_multiplier = params.professional and tweak_data:get_value("experience_manager", "pro_day_multiplier", current_job_stage) or tweak_data:get_value("experience_manager", "day_multiplier", current_job_stage)
	else
		local pro_day_multiplier = {
			1.25,
			2.25,
			2.75,
			5.5,
			7,
			8.5,
			10
		}
		days_multiplier = params.professional and pro_day_multiplier[current_job_stage] or tweak_data:get_value("experience_manager", "day_multiplier", current_job_stage)
	end

	if success and on_last_stage then
		job_xp_dissect = managers.experience:get_job_xp_by_stars(total_stars)
		level_limit_dissect = level_limit_dissect + managers.experience:get_job_xp_by_stars(job_stars)
	end

	local static_stage_experience = level_id and tweak_data.levels[level_id].static_experience
	static_stage_experience = static_stage_experience and static_stage_experience[difficulty_stars + 1]
	stage_xp_dissect = static_stage_experience or managers.experience:get_stage_xp_by_stars(total_stars)
	level_limit_dissect = level_limit_dissect + (static_stage_experience or managers.experience:get_stage_xp_by_stars(job_stars))
	base_xp = job_xp_dissect + stage_xp_dissect
	
	days_dissect = math.round(base_xp * days_multiplier - base_xp)
	local is_level_limited = job_stars > player_stars
	if is_level_limited then
		local diff_in_stars = job_stars - player_stars
		local days_tweak_multiplier = tweak_data:get_value("experience_manager", "day_multiplier", current_job_stage)
		local tweak_multiplier = tweak_data:get_value("experience_manager", "level_limit", "pc_difference_multipliers", diff_in_stars) or 0
		days_multiplier = (days_multiplier - days_tweak_multiplier) * tweak_multiplier + days_tweak_multiplier
	end

	level_limit_dissect = math.round(base_xp * days_multiplier - base_xp)
	level_limit_dissect = math.round(level_limit_dissect - days_dissect)
	base_xp = base_xp + days_dissect + level_limit_dissect
	risk_dissect = math.round(base_xp * xp_multiplier)
	contract_xp = base_xp + risk_dissect
	if not success then
		local multiplier = tweak_data:get_value("experience_manager", "stage_failed_multiplier") or 1
		failed_level_dissect = math.round(contract_xp * multiplier - contract_xp)
		contract_xp = contract_xp + failed_level_dissect
	elseif not personal_win then
		local multiplier = tweak_data:get_value("experience_manager", "in_custody_multiplier") or 1
		personal_win_dissect = math.round(contract_xp * multiplier - contract_xp)
		contract_xp = contract_xp + personal_win_dissect
	end

	total_xp = contract_xp
	local total_contract_xp = total_xp
	local multiplier = managers.player:get_skill_exp_multiplier(managers.groupai and managers.groupai:state():whisper_mode())
	skill_dissect = math.round(total_contract_xp * multiplier - total_contract_xp)
	total_xp = total_xp + skill_dissect
	local bonus_xp = managers.player:get_infamy_exp_multiplier()
	infamy_dissect = math.round(total_contract_xp * bonus_xp - total_contract_xp)
	total_xp = total_xp + infamy_dissect
	bonus_xp = tweak_data:get_value("experience_manager", "limited_bonus_multiplier") or 1
	extra_bonus_dissect = math.round(total_contract_xp * bonus_xp - total_contract_xp)
	total_xp = total_xp + extra_bonus_dissect
	if success then
		local num_players_bonus = num_winners and tweak_data:get_value("experience_manager", "alive_humans_multiplier", num_winners) or 1
		alive_crew_dissect = math.round(total_contract_xp * num_players_bonus - total_contract_xp)
		total_xp = total_xp + alive_crew_dissect
	end

	bonus_xp = managers.gage_assignment:get_current_experience_multiplier()
	gage_assignment_dissect = math.round(total_contract_xp * bonus_xp - total_contract_xp)
	total_xp = total_xp + gage_assignment_dissect
	ghost_dissect = math.round(total_xp * ghost_multiplier - total_xp)
	total_xp = total_xp + ghost_dissect
	local heat_xp_mul = ignore_heat and 1 or math.max(managers.job:get_job_heat_multipliers(job_id), 0)
	job_heat_dissect = math.round(total_xp * heat_xp_mul - total_xp)
	total_xp = total_xp + job_heat_dissect
	local dissection_table = {
		bonus_risk = math.round(risk_dissect),
		bonus_num_players = math.round(alive_crew_dissect),
		bonus_failed = math.round(failed_level_dissect),
		bonus_low_level = math.round(level_limit_dissect),
		bonus_skill = math.round(skill_dissect),
		bonus_days = math.round(days_dissect),
		bonus_pro_job = math.round(0),
		bonus_infamy = math.round(infamy_dissect),
		bonus_extra = math.round(extra_bonus_dissect),
		in_custody = math.round(personal_win_dissect),
		heat_xp = math.round(job_heat_dissect),
		bonus_ghost = math.round(ghost_dissect),
		bonus_gage_assignment = math.round(gage_assignment_dissect),
		bonus_mission_xp = math.round(0),
		bonus_mutators = math.round(bonus_mutators_dissect),
		stage_xp = math.round(stage_xp_dissect),
		job_xp = math.round(job_xp_dissect),
		base = math.round(base_xp),
		total = math.round(total_xp),
		last_stage = on_last_stage
	}
	if Application:production_build() then
		local rounding_error = dissection_table.total - (dissection_table.stage_xp + dissection_table.job_xp + dissection_table.bonus_risk + dissection_table.bonus_num_players + dissection_table.bonus_failed + dissection_table.bonus_skill + dissection_table.bonus_days + dissection_table.heat_xp + dissection_table.bonus_ghost + dissection_table.bonus_gage_assignment)
		dissection_table.rounding_error = rounding_error
	else
		dissection_table.rounding_error = 0
	end

	return math.round(total_xp), dissection_table
end

function ExperienceManager:gui_string(level, rank, offset)
	offset = offset or 0
	local rank_string = rank > 0 and self:rank_string(rank) or ""
	local gui_string
	if rank > 0 then
		gui_string =  rank_string .."-" .. tostring(level)
	else
		gui_string =  tostring(level)
	end
	

	return gui_string
end