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

function BlackMarketGui:populate_player_styles(data)
	for i = 1, #data do
		data[i] = nil
	end

	local sort_data = {}
	local tweak, global_value_tweak = nil

	for i, player_style in ipairs(tweak_data.blackmarket.player_style_list) do
		tweak = tweak_data.blackmarket.player_styles[player_style]
		global_value_tweak = tweak_data.lootdrop.global_values[tweak.global_value]

		if Global.blackmarket_manager.player_styles[player_style] and (not global_value_tweak or not global_value_tweak.hide_unavailable or not not managers.dlc:is_global_value_unlocked(tweak.global_value)) then
			table.insert(sort_data, player_style)
		end
	end

	local sort_table = {}

	for sort_number, player_style in ipairs(sort_data) do
		tweak = tweak_data.blackmarket.player_styles[player_style]
		local unlocked = managers.blackmarket:player_style_unlocked(player_style)
		local global_value = tweak.global_value
		local dlc = tweak.dlc or global_value and managers.dlc:global_value_to_dlc(global_value)
		local achievement_locked = managers.dlc:is_content_achievement_locked("player_style", player_style) or managers.dlc:is_content_achievement_milestone_locked("player_style", player_style)
		local infamy_locked = managers.dlc:is_content_infamy_locked("player_style", player_style)
		sort_table[player_style] = {
			unlocked = unlocked,
			locked_sort = tweak_data.gui:get_locked_sort_number(dlc, achievement_locked, infamy_locked),
			sort_number = sort_number
		}
	end

	local x_data, y_data = nil

	local function sort_func(x, y)
		x_data = sort_table[x]
		y_data = sort_table[y]

		if x_data.unlocked ~= y_data.unlocked then
			return x_data.unlocked
		end

		if not x_data.unlocked and x_data.locked_sort ~= y_data.locked_sort then
			return x_data.locked_sort < y_data.locked_sort
		end

		return x_data.sort_number < y_data.sort_number
	end

	table.sort(sort_data, sort_func)

	local have_suit_variations = nil
	local mannequin_player_style = data.mannequin_player_style or managers.menu_scene and managers.menu_scene:get_player_style() or "none"
	local default_player_style = managers.blackmarket:get_default_player_style()
	local new_data, allow_preview, allow_customize, player_style, player_style_data, guis_catalog, bundle_folder, customize_alpha = nil
	local equipped_player_style = data.equipped_player_style or managers.blackmarket:equipped_player_style()
	local max_items = self:calc_max_items(#sort_data, data.override_slots)

	for i = 1, max_items do
		new_data = {
			comparision_data = nil,
			category = "player_styles",
			slot = i
		}
		player_style = sort_data[i]

		if player_style then
			allow_preview = true
			player_style_data = tweak_data.blackmarket.player_styles[player_style]
			guis_catalog = "guis/"
			bundle_folder = player_style_data.texture_bundle_folder

			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end

			new_data.name = player_style
			new_data.name_localized = managers.localization:text(player_style_data.name_id)
			new_data.global_value = player_style_data.global_value or "normal"
			new_data.unlocked = managers.blackmarket:player_style_unlocked(player_style)
			new_data.equipped = equipped_player_style == player_style
			new_data.lock_color = self:get_lock_color(new_data)
			allow_customize = not data.customize_equipped_only or new_data.equipped

			if player_style ~= default_player_style then
				new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/player_styles/" .. player_style
			else
				new_data.button_text = managers.localization:to_upper_text("menu_default")
			end

			local is_dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].dlc and not managers.dlc:is_dlc_unlocked(new_data.global_value)

			if is_dlc_locked then
				new_data.unlocked = false
				new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_dlc")
				new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
			elseif not new_data.unlocked then
				if managers.dlc:is_content_achievement_locked(data.category, new_data.name) or managers.dlc:is_content_achievement_milestone_locked(data.category, new_data.name) then
					local ach_dlc_id = managers.dlc:get_achievement_from_locked_content(data.category, new_data.name)
					local dlc_tweak = tweak_data.dlc[ach_dlc_id]
					local achievement = dlc_tweak and dlc_tweak.achievement_id
					local achievement_visual = tweak_data.achievement.visual[achievement]
					new_data.lock_texture = "guis/textures/pd2/lock_achievement"
					new_data.dlc_locked = achievement_visual and achievement_visual.desc_id or "achievement_" .. tostring(achievement) .. "_desc"
				elseif managers.dlc:is_content_infamy_locked(data.category, new_data.name) then
					new_data.lock_texture = "guis/textures/pd2/lock_infamy"
					new_data.dlc_locked = "menu_infamy_lock_info"
				else
					local achievement = player_style_data.locks and player_style_data.locks.achievement

					if achievement and managers.achievment:get_info(achievement) and not managers.achievment:get_info(achievement).awarded then
						local achievement_visual = tweak_data.achievement.visual[achievement]
						new_data.lock_texture = "guis/textures/pd2/lock_achievement"
						new_data.dlc_locked = achievement_visual and achievement_visual.desc_id or "achievement_" .. tostring(achievement) .. "_desc"
					else
						new_data.lock_texture = "guis/textures/pd2/skilltree/padlock"
					end
				end
			end

			have_suit_variations = tweak_data.blackmarket:have_suit_variations(player_style)

			if have_suit_variations then
				if allow_customize then
					table.insert(new_data, "trd_customize")
				end

				if allow_customize then
					customize_alpha = 0.8
				else
					customize_alpha = 0.4
				end

				new_data.mini_icons = {}

				table.insert(new_data.mini_icons, {
					texture = "guis/dlcs/trd/textures/pd2/blackmarket/paintbrush_icon",
					top = 5,
					h = 16,
					layer = 1,
					w = 16,
					blend_mode = "add",
					right = 5,
					alpha = customize_alpha
				})
			end

			if new_data.unlocked then
				if not new_data.equipped then
					table.insert(new_data, "trd_equip")
				end
			else
				local dlc_data = Global.dlc_manager.all_dlc_data[new_data.global_value]

				if dlc_data and dlc_data.app_id and not dlc_data.external and not managers.dlc:is_dlc_unlocked(new_data.global_value) then
					table.insert(new_data, "bw_buy_dlc")
				end
			end

			if allow_preview and mannequin_player_style ~= player_style then
				table.insert(new_data, "trd_preview")
			end
		else
			new_data.name = "empty"
			new_data.name_localized = ""
			new_data.unlocked = true
			new_data.equipped = false
		end

		table.insert(data, new_data)
	end
end

function BlackMarketGui:purchase_weapon_mod_callback(data)
end