function MissionBriefingGui:init(saferect_ws, fullrect_ws, node)
	self._safe_workspace = saferect_ws
	self._full_workspace = fullrect_ws
	self._node = node
	self._fullscreen_panel = self._full_workspace:panel():panel()
	self._panel = self._safe_workspace:panel():panel({
		layer = 6,
		w = self._safe_workspace:panel():w() / 2
	})

	self._panel:set_right(self._safe_workspace:panel():w())
	self._panel:set_top(165 + tweak_data.menu.pd2_medium_font_size)
	self._panel:grow(0, -self._panel:top())

	self._ready = managers.network:session():local_peer():waiting_for_player_ready()
	local ready_text = self:ready_text()
	self._ready_button = self._panel:text({
		vertical = "center",
		name = "ready_button",
		blend_mode = "add",
		align = "right",
		rotation = 360,
		layer = 2,
		text = ready_text,
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.button_stage_3
	})
	local _, _, w, h = self._ready_button:text_rect()

	self._ready_button:set_size(w, h)

	if not managers.menu:is_pc_controller() then
		-- Nothing
	end

	self._ready_tick_box = self._panel:bitmap({
		texture = "guis/textures/pd2/mission_briefing/gui_tickbox",
		name = "ready_tickbox",
		layer = 2
	})

	self._ready_tick_box:set_rightbottom(self._panel:w(), self._panel:h())
	self._ready_tick_box:set_image(self._ready and "guis/textures/pd2/mission_briefing/gui_tickbox_ready" or "guis/textures/pd2/mission_briefing/gui_tickbox")
	self._ready_button:set_center_y(self._ready_tick_box:center_y())
	self._ready_button:set_right(self._ready_tick_box:left() - 5)

	local big_text = self._fullscreen_panel:text({
		name = "ready_big_text",
		vertical = "bottom",
		h = 90,
		alpha = 0.4,
		align = "right",
		rotation = 360,
		layer = 1,
		text = ready_text,
		font_size = tweak_data.menu.pd2_massive_font_size,
		font = tweak_data.menu.pd2_massive_font,
		color = tweak_data.screen_colors.button_stage_3
	})
	local _, _, w, h = big_text:text_rect()

	big_text:set_size(w, h)

	local x, y = managers.gui_data:safe_to_full_16_9(self._ready_button:world_right(), self._ready_button:world_center_y())

	big_text:set_world_right(x)
	big_text:set_world_center_y(y)
	big_text:move(13, -3)
	big_text:set_layer(self._ready_button:layer() - 1)

	if MenuBackdropGUI then
		MenuBackdropGUI.animate_bg_text(self, big_text)
	end

	WalletGuiObject.set_wallet(self._safe_workspace:panel(), 10)

	self._node:parameters().menu_component_data = self._node:parameters().menu_component_data or {}
	self._node:parameters().menu_component_data.asset = self._node:parameters().menu_component_data.asset or {}
	self._node:parameters().menu_component_data.loadout = self._node:parameters().menu_component_data.loadout or {}
	local asset_data = self._node:parameters().menu_component_data.asset
	local loadout_data = self._node:parameters().menu_component_data.loadout

	if not managers.menu:is_pc_controller() then
		local prev_page = self._panel:text({
			w = 0,
			name = "tab_text_0",
			vertical = "top",
			y = 0,
			layer = 2,
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			text = managers.localization:get_default_macro("BTN_BOTTOM_L")
		})
		local _, _, w, h = prev_page:text_rect()

		prev_page:set_size(w, h + 10)
		prev_page:set_left(0)

		self._prev_page = prev_page
	end

	self._items = {}
	local index = 1
	local description_text_id = "menu_description"

	if managers.job:has_active_job() then
		local level_tweak = tweak_data.levels[managers.job:current_level_id()]
		local narrator = level_tweak and level_tweak.narrator or "bain"
		description_text_id = "menu_description_" .. narrator
	end

	self._description_item = DescriptionItem:new(self._panel, utf8.to_upper(managers.localization:text(description_text_id)), index, self._node:parameters().menu_component_data.saved_descriptions)

	table.insert(self._items, self._description_item)

	index = index + 1

	if not managers.skirmish:is_skirmish() then
		self._assets_item = AssetsItem:new(self._panel, managers.preplanning:has_current_level_preplanning() and managers.localization:to_upper_text("menu_preplanning") or utf8.to_upper(managers.localization:text("menu_assets")), index, {}, nil, asset_data)

		table.insert(self._items, self._assets_item)

		index = index + 1
	end

	if managers.crime_spree:is_active() then
		local gage_assets_data = {}
		self._gage_assets_item = GageAssetsItem:new(self._panel, managers.localization:to_upper_text("menu_cs_gage_assets"), index)

		table.insert(self._items, self._gage_assets_item)

		index = index + 1
	end

	self._new_loadout_item = NewLoadoutTab:new(self._panel, managers.localization:to_upper_text("menu_loadout"), index, loadout_data)

	table.insert(self._items, self._new_loadout_item)

	index = index + 1

	if not Global.game_settings.single_player then
		self._team_loadout_item = TeamLoadoutItem:new(self._panel, utf8.to_upper(managers.localization:text("menu_team_loadout")), index)

		table.insert(self._items, self._team_loadout_item)

		index = index + 1
	end

	if managers.mutators and managers.mutators:are_mutators_active() then
		self._mutators_item = MutatorsItem:new(self._panel, utf8.to_upper(managers.localization:text("menu_mutators")), index)

		table.insert(self._items, self._mutators_item)

		index = index + 1
	end

	local music_type = tweak_data.levels:get_music_style(Global.level_data.level_id)

	if music_type == "heist" then
		self._jukebox_item = JukeboxItem:new(self._panel, utf8.to_upper(managers.localization:text("menu_jukebox")), index)

		table.insert(self._items, self._jukebox_item)

		index = index + 1
	elseif music_type == "ghost" then
		self._jukebox_item = JukeboxGhostItem:new(self._panel, utf8.to_upper(managers.localization:text("menu_jukebox")), index)

		table.insert(self._items, self._jukebox_item)

		index = index + 1
	end

	local max_x = self._panel:w()

	if not managers.menu:is_pc_controller() then
		local next_page = self._panel:text({
			w = 0,
			vertical = "top",
			y = 0,
			layer = 2,
			name = "tab_text_" .. tostring(#self._items + 1),
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			text = managers.localization:get_default_macro("BTN_BOTTOM_R")
		})
		local _, _, w, h = next_page:text_rect()

		next_page:set_size(w, h + 10)
		next_page:set_right(self._panel:w())

		self._next_page = next_page
		max_x = next_page:left() - 5
	end

	self._reduced_to_small_font = not managers.menu:is_pc_controller()
	self._reduced_to_small_font = self._reduced_to_small_font or managers.crime_spree:is_active()

	self:chk_reduce_to_small_font()

	self._selected_item = 0

	self:set_tab(self._node:parameters().menu_component_data.selected_tab, true)

	local box_panel = self._panel:panel()

	box_panel:set_shape(self._items[1]:panel():shape())
	BoxGuiObject:new(box_panel, {
		sides = {
			1,
			1,
			2,
			1
		}
	})

	if managers.assets:is_all_textures_loaded() or #managers.assets:get_all_asset_ids(true) == 0 then
		self:create_asset_tab()
	end

	self._items[self._selected_item]:select(true)

	if managers.job:is_current_job_competitive() then
		self:set_description_text_id("menu_competitive_rules")
	end

	--[[self._multi_profile_item = MultiProfileItemGui:new(self._safe_workspace, self._panel)

	self._multi_profile_item:panel():set_bottom(self._panel:h())
	self._multi_profile_item:panel():set_left(0)
	self._multi_profile_item:set_name_editing_enabled(false)]]--

	local mutators_panel = self._safe_workspace:panel()
	self._lobby_mutators_text = mutators_panel:text({
		vertical = "top",
		name = "mutated_text",
		align = "right",
		text = managers.localization:to_upper_text("menu_mutators_lobby_wait_title"),
		font_size = tweak_data.menu.pd2_large_font_size * 0.8,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.mutators_color_text,
		layer = self._ready_button:layer()
	})
	local _, _, w, h = self._lobby_mutators_text:text_rect()

	self._lobby_mutators_text:set_size(w, h)
	self._lobby_mutators_text:set_top(tweak_data.menu.pd2_large_font_size)

	local mutators_active = managers.mutators:are_mutators_enabled() and managers.mutators:allow_mutators_in_level(managers.job:current_level_id())

	self._lobby_mutators_text:set_visible(mutators_active)

	local local_peer = managers.network:session():local_peer()

	for peer_id, peer in pairs(managers.network:session():peers()) do
		if peer ~= local_peer then
			local outfit = managers.blackmarket:unpack_outfit_from_string(peer:profile("outfit_string"))

			self:set_slot_outfit(peer_id, peer:character(), outfit)
		end
	end

	self._enabled = true

	self:flash_ready()
end

function MissionBriefingGui:mouse_pressed(button, x, y)
	if not alive(self._panel) or not alive(self._fullscreen_panel) or not self._enabled then
		return
	end

	if game_state_machine:current_state().blackscreen_started and game_state_machine:current_state():blackscreen_started() then
		return
	end

	if self._displaying_asset then
		if button == Idstring("mouse wheel down") then
			self:zoom_asset("out")

			return
		elseif button == Idstring("mouse wheel up") then
			self:zoom_asset("in")

			return
		end

		self:close_asset()

		return
	end

	local mwheel_down = button == Idstring("mouse wheel down")
	local mwheel_up = button == Idstring("mouse wheel up")

	if (mwheel_down or mwheel_up) and managers.menu:is_pc_controller() then
		local mouse_pos_x, mouse_pos_y = managers.mouse_pointer:modified_mouse_pos()

		if mouse_pos_x < self._panel:x() then
			return
		end
	end

	if mwheel_down then
		self:next_tab(true)

		return
	elseif mwheel_up then
		self:prev_tab(true)

		return
	end

	if button ~= Idstring("0") then
		return
	end

	if MenuCallbackHandler:is_overlay_enabled() then
		local fx, fy = managers.mouse_pointer:modified_fullscreen_16_9_mouse_pos()

		for peer_id = 1, CriminalsManager.MAX_NR_CRIMINALS do
			if managers.hud:is_inside_mission_briefing_slot(peer_id, "name", fx, fy) then
				local peer = managers.network:session() and managers.network:session():peer(peer_id)

				if peer then
					Steam:overlay_activate("url", tweak_data.gui.fbi_files_webpage .. "/suspect/" .. peer:user_id() .. "/")

					return
				end
			end
		end
	end

	for index, tab in ipairs(self._items) do
		local pressed, cost = tab:mouse_pressed(button, x, y)

		if pressed == true then
			self:set_tab(index)
		elseif type(pressed) == "number" then
			if cost then
				if type(cost) == "number" then
					local asset_id, is_gage_asset, locked = tab:get_asset_id(pressed)

					if is_gage_asset and not locked then
						self:open_gage_asset(asset_id)
					else
						self:open_asset_buy(pressed, asset_id, is_gage_asset)
					end
				end
			else
				local asset_id, is_gage_asset, locked = tab:get_asset_id(pressed)

				if is_gage_asset then
					self:open_gage_asset(asset_id)
				else
					self:open_asset(pressed)
				end
			end
		end
	end

	if self._ready_button:inside(x, y) or self._ready_tick_box:inside(x, y) then
		self:on_ready_pressed()
	end

	--[[if not self._ready then
		self._multi_profile_item:mouse_pressed(button, x, y)
	end]]--

	return self._selected_item
end

function MissionBriefingGui:mouse_moved(x, y)
	if not alive(self._panel) or not alive(self._fullscreen_panel) or not self._enabled then
		return false, "arrow"
	end

	if self._displaying_asset then
		return false, "arrow"
	end

	if game_state_machine:current_state().blackscreen_started and game_state_machine:current_state():blackscreen_started() then
		return false, "arrow"
	end

	local mouse_over_tab = false

	for _, tab in ipairs(self._items) do
		local selected, highlighted = tab:mouse_moved(x, y)

		if highlighted and not selected then
			mouse_over_tab = true
		end
	end

	if mouse_over_tab then
		return true, "link"
	end

	local fx, fy = managers.mouse_pointer:modified_fullscreen_16_9_mouse_pos()

	for peer_id = 1, CriminalsManager.MAX_NR_CRIMINALS do
		if managers.hud:is_inside_mission_briefing_slot(peer_id, "name", fx, fy) then
			return true, "link"
		end
	end

	if self._ready_button:inside(x, y) or self._ready_tick_box:inside(x, y) then
		if not self._ready_highlighted then
			self._ready_highlighted = true

			self._ready_button:set_color(tweak_data.screen_colors.button_stage_2)
			managers.menu_component:post_event("highlight")
		end

		return true, "link"
	elseif self._ready_highlighted then
		self._ready_button:set_color(tweak_data.screen_colors.button_stage_3)

		self._ready_highlighted = false
	end

	if managers.hud._hud_mission_briefing and managers.hud._hud_mission_briefing._backdrop then
		managers.hud._hud_mission_briefing._backdrop:mouse_moved(x, y)
	end

	--local u, p = self._multi_profile_item:mouse_moved(x, y)

	return u or false, p or "arrow"
end

function MissionBriefingGui:special_btn_pressed(button)
	if not alive(self._panel) or not alive(self._fullscreen_panel) or not self._enabled then
		return false
	end

	if self._displaying_asset then
		self:close_asset()

		return false
	end

	if game_state_machine:current_state().blackscreen_started and game_state_machine:current_state():blackscreen_started() then
		return false
	end

	if button == Idstring("menu_toggle_ready") then
		self:on_ready_pressed()

		return true
	elseif button == Idstring("menu_toggle_pp_breakdown") then
		if managers.preplanning:has_current_level_preplanning() and self._assets_item and self._items[self._selected_item] == self._assets_item then
			self._assets_item:open_preplanning()
		end
    end
	--[[elseif button == Idstring("menu_change_profile_right") and managers.multi_profile:has_next() then
		managers.multi_profile:next_profile()
	elseif button == Idstring("menu_change_profile_left") and managers.multi_profile:has_previous() then
		managers.multi_profile:previous_profile()
	end]]--

	return false
end

function NewLoadoutTab:init(panel, text, i, menu_component_data)
	self._my_menu_component_data = menu_component_data

	NewLoadoutTab.super.init(self, panel, text, i)
	self._panel:move(0, 5)
	self._panel:grow(0, -5)

	self._index = i
	local player_loadout_data = managers.blackmarket:player_loadout_data()
	local items = {
		player_loadout_data.primary,
		player_loadout_data.secondary,
		player_loadout_data.melee_weapon,
		player_loadout_data.armor,
		player_loadout_data.deployable
	}
	local selected = self._my_menu_component_data.selected or 1
	self._items = {}
	local columns = NewLoadoutTab.columns
	local rows = NewLoadoutTab.rows

	for row = 1, rows do
		for column = 1, columns do
			local item = items[(row - 1) * columns + column]

			if item then
				local new_item = NewLoadoutItem:new(self._panel, columns, rows, column, row, item)

				table.insert(self._items, new_item)

				if #self._items == selected then
					new_item:select_item()

					self._item_selected = #self._items
					self._my_menu_component_data.selected = selected
				end
			end
		end
	end
end

function NewLoadoutTab:populate_category(data, category)
	local crafted_category = managers.blackmarket:get_crafted_category(category) or {}
	local new_data = {}
	local index = 0
	local max_items = data.override_slots and data.override_slots[1] * data.override_slots[2] or 9
	local max_rows = tweak_data.gui.MAX_WEAPON_ROWS or 3
	max_items = max_rows * (data.override_slots and data.override_slots[1] or 3)
	for i = 1, max_items do
		data[i] = nil
	end

	local weapon_data = Global.blackmarket_manager.weapons
	local guis_catalog = "guis/"

	for i, crafted in pairs(crafted_category) do
		guis_catalog = "guis/"
		local bundle_folder = tweak_data.weapon[crafted.weapon_id] and tweak_data.weapon[crafted.weapon_id].texture_bundle_folder

		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end

		new_data = {
			name = crafted.weapon_id,
			name_localized = managers.weapon_factory:get_weapon_name_by_factory_id(crafted.factory_id),
			category = category,
			slot = i,
			custom_name_text = managers.blackmarket:get_crafted_custom_name(category, index, true),
			unlocked = managers.blackmarket:weapon_unlocked(crafted.weapon_id)
		}
		new_data.lock_texture = not new_data.unlocked and "guis/textures/pd2/lock_level"
		new_data.equipped = crafted.equipped
		new_data.can_afford = true
		new_data.skill_based = weapon_data[crafted.weapon_id].skill_based
		new_data.skill_name = new_data.skill_based and "bm_menu_skill_locked_" .. new_data.name
		new_data.func_based = weapon_data[crafted.weapon_id].func_based
		new_data.level = managers.blackmarket:weapon_level(crafted.weapon_id)
		local texture_name, bg_texture = managers.blackmarket:get_weapon_icon_path(crafted.weapon_id, crafted.cosmetics)
		new_data.bitmap_texture = texture_name
		new_data.bg_texture = bg_texture
		new_data.comparision_data = new_data.unlocked and managers.blackmarket:get_weapon_stats(category, i)
		new_data.stream = false
		new_data.global_value = tweak_data.weapon[new_data.name] and tweak_data.weapon[new_data.name].global_value or "normal"
		new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or nil
		new_data.lock_texture = BlackMarketGui.get_lock_icon(self, new_data)
		new_data.name_color = crafted.locked_name and crafted.cosmetics and tweak_data.economy.rarities[tweak_data.blackmarket.weapon_skins[crafted.cosmetics.id].rarity or "common"].color

		if not new_data.equipped and new_data.unlocked then
			table.insert(new_data, "lo_w_equip")
		end

		local icon_list = managers.menu_component:create_weapon_mod_icon_list(crafted.weapon_id, category, crafted.factory_id, i)
		local icon_index = 1
		new_data.mini_icons = {}

		for _, icon in pairs(icon_list) do
			table.insert(new_data.mini_icons, {
				layer = 1,
				h = 16,
				stream = false,
				w = 16,
				bottom = 0,
				texture = icon.texture,
				right = (icon_index - 1) * 18,
				alpha = icon.equipped and 1 or 0.25
			})

			icon_index = icon_index + 1
		end

		data[i] = new_data
		index = i
	end

	for i = 1, max_items do
		if not data[i] then
			new_data = {
				name = "empty_slot",
				name_localized = managers.localization:text("bm_menu_empty_weapon_slot")
			}
			new_data.name_localized_selected = new_data.name_localized
			new_data.is_loadout = true
			new_data.category = category
			new_data.empty_slot = true
			new_data.slot = i
			new_data.unlocked = true
			new_data.equipped = false
			new_data.mid_text = {
				noselected_text = new_data.name_localized,
				noselected_color = tweak_data.screen_colors.button_stage_3
			}
			new_data.mid_text.selected_text = new_data.mid_text.noselected_text
			new_data.mid_text.selected_color = new_data.mid_text.noselected_color
			new_data.mid_text.is_lock_same_color = true
			data[i] = new_data
		end
	end
end

function NewLoadoutTab:open_node(node)
	self._my_menu_component_data.changing_loadout = nil
	self._my_menu_component_data.current_slot = nil

	if node == 1 then
		self._my_menu_component_data.changing_loadout = "primary"
		self._my_menu_component_data.current_slot = managers.blackmarket:equipped_weapon_slot("primaries")

		managers.menu_component:post_event("menu_enter")
		managers.menu:open_node("loadout", {
			self:create_primaries_loadout()
		})
	elseif node == 2 then
		self._my_menu_component_data.changing_loadout = "secondary"
		self._my_menu_component_data.current_slot = managers.blackmarket:equipped_weapon_slot("secondaries")

		managers.menu_component:post_event("menu_enter")
		managers.menu:open_node("loadout", {
			self:create_secondaries_loadout()
		})
	elseif node == 3 then
		managers.menu_component:post_event("menu_enter")
		managers.menu:open_node("loadout", {
			self:create_melee_weapon_loadout()
		})
	elseif node == 4 then
		managers.menu_component:post_event("menu_enter")
		managers.menu:open_node("loadout", {
			self:create_armor_loadout()
		})
	elseif node == 5 then
		managers.menu_component:post_event("menu_enter")
		managers.menu:open_node("loadout", {
			self:create_deployable_loadout()
		})
	end

	managers.menu_component:on_ready_pressed_mission_briefing_gui(false)
end

function NewLoadoutTab:populate_primaries(data)
	self:populate_category(data, "primaries")
end

function NewLoadoutTab:populate_secondaries(data)
	self:populate_category(data, "secondaries")
end

function NewLoadoutTab:create_primaries_loadout()
	local data = {}

	table.insert(data, {
		name = "bm_menu_primaries",
		category = "primaries",
		on_create_func = callback(self, self, "populate_primaries"),
		override_slots = {
			3,
			3
		},
		identifier = Idstring("weapon")
	})

	data.topic_id = "menu_loadout_blackmarket"
	data.topic_params = {
		category = managers.localization:text("bm_menu_primaries")
	}
	data.is_loadout = true

	return data
end

function NewLoadoutTab:create_secondaries_loadout()
	local data = {}

	table.insert(data, {
		name = "bm_menu_secondaries",
		category = "secondaries",
		on_create_func = callback(self, self, "populate_secondaries"),
		override_slots = {
			3,
			3
		},
		identifier = Idstring("weapon")
	})

	data.topic_id = "menu_loadout_blackmarket"
	data.topic_params = {
		category = managers.localization:text("bm_menu_secondaries")
	}
	data.is_loadout = true

	return data
end