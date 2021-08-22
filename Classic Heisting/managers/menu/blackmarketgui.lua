Hooks:PostHook(BlackMarketGui, "_setup", "restore_setup", function(self, is_start_page, component_data)
	self._stats_shown = {
		{
			round_value = true,
			name = "magazine",
			stat_name = "extra_ammo"
		},
		{
			round_value = true,
			name = "totalammo",
			stat_name = "total_ammo_mod"
		},
		{
			round_value = true,
			name = "fire_rate"
		},
		{
			round_value = true,
			name = "damage"
		},
		{
			round_value = true,
			percent = true,
			name = "spread",
			offset = true,
			revert = true
		},
		{
			round_value = true,
			percent = true,
			name = "recoil",
			offset = true,
			revert = true
		},
		{
			round_value = true,
			index = true,
			name = "concealment"
		},
		{
			round_value = true,
			percent = false,
			name = "suppression",
			offset = true
		}
	}
end)

function BlackMarketGui:populate_characters(data)
	local new_data = {}
	local max_items = 8--self:calc_max_items(math.max(#data, CriminalsManager.get_num_characters()), data.override_slots)

	for i = 1, max_items do
		data[i] = nil
	end

	local equipped_index = nil
	local index = 1

	for i = 1, 4 --[[CriminalsManager.get_num_characters()]] do
		local character = CriminalsManager.character_names()[i]
		local character_name = CriminalsManager.convert_old_to_new_character_workname(character)
		local character_table = tweak_data.blackmarket.characters[character] or tweak_data.blackmarket.characters.locked[character_name]
		local unlocked = not character_table or not character_table.dlc or managers.dlc:is_dlc_unlocked(character_table.dlc)
		local hide_unavailable = tweak_data:get_raw_value("lootdrop", "global_values", character_table.dlc, "hide_unavailable")

		if character_table and (unlocked or not hide_unavailable) then
			equipped_index = nil

			for preferred_index, preferred_character in ipairs(managers.blackmarket:get_preferred_characters_list()) do
				if preferred_character == character then
					equipped_index = preferred_index

					break
				end
			end

			new_data = {
				name = character
			}
			new_data.name_localized = managers.localization:text("menu_" .. new_data.name)
			new_data.category = "characters"
			new_data.slot = i
			new_data.unlocked = unlocked
			new_data.equipped = not not equipped_index
			new_data.equipped_text = equipped_index and tostring(equipped_index) or managers.localization:text("bm_menu_preferred")
			new_data.bitmap_texture = managers.blackmarket:get_character_icon(character_name)
			new_data.stream = false
			new_data.global_value = character_table.dlc
			new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_community")
			new_data.lock_color = self:get_lock_color(new_data)

			if character_table and character_table.locks then
				local dlc = character_table.locks.dlc
				local achievement = character_table.locks.achievement
				local saved_job_value = character_table.locks.saved_job_value
				local level = character_table.locks.level

				if achievement and managers.achievment:get_info(achievement) and not managers.achievment:get_info(achievement).awarded then
					new_data.dlc_locked = "menu_bm_achievement_locked_" .. tostring(achievement)
				elseif dlc and not managers.dlc:is_dlc_unlocked(dlc) then
					new_data.dlc_locked = tweak_data.lootdrop.global_values[dlc] and tweak_data.lootdrop.global_values[dlc].unlock_id or "bm_menu_dlc_locked"
				end
			else
				new_data.dlc_locked = character_table and character_table.dlc and tweak_data.lootdrop.global_values[character_table.dlc] and tweak_data.lootdrop.global_values[character_table.dlc].unlock_id or "bm_menu_dlc_locked"
			end

			local active = true
			local btn_show_funcs = {}

			if new_data.unlocked then
				if active then
					if new_data.equipped then
						table.insert(new_data, "c_swap_slots")

						btn_show_funcs.c_swap_slots = "can_swap_character"
					else
						table.insert(new_data, "c_equip_to_slot")
					end
				end

				table.insert(new_data, "c_clear_slots")
			else
				local dlc_data = Global.dlc_manager.all_dlc_data[new_data.global_value]

				if dlc_data and dlc_data.app_id and not dlc_data.external and not managers.dlc:is_dlc_unlocked(new_data.global_value) then
					table.insert(new_data, "bw_buy_dlc")
				end
			end

			new_data.btn_show_funcs = btn_show_funcs
			data[index] = new_data
			index = index + 1
		end
	end

	for i = 1, max_items do
		if not data[i] then
			new_data = {
				name = "empty",
				name_localized = "",
				category = "characters",
				slot = i,
				unlocked = true,
				equipped = false
			}
			data[i] = new_data
		end
	end
end

function BlackMarketGui:purchase_weapon_mod_callback(data)
end