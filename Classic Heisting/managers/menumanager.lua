Hooks:Add("MenuManagerBuildCustomMenus", "restoreBtnsMainMenu", function(menu_manager, nodes)

		local mainmenu = nodes.main
		if not mainmenu then
			return
		end

		_G.mainmenu = mainmenu or {}

		for index, item in pairs(mainmenu._items) do
			for i, v in pairs(item._parameters) do
				if i == "font_size" then
					item._parameters.font_size = 24
				end
			end
		end

		local data = {
			type = "CoreMenuItem.Item",
		}

		local params = {
			name = "select_infamy_btn",
			text_id = "menu_infamytree",
			help_id = "menu_infamytree_help",
			callback = "open_infamy",
		}
		local new_item = mainmenu:create_item(data, params)
		new_item.dirty_callback = callback(mainmenu, mainmenu, "item_dirty")
		if mainmenu.callback_handler then
			new_item:set_callback_handler(mainmenu.callback_handler)
		end

		local position = 14
		MenuHelper:RemoveMenuItem(mainmenu, "story_missions")
		table.insert(mainmenu._items, position, new_item)

		params = {
			name = "select_safehouse_btn",
			text_id = "menu_safehouse",
			help_id = "menu_safehouse_help",
			callback = "open_safehouse"
		}
		new_item = mainmenu:create_item(data, params)
		new_item.dirty_callback = callback(mainmenu, mainmenu, "item_dirty")
		if mainmenu.callback_handler then
			new_item:set_callback_handler(mainmenu.callback_handler)
		end

		if position == 14 then
			position = 15
		end

		table.insert(mainmenu._items, position, new_item)
		
		params = {
			name = "select_skilltree_btn",
			text_id = "menu_skilltree",
			help_id = "menu_skilltree_help",
			callback = "open_skills"
		}
		new_item = mainmenu:create_item(data, params)
		new_item.dirty_callback = callback(mainmenu, mainmenu, "item_dirty")
		if mainmenu.callback_handler then
			new_item:set_callback_handler(mainmenu.callback_handler)
		end

		position = 14
		table.insert(mainmenu._items, position, new_item)

		local lobby = nodes.lobby
		if not lobby then
			return
		end

		MenuHelper:RemoveMenuItem(lobby, "story_missions")

		position = 7
		table.insert(lobby._items, position, new_item)

		
		local adv_options = nodes.adv_options
		if not adv_options then
			return
		end

		params = {
			name = "select_max_progress_btn",
			text_id = "menu_max_progress",
			help_id = "menu_max_progress_help",
			callback = "max_progress_msg"
		}

		new_item = adv_options:create_item(data, params)
		new_item.dirty_callback = callback(adv_options, adv_options, "item_dirty")
		if adv_options.callback_handler then
			new_item:set_callback_handler(adv_options.callback_handler)
		end

		position = 10
		table.insert(adv_options._items, position, new_item)
	end)

function MenuHelper:GetMenuItem(parent_menu, child_menu)
	for i, item in pairs(parent_menu._items) do
		if item._parameters.name == child_menu then
			return i, item
		end
	end
end

function MenuHelper:RemoveMenuItem(parent_menu, child_menu)
	local index = self:GetMenuItem(parent_menu, child_menu)
	if index then
		return table.remove(parent_menu._items, index)
	end
end

function MenuCallbackHandler:open_safehouse()
	MenuCallbackHandler:play_safehouse({skip_question = false})
end

function MenuCallbackHandler:open_infamy()
	managers.menu:open_node("infamytree")
end

function MenuCallbackHandler:open_skills()
	managers.menu:open_node("skilltree_new", {})
end

