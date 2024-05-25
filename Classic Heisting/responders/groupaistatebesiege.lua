local math_random = math.random

function GroupAIStateBesiege:chk_has_civilian_hostages()
	return self._hostage_headcount - self._police_hostage_headcount > 0
end

function GroupAIStateBesiege:chk_had_hostages()
	return self._had_hostages
end

function GroupAIStateBesiege:chk_assault_active_atm()
	local assault_task = self._task_data.assault
	return assault_task and (assault_task.phase == "build" or assault_task.phase == "sustain" or assault_task.phase == "fade")
end
	
-- Assault/Rescue team going in lines
function GroupAIStateBesiege:_voice_groupentry(group, recon)
	local group_leader_u_key, group_leader_u_data = self._determine_group_leader(group.units)
	if group_leader_u_data and group_leader_u_data.char_tweak.chatter.entry then
		self:chk_say_enemy_chatter(group_leader_u_data.unit, group_leader_u_data.m_pos, (recon and "hrt" or "cs") .. math_random(1, 4))
	end
end

Hooks:PreHook(GroupAIStateBesiege, "_set_objective_to_enemy_group", "RR_set_objective_to_enemy_group", function(self, group, grp_objective)
	if group.objective.type == "assault_area" and grp_objective.type == "retire" then -- current objective is assault_area and new objective is retire
		local group_leader_u_key, group_leader_u_data = self._determine_group_leader(group.units)
		if group_leader_u_data and group_leader_u_data.char_tweak.chatter.retreat then
			self:chk_say_enemy_chatter(group_leader_u_data.unit, group_leader_u_data.m_pos, "retreat") -- declare our retreat if we were assaulting but now retiring
		end
	end
end)

Hooks:PostHook(GroupAIStateBesiege, "_perform_group_spawning", "RR_perform_group_spawning", function(self, spawn_task)
	if spawn_task.group.has_spawned then
		self:_voice_groupentry(spawn_task.group, spawn_task.group.objective.type == "recon_area") -- so it doesn't depend on setting this up in groupaitweakdata anymore as well as being more accurate to the group's actual intent
	end
end)

Hooks:PostHook(GroupAIStateBesiege, "_end_regroup_task", "RR_end_regroup_task", function(self)
	self._had_hostages = self._hostage_headcount > 3
end)

function GroupAIStateBesiege:_voice_open_fire_start(group)
	for u_key, unit_data in pairs(group.units) do
		if unit_data.char_tweak.chatter.open_fire and self:chk_say_enemy_chatter(unit_data.unit, unit_data.m_pos, "open_fire") then
			break
		end
	end
end

function GroupAIStateBesiege:_voice_saw(dead_unit)
	local dead_unit_u_key = dead_unit:key()
	local group = self._police[dead_unit_u_key] and self._police[dead_unit_u_key].group
	if group then
		for u_key, unit_data in pairs(group.units) do
			if dead_unit_u_key ~= u_key and unit_data.char_tweak.chatter.saw and self:chk_say_enemy_chatter(unit_data.unit, unit_data.m_pos, "saw") then
				break
			end
		end
	end
end

function GroupAIStateBesiege:_voice_trip_mine(dead_unit)
	local dead_unit_u_key = dead_unit:key()
	local group = self._police[dead_unit_u_key] and self._police[dead_unit_u_key].group
	if group then
		for u_key, unit_data in pairs(group.units) do
			if dead_unit_u_key ~= u_key and unit_data.char_tweak.chatter.trip_mine and self:chk_say_enemy_chatter(unit_data.unit, unit_data.m_pos, "trip_mine") then
				break
			end
		end
	end
end

function GroupAIStateBesiege:_voice_sentry(dead_unit)
	local dead_unit_u_key = dead_unit:key()
	local group = self._police[dead_unit_u_key] and self._police[dead_unit_u_key].group
	if group then
		for u_key, unit_data in pairs(group.units) do
			if dead_unit_u_key ~= u_key and unit_data.char_tweak.chatter.sentry and self:chk_say_enemy_chatter(unit_data.unit, unit_data.m_pos, "sentry") then
				break
			end
		end
	end
end