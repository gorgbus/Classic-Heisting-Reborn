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