function MenuCallbackHandler:max_progress_msg()
	local dialog_data = {
		title = managers.localization:text("dialog_warning_title"),
		text = managers.localization:text("menu_progress_msg", {
		}),
		focus_button = 1
	}
	local yes_button = {
		text = managers.localization:text("dialog_yes"),
		callback_func = callback(self, self, "max_progress", index)
	}
	local no_button = {
		text = managers.localization:text("dialog_no"),
		callback_func = idk,
		cancel_button = true
	}
	dialog_data.button_list = {
		yes_button,
		no_button
	}

	managers.system_menu:show(dialog_data)
end

function MenuCallbackHandler:max_progress()
	managers.experience:_set_current_level(100)
	managers.skilltree:_set_points(120 - (120 - managers.skilltree:points()))
	managers.experience:_set_current_rank(5)
	managers.infamy:_set_points(5 - managers.experience:current_rank())
	managers.money:_set_offshore(10000000000)
	managers.money:_set_total(1000000000)

	for name, item in pairs(tweak_data.blackmarket.weapon_mods) do
		if not item.dlc or managers.dlc:is_dlc_unlocked(item.dlc) then
			for i = 100, 100 do
				managers.blackmarket:add_to_inventory(item.dlc or "normal", "weapon_mods", name)
			end
		end
	end
	for name, item in pairs(tweak_data.blackmarket.masks) do
		if name ~= "character_locked" then
			if item.dlc and managers.dlc:is_dlc_unlocked(item.dlc) then
				managers.blackmarket:add_to_inventory(item.dlc, "masks", name)
			else
				local global_value = item.infamous and "infamous" or item.global_value or "normal"
				managers.blackmarket:add_to_inventory(global_value, "masks", name)
			end
		end
	end
	for name, item in pairs(tweak_data.blackmarket.materials) do
		if name ~= "plastic" then
			if item.dlc and managers.dlc:is_dlc_unlocked(item.dlc) then
				local global_value = item.infamous and "infamous" or item.global_value or item.dlc
				managers.blackmarket:add_to_inventory(global_value, "materials", name)
			else
				local global_value = item.infamous and "infamous" or item.global_value or "normal"
				managers.blackmarket:add_to_inventory(global_value, "materials", name)
			end
		end
	end
	for name, item in pairs(tweak_data.blackmarket.textures) do
		if name ~= "no_color_no_material" and name ~= "no_color_full_material" then
			if item.dlc and managers.dlc:is_dlc_unlocked(item.dlc) then
				local global_value = item.infamous and "infamous" or item.global_value or item.dlc
				managers.blackmarket:add_to_inventory(global_value, "textures", name)
			else
				local global_value = item.infamous and "infamous" or item.global_value or "normal"
				managers.blackmarket:add_to_inventory(global_value, "textures", name)
			end
		end
	end
	for name, item in pairs(tweak_data.blackmarket.colors) do
		if item.dlc and managers.dlc:is_dlc_unlocked(item.dlc) then
			local global_value = item.infamous and "infamous" or item.global_value or item.dlc
			managers.blackmarket:add_to_inventory(global_value, "colors", name)
		else
			local global_value = item.infamous and "infamous" or item.global_value or "normal"
			managers.blackmarket:add_to_inventory(global_value, "colors", name)
		end
	end
end

function SkillSwitchInitiator:modify_node(node, data)
end

function MenuCallbackHandler:become_infamous(params)
	if not self:can_become_infamous() then
		return
	end

	local rank = managers.experience:current_rank() + 1
	local infamous_cost = managers.money:get_infamous_cost(rank)
	local yes_clbk = params and params.yes_clbk or false
	local no_clbk = params and params.no_clbk
	local params = {
		cost = managers.experience:cash_string(infamous_cost),
		free = infamous_cost == 0
	}

	if infamous_cost <= managers.money:offshore() and managers.experience:current_level() >= 100 then
		function params.yes_func()
			managers.menu:open_node("blackmarket_preview_node", {
				{
					back_callback = callback(MenuCallbackHandler, MenuCallbackHandler, "_increase_infamous", yes_clbk)
				}
			})
			managers.menu_scene:spawn_infamy_card(rank)
			self._sound_source:post_event("infamous_stinger_level_" .. (rank < 10 and "0" or "") .. tostring(rank))
		end
	end

	function params.no_func()
		if no_clbk then
			no_clbk()
		end
	end

	managers.menu:show_confirm_become_infamous(params)
