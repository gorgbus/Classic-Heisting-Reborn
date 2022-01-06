local level = Global.level_data and Global.level_data.level_id or ''

core:module("CoreElementUnitSequence")
core:import("CoreMissionScriptElement")
core:import("CoreCode")
core:import("CoreUnit")

ElementUnitSequence = ElementUnitSequence or class(CoreMissionScriptElement.MissionScriptElement)

local ElementUnitSequence_on_executed_orig = ElementUnitSequence.on_executed
function ElementUnitSequence:on_executed(...)
	if self._values.enabled then
		if level == "family" then
			if self._id == 102211 then
				return
			end
        elseif level == "welcome_to_the_jungle_1" or level == "welcome_to_the_jungle_1_night" then
			if self._id == 101301 then
				return
			end
        elseif level == "four_stores" then
			if self._id == 103683 then
				return
			end
        end
	end
	ElementUnitSequence_on_executed_orig(self, ...)
end