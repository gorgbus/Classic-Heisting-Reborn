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