end

function MenuCallbackHandler:is_contract_difficulty_allowed(item)
	if not managers.menu:active_menu() then
		return false
	end
	if not managers.menu:active_menu().logic then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node() then
		return false
	end
	if not managers.menu:active_menu().logic:selected_node():parameters().menu_component_data then
		return false
	end
	local job_data = managers.menu:active_menu().logic:selected_node():parameters().menu_component_data
	if not job_data.job_id then
		return false
	end
	if job_data.professional and item:value() < 3 then
		return false
	end
	if job_data.professional or item:value() > 5 then
	end
	local job_jc = tweak_data.narrative:job_data(job_data.job_id).jc
	local difficulty_jc = (item:value() - 2) * 10
	local plvl = managers.experience:current_level()
	local prank = managers.experience:current_rank()
	local level_lock = tweak_data.difficulty_level_locks[item:value()] or 0
	local is_not_level_locked = plvl >= level_lock
	return is_not_level_locked and managers.job:get_max_jc_for_player() >= math.clamp(job_jc + difficulty_jc, 0, 100)
end

function MenuCrimeNetFiltersInitiator:update_node(node)
	if MenuCallbackHandler:is_win32() then
		local not_friends_only = not Global.game_settings.search_friends_only

		node:item("toggle_new_servers_only"):set_enabled(not_friends_only)
		node:item("toggle_server_state_lobby"):set_enabled(not_friends_only)
		node:item("toggle_job_appropriate_lobby"):set_enabled(not_friends_only)
		node:item("toggle_mutated_lobby"):set_enabled(not_friends_only)
		node:item("max_lobbies_filter"):set_enabled(not_friends_only)
		node:item("server_filter"):set_enabled(not_friends_only)
		node:item("kick_option_filter"):set_enabled(not_friends_only)
		node:item("job_id_filter"):set_enabled(not_friends_only)
		node:item("job_plan_filter"):set_enabled(not_friends_only)
		node:item("toggle_job_appropriate_lobby"):set_visible(self:is_standard())
		node:item("toggle_allow_safehouses"):set_visible(self:is_standard())
		node:item("toggle_mutated_lobby"):set_visible(self:is_standard())
		node:item("toggle_one_down_lobby"):set_visible(self:is_standard())
		node:item("difficulty_filter"):set_visible(false)
		node:item("difficulty"):set_visible(self:is_standard())
		node:item("job_id_filter"):set_visible(self:is_standard())
		node:item("max_spree_difference_filter"):set_visible(self:is_crime_spree())
		node:item("skirmish_wave_filter"):set_visible(self:is_skirmish())
		node:item("job_plan_filter"):set_visible(not self:is_skirmish())
	elseif MenuCallbackHandler:is_xb1() then
		if Global.game_settings.search_crimespree_lobbies then
			print("GN: CS lobby set to true")
			node:item("difficulty_filter"):set_enabled(false)
			node:item("max_spree_difference_filter"):set_enabled(true)
		else
			print("GN: CS lobby set to false")
			node:item("difficulty_filter"):set_enabled(true)
			node:item("max_spree_difference_filter"):set_enabled(false)
		end

		if Global.game_settings.search_crimespree_lobbies then
			node:item("toggle_mutated_lobby"):set_enabled(false)
		elseif Global.game_settings.search_mutated_lobbies then
			node:item("toggle_crimespree_lobby"):set_enabled(false)
		else
			node:item("toggle_mutated_lobby"):set_enabled(true)
			node:item("toggle_crimespree_lobby"):set_enabled(true)
		end
	end
