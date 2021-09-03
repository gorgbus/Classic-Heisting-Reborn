core:module('CoreMissionManager')
core:import('CoreTable')

local level = Global.level_data and Global.level_data.level_id or ''

if level == 'friend' then
	Hooks:PreHook(MissionManager, "_add_script", "turret_get_around", function(self, data)
		for _, element in pairs(data.elements) do
			if element.id == 101233 and element.editor_name == 'normal_hard001' then
				element.values.difficulty_easy_wish = true
				element.values.difficulty_overkill = true
				element.values.difficulty_sm_wish = true
				element.values.difficulty_overkill_145 = true
				element.values.difficulty_overkill_290 = true
			end
			if element.id == 101263 and element.editor_name == 'vhard001' then
				element.values.difficulty_easy_wish = false
				element.values.difficulty_overkill = false
				element.values.difficulty_sm_wish = false
				element.values.difficulty_overkill_145 = false
				element.values.difficulty_overkill_290 = false
			end
			if element.id == 101268 and element.editor_name == 'ovk_mayhem' then
				element.values.difficulty_easy_wish = false
				element.values.difficulty_overkill = false
				element.values.difficulty_sm_wish = false
				element.values.difficulty_overkill_145 = false
				element.values.difficulty_overkill_290 = false
			end
			if element.id == 101379 and element.editor_name == 'sm' then
				element.values.difficulty_easy_wish = false
				element.values.difficulty_overkill = false
				element.values.difficulty_sm_wish = false
				element.values.difficulty_overkill_145 = false
				element.values.difficulty_overkill_290 = false
			end
		end
	end)
end
