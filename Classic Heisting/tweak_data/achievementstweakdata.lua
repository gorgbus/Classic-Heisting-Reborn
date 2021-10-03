local tracking = {
	second = "second",
	realtime = "realtime",
	rarely = "rarely"
}

local function from_crimespree_item(item)
	return {
		get = function ()
			local rtn = managers.crime_spree:spree_level()

			return rtn == -1 and 0 or rtn
		end,
		max = item.level,
		update = tracking.realtime
	}
end

local function from_owned_weapons(num)
	if not num then
		error()
	end

	return {
		persistent = true,
		get = function ()
			return table.size(managers.blackmarket:get_crafted_category("primaries")) + table.size(managers.blackmarket:get_crafted_category("secondaries"))
		end,
		max = num,
		update = tracking.rarely
	}
end

local function from_timed_memory(item, memory_name, count_name)
	count_name = count_name or "count"

	if not memory_name or not item or not item[count_name] then
		error()
	end

	return {
		get = function ()
			local mem = managers.job:get_memory(memory_name, true) or {}
			local t = Application:time()

			return table.count(mem, function (time)
				return t - time < item.timer
			end)
		end,
		max = item[count_name],
		update = tracking.realtime
	}
end

local function from_level(level)
	if not level then
		error()
	end

	return {
		persistent = true,
		get = function ()
			return managers.experience:current_level()
		end,
		max = level,
		update = tracking.realtime
	}
end

local function get_texture_path(tweak_data, category, id)
	local td = nil
	local rtn = {}

	if category == "armor_skins" then
		td = tweak_data.economy.armor_skins[id]
	elseif category == "suit_variations" then
		local player_style = id[1]
		local suit_variation = id[2]
		local ps_td = tweak_data:get_raw_value("blackmarket", "player_styles", player_style)
		local sv_td = ps_td.material_variations and ps_td.material_variations[suit_variation]
		td = sv_td and (sv_td.texture_bundle_folder and sv_td or ps_td)
	else
		td = tweak_data:get_raw_value("blackmarket", category, id)
	end

	if category == "textures" then
		rtn.texture = td.texture
		rtn.render_template = "VertexColorTexturedPatterns"
	else
		local guis_catalog = "guis/"

		if category == "armor_skins" then
			rtn.texture = guis_catalog .. "armor_skins/" .. id
		elseif category == "weapon_skins" then
			rtn.texture = guis_catalog .. "textures/pd2/blackmarket/icons/" .. (td.is_a_color_skin and "weapon_color" or "weapon_skins") .. "/" .. id
		elseif category == "suit_variations" then
			local player_style = id[1]
			local suit_variation = id[2]
			rtn.texture = guis_catalog .. "textures/pd2/blackmarket/icons/player_styles/" .. player_style .. "_" .. suit_variation
		else
			rtn.texture = guis_catalog .. "textures/pd2/blackmarket/icons/" .. (category == "weapon_mods" and "mods" or category) .. "/" .. id
		end
	end

	if not DB:has(Idstring("texture"), Idstring(rtn.texture)) then
		Application:error("ERROR MISSING TEXTURE:", rtn.texture)

		rtn.texture = "guis/textures/pd2/endscreen/exp_ring"
	end

	return rtn
end

local function from_complete_heist_stats_item(self, item)
	local heists = nil

	if item.contact == "all" then
		local lists = table.map_values(self.job_list)
		heists = table.list_union(unpack(lists))
	else
		heists = table.list_copy(self.job_list[item.contact])
	end

	local function get_todo()
		local res = table.list_to_set(heists)

		for _, job in pairs(heists) do
			for _, difficulty in ipairs(item.difficulty) do
				if managers.statistics:completed_job(job, difficulty, item.one_down) > 0 then
					res[job] = nil

					break
				end
			end
		end

		return table.map_keys(res)
	end

	return {
		persistent = true,
		is_list = true,
		get_todo_list = get_todo,
		get = function ()
			return #heists - #get_todo()
		end,
		checklist = heists,
		max = #heists,
		update = tracking.rarely
	}