end

function MenuCrimeNetFiltersInitiator:add_filters(node)
	if node:item("divider_end") then
		return
	end
	
	local params = {
		callback = "choice_difficulty_filter",
		name = "difficulty",
		text_id = "menu_diff_filter",
		help_id = "menu_diff_help",
		filter = true
	}
	local data_node = {
			{
			value = -1,
			text_id = "menu_any",
			_meta = "option"
		},
		{
			value = 2,
			text_id = "menu_difficulty_normal",
			_meta = "option"
		},
		{
			value = 3,
			text_id = "menu_difficulty_hard",
			_meta = "option"
		},
		{
			value = 4,
			text_id = "menu_difficulty_very_hard",
			_meta = "option"
		},
		{
			value = 5,
			text_id = "menu_difficulty_overkill",
			_meta = "option"
		},
		{
			value = 6,
			text_id = "menu_difficulty_apocalypse",
			_meta = "option"
		},
		type = "MenuItemMultiChoice"
	}
	local new_item = node:create_item(data_node, params)

	new_item:set_value(managers.network.matchmake:difficulty_filter())
	node:add_item(new_item)

	local params = {
		visible_callback = "is_multiplayer is_win32",
		name = "job_id_filter",
		callback = "choice_job_id_filter",
		text_id = "menu_job_id_filter",
		filter = true
	}
	local data_node = {
		{
			value = -1,
			text_id = "menu_any",
			_meta = "option"
		},
		type = "MenuItemMultiChoice"
	}

	for index, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local job_tweak = tweak_data.narrative.jobs[job_id]
		local contact = job_tweak.contact
		local contact_tweak = tweak_data.narrative.contacts[contact]
		local allow = not job_tweak.wrapped_to_job and contact ~= "tests" and (not job_tweak or not job_tweak.hidden)

		if allow then
			local text_id, color_data = tweak_data.narrative:create_job_name(job_id)
			local params = {
				localize = false,
				_meta = "option",
				text_id = text_id,
				value = index
			}

			for count, color in ipairs(color_data) do
				params["color" .. count] = color.color
				params["color_start" .. count] = color.start
				params["color_stop" .. count] = color.stop
			end

			table.insert(data_node, params)
		end
	end

	local new_item = node:create_item(data_node, params)

	new_item:set_value(managers.network.matchmake:get_lobby_filter("job_id") or -1)
	node:add_item(new_item)

	local params = {
		visible_callback = "is_multiplayer is_win32",
		name = "kick_option_filter",
		callback = "choice_kick_option",
		text_id = "menu_kicking_allowed_filter",
		filter = true
	}
	local data_node = {
		{
			value = -1,
			text_id = "menu_any",
			_meta = "option"
		},
		type = "MenuItemMultiChoice"
	}
	local kick_filters = {
		{
			value = 1,
			text_id = "menu_kick_server"
		},
		{
			value = 2,
			text_id = "menu_kick_vote"
		},
		{
			value = 0,
			text_id = "menu_kick_disabled"
		}
	}

	for index, filter in ipairs(kick_filters) do
		table.insert(data_node, {
			_meta = "option",
			text_id = filter.text_id,
			value = filter.value
		})
	end

	local new_item = node:create_item(data_node, params)

	new_item:set_value(managers.network.matchmake:get_lobby_filter("kick_option") or -1)
	node:add_item(new_item)

	local params = {
		size = 8,
		name = "divider_end",
		no_text = true
	}
	local data_node = {type = "MenuItemDivider"}
	local new_item = node:create_item(data_node, params)

	node:add_item(new_item)

	local params = {
		callback = "_reset_filters",
		name = "reset_filters",
		align = "right",
		text_id = "dialog_reset_filters"
	}
	local data_node = {}
	local new_item = node:create_item(data_node, params)

	node:add_item(new_item)
	self:modify_node(node, {})
end