end

function AchievementsTweakData:_init_visual(tweak_data)
	self.tags = {
		progress = {
			"leveling",
			"beginner",
			"completion",
			"heisting",
			"generic"
		},
		contracts = {
			"all"
		},
		difficulty = {
			"normal",
			"hard",
			"very_hard",
			"overkill",
			"mayhem",
			"death_wish",
			"death_sentence"
		},
		unlock = {
			"mask",
			"weapon",
			"skill_slot",
			"character"
		},
		tactics = {
			"loud",
			"stealth",
			"killer",
			"timed"
		},
		inventory = {
			"mask",
			"weapon",
			"armor",
			"skill",
			"equipment"
		},
		teamwork = {
			"players_1_to_4",
			"players_4"
		}
	}

	table.insert(self.tags.unlock, "outfit")
	table.insert(self.tags.unlock, "weapon_color")
	table.insert(self.tags.unlock, "gloves")

	local contacts = {}

	for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local contact = tweak_data.narrative:job_data(job_id).contact

		if contact ~= "wip" and contact ~= "tests" and not table.contains(self.tags.contracts, contact) then
			table.insert(self.tags.contracts, contact)
		end
	end

	for cat_name, cat in pairs(self.tags) do
		local converted = {}

		for _, tag in pairs(cat) do
			converted[tag] = cat_name .. "_" .. tag
		end

		self.tags[cat_name] = converted
	end

	self.visual = init_auto_generated_achievement_data(self.tags)

	self:_init_non_auto_generated(tweak_data)

	for stat, unlocks in pairs(self.persistent_stat_unlocks) do
		for _, v in pairs(unlocks) do
			local data = self.visual[v.award]

			if not data then
				Application:error("Achievement visual data for '" .. v.award .. "' doesn't exists! (achievement was found in 'persistent_stat_unlocks')")
			elseif type(data.progress) ~= "table" then
				data.progress = {
					persistent = true,
					get = function ()
						return managers.achievment:get_stat(stat)
					end,
					max = v.at,
					update = tracking.second
				}
			end
		end
	end

	for name, data in pairs(tweak_data.dlc) do
		local visual = data.achievement_id and self.visual[data.achievement_id]

		if visual then
			if visual.need_unlock_icons == false then
				visual.need_unlock_icons = nil
			else
				visual.need_unlock_icons = nil
				visual.unlock_icons = visual.unlock_icons or {}
				visual.unlock_id = visual.unlock_id or true

				for _, loot in pairs(data.content.loot_drops or {}) do
					local tex_data = get_texture_path(tweak_data, loot.type_items, loot.item_entry)
					

					if not table.contains(visual.unlock_icons, tex_data) then
						tex_data.type_items = loot.type_items
						tex_data.original_order = #visual.unlock_icons + 1

						table.insert(visual.unlock_icons, tex_data)
					end
				end

				local sort_order = {
					"characters",
					"weapon_mods",
					"weapon_skins",
					"masks",
					"player_styles",
					"gloves",
					"melee_weapons",
					"materials",
					"textures"
				}

				table.sort(visual.unlock_icons, function (lhs, rhs)
					local l = table.index_of(sort_order, lhs.type_items)
					local r = table.index_of(sort_order, rhs.type_items)

					if l == r then
						return lhs.original_order < rhs.original_order
					elseif not l or not r then
						return l
					end

					return l < r
				end)
			end
		elseif data.achievement_id then
			for _, loot in pairs(data.content.loot_drops) do
				get_texture_path(tweak_data, loot.type_items, loot.item_entry)
			end
		end
	end

	for name, data in pairs(self.visual) do
		data.name_id = data.name_id or "achievement_" .. name
		data.desc_id = data.desc_id or "achievement_" .. name .. "_desc"
		data.additional_id = data.additional_id == true and "achievement_" .. name .. "_additional" or data.additional_id
		data.unlock_id = data.unlock_id == true and "achievement_" .. name .. "_unlock" or data.unlock_id
		data.icon_id = data.icon_id or data.sort_name
	end
end

function AchievementsTweakData:_init_non_auto_generated(tweak_data)
	self.visual.bulldog_1.unlock_icons = {
		{
			type_items = "characters",
			type_index = -1,
			original_order = -1,
			texture = "guis/dlcs/trk/textures/pd2/old_hoxton_unlock_icon"
		},
		table.map_append({
			type_items = "melee_weapons",
			type_index = 99,
			original_order = 0
		}, get_texture_path(tweak_data, "melee_weapons", "toothbrush"))
	}
	self.visual.frog_1.unlock_icons = {
		{
			type_items = "kill_slot",
			texture = "guis/dlcs/trk/textures/pd2/skills_slot_unlock_icon"
		}
	}
	self.visual.armored_2.need_unlock_icons = false
	self.visual.fin_1.need_unlock_icons = false

	for k, v in pairs(self.complete_heist_stats_achievements) do
		if v.award and self.visual[v.award] then
			self.visual[v.award].progress = from_complete_heist_stats_item(self, v)
		end
	end

	self.visual.armed_and_dangerous.progress = from_level(self.level_achievements.armed_and_dangerous.level)
	self.visual.big_shot.progress = from_level(self.level_achievements.big_shot.level)
	self.visual.gone_in_30_seconds.progress = from_level(self.level_achievements.gone_in_30_seconds.level)
	self.visual.guilty_of_crime.progress = from_level(self.level_achievements.guilty_of_crime.level)
	self.visual.most_wanted.progress = from_level(self.level_achievements.most_wanted.level)
	self.visual.you_gotta_start_somewhere.progress = from_level(self.level_achievements.you_gotta_start_somewhere.level)

	for id, v in pairs(self.crime_spree) do
		if v.award then
			self.visual[id].progress = from_crimespree_item(v)
		end
	end

	for i, v in pairs(self.infamous) do
		self.visual[v].progress = {
			get = function ()
				return managers.experience:current_rank() or 0
			end,
			max = i
		}
	end

	self.visual.fully_loaded.progress = from_owned_weapons(self.fully_loaded)
	self.visual.gage_8.progress = from_owned_weapons(self.arms_dealer)
	self.visual.weapon_collector.progress = from_owned_weapons(self.weapon_collector)
	self.visual.grill_3.progress = from_timed_memory(self.grenade_achievements.not_invited, "gre_ach_not_invited", "kill_count")
	self.visual.gage4_4.progress = from_timed_memory(self.enemy_kill_achievements.seven_eleven, "seven_eleven")
	self.visual.eagle_5.progress = from_timed_memory(self.enemy_kill_achievements.bullet_hell, "bullet_hell")
	self.visual.scorpion_4.progress = from_timed_memory(self.enemy_kill_achievements.scorpion_4, "scorpion_4")
	self.visual.brooklyn_1.progress = {
		max = 1,
		get = function ()
			return 0
		end,
		update = tracking.realtime
	}
	self.visual.berry_5.progress = {
		get = function ()
			return managers.job:get_memory("berry_5", true) or 0
		end,
		max = self.enemy_kill_achievements.berry_5.count_in_row,
		update = tracking.realtime
	}
	self.visual.turtles_1.progress = {
		get = function ()
			return managers.job:get_memory("kill_count_no_reload_wa2000", true) or 0
		end,
		max = self.enemy_kill_achievements.turtles_1.count_no_reload,
		update = tracking.realtime
	}
	self.visual.grv_2.progress = {
		get = function ()
			return managers.job:get_memory("kill_count_no_reload_coal", true) or 0
		end,
		max = self.enemy_kill_achievements.grv_2.count_no_reload,
		update = tracking.realtime
	}
	local cane_5 = self.loot_cash_achievements.cane_5
	self.visual.cane_5.progress = {
		get = function ()
			local total, _, _ = managers.loot:_count_achievement_secured("cane_5", cane_5.secured)

			return total or 0
		end,
		max = cane_5.secured.total_amount,
		update = tracking.second
	}
	self.visual.gage2_5.progress = {
		get = function ()
			return managers.statistics:session_killed_by_weapon_category(self.first_blood.weapon_type)
		end,
		max = self.first_blood.count,
		update = tracking.realtime
	}
	self.visual.going_places.progress = {
		get = function ()
			return managers.money:total()
		end,
		max = self.going_places,
		update = tracking.realtime
	}
	local pal_2 = self.loot_cash_achievements.pal_2
	self.visual.pal_2.progress = {
		get = function ()
			local _, _, value = managers.loot:_count_achievement_secured("pal_2", pal_2.secured)

			return value or 0
		end,
		max = pal_2.secured.value,
		update = tracking.second
	}
	local steel_2 = self.enemy_melee_hit_achievements.steel_2
	self.visual.steel_2.progress = {
		get = function ()
			if table.contains(steel_2.melee_weapons, managers.blackmarket:equipped_melee_weapon()) then
				return managers.statistics:session_enemy_killed_by_type(steel_2.enemy_kills.enemy, "melee")
			end

			return 0
		end,
		max = steel_2.enemy_kills.count,
		update = tracking.second
	}
	local tango_3 = self.complete_heist_achievements.tango_3
	self.visual.tango_achieve_3.progress = {
		get = function ()
			if not table.contains(tango_3.difficulty, Global.game_settings.difficulty) then
				return 0
			end

			local rtn = 0
			local weapons_to_check = {
				managers.blackmarket:equipped_primary(),
				managers.blackmarket:equipped_secondary()
			}

			for _, weapon_data in ipairs(weapons_to_check) do
				if table.contains(weapon_data.blueprint or {}, tango_3.killed_by_blueprint.blueprint) then
					rtn = rtn + (managers.statistics:session_killed_by_weapon(weapon_data.weapon_id) or 0)
				end
			end

			return rtn
		end,
		max = tango_3.killed_by_blueprint.amount,
		update = tracking.realtime
	}
	self.visual.tango_achieve_4.progress = {
		get = function ()
			local unit = managers.player:equipped_weapon_unit()

			if not unit or not unit:base() then
				return 0
			end

			local data = unit:base()._tango_4_data

			return data and data.count or 0
		end,
		max = self.tango_4.count
	}
	local turtles_2 = self.enemy_kill_achievements.turtles_2
	self.visual.turtles_2.progress = {
		get = function ()
			return managers.statistics:session_killed_by_weapon(turtles_2.weapon) or 0
		end,
		max = turtles_2.kill_count
	}
	self.visual.gage4_3.progress = {
		get = function ()
			return managers.statistics:session_total_killed()[self.close_and_personal.kill_type] or 0
		end,
		max = self.close_and_personal.count
	}
	self.visual.spend_money_to_make_money.progress = {
		get = function ()
			return managers.money:total_spent()
		end,
		max = self.spend_money_to_make_money
	}

	local function dummy_progress()
		return 0
	end

	self.visual.cac_2.progress = {
		max = 0,
		get = dummy_progress,
		update = tracking.realtime
	}
	self.visual.cac_20.progress = {
		max = 7,
		get = function ()
			local masks = {
				"sds_01",
				"sds_02",
				"sds_03",
				"sds_04",
				"sds_05",
				"sds_06",
				"sds_07"
			}
			local count = 0

			for _, mask_id in ipairs(masks) do
				if managers.blackmarket:has_item("halloween", "masks", mask_id) then
					count = count + 1
				end
			end

			return count
		end
	}
end