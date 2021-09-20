local function format_round(num, round_value)
	return round_value and tostring(math.round(num)) or string.format("%.1f", num):gsub("%.?0+$", "")
end

local function make_cosmetic_data(data, cosmetic_id, unlocked, quality, bonus, equipped)
	local crafted = managers.blackmarket:get_crafted_category(data.category)[data.prev_node_data and data.prev_node_data.slot]
	local my_cd = tweak_data.blackmarket.weapon_skins[cosmetic_id]
	local new_data = {
		name = cosmetic_id,
		name_localized = my_cd and my_cd.name_id and managers.localization:text(my_cd.name_id) or managers.localization:text("bm_menu_no_mod"),
		desc_id = my_cd and my_cd.desc_id,
		lock_text_id = my_cd and my_cd.lock_id,
		category = data.category or data.prev_node_data and data.prev_node_data.category,
		default_blueprint = my_cd and my_cd.default_blueprint,
		locked_cosmetics = my_cd and my_cd.locked
	}
	local bitmap_texture, bg_texture = managers.blackmarket:get_weapon_icon_path(data.prev_node_data.name, {
		id = cosmetic_id
	})

	new_data.bitmap_texture = bitmap_texture
	new_data.bg_texture = bg_texture

	if not unlocked then
		new_data.bitmap_locked_color = Color.white
		new_data.bitmap_locked_blend_mode = "normal"
		new_data.bitmap_locked_alpha = 0.6
		new_data.bg_alpha = 0.4
	end

	new_data.slot = data.slot or data.prev_node_data and data.prev_node_data.slot
	new_data.global_value = my_cd and my_cd.global_value or "normal"
	new_data.akimbo_gui_data = tweak_data.weapon[crafted.weapon_id] and tweak_data.weapon[crafted.weapon_id].akimbo_gui_data
	new_data.cosmetic_id = cosmetic_id
	new_data.cosmetic_quality = quality
	new_data.cosmetic_rarity = my_cd and my_cd.rarity or "common"
	new_data.cosmetic_bonus = bonus
	new_data.unlocked = unlocked
	new_data.equipped = equipped
	new_data.stream = true
	new_data.lock_texture = not new_data.unlocked

	if new_data.default_blueprint then
		new_data.comparision_data = managers.blackmarket:get_weapon_stats(new_data.category, new_data.slot, new_data.default_blueprint)
	end

	if new_data.unlocked then
		if managers.blackmarket:last_previewed_cosmetic() == cosmetic_id then
			table.insert(new_data, "wcc_cancel_preview")
		else
			table.insert(new_data, "wcc_preview")
		end
	end

	if new_data.equipped then
		table.insert(new_data, "wcc_remove")
	end

	if new_data.unlocked then
		if not crafted.previewing and not new_data.equipped then
			table.insert(new_data, "wcc_equip")
		end

		if managers.blackmarket:is_previewing_any_mod() then
			table.insert(new_data, "wm_clear_mod_preview")
		end
	else
		if managers.blackmarket:last_previewed_cosmetic() == cosmetic_id then
			table.insert(new_data, "wcc_cancel_preview")
		else
			table.insert(new_data, "wcc_preview")
		end

		if not crafted.previewing and not my_cd.is_a_unlockable and managers.menu:is_pc_controller() then
			table.insert(new_data, "wcc_market")
		end

		if managers.blackmarket:is_previewing_any_mod() then
			table.insert(new_data, "wm_clear_mod_preview")
		end

		local lock_icon = nil

		if managers.dlc:is_content_achievement_locked("weapon_skins", new_data.name) or managers.dlc:is_content_achievement_milestone_locked("weapon_skins", new_data.name) then
			lock_icon = "guis/textures/pd2/lock_achievement"
		end

		new_data.mini_icons = new_data.mini_icons or {}

		table.insert(new_data.mini_icons, {
			stream = true,
			layer = 2,
			h = 30,
			w = 30,
			blend_mode = "normal",
			bottom = 1,
			right = 1,
			texture = lock_icon or my_cd.is_a_unlockable and "guis/textures/pd2/skilltree/padlock" or "guis/textures/pd2/lock_dlc",
			color = tweak_data.screen_colors.important_1
		})
	end

	return new_data
end

local function make_cosmetic_data_color(data, cosmetic_id, unlocked, quality, bonus, equipped)
	local crafted = managers.blackmarket:get_crafted_category(data.category)[data.prev_node_data and data.prev_node_data.slot]
	local my_cd = tweak_data.blackmarket.weapon_skins[cosmetic_id]
	local new_data = {
		name = cosmetic_id,
		name_localized = my_cd and my_cd.name_id and managers.localization:text(my_cd.name_id) or managers.localization:text("bm_menu_no_mod"),
		desc_id = my_cd and my_cd.desc_id,
		lock_text_id = my_cd and my_cd.lock_id,
		category = data.category or data.prev_node_data and data.prev_node_data.category,
		default_blueprint = my_cd and my_cd.default_blueprint,
		locked_cosmetics = my_cd and my_cd.locked
	}
	local bitmap_texture, bg_texture = managers.blackmarket:get_weapon_icon_path(data.prev_node_data.name, {
		id = cosmetic_id
	})

	local cosmetic_data = tweak_data.blackmarket.weapon_skins[cosmetic_id]

	local guis_catalog = "guis/"
	local bundle_folder = cosmetic_data.texture_bundle_folder

	if bundle_folder then
		guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
	end

	color_texture = guis_catalog .. "textures/pd2/blackmarket/icons/weapon_color/" .. cosmetic_id

	new_data.bitmap_texture = color_texture
	new_data.bg_texture = bg_texture

	if not unlocked then
		new_data.bitmap_locked_color = Color.white
		new_data.bitmap_locked_blend_mode = "normal"
		new_data.bitmap_locked_alpha = 0.6
		new_data.bg_alpha = 0.4
	end

	new_data.slot = data.slot or data.prev_node_data and data.prev_node_data.slot
	new_data.global_value = my_cd and my_cd.global_value or "normal"
	new_data.akimbo_gui_data = tweak_data.weapon[crafted.weapon_id] and tweak_data.weapon[crafted.weapon_id].akimbo_gui_data
	new_data.cosmetic_id = cosmetic_id
	new_data.cosmetic_quality = quality
	new_data.cosmetic_rarity = my_cd and my_cd.rarity or "common"
	new_data.cosmetic_bonus = bonus
	new_data.unlocked = unlocked
	new_data.equipped = equipped
	new_data.stream = true
	new_data.lock_texture = not new_data.unlocked

	if new_data.default_blueprint then
		new_data.comparision_data = managers.blackmarket:get_weapon_stats(new_data.category, new_data.slot, new_data.default_blueprint)
	end

	if new_data.unlocked then
		if managers.blackmarket:last_previewed_cosmetic() == cosmetic_id then
			table.insert(new_data, "wcc_cancel_preview")
		else
			table.insert(new_data, "wcc_preview")
		end
	end

	if new_data.equipped then
		table.insert(new_data, "wcc_remove")
	end

	if new_data.unlocked then
		if not crafted.previewing and not new_data.equipped then
			table.insert(new_data, "wcs_equip")
		end

		table.insert(new_data, "wcs_set_scheme")
		table.insert(new_data, "wcs_set_wear")
		table.insert(new_data, "wcs_set_scale")

		if managers.blackmarket:is_previewing_any_mod() then
			table.insert(new_data, "wm_clear_mod_preview")
		end
	else
		if managers.blackmarket:last_previewed_cosmetic() == cosmetic_id then
			table.insert(new_data, "wcc_cancel_preview")
		else
			table.insert(new_data, "wcc_preview")
		end

		if not crafted.previewing and not my_cd.is_a_unlockable and managers.menu:is_pc_controller() then
			table.insert(new_data, "wcc_market")
		end

		if managers.blackmarket:is_previewing_any_mod() then
			table.insert(new_data, "wm_clear_mod_preview")
		end

		local lock_icon = nil

		if managers.dlc:is_content_achievement_locked("weapon_skins", new_data.name) or managers.dlc:is_content_achievement_milestone_locked("weapon_skins", new_data.name) then
			lock_icon = "guis/textures/pd2/lock_achievement"
		end

		new_data.mini_icons = new_data.mini_icons or {}

		local dlc = cosmetic_data.dlc or managers.dlc:global_value_to_dlc(cosmetic_data.global_value)
		local dlc_unlocked = not dlc or managers.dlc:is_dlc_unlocked(dlc)
		if not dlc_unlocked then
			lock_icon = "guis/textures/pd2/lock_dlc"
		end

		table.insert(new_data.mini_icons, {
			stream = true,
			layer = 2,
			h = 30,
			w = 30,
			blend_mode = "normal",
			bottom = 1,
			right = 1,
			texture = lock_icon or my_cd.is_a_unlockable and "guis/textures/pd2/skilltree/padlock" or "guis/textures/pd2/lock_dlc",
			color = tweak_data.screen_colors.important_1
		})
	end

	return new_data
end

require("lib/managers/menu/WalletGuiObject")
local is_win32 = SystemInfo:platform() == Idstring("WIN32")
local NOT_WIN_32 = not is_win32
local WIDTH_MULTIPLIER = NOT_WIN_32 and 0.68 or 0.71
local BOX_GAP = 13.5
local GRID_H_MUL = (NOT_WIN_32 and 7 or 6.9) / 8
local massive_font = tweak_data.menu.pd2_massive_font
local large_font = tweak_data.menu.pd2_large_font
local medium_font = tweak_data.menu.pd2_medium_font
local small_font = tweak_data.menu.pd2_small_font
local massive_font_size = tweak_data.menu.pd2_massive_font_size
local large_font_size = tweak_data.menu.pd2_large_font_size
local medium_font_size = tweak_data.menu.pd2_medium_font_size
local small_font_size = tweak_data.menu.pd2_small_font_size

BlackMarketGuiTabItem = BlackMarketGuiTabItem or class(BlackMarketGuiItem)
function BlackMarketGuiTabItem:init(main_panel, data, node, size_data, hide_select_rect, scroll_tab_table)
	BlackMarketGuiTabItem.super.init(self, main_panel, data, 0, 0, main_panel:w(), main_panel:h())
	local grid_panel_w = size_data.grid_w
	local grid_panel_h = size_data.grid_h
	local square_w = size_data.square_w
	local square_h = size_data.square_h
	local padding_w = size_data.padding_w
	local padding_h = size_data.padding_h
	local left_padding = size_data.left_padding
	local top_padding = size_data.top_padding
	self._size_data = size_data
	self._node = node
	if not data.override_slots then
		local slots = {3, 3}
	end
	local slots = {3, 3}
	slots[1] = math.max(1, slots[1])
	slots[2] = math.max(1, slots[2])
	self.my_slots_dimensions = slots
	square_w = square_w * 3 / slots[1]
	square_h = square_h * 3 / slots[2]
	self._square_w = square_w
	self._square_h = square_h
	self._tab_panel = scroll_tab_table.panel:panel({name = "tab_panel"})
	self._tab_text_string = utf8.to_upper(data.name_localized or managers.localization:text(data.name))
	local text = self._tab_panel:text({
		name = "tab_text",
		align = "center",
		vertical = "center",
		text = self._tab_text_string,
		font_size = medium_font_size,
		font = medium_font,
		color = tweak_data.screen_colors.button_stage_3,
		blend_mode = "add",
		layer = 1,
		visible = not hide_select_rect
	})
	BlackMarketGui.make_fine_text(self, text)
	local _, _, tw, th = text:text_rect()
	self._tab_panel:set_size(tw + 15, th + 10)
	self._tab_panel:child("tab_text"):set_size(self._tab_panel:size())
	self._tab_panel:set_center_x(self._panel:w() / 2)
	self._tab_panel:set_y(0)
	self._tab_panel:bitmap({
		name = "tab_select_rect",
		texture = "guis/textures/pd2/shared_tab_box",
		w = self._tab_panel:w(),
		h = self._tab_panel:h(),
		layer = 0,
		color = tweak_data.screen_colors.text:with_alpha(hide_select_rect and 0 or 1),
		visible = false
	})
	table.insert(scroll_tab_table, self._tab_panel)
	self._child_panel = self._panel:panel()
	self._grid_panel = self._child_panel:panel({
		name = "grid_panel",
		w = grid_panel_w,
		h = grid_panel_h,
		layer = 1
	})
	self._grid_panel:set_left(0)
	self._grid_panel:set_top(self._tab_panel:bottom() - 2 + top_padding)
	self._grid_panel:rect({
		color = Color.white:with_alpha(0),
		layer = -10
	})
	self._grid_scroll_panel = self._grid_panel:panel({
		name = "grid_scroll_panel",
		halign = "grow"
	})
	self._node:parameters().menu_component_tabs = self._node:parameters().menu_component_tabs or {}
	self._node:parameters().menu_component_tabs[data.name] = self._node:parameters().menu_component_tabs[data.name] or {}
	self._my_node_data = self._node:parameters().menu_component_tabs[data.name]
	self._data.on_create_func(self._data)
	self._grid_scroll_panel:set_h(grid_panel_h / slots[2] * #self._data / slots[1])
	local scrolling = self._grid_scroll_panel:h() > self._grid_panel:h()
	if scrolling then
		self._grid_panel:grow(-9, 0)
		square_w = square_w - 9 / slots[1]
	end
	self._slots = {}
	local slot_equipped = 1
	local max_y_index = 0
	for index, data in ipairs(self._data) do
		local new_slot_class = BlackMarketGuiSlotItem
		if data.unique_slot_class then
			new_slot_class = _G[data.unique_slot_class]
		end
		local y_index = math.floor((index - 1) / slots[1])
		max_y_index = math.max(max_y_index, y_index)
		local new_slot = new_slot_class:new(self._grid_scroll_panel, data, padding_w + (index - 1) % slots[1] * (square_w + padding_w), padding_h + y_index * (square_h + padding_h), square_w, square_h)
		new_slot.rect_bg:set_alpha(scrolling and y_index % 2 == 1 and 0.1 or 0)
		table.insert(self._slots, new_slot)
		if data.equipped then
			slot_equipped = index
		end
	end
	self._max_y_index = max_y_index
	self.my_scroll_slots_y = math.max(self.my_slots_dimensions[2], math.ceil(#self._data / self.my_slots_dimensions[1]))
	self._my_node_data.scroll_y_index = self._my_node_data.scroll_y_index or 1
	--self:check_new_drop()
	self._scroll_bar_panel = self._child_panel:panel({
		name = "scroll_bar_panel",
		w = BOX_GAP + 9,
		h = self._grid_panel:h()
	})
	self._scroll_bar_panel:set_left(self._grid_panel:right() - 2)
	self._scroll_bar_panel:set_top(self._grid_panel:top())
	self._scroll_indicator_box_class = BoxGuiObject:new(self._grid_panel, {
		sides = {
			0,
			0,
			0,
			0
		}
	})
	local texture, rect = tweak_data.hud_icons:get_icon_data("scrollbar_arrow")
	local scroll_up_indicator_arrow = self._scroll_bar_panel:bitmap({
		name = "scroll_up_indicator_arrow",
		texture = texture,
		texture_rect = rect,
		layer = 2,
		color = Color.white
	})
	scroll_up_indicator_arrow:set_center_x(self._scroll_bar_panel:w() / 2)
	local texture, rect = tweak_data.hud_icons:get_icon_data("scrollbar_arrow")
	local scroll_down_indicator_arrow = self._scroll_bar_panel:bitmap({
		name = "scroll_down_indicator_arrow",
		texture = texture,
		texture_rect = rect,
		layer = 2,
		color = Color.white,
		rotation = 180
	})
	scroll_down_indicator_arrow:set_bottom(self._scroll_bar_panel:h())
	scroll_down_indicator_arrow:set_center_x(self._scroll_bar_panel:w() / 2)
	local bar_h = scroll_down_indicator_arrow:top() - scroll_up_indicator_arrow:bottom()
	self._scroll_bar_panel:rect({
		color = Color.black,
		alpha = 0.05,
		y = scroll_up_indicator_arrow:bottom(),
		h = bar_h,
		w = 4,
		x = 4
	})
	bar_h = scroll_down_indicator_arrow:bottom() - scroll_up_indicator_arrow:top()
	local scroll_bar = self._scroll_bar_panel:panel({
		name = "scroll_bar",
		layer = 2,
		h = bar_h,
		w = self._scroll_bar_panel:w()
	})
	local scroll_bar_box_panel = scroll_bar:panel({
		name = "scroll_bar_box_panel",
		w = 4,
		halign = "scale",
		valign = "scale"
	})
	scroll_bar_box_panel:set_center_x(scroll_bar:w() / 2)
	self._scroll_bar_box_class = BoxGuiObject:new(scroll_bar_box_panel, {
		sides = {
			2,
			2,
			0,
			0
		}
	})
	self._scroll_bar_box_class:set_aligns("scale", "scale")
	scroll_bar_box_panel:set_w(8)
	scroll_bar:set_top(scroll_up_indicator_arrow:bottom())
	scroll_bar:set_center_x(scroll_up_indicator_arrow:center_x())
	self._slot_selected = 0 < #self._slots and (self._my_node_data.selected or slot_equipped)
	self._slot_highlighted = nil
	self:set_scroll_y(self._slot_selected)
	self:deselect(true)
	self:set_highlight(false)
end

function BlackMarketGuiTabItem:is_inside_scrollbar(x, y)
	if self._scroll_bar_panel:visible() and self._scroll_bar_panel:inside(x, y) then
		return true
	end
	return false
end

function BlackMarketGuiTabItem:destroy()
	for i, slot in ipairs(self._slots) do
		slot:destroy()
	end
end

function BlackMarketGuiTabItem:deselect(instant)
	self:release_scroll_bar()
	BlackMarketGuiTabItem.super.deselect(self, instant)
end

function BlackMarketGuiTabItem:set_tab_text(new_text)
	local text = self._tab_panel:child("tab_text")
	text:set_text(new_text)
	BlackMarketGui.make_fine_text(self, text)
	local _, _, tw, th = text:text_rect()
	self._tab_panel:set_size(tw + 15, th + 10)
	text:set_size(self._tab_panel:size())
	self._tab_panel:child("tab_select_rect"):set_size(self._tab_panel:size())
end

function BlackMarketGuiTabItem:check_new_drop(first_time)
	local got_new_drop = false
	for _, slot in pairs(self._slots) do
		if slot._data.new_drop_data and slot._data.new_drop_data.icon then
			got_new_drop = true
		else
		end
	end
	local tab_text_string = self._tab_text_string
	if got_new_drop then
		tab_text_string = tab_text_string .. "" .. managers.localization:get_default_macro("BTN_INV_NEW")
	else
	end
	self:set_tab_text(tab_text_string)
end

function BlackMarketGuiTabItem:refresh()
	self._alpha = 1
	if self._selected then
		self._tab_panel:child("tab_text"):set_color(tweak_data.screen_colors.button_stage_1)
		self._tab_panel:child("tab_text"):set_blend_mode("normal")
		self._tab_panel:child("tab_select_rect"):show()
	elseif self._highlighted then
		self._tab_panel:child("tab_text"):set_color(tweak_data.screen_colors.button_stage_2)
		self._tab_panel:child("tab_text"):set_blend_mode("add")
		self._tab_panel:child("tab_select_rect"):hide()
	else
		self._tab_panel:child("tab_text"):set_color(tweak_data.screen_colors.button_stage_3)
		self._tab_panel:child("tab_text"):set_blend_mode("add")
		self._tab_panel:child("tab_select_rect"):hide()
	end
	if self._child_panel and alive(self._child_panel) then
		self._child_panel:set_visible(self._selected)
	end
end

function BlackMarketGuiTabItem:set_tab_position(x)
	self._tab_panel:set_x(x)
	local _, _, tw, th = self._tab_panel:child("tab_text"):text_rect()
	self._tab_panel:set_size(tw + 15, th + 10)
	self._tab_panel:child("tab_text"):set_size(self._tab_panel:size())
	if self._new_drop_icon then
		self._new_drop_icon:set_leftbottom(0, 0)
	end
	return math.round(x + tw + 15 + 5)
end

function BlackMarketGuiTabItem:check_grab_scroll_bar(x, y)
	local scroll_bar = self._scroll_bar_panel:child("scroll_bar")
	if self._scroll_bar_panel:visible() and scroll_bar:inside(x, y) then
		self._grabbed_scroll_bar = true
		self._current_scroll_bar_y = y
		return true
	end
	local height = self._square_h + self._size_data.padding_h
	if self._scroll_bar_panel:child("scroll_up_indicator_arrow"):visible() and self._scroll_bar_panel:child("scroll_up_indicator_arrow"):inside(x, y) then
		self._my_node_data.scroll_y_index = math.max(self._my_node_data.scroll_y_index - 1, 1)
		self._pressing_arrow_up = true
		self:set_scroll_y()
		return true
	end
	if self._scroll_bar_panel:child("scroll_down_indicator_arrow"):visible() and self._scroll_bar_panel:child("scroll_down_indicator_arrow"):inside(x, y) then
		self._my_node_data.scroll_y_index = math.min(self._my_node_data.scroll_y_index + 1, self._max_y_index - 1)
		self._pressing_arrow_down = true
		self:set_scroll_y()
		return true
	end
	return false
end

function BlackMarketGuiTabItem:release_scroll_bar()
	self._pressing_arrow_up = nil
	self._pressing_arrow_down = nil
	if self._grabbed_scroll_bar then
		self._grabbed_scroll_bar = nil
		return true
	end
	return false
end

function BlackMarketGuiTabItem:scroll_with_bar(target_y, current_y)
	local scroll_up_indicator_arrow = self._scroll_bar_panel:child("scroll_up_indicator_arrow")
	local scroll_down_indicator_arrow = self._scroll_bar_panel:child("scroll_down_indicator_arrow")
	local scroll_bar = self._scroll_bar_panel:child("scroll_bar")
	local grid_panel = self._grid_panel
	local grid_scroll_panel = self._grid_scroll_panel
	local mul = grid_scroll_panel:h() / grid_panel:h()
	local height = self._square_h + self._size_data.padding_h
	local diff = current_y - target_y
	if diff == 0 then
		return current_y
	end
	local grid_panel = self._grid_panel
	local grid_scroll_panel = self._grid_scroll_panel
	local max_view_x = self.my_slots_dimensions[1] or 3
	local max_view_y = self.my_slots_dimensions[2] or 3
	local dir = diff / math.abs(diff)
	while math.abs(current_y - target_y) >= height / mul do
		if dir > 0 and 1 >= self._my_node_data.scroll_y_index then
			self._my_node_data.scroll_y_index = 1
			break
		elseif dir < 0 and self._my_node_data.scroll_y_index + max_view_y - 1 >= self._max_y_index + 1 then
			self._my_node_data.scroll_y_index = self._max_y_index - 1
			break
		end
		current_y = current_y - height / mul * dir
		self._my_node_data.scroll_y_index = self._my_node_data.scroll_y_index - 1 * dir
	end
	self:set_scroll_y()
	return current_y
end

function BlackMarketGuiTabItem:set_scroll_indicators()
	local new_y_index = self._my_node_data.scroll_y_index
	local max_view_x = self.my_slots_dimensions[1] or 3
	local max_view_y = self.my_slots_dimensions[2] or 3
	local scroll_up_indicator_arrow = self._scroll_bar_panel:child("scroll_up_indicator_arrow")
	local scroll_down_indicator_arrow = self._scroll_bar_panel:child("scroll_down_indicator_arrow")
	local scroll_bar = self._scroll_bar_panel:child("scroll_bar")
	local grid_panel = self._grid_panel
	local grid_scroll_panel = self._grid_scroll_panel
	if grid_scroll_panel:h() == 0 then
		Application:error("[BlackMarketGuiTabItem:set_scroll_indicators] Dodging division by zero.", "grid_scroll_panel", inspect(self._data), inspect(self))
		return
	end
	local bar_h = scroll_down_indicator_arrow:bottom() - scroll_up_indicator_arrow:top()
	local scroll_diff = grid_panel:h() / grid_scroll_panel:h()
	if scroll_diff ~= 1 then
		local old_h = scroll_bar:h()
		scroll_bar:set_h(bar_h * scroll_diff)
		if old_h ~= scroll_bar:h() then
		end
	end
	local sh = grid_scroll_panel:h()
	scroll_bar:set_y(-grid_scroll_panel:y() * grid_panel:h() / sh)
	scroll_bar:set_center_x(scroll_up_indicator_arrow:center_x())
	scroll_bar:set_x(math.round(scroll_bar:x()) - 1)
	local visible = grid_scroll_panel:h() > grid_panel:h()
	local scroll_up_visible = new_y_index > 1
	local scroll_dn_visible = new_y_index + max_view_y - 1 < self._max_y_index + 1
	scroll_up_indicator_arrow:set_visible(scroll_up_visible)
	scroll_down_indicator_arrow:set_visible(scroll_dn_visible)
	if self._scroll_up_visible ~= scroll_up_visible or self._scroll_dn_visible ~= scroll_dn_visible then
		self._scroll_up_visible = scroll_up_visible
		self._scroll_dn_visible = scroll_dn_visible
		self._scroll_indicator_box_class:create_sides(self._grid_panel, {
			sides = {
				0,
				0,
				scroll_up_visible and 2 or 0,
				scroll_dn_visible and 2 or 0
			}
		})
	end
	self._scroll_bar_panel:set_visible(visible)
end

function BlackMarketGuiTabItem:mouse_pressed(button, x, y)
	if self._scroll_bar_panel:visible() then
		if button == Idstring("mouse wheel down") then
			local max_view_x = self.my_slots_dimensions[1] or 3
			local max_view_y = self.my_slots_dimensions[2] or 3
			if self._my_node_data.scroll_y_index + max_view_y - 1 >= self._max_y_index + 1 then
				self._my_node_data.scroll_y_index = self._max_y_index - 1
			else
				self._my_node_data.scroll_y_index = self._my_node_data.scroll_y_index + 1
			end
			self:set_scroll_y()
			return self._slots[self._slot_selected]
		elseif button == Idstring("mouse wheel up") then
			local max_view_x = self.my_slots_dimensions[1] or 3
			local max_view_y = self.my_slots_dimensions[2] or 3
			if 1 >= self._my_node_data.scroll_y_index then
				self._my_node_data.scroll_y_index = 1
			else
				self._my_node_data.scroll_y_index = self._my_node_data.scroll_y_index - 1
			end
			self:set_scroll_y()
			return self._slots[self._slot_selected]
		end
	end
	if self:check_grab_scroll_bar(x, y) then
		return self._slots[self._slot_selected]
	end
	if not self._slots[self._slot_highlighted] then
		return
	end
	if self._slots[self._slot_selected] == self._slots[self._slot_highlighted] then
		return
	end
	if button ~= Idstring("0") then
		return
	end
	if self._slots[self._slot_highlighted] and self._slots[self._slot_highlighted]:inside(x, y) then
		if self._slots[self._slot_selected] then
			self._slots[self._slot_selected]:deselect(false)
		end
		return self:select_slot(self._slot_highlighted)
	end
end

function BlackMarketGuiTabItem:selected_slot_center()
	if not self._slots[self._slot_selected] then
		return 0, 0
	end
	local x = self._slots[self._slot_selected]._panel:world_center_x()
	local y = self._slots[self._slot_selected]._panel:world_center_y()
	return x, y
end

function BlackMarketGuiTabItem:set_scroll_y(slot)
	local max_view_x = self.my_slots_dimensions[1] or 3
	local max_view_y = self.my_slots_dimensions[2] or 3
	local y_index = slot and math.ceil(slot / max_view_x)
	local top = self._my_node_data.scroll_y_index or 1
	local bottom = top + max_view_y - 1
	local height = self._square_h + self._size_data.padding_h
	local new_y_index = self._my_node_data.scroll_y_index
	if y_index and y_index < top then
		new_y_index = y_index
	end
	if y_index and y_index > bottom then
		new_y_index = y_index - max_view_y + 1
	end
	self._grid_scroll_panel:set_y(-(new_y_index - 1) * height)
	self._my_node_data.scroll_y_index = new_y_index
	self:set_scroll_indicators()
end

function BlackMarketGuiTabItem:select_slot(slot, instant)
	if not slot then
	else
		slot = (self._slot_selected or self._slots[slot]) and slot
	end
	if not slot then
		slot = self._slot_selected or 1
		for i, d in pairs(self._slots) do
			if d._data and d._data.equipped then
				slot = i
			end
		end
	end
	local no_sound = false
	if self._slots[slot] and self._slots[slot]._name == "empty" then
		if slot > self._slot_selected then
			return self:select_slot(slot - 1, instant)
		end
		slot = self._slot_selected
		no_sound = true
	end
	if self._slots[self._slot_selected] then
		self._slots[self._slot_selected]:deselect(instant)
	end
	local old_slot = self._slot_selected
	self._slot_selected = slot
	self._my_node_data.selected = self._slot_selected
	if old_slot ~= slot then
		self:set_scroll_y(slot)
	end
	local selected_slot = {}
	if not self._slots[self._slot_selected] then
		selected_slot = self._slots[1]:select(instant, no_sound)
	else
		selected_slot = self._slots[self._slot_selected]:select(instant, no_sound)
	end
	--self:check_new_drop()
	managers.menu_component:set_blackmarket_tab_positions()
	return selected_slot
end

function BlackMarketGuiTabItem:slots()
	return self._slots
end

BlackMarketGuiSlotItem = BlackMarketGuiSlotItem or class(BlackMarketGuiItem)
function BlackMarketGuiSlotItem:init(main_panel, data, x, y, w, h)
	BlackMarketGuiSlotItem.super.init(self, main_panel, data, x, y, w, h)
	self.rect_bg = self._panel:rect({
		color = Color.black,
		alpha = 0
	})
	if data.holding then
		self._post_load_alpha = 0.2
		data.equipped_text = managers.localization:to_upper_text("bm_menu_holding_item")
	end
	if data.custom_name_text then
		local custom_name_text = self._panel:text({
			name = "custom_name_text",
			text = data.custom_name_text,
			align = "right",
			vertical = "top",
			font_size = small_font_size,
			font = small_font,
			color = tweak_data.screen_colors.text,
			layer = 2
		})
		custom_name_text:move((data.custom_name_text_right or 0) - 5, 5)
		local right = custom_name_text:right()
		custom_name_text:grow(-(custom_name_text:w() * (data.custom_name_text_width or 0.5)), 0)
		local _, _, w, h = custom_name_text:text_rect()
		if w > custom_name_text:w() then
			custom_name_text:set_font_scale(custom_name_text:font_scale() * custom_name_text:w() / w)
		end
		custom_name_text:set_right(right)
	end
	if data.hide_bg then
	end
	if data.mid_text and type(data.mid_text) == "table" then
		local text = self._panel:text({
			name = "text",
			text = data.mid_text.no_upper and data.mid_text.noselected_text or utf8.to_upper(data.mid_text.noselected_text),
			align = data.mid_text.align or "center",
			vertical = data.mid_text.vertical or "center",
			font_size = data.mid_text.font_size or medium_font_size,
			font = data.mid_text.font or medium_font,
			color = data.mid_text.noselected_color,
			blend_mode = data.mid_text.blend_mode or "add",
			layer = 2,
			wrap = true,
			word_wrap = true
		})
		text:grow(-10, -10)
		text:move(5, 5)
		if data.lock_texture then
			text:move(0, text:h() / 2 - text:font_size() / 2)
			text:set_vertical("top")
		end
		self._text_in_mid = true
	end
	local animate_loading_texture = function(o)
		o:set_render_template(Idstring("VertexColorTexturedRadial"))
		o:set_color(Color(0, 0, 1, 1))
		local time = coroutine.yield()
		o:set_color(Color(1, 0, 1, 1))
		while true do
			o:set_color(Color(1, time % 1, 1, 1))
			time = time + coroutine.yield() * 2
		end
	end

	self._extra_textures = {}
	if data.extra_bitmaps then
		local color, shape
		for i, bitmap in ipairs(data.extra_bitmaps) do
			if DB:has(Idstring("texture"), bitmap) then
				color = data.extra_bitmaps_colors and data.extra_bitmaps_colors[i] or Color.white
				shape = data.extra_bitmaps_shape and data.extra_bitmaps_shape[i] or {x = 0, y = 0}
				table.insert(self._extra_textures, self._panel:bitmap({
					texture = bitmap,
					color = color,
					w = 32,
					h = 32,
					layer = 0,
					x = self._panel:w() * shape.x,
					y = self._panel:h() * shape.y
				}))
			else
				Application:error("[BlackMarketGuiSlotItem] Texture not found in DB: ", tostring(bitmap))
			end
		end
	end
	local texture_loaded_clbk = callback(self, self, "texture_loaded_clbk")
	if data.mini_icons then
		local padding = data.mini_icons.borders and 14 or 5
		for k, icon_data in ipairs(data.mini_icons) do
			icon_data.padding = padding
			if not icon_data.texture then
				local new_icon
				if icon_data.text then
					new_icon = self._panel:text({
						font = tweak_data.menu.pd2_small_font,
						font_size = tweak_data.menu.pd2_font_size,
						text = icon_data.text,
						color = icon_data.color or Color.white,
						w = icon_data.w or 32,
						h = icon_data.h or 32,
						layer = icon_data.layer or 1,
						blend_mode = icon_data.blend_mode
					})
				else
					new_icon = self._panel:rect({
						color = icon_data.color or Color.white,
						w = icon_data.w or 32,
						h = icon_data.h or 32,
						layer = icon_data.layer or 1,
						blend_mode = icon_data.blend_mode,
						alpha = icon_data.alpha
					})
				end
				if icon_data.visible == false then
					new_icon:set_visible(false)
				end
				if icon_data.left then
					new_icon:set_left(padding + icon_data.left)
				elseif icon_data.right then
					new_icon:set_right(self._panel:w() - padding - icon_data.right)
				end
				if icon_data.top then
					new_icon:set_top(padding + icon_data.top)
				elseif icon_data.bottom then
					new_icon:set_bottom(self._panel:h() - padding - icon_data.bottom)
				end
				if icon_data.name == "new_drop" and data.new_drop_data then
					data.new_drop_data.icon = new_icon
				end
			elseif icon_data.stream then
				if DB:has(Idstring("texture"), icon_data.texture) then
					icon_data.request_index = managers.menu_component:request_texture(icon_data.texture, callback(self, self, "icon_loaded_clbk", icon_data)) or false
				end
			else
				local new_icon = self._panel:bitmap({
					texture = icon_data.texture,
					color = icon_data.color or Color.white,
					w = icon_data.w or 32,
					h = icon_data.h or 32,
					layer = icon_data.layer or 1,
					alpha = icon_data.alpha
				})
				if icon_data.render_template then
					new_icon:set_render_template(icon_data.render_template)
				end
				if icon_data.visible == false then
					new_icon:set_visible(false)
				end
				if icon_data.left then
					new_icon:set_left(padding + icon_data.left)
				elseif icon_data.right then
					new_icon:set_right(self._panel:w() - padding - icon_data.right)
				end
				if icon_data.top then
					new_icon:set_top(padding + icon_data.top)
				elseif icon_data.bottom then
					new_icon:set_bottom(self._panel:h() - padding - icon_data.bottom)
				end
				if icon_data.name == "new_drop" and data.new_drop_data then
					data.new_drop_data.icon = new_icon
				end
				if icon_data.spin then
					local spin_animation = function(o)
						local dt
						while true do
							dt = coroutine.yield()
							o:rotate(dt * 180)
						end
					end

					new_icon:animate(spin_animation)
					self._loading_icon = new_icon
				end
			end
			if icon_data.borders then
				local icon_border_panel = self._panel:panel({
					w = icon_data.w or 32,
					h = icon_data.h or 32,
					layer = icon_data.layer or 1
				})
				if icon_data.visible == false then
					icon_border_panel:set_visible(false)
				end
				if icon_data.left then
					icon_border_panel:set_left(padding + icon_data.left)
				elseif icon_data.right then
					icon_border_panel:set_right(self._panel:w() - padding - icon_data.right)
				end
				if icon_data.top then
					icon_border_panel:set_top(padding + icon_data.top)
				elseif icon_data.bottom then
					icon_border_panel:set_bottom(self._panel:h() - padding - icon_data.bottom)
				end
				BoxGuiObject:new(icon_border_panel, {
					sides = {
						1,
						1,
						1,
						1
					}
				})
			end
		end
		if data.mini_icons.borders then
			local tl_side = self._panel:rect({
				w = 10,
				h = 2,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			local tl_down = self._panel:rect({
				w = 2,
				h = 10,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			local tr_side = self._panel:rect({
				w = 10,
				h = 2,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			local tr_down = self._panel:rect({
				w = 2,
				h = 10,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			local bl_side = self._panel:rect({
				w = 10,
				h = 2,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			local bl_down = self._panel:rect({
				w = 2,
				h = 10,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			local br_side = self._panel:rect({
				w = 10,
				h = 2,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			local br_down = self._panel:rect({
				w = 2,
				h = 10,
				color = Color.white,
				alpha = 0.4,
				blend_mode = "add"
			})
			tl_side:set_lefttop(self._panel:w() - 54, 8)
			tl_down:set_lefttop(self._panel:w() - 54, 8)
			tr_side:set_righttop(self._panel:w() - 8, 8)
			tr_down:set_righttop(self._panel:w() - 8, 8)
			bl_side:set_leftbottom(self._panel:w() - 54, self._panel:h() - 8)
			bl_down:set_leftbottom(self._panel:w() - 54, self._panel:h() - 8)
			br_side:set_rightbottom(self._panel:w() - 8, self._panel:h() - 8)
			br_down:set_rightbottom(self._panel:w() - 8, self._panel:h() - 8)
		end
	end
	if data.bitmap_texture then
		if DB:has(Idstring("texture"), data.bitmap_texture) then
			self._loading_texture = true
			if data.stream then
				self._requested_texture = data.bitmap_texture
				self._request_index = managers.menu_component:request_texture(self._requested_texture, texture_loaded_clbk)
			else
				texture_loaded_clbk(data.bitmap_texture, Idstring(data.bitmap_texture))
			end
		end
		if not self._bitmap then
			self._bitmap = self._panel:bitmap({
				name = "item_texture",
				texture = "guis/textures/pd2/endscreen/exp_ring",
				color = Color(0.2, 1, 1),
				w = 32,
				h = 32,
				layer = #self._extra_textures + 1,
				render_template = "VertexColorTexturedRadial"
			})
			self._bitmap:set_center(self._panel:w() / 2, self._panel:h() / 2)
			self._bitmap:animate(animate_loading_texture)
		end
	elseif data.bg_texture then
		if DB:has(Idstring("texture"), data.bg_texture) then
			self._loading_texture = true
			if data.stream then
				self._requested_texture = data.bg_texture
				self._request_index = managers.menu_component:request_texture(self._requested_texture, texture_loaded_clbk)
			else
				texture_loaded_clbk(data.bg_texture, Idstring(data.bg_texture))
			end
		end
		if not self._bitmap then
			self._bitmap = self._panel:bitmap({
				name = "item_texture",
				texture = "guis/textures/pd2/endscreen/exp_ring",
				color = Color(0.2, 1, 1),
				w = 32,
				h = 32,
				layer = #self._extra_textures + 1,
				render_template = "VertexColorTexturedRadial"
			})
			self._bitmap:set_center(self._panel:w() / 2, self._panel:h() / 2)
			self._bitmap:animate(animate_loading_texture)
		end
	end
	local equipped_text = self._panel:text({
		name = "equipped_text",
		text = "",
		align = "left",
		vertical = "top",
		font_size = small_font_size,
		font = small_font,
		color = tweak_data.screen_colors.text,
		layer = 2
	})
	equipped_text:move(5, 5)
	if data.equipped then
		local equipped_string = data.equipped_text or managers.localization:text("bm_menu_equipped")
		equipped_text:set_text(utf8.to_upper(equipped_string))
		self._equipped_box = BoxGuiObject:new(self._panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
	end
	local red_box = false
	local number_text = false
	self._conflict = data.conflict
	self._level_req = data.level
	if data.lock_texture then
		red_box = true
	end
	if type(data.unlocked) == "number" then
		number_text = math.abs(data.unlocked)
		if 0 > data.unlocked then
			red_box = true
			self._item_req = true
		end
	end
	if data.mid_text then
		if self._bitmap then
			self._bitmap:set_color(self._bitmap:color():with_alpha(0.6))
		end
		if self._loading_texture then
			self._post_load_alpha = 0.4
		end
	end
	if red_box then
		if self._bitmap then
			self._bitmap:set_color(Color.white:with_alpha(0.6))
			for _, bitmap in pairs(self._extra_textures) do
				bitmap:set_color(bitmap:color():with_alpha(0.6))
			end
			self._bitmap:set_blend_mode("sub")
		end
		if self._loading_texture then
			self._post_load_alpha = 0.6
			self._post_load_blend_mode = "sub"
		end
		if (not data.unlocked or data.can_afford ~= false) and data.lock_texture ~= true then
			self._lock_bitmap = self._panel:bitmap({
				name = "lock",
				texture = data.lock_texture or "guis/textures/pd2/skilltree/padlock",
				w = 32,
				h = 32,
				color = data.lock_color or tweak_data.screen_colors.important_1,
				layer = #self._extra_textures + 2
			})
			if data.lock_shape then
				local w = data.lock_shape.w or 32
				local h = data.lock_shape.h or 32
				self._lock_bitmap:set_size(w, h)
			end
			self._lock_bitmap:set_center(self._panel:w() / 2, self._panel:h() / 2)
			if data.lock_shape then
				local x = data.lock_shape.x or 0
				local y = data.lock_shape.y or 0
				self._lock_bitmap:move(x, y)
			end
		end
	end
	if number_text then
	end
	self:deselect(true)
	self:set_highlight(false, true)
end

function BlackMarketGuiSlotItem:get_texure_size(debug)
	if self._bitmap then
		local texture_width = self._bitmap:texture_width()
		local texture_height = self._bitmap:texture_height()
		local panel_width, panel_height = self._panel:size()
		if texture_width == 0 or texture_height == 0 or panel_width == 0 or panel_height == 0 then
			if debug then
				Application:error("BlackMarketGuiSlotItem:get_texure_size(): " .. self._data.bitmap_texture or self._data.bg_texture or "")
				Application:debug("BlackMarketGuiSlotItem:", "texture_width " .. texture_width, "texture_height " .. texture_height, "panel_width " .. panel_width, "panel_height " .. panel_height)
			end
			return 0, 0
		end
		local aspect = panel_width / panel_height
		local sw = math.max(texture_width, texture_height * aspect)
		local sh = math.max(texture_height, texture_width / aspect)
		local dw = texture_width / sw
		local dh = texture_height / sh
		return math.round(dw * panel_width), math.round(dh * panel_height)
	end
	return 0, 0
end

function BlackMarketGuiSlotItem:icon_loaded_clbk(icon_data, texture_idstring, ...)
	if not alive(self._panel) then
		Application:error("[BlackMarketGuiSlotItem] icon_loaded_clbk(): This code should no longer occur!!")
		return
	end
	local padding = icon_data.padding or 5
	local new_icon = self._panel:bitmap({
		texture = texture_idstring,
		color = icon_data.color or Color.white,
		w = icon_data.w or 32,
		h = icon_data.h or 32,
		layer = icon_data.layer or 1,
		alpha = icon_data.alpha,
		blend_mode = icon_data.blend_mode
	})
	if icon_data.render_template then
		new_icon:set_render_template(icon_data.render_template)
	end
	if icon_data.visible == false then
		new_icon:set_visible(false)
	end
	if icon_data.left then
		new_icon:set_left(padding + icon_data.left)
	elseif icon_data.right then
		new_icon:set_right(self._panel:w() - padding - icon_data.right)
	end
	if icon_data.top then
		new_icon:set_top(padding + icon_data.top)
	elseif icon_data.bottom then
		new_icon:set_bottom(self._panel:h() - padding - icon_data.bottom)
	end
	if icon_data.name == "new_drop" and self._data.new_drop_data then
		self._data.new_drop_data.icon = new_icon
	end
end

function BlackMarketGuiSlotItem:destroy()
	if self._data and self._data.mini_icons then
		for i, icon_data in ipairs(self._data.mini_icons) do
			if icon_data.stream then
				managers.menu_component:unretrieve_texture(icon_data.texture, icon_data.request_index)
			end
		end
	end
	if self._requested_texture then
		managers.menu_component:unretrieve_texture(self._requested_texture, self._request_index)
	end
end

function BlackMarketGuiSlotItem:texture_loaded_clbk(texture_idstring)
	if not alive(self._panel) then
		Application:error("[BlackMarketGuiSlotItem] texture_loaded_clbk(): This code should no longer occur!!")
		return
	end
	if self._bitmap then
		self._bitmap:stop()
		self._bitmap:set_rotation(0)
		self._bitmap:set_color(Color.white)
		self._bitmap:set_image(texture_idstring)
		self._bitmap:set_render_template(self._data.render_template or Idstring("VertexColorTextured"))
		self._bitmap:set_blend_mode("normal")
		for _, bitmap in pairs(self._extra_textures) do
			bitmap:set_color(bitmap:color():with_alpha(1))
			bitmap:set_blend_mode("normal")
		end
	else
		self._bitmap = self._panel:bitmap({
			name = "item_texture",
			texture = texture_idstring,
			blend_mode = "normal",
			layer = 1
		})
		self._bitmap:set_render_template(self._data.render_template or Idstring("VertexColorTextured"))
	end
	self._bitmap:set_size(self:get_texure_size(true))
	self._bitmap:set_center(self._panel:w() / 2, self._panel:h() / 2)
	local shape
	for i, bitmap in ipairs(self._extra_textures) do
		shape = self._data.extra_bitmaps_shape and self._data.extra_bitmaps_shape[i] or {
			x = 0,
			y = 0,
			w = 1,
			h = 1
		}
		bitmap:set_size(self._bitmap:size())
		bitmap:grow(bitmap:w() * shape.w, bitmap:h() * shape.h)
		bitmap:set_center(self._bitmap:center())
		bitmap:move(self._panel:w() * shape.x, self._panel:h() * shape.y)
	end
	if self._post_load_alpha then
		self._bitmap:set_color(Color.white:with_alpha(self._post_load_alpha))
		self._bitmap:set_blend_mode(self._post_load_blend_mode or "normal")
		for _, bitmap in pairs(self._extra_textures) do
			bitmap:set_color(bitmap:color():with_alpha(self._post_load_alpha))
			bitmap:set_blend_mode(self._post_load_blend_mode or "normal")
		end
		self._post_load_alpha = nil
		self._post_load_blend_mode = nil
	end
	self._loading_texture = nil
	self:set_highlight(self._highlighted, true)
	if self._selected then
		self:select(true)
	else
		self:deselect(true)
	end
	self:refresh()
end

function BlackMarketGuiSlotItem:set_btn_text(text)
end

function BlackMarketGuiSlotItem:set_highlight(highlight, instant)
	if self._bitmap and not self._loading_texture then
		if highlight then
			local animate_select = function(o, panel, instant, width, height)
				local w = o:w()
				local h = o:h()
				local end_w = width * 0.85
				local end_h = height * 0.85
				local center_x, center_y = o:center()
				if w == end_w or instant then
					o:set_size(end_w, end_h)
					o:set_center(center_x, center_y)
					return
				end
				over(math.abs(end_w - w) / end_w, function(p)
					o:set_size(math.lerp(w, end_w, p), math.lerp(h, end_h, p))
					o:set_center(center_x, center_y)
					end
				)
			end

			local w, h = self:get_texure_size()
			self._bitmap:stop()
			self._bitmap:animate(animate_select, self._panel, instant, w, h)
			local shape
			for i, bitmap in pairs(self._extra_textures) do
				shape = self._data.extra_bitmaps_shape and self._data.extra_bitmaps_shape[i] or {
					x = 0,
					y = 0,
					w = 1,
					h = 1
				}
				bitmap:stop()
				bitmap:animate(animate_select, self._panel, instant, w * shape.w, h * shape.h)
			end
		else
			local animate_deselect = function(o, panel, instant, width, height)
				local w = o:w()
				local h = o:h()
				local end_w = width * 0.65
				local end_h = height * 0.65
				local center_x, center_y = o:center()
				if w == end_w or instant then
					o:set_size(end_w, end_h)
					o:set_center(center_x, center_y)
					return
				end
				over(math.abs(end_w - w) / end_w, function(p)
					o:set_size(math.lerp(w, end_w, p), math.lerp(h, end_h, p))
					o:set_center(center_x, center_y)
					end
				)
			end

			local w, h = self:get_texure_size()
			self._bitmap:stop()
			self._bitmap:animate(animate_deselect, self._panel, instant, w, h)
			local shape
			for i, bitmap in pairs(self._extra_textures) do
				shape = self._data.extra_bitmaps_shape and self._data.extra_bitmaps_shape[i] or {
					x = 0,
					y = 0,
					w = 1,
					h = 1
				}
				bitmap:stop()
				bitmap:animate(animate_deselect, self._panel, instant, w * shape.w, h * shape.h)
			end
		end
	end
end

function BlackMarketGuiSlotItem:select(instant, no_sound)
	BlackMarketGuiSlotItem.super.select(self, instant, no_sound)
	if not managers.menu:is_pc_controller() then
		self:set_highlight(true, instant)
	end
	if self._text_in_mid and alive(self._panel:child("text")) then
		self._panel:child("text"):set_color(self._data.mid_text.selected_color or Color.white)
		self._panel:child("text"):set_text(self._data.mid_text.no_upper and self._data.mid_text.selected_text or utf8.to_upper(self._data.mid_text.selected_text or ""))
		if alive(self._lock_bitmap) and self._data.mid_text.is_lock_same_color then
			self._lock_bitmap:set_color(self._panel:child("text"):color())
		end
	end
	if self._data.new_drop_data then
		local newdrop = self._data.new_drop_data
		if newdrop[1] and newdrop[2] and newdrop[3] then
			managers.blackmarket:remove_new_drop(newdrop[1], newdrop[2], newdrop[3])
			if newdrop.icon then
				newdrop.icon:parent():remove(newdrop.icon)
			end
			self._data.new_drop_data = nil
		end
	end
	if self._panel:child("equipped_text") and self._data.selected_text and not self._data.equipped then
		self._panel:child("equipped_text"):set_text(self._data.selected_text)
	end
	return self
end

function BlackMarketGuiSlotItem:deselect(instant)
	BlackMarketGuiSlotItem.super.deselect(self, instant)
	if not managers.menu:is_pc_controller() then
		self:set_highlight(false, instant)
	end
	if self._text_in_mid and alive(self._panel:child("text")) then
		self._panel:child("text"):set_color(self._data.mid_text.noselected_color or Color.white)
		self._panel:child("text"):set_text(self._data.mid_text.no_upper and self._data.mid_text.noselected_text or utf8.to_upper(self._data.mid_text.noselected_text or ""))
		if alive(self._lock_bitmap) and self._data.mid_text.is_lock_same_color then
			self._lock_bitmap:set_color(self._panel:child("text"):color())
		end
	end
	if self._panel:child("equipped_text") and self._data.selected_text and not self._data.equipped then
		self._panel:child("equipped_text"):set_text("")
	end
end

function BlackMarketGuiSlotItem:refresh()
	BlackMarketGuiSlotItem.super.refresh(self)
	if self._bitmap then
		self._bitmap:set_alpha(1)
		for _, bitmap in pairs(self._extra_textures) do
			bitmap:set_alpha(1)
		end
	end
end

BlackMarketGuiMaskSlotItem = BlackMarketGuiMaskSlotItem or class(BlackMarketGuiSlotItem)
function BlackMarketGuiMaskSlotItem:init(main_panel, data, x, y, w, h)
	BlackMarketGuiMaskSlotItem.super.init(self, main_panel, data, x, y, w, h)
	local cx, cy = self._panel:w() / 2, self._panel:h() / 2
	self._box_panel = self._panel:panel({
		w = self._panel:w() * 0.5,
		h = self._panel:w() * 0.5
	})
	self._box_panel:set_center(cx, cy)
	if not data.my_part_data.is_good then
		BoxGuiObject:new(self._box_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
	end
	self._mask_text = self._panel:text({
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size
	})
	self._mask_text:set_position(self._box_panel:left(), self._box_panel:bottom() + 10)
	self._mask_text:set_text(utf8.to_upper(data.name_localized .. ": "))
	BlackMarketGui.make_fine_text(self, self._mask_text)
	self._mask_name_text = self._panel:text({
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		wrap = true,
		word_wrap = true
	})
	self._mask_name_text:set_position(self._mask_text:right(), self._mask_text:top())
	self._mask_name_text:set_text(data.my_part_data.is_good and managers.localization:text(data.my_part_data.text) or "NOT SELECTED")
	self._mask_name_text:set_blend_mode(data.my_part_data.is_good and "normal" or "add")
	self._mask_name_text:set_color(data.my_part_data.is_good and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1)
	self._mask_name_text:grow(-self._mask_name_text:x() - 5, 0)
	local _, _, _, texth = self._mask_name_text:text_rect()
	if data.my_part_data.override then
		self._mask_error_text = self._panel:text({
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			wrap = true,
			word_wrap = true,
			color = tweak_data.screen_colors.important_1,
			blend_mode = "add"
		})
		self._mask_error_text:set_position(self._mask_text:left(), self._mask_text:top() + texth)
		self._mask_error_text:set_text(managers.localization:to_upper_text("menu_bm_overwrite", {
			category = managers.localization:text("bm_menu_" .. data.my_part_data.override)
		}))
	end
	local current_match_with_true = true
	current_match_with_true = data.my_part_data.is_good and data.my_true_part_data and data.my_part_data.id == data.my_true_part_data.id
	if not current_match_with_true then
		if self._bitmap then
			self._bitmap:set_color(Color.white:with_alpha(0.3))
			for _, bitmap in pairs(self._extra_textures) do
				bitmap:set_color(bitmap:color():with_alpha(0.3))
			end
		end
		if self._loading_texture then
			self._post_load_alpha = 0.3
		end
		self._mask_text:set_color(self._mask_text:color():with_alpha(0.5))
		self._mask_name_text:set_color(self._mask_name_text:color():with_alpha(0.5))
		if self._mask_error_text then
			self._mask_error_text:set_color(self._mask_error_text:color():with_alpha(0.5))
		end
	end
	self:deselect(true)
	self:set_highlight(false, true)
end

function BlackMarketGuiMaskSlotItem:set_highlight(highlight, instant)
	if self._bitmap and not self._loading_texture then
		if highlight then
			local animate_select = function(o, panel, instant, width, height)
				local w = o:w()
				local h = o:h()
				local end_w = width * 0.55
				local end_h = height * 0.55
				local center_x, center_y = o:center()
				if w == end_w or instant then
					o:set_size(end_w, end_h)
					o:set_center(center_x, center_y)
					return
				end
				over(math.abs(end_w - w) / end_w, function(p)
					o:set_size(math.lerp(w, end_w, p), math.lerp(h, end_h, p))
					o:set_center(center_x, center_y)
				end)
			end

			local w, h = self:get_texure_size()
			self._bitmap:stop()
			self._bitmap:animate(animate_select, self._panel, instant, w, h)
			for _, bitmap in pairs(self._extra_textures) do
				bitmap:stop()
				bitmap:animate(animate_select, self._panel, instant, w, h)
			end
		else
			local animate_deselect = function(o, panel, instant, width, height)
				local w = o:w()
				local h = o:h()
				local end_w = width * 0.45
				local end_h = height * 0.45
				local center_x, center_y = o:center()
				if w == end_w or instant then
					o:set_size(end_w, end_h)
					o:set_center(center_x, center_y)
					return
				end
				over(math.abs(end_w - w) / end_w, function(p)
					o:set_size(math.lerp(w, end_w, p), math.lerp(h, end_h, p))
					o:set_center(center_x, center_y)
				end)
			end

			local w, h = self:get_texure_size()
			self._bitmap:stop()
			self._bitmap:animate(animate_deselect, self._panel, instant, w, h)
			for _, bitmap in pairs(self._extra_textures) do
				bitmap:stop()
				bitmap:animate(animate_deselect, self._panel, instant, w, h)
			end
		end
	end
end



BlackMarketGui = BlackMarketGui or class()
BlackMarketGui.identifiers = {
	weapon = Idstring("weapon"),
	armor = Idstring("armor"),
	armor_skins = Idstring("armor_skins"),
	melee_weapon = Idstring("melee_weapon"),
	grenade = Idstring("grenade"),
	mask = Idstring("mask"),
	weapon_mod = Idstring("weapon_mod"),
	mask_mod = Idstring("mask_mod"),
	deployable = Idstring("deployable"),
	character = Idstring("character"),
	gloves = Idstring("gloves"),
	player_style = Idstring("player_style"),
	suit_variation = Idstring("suit_variation")
}

function BlackMarketGui:set_enabled(enabled)
	self._enabled = enabled
	if not self._enabled then
		local blur = self._disabled_panel:bitmap({
			texture = "guis/textures/test_blur_df",
			w = self._disabled_panel:panel():w(),
			h = self._disabled_panel:panel():h(),
			render_template = "VertexColorTexturedBlur3D"
		})
		local func = function(o)
			local start_blur = 0
			over(0.6, function(p)
				o:set_alpha(math.lerp(start_blur, 1, p))
			end)
		end

		blur:animate(func)
	else
		self._disabled_panel:clear()
	end
end

function BlackMarketGui:make_fine_text(text)
	local x, y, w, h = text:text_rect()
	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end

function BlackMarketGui:_setup(is_start_page, component_data)
	if alive(self._panel) then
		self._ws:panel():remove(self._panel)
	end
	self._item_bought = nil
	self._panel = self._ws:panel():panel({})
	self._fullscreen_panel = self._fullscreen_ws:panel():panel({layer = 40})
	self:set_layer(45)
	self._disabled_panel = self._fullscreen_panel:panel({layer = 100})
	WalletGuiObject.set_wallet(self._panel)
	self._data = component_data or self:_start_page_data()
	self._node:parameters().menu_component_data = self._data
	if self._data.init_callback_name then
		local clbk_func = callback(self, self, self._data.init_callback_name, self._data.init_callback_params)
		if clbk_func then
			clbk_func()
		end
		if self._data.init_callback_params and self._data.init_callback_params.run_once then
			self._data.init_callback_name = nil
			self._data.init_callback_params = nil
		end
	end
	self._data.blur_fade = self._data.blur_fade or 0
	local blur = self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		w = self._fullscreen_ws:panel():w(),
		h = self._fullscreen_ws:panel():h(),
		render_template = "VertexColorTexturedBlur3D",
		layer = -1
	})
	local func = function(o, component_data)
		local start_blur = component_data.blur_fade
		over(0.6 - 0.6 * component_data.blur_fade, function(p)
			component_data.blur_fade = math.lerp(start_blur, 1, p)
			o:set_alpha(component_data.blur_fade)
		end)
	end

	blur:animate(func, self._data)
	self._panel:text({
		name = "back_button",
		text = utf8.to_upper(managers.localization:text("menu_back")),
		align = "right",
		vertical = "bottom",
		font_size = large_font_size,
		font = large_font,
		color = tweak_data.screen_colors.button_stage_3
	})
	self:make_fine_text(self._panel:child("back_button"))
	self._panel:child("back_button"):set_right(self._panel:w())
	self._panel:child("back_button"):set_bottom(self._panel:h())
	self._panel:child("back_button"):set_visible(managers.menu:is_pc_controller())
	self._pages = #self._data > 1 or self._data.show_tabs
	local grid_panel_w = self._panel:w() * WIDTH_MULTIPLIER
	local grid_panel_h = (self._panel:h() - (medium_font_size + 10) - 60) * GRID_H_MUL
	grid_panel_w = math.round(grid_panel_w / 3) * 3
	grid_panel_h = math.round(grid_panel_h / 3) * 3
	local square_w = grid_panel_w / 3
	local square_h = grid_panel_h / 3
	local padding_w = 0
	local padding_h = 0
	local left_padding = 0
	local top_padding = 60
	local size_data = {}
	size_data.grid_w = math.floor(grid_panel_w)
	size_data.grid_h = math.floor(grid_panel_h)
	size_data.square_w = math.floor(square_w)
	size_data.square_h = math.floor(square_h)
	size_data.padding_w = math.floor(padding_w)
	size_data.padding_h = math.floor(padding_h)
	size_data.left_padding = math.floor(left_padding)
	size_data.top_padding = math.floor(top_padding)
	self._inception_node_name = self._node:parameters().menu_component_next_node_name or "blackmarket_node"
	self._preview_node_name = self._node:parameters().menu_component_preview_node_name or "blackmarket_preview_node"
	self._tabs = {}
	self._btns = {}
	self._title_text = self._panel:text({
		name = "title_text",
		text = utf8.to_upper(managers.localization:text(self._data.topic_id, self._data.topic_params)),
		font_size = large_font_size,
		font = large_font,
		color = tweak_data.screen_colors.text
	})
	self:make_fine_text(self._title_text)
	self._tab_scroll_panel = self._panel:panel({
		w = grid_panel_w,
		y = top_padding + 1
	})
	self._tab_area_panel = self._panel:panel({
		w = grid_panel_w,
		y = top_padding + 1
	})
	self._tab_scroll_table = {
		panel = self._tab_scroll_panel
	}
	for i, data in ipairs(self._data) do
		if data.on_create_func_name then
			data.on_create_func = callback(self, self, data.on_create_func_name)
		end
		local new_tab = BlackMarketGuiTabItem:new(self._panel, data, self._node, size_data, not self._pages, self._tab_scroll_table)
		table.insert(self._tabs, new_tab)
	end
	if self._data.open_callback_name then
		local clbk_func = callback(self, self, self._data.open_callback_name, self._data.open_callback_params)
		if clbk_func then
			clbk_func()
		end
	end
	if 0 < #self._tabs then
		self._tab_area_panel:set_h(self._tabs[#self._tabs]._tab_panel:h())
	end
	self._selected = self._node:parameters().menu_component_selected or 1
	self._select_rect = self._panel:panel({
		name = "select_rect",
		w = square_w,
		h = square_h,
		layer = 8
	})
	if self._tabs[self._selected] then
		self._tabs[self._selected]:select(true)
		local slot_dim_x = self._tabs[self._selected].my_slots_dimensions[1]
		local slot_dim_y = self._tabs[self._selected].my_slots_dimensions[2]
		self._select_rect:set_size(square_w * 3 / slot_dim_x, square_h * 3 / slot_dim_y)
		self._select_rect_box = BoxGuiObject:new(self._select_rect, {
			sides = {
				2,
				2,
				2,
				2
			}
		})
		self._select_rect_box:set_clipping(false)
		self._box_panel = self._panel:panel()
		self._box_panel:set_shape(self._tabs[self._selected]._grid_panel:shape())
		self._box = BoxGuiObject:new(self._box_panel, {
			sides = {
				1,
				1,
				1 + (1 < #self._tabs and 1 or 0),
				1
			}
		})
		local info_box_panel = self._panel:panel({
			name = "info_box_panel"
		})
		info_box_panel:set_size(self._panel:w() * (1 - WIDTH_MULTIPLIER) - BOX_GAP, self._box_panel:h())
		info_box_panel:set_right(self._panel:w())
		info_box_panel:set_top(self._box_panel:top())
		self._selected_slot = self._tabs[self._selected]:select_slot(nil, true)
		self._slot_data = self._selected_slot._data
		local x, y = self._tabs[self._selected]:selected_slot_center()
		self._select_rect:set_world_center(x, y)
		local BTNS = {
			w_move = {
				prio = managers.menu:is_pc_controller() and 5 or 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_move_weapon",
				callback = callback(self, self, "pickup_crafted_item_callback")
			},
			w_place = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_place_weapon",
				callback = callback(self, self, "place_crafted_item_callback")
			},
			w_swap = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_swap_weapon",
				callback = callback(self, self, "place_crafted_item_callback")
			},
			m_move = {
				prio = 5,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_move_mask",
				callback = callback(self, self, "pickup_crafted_item_callback")
			},
			m_place = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_place_mask",
				callback = callback(self, self, "place_crafted_item_callback")
			},
			m_swap = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_swap_mask",
				callback = callback(self, self, "place_crafted_item_callback")
			},
			i_stop_move = {
				prio = 2,
				btn = "BTN_X",
				pc_btn = Idstring("menu_remove_item"),
				name = "bm_menu_btn_stop_move",
				callback = callback(self, self, "drop_hold_crafted_item_callback")
			},
			i_rename = {
				prio = 2,
				btn = "BTN_BACK",
				pc_btn = Idstring("toggle_chat"),
				name = "bm_menu_btn_rename_item",
				callback = callback(self, self, "rename_item_with_gamepad_callback")
			},
			w_mod = {
				prio = 2,
				btn = "BTN_Y",
				pc_btn = Idstring("menu_modify_item"),
				name = "bm_menu_btn_mod",
				callback = callback(self, self, "choose_weapon_mods_callback")
			},
			w_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_equip_weapon",
				callback = callback(self, self, "equip_weapon_callback")
			},
			w_preview = {
				prio = 3,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview",
				callback = callback(self, self, "preview_weapon_callback")
			},
			w_sell = {
				prio = 4,
				btn = "BTN_X",
				pc_btn = Idstring("menu_remove_item"),
				name = "bm_menu_btn_sell",
				callback = callback(self, self, "sell_item_callback")
			},
			ew_unlock = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_buy_weapon_slot",
				callback = callback(self, self, "choose_weapon_slot_unlock_callback")
			},
			ew_buy = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_buy_new_weapon",
				callback = callback(self, self, "choose_weapon_buy_callback")
			},
			bw_buy = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_buy_selected_weapon",
				callback = callback(self, self, "buy_weapon_callback")
			},
			bw_preview = {
				prio = 3,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview",
				callback = callback(self, self, "preview_buy_weapon_callback")
			},
			bw_available_mods = {
				prio = 2,
				btn = "BTN_Y",
				pc_btn = Idstring("menu_preview_item_alt"),
				name = "bm_menu_available_mods",
				callback = callback(self, self, "show_available_mods_callback")
			},
			bw_buy_dlc = {
				prio = 4,
				btn = "BTN_X",
				pc_btn = Idstring("menu_modify_item"),
				name = "bm_menu_buy_dlc",
				callback = callback(self, self, "show_buy_dlc_callback")
			},
			mt_choose = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_choose",
				callback = callback(self, self, "choose_mod_callback")
			},
			wm_buy = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_craft_mod",
				callback = callback(self, self, "buy_mod_callback")
			},
			wm_preview = {
				prio = 3,
				btn = "BTN_Y",
				pc_btn = Idstring("menu_preview_item_alt"),
				name = "bm_menu_btn_preview",
				callback = callback(self, self, "preview_weapon_callback")
			},
			wm_preview_mod = {
				prio = 4,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview_with_mod",
				callback = callback(self, self, "preview_weapon_with_mod_callback")
			},
			wm_remove_buy = {
				prio = 2,
				btn = "BTN_X",
				pc_btn = Idstring("menu_remove_item"),
				name = "bm_menu_btn_remove_mod",
				callback = callback(self, self, "remove_mod_callback")
			},
			wm_remove_preview_mod = {
				prio = 4,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview_with_mod",
				callback = callback(self, self, "preview_weapon_callback")
			},
			wm_remove_preview = {
				prio = 3,
				btn = "BTN_Y",
				pc_btn = Idstring("menu_preview_item_alt"),
				name = "bm_menu_btn_preview_no_mod",
				callback = callback(self, self, "preview_weapon_without_mod_callback")
			},
			wm_sell = {
				prio = 2,
				btn = "BTN_X",
				pc_btn = Idstring("menu_remove_item"),
				name = "bm_menu_btn_sell",
				callback = callback(self, self, "sell_weapon_mods_callback")
			},
			wcs_set_scheme = {
				btn = "BTN_X",
				prio = 1,
				name = "bm_menu_btn_set_weapon_cosmetic_scheme",
				callback = callback(self, self, "set_scheme_callback")
			},
			wcs_set_wear = {
				btn = "BTN_Y",
				prio = 2,
				name = "bm_menu_btn_set_weapon_cosmetic_wear",
				callback = callback(self, self, "set_wear_callback")
			},
			wcs_set_scale = {
				btn = "BTN_R",
				prio = 3,
				name = "bm_menu_btn_set_weapon_cosmetic_scale",
				callback = callback(self, self, "set_scale_callback")
			},
			wcs_equip = {
				btn = "BTN_A",
				prio = 0,
				name = "bm_menu_btn_equip_weapon_cosmetic",
				callback = callback(self, self, "equip_weapon_color_callback")
			},
			wcs_customize_color = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_customize_weapon_color",
				callback = callback(self, self, "open_customize_weapon_color_menu")
			},
			wcc_equip = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_equip_weapon_cosmetic",
				callback = callback(self, self, "equip_weapon_cosmetics_callback")
			},
			wcc_choose = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_choose_weapon_cosmetic",
				callback = callback(self, self, "choose_weapon_cosmetics_callback")
			},
			wcc_remove = {
				btn = "BTN_X",
				name = "bm_menu_btn_remove_weapon_cosmetic",
				prio = 0,
				pc_btn = "menu_remove_item",
				callback = callback(self, self, "remove_weapon_cosmetics_callback")
			},
			wcc_buy_equip_weapon = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_buy_new_weapon",
				callback = callback(self, self, "buy_equip_weapon_cosmetics_callback")
			},
			wcc_market = {
				btn = "BTN_X",
				name = "bm_menu_btn_buy_tradable",
				prio = 5,
				pc_btn = "menu_remove_item",
				callback = callback(self, self, "purchase_market_cosmetic_on_weapon_callback")
			},
			it_wcc_choose_equip = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_equip_weapon_cosmetic",
				callback = callback(self, self, "choose_equip_weapon_cosmetics_callback")
			},
			a_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_equip_armor",
				callback = callback(self, self, "equip_armor_callback")
			},
			a_mod = {
				btn = "BTN_Y",
				name = "bm_menu_btn_customize_armor",
				prio = 2,
				pc_btn = "menu_modify_item",
				callback = callback(self, self, "open_armor_skins_menu_callback")
			},
			as_equip = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_equip_armor_skin",
				callback = callback(self, self, "equip_armor_skin_callback")
			},
			trd_equip = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_equip_player_style",
				callback = callback(self, self, "equip_player_style_callback")
			},
			trd_customize = {
				btn = "BTN_Y",
				name = "bm_menu_btn_customize_player_style",
				prio = 2,
				pc_btn = "menu_modify_item",
				callback = callback(self, self, "customize_player_style_callback")
			},
			trd_mod_equip = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_equip_suit_variation",
				callback = callback(self, self, "equip_suit_variation_callback")
			},
			hnd_equip = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_equip_gloves",
				callback = callback(self, self, "equip_gloves_callback")
			},
			m_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_equip_mask",
				callback = callback(self, self, "equip_mask_callback")
			},
			m_mod = {
				prio = 2,
				btn = "BTN_Y",
				pc_btn = Idstring("menu_modify_item"),
				name = "bm_menu_btn_mod_mask",
				callback = callback(self, self, "mask_mods_callback")
			},
			m_preview = {
				prio = 3,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview_mask",
				callback = callback(self, self, "preview_mask_callback")
			},
			m_sell = {
				prio = 4,
				btn = "BTN_X",
				pc_btn = Idstring("menu_remove_item"),
				name = "bm_menu_btn_sell_mask",
				callback = callback(self, self, "sell_mask_callback")
			},
			m_remove = {
				prio = 4,
				btn = "BTN_X",
				pc_btn = Idstring("menu_remove_item"),
				name = "bm_menu_btn_remove_mask",
				callback = callback(self, self, "remove_mask_callback")
			},
			em_gv = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_buy_new_mask",
				callback = callback(self, self, "choose_mask_global_value_callback")
			},
			em_buy = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_buy_new_mask",
				callback = callback(self, self, "choose_mask_buy_callback")
			},
			em_unlock = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_buy_mask_slot",
				callback = callback(self, self, "choose_mask_slot_unlock_callback")
			},
			em_available_mods = {
				btn = "BTN_Y",
				name = "bm_menu_buy_mask_title",
				prio = 3,
				pc_btn = "menu_preview_item_alt",
				callback = callback(self, self, "show_available_mask_mods_callback")
			},
			mm_choose_textures = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_choose_pattern",
				callback = callback(self, self, "choose_mask_mod_callback", "textures")
			},
			mm_choose_materials = {
				btn = "BTN_A",
				prio = 2,
				name = "bm_menu_choose_material",
				callback = callback(self, self, "choose_mask_mod_callback", "materials")
			},
			mm_choose_colors = {
				btn = "BTN_A",
				prio = 3,
				name = "bm_menu_choose_color",
				callback = callback(self, self, "choose_mask_mod_callback", "colors")
			},
			mm_choose = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_choose_mask_mod",
				callback = callback(self, self, "choose_mask_type_callback")
			},
			mm_buy = {
				btn = "BTN_Y",
				name = "bm_menu_btn_customize_mask",
				prio = 5,
				pc_btn = "menu_modify_item",
				callback = callback(self, self, "buy_customized_mask_callback")
			},
			mm_preview = {
				btn = "BTN_STICK_R",
				name = "bm_menu_btn_preview_mask",
				prio = 4,
				pc_btn = "menu_preview_item",
				callback = callback(self, self, "preview_customized_mask_callback")
			},
			mp_choose = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_choose_mask_mod",
				callback = callback(self, self, "choose_mask_part_callback")
			},
			mp_preview = {
				btn = "BTN_STICK_R",
				name = "bm_menu_btn_preview_mask",
				prio = 2,
				pc_btn = "menu_preview_item",
				callback = callback(self, self, "preview_customized_mask_callback")
			},
			mp_preview_mod = {
				btn = "BTN_STICK_R",
				name = "bm_menu_btn_preview_mask",
				prio = 2,
				pc_btn = "menu_preview_item",
				callback = callback(self, self, "preview_customized_mask_with_mod_callback")
			},
			mp_choose_first = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_choose_color_a",
				callback = callback(self, self, "choose_mask_color_a_callback")
			},
			mp_choose_second = {
				btn = "BTN_A",
				prio = 1,
				name = "bm_menu_btn_choose_color_b",
				callback = callback(self, self, "choose_mask_color_b_callback")
			},
			bm_buy = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_buy_selected_mask",
				callback = callback(self, self, "buy_mask_callback")
			},
			bm_preview = {
				prio = 2,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview_mask",
				callback = callback(self, self, "preview_buy_mask_callback")
			},
			bm_sell = {
				prio = 4,
				btn = "BTN_X",
				pc_btn = Idstring("menu_remove_item"),
				name = "bm_menu_btn_sell_mask",
				callback = callback(self, self, "sell_stashed_mask_callback")
			},
			c_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_set_preferred",
				callback = callback(self, self, "set_preferred_character_callback")
			},
			lo_w_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_equip_weapon",
				callback = callback(self, self, "equip_weapon_callback")
			},
			lo_d_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_equip_deployable",
				callback = callback(self, self, "lo_equip_deployable_callback")
			},
			lo_mw_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_equip_melee_weapon",
				callback = callback(self, self, "lo_equip_melee_weapon_callback")
			},
			lo_mw_preview = {
				prio = 2,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview_melee_weapon",
				callback = callback(self, self, "preview_melee_weapon_callback")
			},
			lo_g_equip = {
				prio = 1,
				btn = "BTN_A",
				pc_btn = nil,
				name = "bm_menu_btn_equip_grenade",
				callback = callback(self, self, "lo_equip_grenade_callback")
			},
			lo_g_preview = {
				prio = 2,
				btn = "BTN_STICK_R",
				pc_btn = Idstring("menu_preview_item"),
				name = "bm_menu_btn_preview_grenade",
				callback = callback(self, self, "preview_grenade_callback")
			}
		}
		local get_real_font_sizes = false
		local real_small_font_size = small_font_size
		if get_real_font_sizes then
			local test_text = self._panel:text({
				font = small_font,
				font_size = small_font_size,
				text = "TeWqjI-" .. managers.localization:get_default_macro("BTN_BOTTOM_L"),
				visible = false
			})
			local x, y, w, h = test_text:text_rect()
			real_small_font_size = h
			self._panel:remove(test_text)
			test_text = nil
		end
		self._real_small_font_size = real_small_font_size
		local real_medium_font_size = medium_font_size
		if get_real_font_sizes then
			local test_text = self._panel:text({
				font = medium_font,
				font_size = medium_font_size,
				text = "TeWqjI-" .. managers.localization:get_default_macro("BTN_BOTTOM_L"),
				visible = false
			})
			local x, y, w, h = test_text:text_rect()
			real_medium_font_size = h
			Global.test_text = test_text
		end
		self._real_medium_font_size = real_medium_font_size
		self._weapon_info_panel = self._panel:panel({
			x = info_box_panel:x(),
			y = info_box_panel:y(),
			w = info_box_panel:w()
		})
		self._detection_panel = self._panel:panel({
			name = "suspicion_panel",
			layer = 1,
			x = info_box_panel:x(),
			y = info_box_panel:y() + 250,
			w = info_box_panel:w(),
			h = 64
		})
		self._btn_panel = self._panel:panel({
			name = "btn_panel",
			x = info_box_panel:x(),
			w = info_box_panel:w(),
			h = 136
		})
		self._weapon_info_panel:set_h(info_box_panel:h() - self._btn_panel:h() - 8 - self._detection_panel:h() - 8)
		self._detection_panel:set_top(self._weapon_info_panel:bottom() + 8)
		self._btn_panel:set_top(self._detection_panel:bottom() + 8)
		self._weapon_info_border = BoxGuiObject:new(self._weapon_info_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		self._detection_border = BoxGuiObject:new(self._detection_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		self._button_border = BoxGuiObject:new(self._btn_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
		local scale = 0.75
		local detection_ring_left_bg = self._detection_panel:bitmap({
			name = "detection_left_bg",
			texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
			alpha = 0.2,
			blend_mode = "add",
			layer = 1,
			x = 8,
			w = 64,
			h = 64
		})
		local detection_ring_right_bg = self._detection_panel:bitmap({
			name = "detection_right_bg",
			texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
			alpha = 0.2,
			blend_mode = "add",
			layer = 1,
			x = 8,
			w = 64,
			h = 64
		})
		detection_ring_left_bg:set_size(detection_ring_left_bg:w() * scale, detection_ring_left_bg:h() * scale)
		detection_ring_right_bg:set_size(detection_ring_right_bg:w() * scale, detection_ring_right_bg:h() * scale)
		detection_ring_right_bg:set_texture_rect(64, 0, -64, 64)
		detection_ring_left_bg:set_center_y(self._detection_panel:h() / 2)
		detection_ring_right_bg:set_center_y(self._detection_panel:h() / 2)
		local detection_ring_left = self._detection_panel:bitmap({
			name = "detection_left",
			texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
			render_template = "VertexColorTexturedRadial",
			blend_mode = "add",
			layer = 1,
			x = 8,
			w = 64,
			h = 64
		})
		local detection_ring_right = self._detection_panel:bitmap({
			name = "detection_right",
			texture = "guis/textures/pd2/blackmarket/inv_detection_meter",
			render_template = "VertexColorTexturedRadial",
			blend_mode = "add",
			layer = 1,
			x = 8,
			w = 64,
			h = 64
		})
		detection_ring_left:set_size(detection_ring_left:w() * scale, detection_ring_left:h() * scale)
		detection_ring_right:set_size(detection_ring_right:w() * scale, detection_ring_right:h() * scale)
		detection_ring_right:set_texture_rect(64, 0, -64, 64)
		detection_ring_left:set_center_y(self._detection_panel:h() / 2)
		detection_ring_right:set_center_y(self._detection_panel:h() / 2)
		local detection_value = self._detection_panel:text({
			name = "detection_value",
			font_size = medium_font_size,
			font = medium_font,
			layer = 1,
			blend_mode = "add",
			color = tweak_data.screen_colors.text
		})
		detection_value:set_x(detection_ring_left_bg:x() + detection_ring_left_bg:w() / 2 - medium_font_size / 2 + 2)
		detection_value:set_y(detection_ring_left_bg:y() + detection_ring_left_bg:h() / 2 - medium_font_size / 2 + 2)
		local detection_text = self._detection_panel:text({
			name = "detection_text",
			font_size = small_font_size,
			font = small_font,
			layer = 1,
			blend_mode = "add",
			color = tweak_data.screen_colors.text,
			text = utf8.to_upper(managers.localization:text("bm_menu_stats_detection"))
		})
		detection_text:set_left(detection_ring_left:right() + 8)
		detection_text:set_y(detection_ring_left:y() + detection_ring_left_bg:h() / 2 - medium_font_size / 2 + 2)
		self._buttons = self._btn_panel:panel({y = 8})
		local btn_x = 10
		for btn, btn_data in pairs(BTNS) do
			local new_btn = BlackMarketGuiButtonItem:new(self._buttons, btn_data, btn_x)
			self._btns[btn] = new_btn
		end
		self._info_texts = {}
		self._info_texts_panel = self._panel:panel({
			x = info_box_panel:x() + 10,
			y = info_box_panel:y() + 10,
			w = info_box_panel:w() - 20,
			h = info_box_panel:h() - 20 - real_small_font_size * 3
		})
		table.insert(self._info_texts, self._info_texts_panel:text({
			name = "info_text_1",
			font_size = medium_font_size,
			font = medium_font,
			layer = 1,
			color = tweak_data.screen_colors.text,
			text = ""
		}))
		table.insert(self._info_texts, self._info_texts_panel:text({
			name = "info_text_2",
			font_size = small_font_size,
			font = small_font,
			layer = 1,
			color = tweak_data.screen_colors.text,
			text = "",
			wrap = true,
			word_wrap = true
		}))
		table.insert(self._info_texts, self._info_texts_panel:text({
			name = "info_text_3",
			font_size = small_font_size,
			font = small_font,
			layer = 1,
			color = tweak_data.screen_colors.important_1,
			text = "",
			wrap = true,
			word_wrap = true,
			blend_mode = "add"
		}))
		table.insert(self._info_texts, self._info_texts_panel:text({
			name = "info_text_4",
			font_size = small_font_size,
			font = small_font,
			layer = 1,
			color = tweak_data.screen_colors.text,
			text = "",
			wrap = true,
			word_wrap = true
		}))
		table.insert(self._info_texts, self._info_texts_panel:text({
			name = "info_text_5",
			font_size = small_font_size,
			font = small_font,
			layer = 1,
			color = tweak_data.screen_colors.important_1,
			text = "",
			wrap = true,
			word_wrap = true
		}))
		self._info_texts_color = {}
		self._info_texts_bg = {}
		for i, info_text in ipairs(self._info_texts) do
			self._info_texts_color[i] = info_text:color()
			self._info_texts_bg[i] = self._info_texts_panel:rect({
				layer = 0,
				color = Color.black,
				alpha = 0.2,
				visible = false
			})
			self._info_texts_bg[i]:set_shape(info_text:shape())
		end
		local h = real_small_font_size
		local longest_text_w = 0
		if self._data.info_callback then
			self._info_panel = self._panel:panel({
				name = "info_panel",
				layer = 1,
				w = self._btn_panel:w()
			})
			local info_table = self._data.info_callback()
			for i, info in ipairs(info_table) do
				local info_name = info.name or ""
				local info_string = info.text or ""
				local info_color = info.color or tweak_data.screen_colors.text
				local category_text = self._info_panel:text({
					name = "category_" .. tostring(i),
					y = (i - 1) * h,
					w = 0,
					h = h,
					font_size = h,
					font = small_font,
					layer = 1,
					color = tweak_data.screen_colors.text,
					text = utf8.to_upper(managers.localization:text("bm_menu_" .. tostring(info_name)))
				})
				local status_text = self._info_panel:text({
					name = "status_" .. tostring(i),
					y = (i - 1) * h,
					w = 0,
					h = h,
					font_size = h,
					font = small_font,
					layer = 1,
					color = info_color,
					text = utf8.to_upper(managers.localization:text(info_string))
				})
				if info_string == "" then
					category_text:set_color(info_color)
				end
				local _, _, w, _ = category_text:text_rect()
				if longest_text_w < w then
					longest_text_w = w + 10
				end
			end
			for name, text in ipairs(self._info_panel:children()) do
				if string.split(text:name(), "_")[1] == "category" then
					text:set_w(longest_text_w)
					text:set_x(0)
				else
					local _, _, w, _ = text:text_rect()
					text:set_w(w)
					text:set_x(math.round(longest_text_w + 5))
				end
			end
		else
			self._stats_shown = {
				{name = "magazine", stat_name = "extra_ammo"},
				{
					name = "totalammo",
					stat_name = "total_ammo_mod"
				},
				{name = "fire_rate"},
				{name = "damage"},
				{
					name = "spread",
					offset = true,
					revert = true
				},
				{
					name = "recoil",
					offset = true,
					revert = true
				},
				{
					name = "concealment",
					index = true
				},
				{
					name = "suppression",
					offset = true
				}
			}
			self._stats_panel = self._panel:panel({
				layer = 1,
				x = info_box_panel:x() + 10,
				y = info_box_panel:y() + 58,
				w = info_box_panel:w() - 20,
				h = info_box_panel:h() - 84
			})
			local panel = self._stats_panel:panel({
				layer = 1,
				w = self._stats_panel:w(),
				h = 20
			})
			panel:rect({
				color = Color.black:with_alpha(0.5)
			})
			self._stats_titles = {}
			self._stats_titles.equip = self._stats_panel:text({
				x = 120,
				font_size = small_font_size,
				font = small_font,
				layer = 2,
				color = tweak_data.screen_colors.text
			})
			self._stats_titles.base = self._stats_panel:text({
				x = 170,
				font_size = small_font_size,
				font = small_font,
				layer = 2,
				alpha = 0.75,
				color = tweak_data.screen_colors.text,
				text = utf8.to_upper(managers.localization:text("bm_menu_stats_base"))
			})
			self._stats_titles.mod = self._stats_panel:text({
				x = 215,
				font_size = small_font_size,
				font = small_font,
				layer = 2,
				alpha = 0.75,
				color = tweak_data.screen_colors.stats_mods,
				text = utf8.to_upper(managers.localization:text("bm_menu_stats_mod"))
			})
			self._stats_titles.skill = self._stats_panel:text({
				x = 255,
				font_size = small_font_size,
				font = small_font,
				alpha = 0.75,
				layer = 2,
				color = tweak_data.screen_colors.resource,
				text = utf8.to_upper(managers.localization:text("bm_menu_stats_skill"))
			})
			self._stats_titles.total = self._stats_panel:text({
				x = 200,
				font_size = small_font_size,
				font = small_font,
				layer = 2,
				color = tweak_data.screen_colors.text,
				text = utf8.to_upper(managers.localization:text("bm_menu_chosen"))
			})
			local x = 0
			local y = 20
			local text_panel
			local text_columns = {
				{name = "name", size = 100},
				{
					name = "equip",
					size = 45,
					align = "right",
					alpha = 0.75,
					blend = "add"
				},
				{
					name = "base",
					size = 45,
					align = "right",
					alpha = 0.75,
					blend = "add"
				},
				{
					name = "mods",
					size = 45,
					align = "right",
					alpha = 0.75,
					blend = "add",
					color = tweak_data.screen_colors.stats_mods
				},
				{
					name = "skill",
					size = 45,
					align = "right",
					alpha = 0.75,
					blend = "add",
					color = tweak_data.screen_colors.resource
				},
				{
					name = "total",
					size = 45,
					align = "right"
				}
			}
			self._stats_texts = {}
			self._rweapon_stats_panel = self._stats_panel:panel()
			for i, stat in ipairs(self._stats_shown) do
				panel = self._rweapon_stats_panel:panel({
					name = "weapon_stats",
					layer = 1,
					x = 0,
					y = y,
					w = self._rweapon_stats_panel:w(),
					h = 20
				})
				if math.mod(i, 2) == 0 and not panel:child(tostring(i)) then
					panel:rect({
						name = tostring(i),
						color = Color.black:with_alpha(0.3)
					})
				end
				x = 2
				y = y + 20
				self._stats_texts[stat.name] = {}
				for _, column in ipairs(text_columns) do
					text_panel = panel:panel({
						layer = 0,
						x = x,
						w = column.size,
						h = panel:h()
					})
					self._stats_texts[stat.name][column.name] = text_panel:text({
						font_size = small_font_size,
						font = small_font,
						align = column.align,
						layer = 1,
						alpha = column.alpha,
						blend_mode = column.blend,
						color = column.color or tweak_data.screen_colors.text
					})
					x = x + column.size
					if column.name == "total" then
						text_panel:set_x(190)
					end
				end
			end
			self._armor_stats_shown = {
				{name = "armor"},
				{
					name = "concealment",
					index = true
				},
				{name = "movement", procent = true},
				{
					name = "dodge",
					revert = true,
					procent = true
				},
				{
					name = "damage_shake"
				},
				{name = "stamina"}
			}
			do
				local x = 0
				local y = 20
				local text_panel
				self._armor_stats_texts = {}
				local text_columns = {
					{name = "name", size = 100},
					{
						name = "equip",
						size = 45,
						align = "right",
						alpha = 0.75,
						blend = "add"
					},
					{
						name = "base",
						size = 60,
						align = "right",
						alpha = 0.75,
						blend = "add"
					},
					{
						name = "skill",
						size = 60,
						align = "right",
						alpha = 0.75,
						blend = "add",
						color = tweak_data.screen_colors.resource
					},
					{
						name = "total",
						size = 45,
						align = "right"
					}
				}
				self._armor_stats_panel = self._stats_panel:panel()
				for i, stat in ipairs(self._armor_stats_shown) do
					panel = self._armor_stats_panel:panel({
						layer = 1,
						x = 0,
						y = y,
						w = self._armor_stats_panel:w(),
						h = 20
					})
					if math.mod(i, 2) == 0 and not panel:child(tostring(i)) then
						panel:rect({
							name = tostring(i),
							color = Color.black:with_alpha(0.3)
						})
					end
					x = 2
					y = y + 20
					self._armor_stats_texts[stat.name] = {}
					for _, column in ipairs(text_columns) do
						text_panel = panel:panel({
							layer = 0,
							x = x,
							w = column.size,
							h = panel:h()
						})
						self._armor_stats_texts[stat.name][column.name] = text_panel:text({
							font_size = small_font_size,
							font = small_font,
							align = column.align,
							layer = 1,
							alpha = column.alpha,
							blend_mode = column.blend,
							color = column.color or tweak_data.screen_colors.text
						})
						x = x + column.size
						if column.name == "total" then
							text_panel:set_x(190)
						end
					end
				end
			end
			self._mweapon_stats_shown = {
				{name = "damage", range = true},
				{
					name = "damage_effect",
					range = true,
					multiple_of = "damage"
				},
				{
					name = "charge_time",
					num_decimals = 1,
					inverse = true,
					suffix = managers.localization:text("menu_seconds_suffix_short")
				},
				{name = "range", range = true},
				{
					name = "concealment",
					index = true
				}
			}
			do
				local x = 0
				local y = 20
				local text_panel
				self._mweapon_stats_texts = {}
				local text_columns = {
					{name = "name", size = 100},
					{
						name = "equip",
						size = 55,
						align = "right",
						alpha = 0.75,
						blend = "add"
					},
					{
						name = "base",
						size = 60,
						align = "right",
						alpha = 0.75,
						blend = "add"
					},
					{
						name = "skill",
						size = 65,
						align = "right",
						alpha = 0.75,
						blend = "add",
						color = tweak_data.screen_colors.resource
					},
					{
						name = "total",
						size = 55,
						align = "right"
					}
				}
				self._mweapon_stats_panel = self._stats_panel:panel()
				for i, stat in ipairs(self._mweapon_stats_shown) do
					panel = self._mweapon_stats_panel:panel({
						layer = 1,
						x = 0,
						y = y,
						w = self._mweapon_stats_panel:w(),
						h = 20
					})
					if math.mod(i, 2) == 0 and not panel:child(tostring(i)) then
						panel:rect({
							name = tostring(i),
							color = Color.black:with_alpha(0.3)
						})
					end
					x = 2
					y = y + 20
					self._mweapon_stats_texts[stat.name] = {}
					for _, column in ipairs(text_columns) do
						text_panel = panel:panel({
							layer = 0,
							x = x,
							w = column.size,
							h = panel:h()
						})
						self._mweapon_stats_texts[stat.name][column.name] = text_panel:text({
							font_size = small_font_size,
							font = small_font,
							align = column.align,
							layer = 1,
							alpha = column.alpha,
							blend_mode = column.blend,
							color = column.color or tweak_data.screen_colors.text
						})
						x = x + column.size
						if column.name == "total" then
							text_panel:set_x(190)
						end
					end
				end
			end
			panel = self._stats_panel:panel({
				name = "modslist_panel",
				layer = 0,
				y = y + 20,
				w = self._stats_panel:w(),
				h = self._stats_panel:h()
			})
			self._stats_text_modslist = panel:text({
				font_size = small_font_size,
				font = small_font,
				layer = 1,
				color = tweak_data.screen_colors.text,
				wrap = true,
				word_wrap = true
			})
		end
		if self._info_panel then
			self._info_panel:set_size(info_box_panel:w() - 20, self._info_panel:num_children() / 2 * h)
			self._info_panel:set_rightbottom(self._panel:w() - 10, self._btn_panel:top() - 10)
		end
		local tab_x = 0
		if not managers.menu:is_pc_controller() and #self._tabs > 1 then
			local prev_page = self._panel:text({
				name = "prev_page",
				y = 0,
				font_size = medium_font_size,
				font = medium_font,
				layer = 2,
				color = tweak_data.screen_colors.text,
				text = managers.localization:get_default_macro("BTN_BOTTOM_L")
			})
			local _, _, w, h = prev_page:text_rect()
			prev_page:set_w(w)
			prev_page:set_top(top_padding)
			prev_page:set_left(tab_x)
			prev_page:set_visible(self._selected > 1)
			self._tab_scroll_panel:move(w + 15, 0)
			self._tab_scroll_panel:grow(-(w + 15), 0)
		end
		for _, tab in ipairs(self._tabs) do
			tab_x = tab:set_tab_position(tab_x)
		end
		if not managers.menu:is_pc_controller() and #self._tabs > 1 then
			local next_page = self._panel:text({
				name = "next_page",
				y = 0,
				font_size = medium_font_size,
				font = medium_font,
				layer = 2,
				color = tweak_data.screen_colors.text,
				text = managers.localization:get_default_macro("BTN_BOTTOM_R")
			})
			local _, _, w, h = next_page:text_rect()
			next_page:set_size(w, h)
			next_page:set_top(top_padding)
			next_page:set_right(grid_panel_w)
			next_page:set_visible(self._selected < #self._tabs)
			self._tab_scroll_panel:grow(-(w + 15), 0)
		end
		if managers.menu:is_pc_controller() and self._tab_scroll_table[#self._tab_scroll_table]:right() > self._tab_scroll_table.panel:w() then
			local prev_page = self._panel:text({
				name = "prev_page",
				y = 0,
				w = 0,
				font_size = medium_font_size,
				font = medium_font,
				layer = 2,
				color = tweak_data.screen_colors.button_stage_3,
				text = "<",
				align = "center"
			})
			local _, _, w, h = prev_page:text_rect()
			prev_page:set_size(w, h)
			prev_page:set_top(top_padding)
			prev_page:set_left(0)
			prev_page:set_text(" ")
			self._tab_scroll_panel:move(w + 15, 0)
			self._tab_scroll_panel:grow(-(w + 15), 0)
			local next_page = self._panel:text({
				name = "next_page",
				y = 0,
				w = 0,
				font_size = medium_font_size,
				font = medium_font,
				layer = 2,
				color = tweak_data.screen_colors.button_stage_3,
				text = ">",
				align = "center"
			})
			local _, _, w, h = next_page:text_rect()
			next_page:set_size(w, h)
			next_page:set_top(top_padding)
			next_page:set_right(grid_panel_w)
			self._tab_scroll_table.left = prev_page
			self._tab_scroll_table.right = next_page
			self._tab_scroll_table.left_klick = false
			self._tab_scroll_table.right_klick = true
			if self._selected > 1 then
				self._tab_scroll_table.left_klick = true
				self._tab_scroll_table.left:set_text("<")
			else
				self._tab_scroll_table.left_klick = false
				self._tab_scroll_table.left:set_text(" ")
			end
			if self._selected < #self._tab_scroll_table then
				self._tab_scroll_table.right_klick = true
				self._tab_scroll_table.right:set_text(">")
			else
				self._tab_scroll_table.right_klick = false
				self._tab_scroll_table.right:set_text(" ")
			end
			self._tab_scroll_panel:grow(-(w + 15), 0)
		end
	else
		self._select_rect:hide()
	end
	if MenuBackdropGUI then
		local bg_text = self._fullscreen_panel:text({
			text = self._title_text:text(),
			h = 90,
			align = "left",
			vertical = "top",
			font_size = massive_font_size,
			font = massive_font,
			color = tweak_data.screen_colors.button_stage_3,
			alpha = 0.4
		})
		local x, y = managers.gui_data:safe_to_full_16_9(self._title_text:world_x(), self._title_text:world_center_y())
		bg_text:set_world_left(x)
		bg_text:set_world_center_y(y)
		bg_text:move(-13, 9)
		MenuBackdropGUI.animate_bg_text(self, bg_text)
		if managers.menu:is_pc_controller() then
			local bg_back = self._fullscreen_panel:text({
				name = "back_button",
				text = utf8.to_upper(managers.localization:text("menu_back")),
				h = 90,
				align = "right",
				vertical = "bottom",
				font_size = massive_font_size,
				font = massive_font,
				color = tweak_data.screen_colors.button_stage_3,
				alpha = 0.4,
				layer = 0
			})
			local x, y = managers.gui_data:safe_to_full_16_9(self._panel:child("back_button"):world_right(), self._panel:child("back_button"):world_center_y())
			bg_back:set_world_right(x)
			bg_back:set_world_center_y(y)
			bg_back:move(13, -9)
			MenuBackdropGUI.animate_bg_text(self, bg_back)
		end
	end
	if self._selected_slot then
		self:on_slot_selected(self._selected_slot)
	end
	local black_rect = self._fullscreen_panel:rect({
		color = Color(0.4, 0, 0, 0),
		layer = 1
	})
	if is_start_page then
		if managers.menu:is_pc_controller() then
			managers.features:announce_feature("blackmarket_rename")
		end
		if managers.dlc:is_dlc_unlocked("ach_bulldog_1") then
			managers.features:announce_feature("freed_old_hoxton")
		end
		local new_givens = managers.blackmarket:fetch_new_items_unlocked()
		local params = {}
		params.sound_event = "stinger_new_weapon"
		for _, unlocked_item in ipairs(new_givens) do
			params.category = unlocked_item[1]
			if params.category == "primaries" or params.category == "secondaries" then
				params.value = managers.weapon_factory:get_weapon_name_by_factory_id(unlocked_item[2])
			else
				params.value = unlocked_item[2]
			end
			params.data = unlocked_item
			if type(params.value) == "table" then
				for _, item in ipairs(params.value) do
					params.category = item[1]
					params.value = item[2]
					params.data = item
					managers.menu:show_new_item_gained(params)
				end
			else
				managers.menu:show_new_item_gained(params)
			end
		end
	end
	self:set_tab_positions()
	self:_round_everything()

	local new_givens = managers.blackmarket:fetch_new_tradable_items() or {}
	local params = {
		sound_event = "stinger_new_weapon"
	}
	local ti_td = nil
	local max_items_to_show = 10
	local inventory_tradable = managers.blackmarket:get_inventory_tradable()
	local index = 0

	for i, instance_id in ipairs(new_givens) do
		if max_items_to_show <= index and index < #new_givens then
			params.amount_more = #new_givens - (index - 1)

			managers.menu:show_and_more_tradable_item_received(params)

			break
		elseif inventory_tradable[instance_id] then
			index = index + 1
			params.instance_id = instance_id
			params.item = inventory_tradable[instance_id]
			params.amount_more = #new_givens - (index - 1)

			if params.item.category == "weapon_skins" then
				ti_td = tweak_data:get_raw_value("blackmarket", params.item.category, params.item.entry)
			else
				ti_td = tweak_data:get_raw_value("economy", params.item.category, params.item.entry)
			end

			if ti_td then
				params.item_name = managers.localization:text(ti_td.name_id)
				params.rarity_name = managers.localization:text(tweak_data.economy.rarities[ti_td.rarity or "common"] and tweak_data.economy.rarities[ti_td.rarity or "common"].name_id or "nil")
				params.quality_name = managers.localization:text(tweak_data.economy.qualities[params.item.quality or "poor"] and tweak_data.economy.qualities[params.item.quality or "poor"].name_id or "nil")
				params.container = params.item.category == "safes" and {
					content = tweak_data.economy.safes[params.item.entry] and tweak_data.economy.safes[params.item.entry].content,
					drill = ti_td.drill,
					safe = params.item.entry,
					safe_id = params.item.instance_id
				}

				managers.menu:show_new_tradable_item_received(params)
			end
		end
	end

end

function BlackMarketGui:_update_borders()
	local wh = self._weapon_info_panel:h()
	local dy = self._detection_panel:y()
	local dh = self._detection_panel:h()
	local by = self._btn_panel:y()
	local bh = self._btn_panel:h()
	self._btn_panel:set_visible(self._button_count > 0 and true or false)
	self._btn_panel:set_h(20 * self._button_count + 16)
	local info_box_panel = self._panel:child("info_box_panel")
	local weapon_info_height = info_box_panel:h() - (self._button_count > 0 and self._btn_panel:h() + 8 or 0) - (self._detection_panel:visible() and self._detection_panel:h() + 8 or 0)
	self._weapon_info_panel:set_h(weapon_info_height)
	self._info_texts_panel:set_h(weapon_info_height - 20)
	if self._detection_panel:visible() then
		self._detection_panel:set_top(self._weapon_info_panel:bottom() + 8)
		if dh ~= self._detection_panel:h() or dy ~= self._detection_panel:y() then
			self._detection_border:create_sides(self._detection_panel, {
				sides = {
					1,
					1,
					1,
					1
				}
			})
		end
	end
	self._btn_panel:set_top((self._detection_panel:visible() and self._detection_panel:bottom() or self._weapon_info_panel:bottom()) + 8)
	if wh ~= self._weapon_info_panel:h() then
		self._weapon_info_border:create_sides(self._weapon_info_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
	end
	if bh ~= self._btn_panel:h() or by ~= self._btn_panel:y() then
		self._button_border:create_sides(self._btn_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})
	end
end

function BlackMarketGui:_set_detection(value, maxed_reached, min_reached)
	local detection_value = self._detection_panel:child("detection_value")
	detection_value:set_text(math.round(value * 100))
	local detection_ring_left_bg = self._detection_panel:child("detection_left_bg")
	local _, _, w, _ = detection_value:text_rect()
	detection_value:set_x(detection_ring_left_bg:x() + detection_ring_left_bg:w() / 2 - w / 2)
	self._detection_panel:child("detection_left"):set_color(Color(0.5 + value * 0.5, 1, 1))
	self._detection_panel:child("detection_right"):set_color(Color(0.5 + value * 0.5, 1, 1))
	local detection_text = self._detection_panel:child("detection_text")
	if maxed_reached then
		detection_text:set_text(utf8.to_upper(managers.localization:text("bm_menu_stats_max_detection")))
		detection_text:set_color(Color(255, 255, 42, 0) / 255)
		detection_value:set_color(Color(255, 255, 42, 0) / 255)
	elseif min_reached then
		detection_text:set_text(utf8.to_upper(managers.localization:text("bm_menu_stats_min_detection")))
		detection_text:set_color(tweak_data.screen_colors.ghost_color)
		detection_value:set_color(tweak_data.screen_colors.text)
	else
		detection_text:set_text(utf8.to_upper(managers.localization:text("bm_menu_stats_detection")))
		detection_text:set_color(tweak_data.screen_colors.text)
		detection_value:set_color(tweak_data.screen_colors.text)
	end
end

function BlackMarketGui:get_weapon_ammo_info(weapon_id, extra_ammo, total_ammo_mod)
	local weapon_tweak_data = tweak_data.weapon[weapon_id]
	local ammo_max_multiplier = managers.player:upgrade_value("player", "extra_ammo_multiplier", 1)
	ammo_max_multiplier = ammo_max_multiplier * managers.player:upgrade_value(weapon_tweak_data.category, "extra_ammo_multiplier", 1)
	if managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul") then
		ammo_max_multiplier = ammo_max_multiplier * managers.player:body_armor_value("skill_ammo_mul", nil, 1)
	end
	local function get_ammo_max_per_clip(weapon_id)
		local function upgrade_blocked(category, upgrade)
			if not weapon_tweak_data.upgrade_blocks then
				return false
			end
			if not weapon_tweak_data.upgrade_blocks[category] then
				return false
			end
			return table.contains(weapon_tweak_data.upgrade_blocks[category], upgrade)
		end

		local clip_base = weapon_tweak_data.CLIP_AMMO_MAX
		local clip_mod = extra_ammo and tweak_data.weapon.stats.extra_ammo[extra_ammo] or 0
		local clip_skill = managers.player:upgrade_value(weapon_id, "clip_ammo_increase")
		if not upgrade_blocked("weapon", "clip_ammo_increase") then
			clip_skill = clip_skill + managers.player:upgrade_value("weapon", "clip_ammo_increase", 0)
		end
		if not upgrade_blocked(weapon_tweak_data.category, "clip_ammo_increase") then
			clip_skill = clip_skill + managers.player:upgrade_value(weapon_tweak_data.category, "clip_ammo_increase", 0)
		end
		return clip_base + clip_mod + clip_skill
	end

	local ammo_max_per_clip = get_ammo_max_per_clip(weapon_id)
	local ammo_max = tweak_data.weapon[weapon_id].AMMO_MAX
	local ammo_from_mods = math.round(ammo_max * (total_ammo_mod and tweak_data.weapon.stats.total_ammo_mod[total_ammo_mod] or 0))
	ammo_max = math.round((ammo_max + ammo_from_mods + managers.player:upgrade_value(weapon_id, "clip_amount_increase") * ammo_max_per_clip) * ammo_max_multiplier)
	ammo_max_per_clip = math.min(ammo_max_per_clip, ammo_max)
	local ammo_data = {}
	ammo_data.base = tweak_data.weapon[weapon_id].AMMO_MAX
	ammo_data.mod = ammo_from_mods + managers.player:upgrade_value(weapon_id, "clip_amount_increase") * ammo_max_per_clip
	ammo_data.skill = math.round((ammo_data.base + ammo_data.mod) * ammo_max_multiplier) - ammo_data.base - ammo_data.mod
	ammo_data.skill_in_effect = managers.player:has_category_upgrade("player", "extra_ammo_multiplier") or managers.player:has_category_upgrade(weapon_tweak_data.category, "extra_ammo_multiplier") or managers.player:has_category_upgrade("player", "add_armor_stat_skill_ammo_mul")
	return ammo_max_per_clip, ammo_max, ammo_data
end

function BlackMarketGui:_get_skill_stats(name, category, slot, base_stats, mods_stats, silencer, single_mod, auto_mod)
	local skill_stats = {}
	for _, stat in pairs(self._stats_shown) do
		skill_stats[stat.name] = {}
		skill_stats[stat.name].value = 0
	end
	local custom_data = {}
	custom_data[category] = managers.blackmarket:get_crafted_category_slot(category, slot)
	local detection_risk = managers.blackmarket:get_suspicion_offset_from_custom_data(custom_data, tweak_data.player.SUSPICION_OFFSET_LERP or 0.75)
	detection_risk = math.round(detection_risk * 100)
	local base_value, modifier, multiplier
	local weapon_tweak = tweak_data.weapon[name]
	for _, stat in ipairs(self._stats_shown) do
		if weapon_tweak.stats[stat.stat_name or stat.name] or stat.name == "totalammo" or stat.name == "fire_rate" then
			if stat.name == "magazine" then
				skill_stats[stat.name].value = managers.player:upgrade_value(name, "clip_ammo_increase", 0)
				if not weapon_tweak.upgrade_blocks or not weapon_tweak.upgrade_blocks.weapon or not table.contains(weapon_tweak.upgrade_blocks.weapon, "clip_ammo_increase") then
					skill_stats[stat.name].value = skill_stats[stat.name].value + managers.player:upgrade_value("weapon", "clip_ammo_increase", 0)
				end
				if not weapon_tweak.upgrade_blocks or not weapon_tweak.upgrade_blocks[weapon_tweak.category] or not table.contains(weapon_tweak.upgrade_blocks[weapon_tweak.category], "clip_ammo_increase") then
					skill_stats[stat.name].value = skill_stats[stat.name].value + managers.player:upgrade_value(weapon_tweak.category, "clip_ammo_increase", 0)
				end
				skill_stats[stat.name].skill_in_effect = managers.player:has_category_upgrade(name, "clip_ammo_increase") or managers.player:has_category_upgrade("weapon", "clip_ammo_increase")
			elseif stat.name == "totalammo" then
			else
				base_value = math.max(base_stats[stat.name].value + mods_stats[stat.name].value, 0)
				multiplier = 1
				modifier = 0
				local crafted_weapon = managers.blackmarket:get_crafted_category_slot(category, slot)
				local blueprint = crafted_weapon and crafted_weapon.blueprint
				if stat.name == "damage" then
					multiplier = managers.blackmarket:damage_multiplier(name, weapon_tweak.category, silencer, detection_risk, nil, blueprint)
					modifier = math.floor(managers.blackmarket:damage_addend(name, weapon_tweak.category, silencer, detection_risk, nil, blueprint) * tweak_data.gui.stats_present_multiplier * multiplier)
				elseif stat.name == "spread" then
					local fire_mode = single_mod and "single" or auto_mod and "auto" or weapon_tweak.FIRE_MODE or "single"
					multiplier = managers.blackmarket:accuracy_multiplier(name, weapon_tweak.category, silencer, nil, fire_mode, blueprint)
				elseif stat.name == "recoil" then
					multiplier = managers.blackmarket:recoil_multiplier(name, weapon_tweak.category, silencer, blueprint)
					modifier = -managers.blackmarket:recoil_addend(name, weapon_tweak.category, silencer, blueprint) * tweak_data.gui.stats_present_multiplier
				elseif stat.name == "suppression" then
					multiplier = managers.blackmarket:threat_multiplier(name, weapon_tweak.category, silencer)
				elseif stat.name == "concealment" then
				elseif stat.name == "fire_rate" then
					multiplier = managers.blackmarket:fire_rate_multiplier(name, weapon_tweak.category, silencer, detection_risk, nil, blueprint)
				end
				if stat.revert then
					multiplier = 1 / math.max(multiplier, 0.01)
				end
				skill_stats[stat.name].skill_in_effect = multiplier ~= 1 or modifier ~= 0
				skill_stats[stat.name].value = modifier + math.round(base_value * multiplier) - base_value
			end
		end
	end
	return skill_stats
end

function BlackMarketGui:_get_mods_stats(name, base_stats, equipped_mods)
	local mods_stats = {}
	local modifier_stats = tweak_data.weapon[name].stats_modifiers
	for _, stat in pairs(self._stats_shown) do
		mods_stats[stat.name] = {}
		mods_stats[stat.name].index = 0
		mods_stats[stat.name].value = 0
	end
	if equipped_mods then
		local tweak_stats = tweak_data.weapon.stats
		local tweak_factory = tweak_data.weapon.factory.parts
		local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(name)
		local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
		local part_data
		for _, mod in ipairs(equipped_mods) do
			part_data = managers.weapon_factory:get_part_data_by_part_id_from_weapon(mod, factory_id, default_blueprint)
			if part_data then
				for _, stat in pairs(self._stats_shown) do
					if part_data.stats then
						if stat.name == "magazine" then
							local ammo = part_data.stats.extra_ammo
							ammo = ammo and ammo + (tweak_data.weapon[name].stats.extra_ammo or 0)
							mods_stats[stat.name].value = mods_stats[stat.name].value + (ammo and tweak_data.weapon.stats.extra_ammo[ammo] or 0)
						elseif stat.name == "totalammo" then
							local ammo = part_data.stats.total_ammo_mod
							mods_stats[stat.name].index = mods_stats[stat.name].index + (ammo or 0)
						else
							mods_stats[stat.name].index = mods_stats[stat.name].index + (part_data.stats[stat.name] or 0)
						end
					end
				end
			end
		end
		local index, stat_name
		for _, stat in pairs(self._stats_shown) do
			stat_name = stat.name
			if mods_stats[stat.name].index and tweak_stats[stat_name] then
				if stat.name == "concealment" then
					index = base_stats[stat.name].index + mods_stats[stat.name].index
				else
					index = math.clamp(base_stats[stat.name].index + mods_stats[stat.name].index, 1, #tweak_stats[stat_name])
				end
				mods_stats[stat.name].value = math.round(stat.index and index or tweak_stats[stat_name][index] * tweak_data.gui.stats_present_multiplier)
				local offset = math.round(math.min(tweak_stats[stat_name][1], tweak_stats[stat_name][#tweak_stats[stat_name]]) * tweak_data.gui.stats_present_multiplier)
				if stat.offset then
					mods_stats[stat.name].value = mods_stats[stat.name].value - offset
				end
				if stat.revert then
					local max_stat = math.round(math.max(tweak_stats[stat_name][1], tweak_stats[stat_name][#tweak_stats[stat_name]]) * tweak_data.gui.stats_present_multiplier)
					if stat.revert then
						max_stat = max_stat - offset
					end
					mods_stats[stat.name].value = max_stat - mods_stats[stat.name].value
				end
				if modifier_stats and modifier_stats[stat.name] then
					local mod = modifier_stats[stat.name]
					if stat.revert and not stat.index then
						local real_base_value = tweak_stats[stat_name][index]
						local modded_value = real_base_value * mod
						local offset = math.round(math.min(tweak_stats[stat_name][1], tweak_stats[stat_name][#tweak_stats[stat_name]]))
						if stat.offset then
							modded_value = modded_value - offset
						end
						local max_stat = math.round(math.max(tweak_stats[stat_name][1], tweak_stats[stat_name][#tweak_stats[stat_name]]))
						if stat.revert then
							max_stat = max_stat - offset
						end
						local new_value = math.round((max_stat - modded_value) * tweak_data.gui.stats_present_multiplier)
						if mod ~= 0 and (modded_value > tweak_stats[stat_name][1] or modded_value < tweak_stats[stat_name][#tweak_stats[stat_name]]) then
							new_value = math.round((new_value + mods_stats[stat.name].value / mod) / 2)
						end
						mods_stats[stat.name].value = new_value
					else
						mods_stats[stat.name].value = math.round(mods_stats[stat.name].value * mod)
					end
				end
				mods_stats[stat.name].value = math.round(mods_stats[stat.name].value - base_stats[stat.name].value)
			end
		end
	end
	return mods_stats
end

function BlackMarketGui:_get_base_stats(name)
	local base_stats = {}
	local index
	local tweak_stats = tweak_data.weapon.stats
	local modifier_stats = tweak_data.weapon[name].stats_modifiers
	for _, stat in pairs(self._stats_shown) do
		base_stats[stat.name] = {}
		if stat.name == "magazine" then
			base_stats[stat.name].index = 0
			base_stats[stat.name].value = tweak_data.weapon[name].CLIP_AMMO_MAX
		elseif stat.name == "totalammo" then
			index = math.clamp(tweak_data.weapon[name].stats.total_ammo_mod, 1, #tweak_stats.total_ammo_mod)
			base_stats[stat.name].index = tweak_data.weapon[name].stats.total_ammo_mod
			base_stats[stat.name].value = tweak_data.weapon[name].AMMO_MAX
		elseif stat.name == "fire_rate" then
			local fire_rate = 60 / tweak_data.weapon[name].fire_mode_data.fire_rate
			base_stats[stat.name].value = math.round(fire_rate / 10) * 10
		elseif tweak_stats[stat.name] then
			index = math.clamp(tweak_data.weapon[name].stats[stat.name], 1, #tweak_stats[stat.name])
			base_stats[stat.name].index = tweak_data.weapon[name].stats[stat.name]
			base_stats[stat.name].value = math.round(stat.index and index or tweak_stats[stat.name][index] * tweak_data.gui.stats_present_multiplier)
			local offset = math.round(math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier)
			if stat.offset then
				base_stats[stat.name].value = base_stats[stat.name].value - offset
			end
			if stat.revert then
				local max_stat = math.round(math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier)
				if stat.revert then
					max_stat = max_stat - offset
				end
				base_stats[stat.name].value = max_stat - base_stats[stat.name].value
			end
			if modifier_stats and modifier_stats[stat.name] then
				local mod = modifier_stats[stat.name]
				if stat.revert and not stat.index then
					local real_base_value = tweak_stats[stat.name][index]
					local modded_value = real_base_value * mod
					local offset = math.round(math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]))
					if stat.offset then
						modded_value = modded_value - offset
					end
					local max_stat = math.round(math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]))
					if stat.revert then
						max_stat = max_stat - offset
					end
					local new_value = math.round((max_stat - modded_value) * tweak_data.gui.stats_present_multiplier)
					if mod ~= 0 and (modded_value > tweak_stats[stat.name][1] or modded_value < tweak_stats[stat.name][#tweak_stats[stat.name]]) then
						new_value = math.round((new_value + base_stats[stat.name].value / mod) / 2)
					end
					base_stats[stat.name].value = new_value
				else
					base_stats[stat.name].value = math.round(base_stats[stat.name].value * mod)
				end
			end
		end
	end
	return base_stats
end

function BlackMarketGui:_get_melee_weapon_stats(name)
	local base_stats = {}
	local mods_stats = {}
	local skill_stats = {}
	local stats_data = managers.blackmarket:get_melee_weapon_stats(name)
	local multiple_of = {}
	local has_non_special = managers.player:has_category_upgrade("player", "non_special_melee_multiplier")
	local has_special = managers.player:has_category_upgrade("player", "melee_damage_multiplier")
	local non_special = managers.player:upgrade_value("player", "non_special_melee_multiplier", 1) - 1
	local special = managers.player:upgrade_value("player", "melee_damage_multiplier", 1) - 1
	for i, stat in ipairs(self._mweapon_stats_shown) do
		local skip_rounding = stat.num_decimals
		base_stats[stat.name] = {
			value = 0,
			min_value = 0,
			max_value = 0
		}
		mods_stats[stat.name] = {
			value = 0,
			min_value = 0,
			max_value = 0
		}
		skill_stats[stat.name] = {
			value = 0,
			min_value = 0,
			max_value = 0
		}
		if stat.name == "damage" then
			local base_min = stats_data.min_damage * tweak_data.gui.stats_present_multiplier
			local base_max = stats_data.max_damage * tweak_data.gui.stats_present_multiplier
			local dmg_mul = managers.player:upgrade_value("player", "melee_" .. tostring(tweak_data.blackmarket.melee_weapons[name].stats.weapon_type) .. "_damage_multiplier", 1)
			local skill_mul = dmg_mul * ((has_non_special and has_special and math.max(non_special, special) or 0) + 1) - 1
			local skill_min = skill_mul
			local skill_max = skill_mul
			base_stats[stat.name] = {
				min_value = base_min,
				max_value = base_max,
				value = (base_min + base_max) / 2
			}
			skill_stats[stat.name] = {
				min_value = skill_min,
				max_value = skill_max,
				value = (skill_min + skill_max) / 2
			}
			skill_stats[stat.name].skill_in_effect = skill_min > 0 or skill_max > 0
		elseif stat.name == "damage_effect" then
			local base_min = stats_data.min_damage_effect
			local base_max = stats_data.max_damage_effect
			base_stats[stat.name] = {
				min_value = base_min,
				max_value = base_max,
				value = (base_min + base_max) / 2
			}
			local dmg_mul = managers.player:upgrade_value("player", "melee_" .. tostring(tweak_data.blackmarket.melee_weapons[name].stats.weapon_type) .. "_damage_multiplier", 1) - 1
			local enf_skill = has_non_special and has_special and math.max(non_special, special) or 0
			local gst_skill = managers.player:upgrade_value("player", "melee_knockdown_mul", 1) - 1
			local skill_mul = (1 + dmg_mul) * (1 + enf_skill) * (1 + gst_skill) - 1
			local skill_min = skill_mul
			local skill_max = skill_mul
			skill_stats[stat.name] = {
				skill_min = skill_min,
				skill_max = skill_max,
				min_value = skill_min,
				max_value = skill_max,
				value = (skill_min + skill_max) / 2
			}
			skill_stats[stat.name].skill_in_effect = skill_min > 0 or skill_max > 0
		elseif stat.name == "charge_time" then
			local base = stats_data.charge_time
			base_stats[stat.name] = {
				value = base,
				min_value = base,
				max_value = base
			}
		elseif stat.name == "range" then
			local base_min = math.round(stats_data.range)
			local base_max = math.round(stats_data.range)
			base_stats[stat.name] = {
				min_value = base_min,
				max_value = base_max,
				value = (base_min + base_max) / 2
			}
		elseif stat.name == "concealment" then
			local base = math.round(managers.blackmarket:_calculate_melee_weapon_concealment(name))
			local skill = math.round(managers.blackmarket:concealment_modifier("melee_weapons"))
			base_stats[stat.name] = {
				min_value = base,
				max_value = base,
				value = base
			}
			skill_stats[stat.name] = {
				min_value = skill,
				max_value = skill,
				value = skill
			}
			skill_stats[stat.name].skill_in_effect = skill > 0
		end
		if stat.multiple_of then
			table.insert(multiple_of, {
				stat.name,
				stat.multiple_of
			})
		end
		base_stats[stat.name].real_value = base_stats[stat.name].value
		mods_stats[stat.name].real_value = mods_stats[stat.name].value
		skill_stats[stat.name].real_value = skill_stats[stat.name].value
		base_stats[stat.name].real_min_value = base_stats[stat.name].min_value
		mods_stats[stat.name].real_min_value = mods_stats[stat.name].min_value
		skill_stats[stat.name].real_min_value = skill_stats[stat.name].min_value
		base_stats[stat.name].real_max_value = base_stats[stat.name].max_value
		mods_stats[stat.name].real_max_value = mods_stats[stat.name].max_value
		skill_stats[stat.name].real_max_value = skill_stats[stat.name].max_value
	end
	for i, data in ipairs(multiple_of) do
		local multiplier = data[1]
		local stat = data[2]
		base_stats[multiplier].min_value = base_stats[stat].real_min_value * base_stats[multiplier].real_min_value
		base_stats[multiplier].max_value = base_stats[stat].real_max_value * base_stats[multiplier].real_max_value
		base_stats[multiplier].value = (base_stats[multiplier].min_value + base_stats[multiplier].max_value) / 2
	end
	for i, stat in ipairs(self._mweapon_stats_shown) do
		if not stat.index then
			if skill_stats[stat.name].value and base_stats[stat.name].value then
				skill_stats[stat.name].value = math.round(base_stats[stat.name].value * skill_stats[stat.name].value)
				base_stats[stat.name].value = math.round(base_stats[stat.name].value)
			end
			if skill_stats[stat.name].min_value and base_stats[stat.name].min_value then
				skill_stats[stat.name].min_value = math.round(base_stats[stat.name].min_value * skill_stats[stat.name].min_value)
				base_stats[stat.name].min_value = math.round(base_stats[stat.name].min_value)
			end
			if skill_stats[stat.name].max_value and base_stats[stat.name].max_value then
				skill_stats[stat.name].max_value = math.round(base_stats[stat.name].max_value * skill_stats[stat.name].max_value)
				base_stats[stat.name].max_value = math.round(base_stats[stat.name].max_value)
			end
		end
	end
	return base_stats, mods_stats, skill_stats
end

function BlackMarketGui:_get_armor_stats(name)
	local base_stats = {}
	local mods_stats = {}
	local skill_stats = {}
	local detection_risk = managers.blackmarket:get_suspicion_offset_from_custom_data({armors = name}, tweak_data.player.SUSPICION_OFFSET_LERP or 0.75)
	detection_risk = math.round(detection_risk * 100)
	local bm_armor_tweak = tweak_data.blackmarket.armors[name]
	local upgrade_level = bm_armor_tweak.upgrade_level
	for i, stat in ipairs(self._armor_stats_shown) do
		base_stats[stat.name] = {value = 0}
		mods_stats[stat.name] = {value = 0}
		skill_stats[stat.name] = {value = 0}
		if stat.name == "armor" then
			local base = tweak_data.player.damage.ARMOR_INIT
			local mod = managers.player:body_armor_value("armor", upgrade_level)
			base_stats[stat.name] = {
				value = math.round((base + mod) * tweak_data.gui.stats_present_multiplier)
			}
			skill_stats[stat.name] = {
				value = math.round((base_stats[stat.name].value + managers.player:body_armor_skill_addend(name) * tweak_data.gui.stats_present_multiplier) * managers.player:body_armor_skill_multiplier() - base_stats[stat.name].value)
			}
		elseif stat.name == "concealment" then
			base_stats[stat.name] = {
				value = math.round(managers.player:body_armor_value("concealment", upgrade_level))
			}
			skill_stats[stat.name] = {
				value = math.round(managers.blackmarket:concealment_modifier("armors"))
			}
		elseif stat.name == "movement" then
			local base = tweak_data.player.movement_state.standard.movement.speed.STANDARD_MAX / 100 * tweak_data.gui.stats_present_multiplier
			local movement_penalty = managers.player:body_armor_value("movement", upgrade_level)
			local base_value = math.round(movement_penalty * base)
			base_stats[stat.name] = {value = base_value}
			local skill_mod = managers.player:movement_speed_multiplier(false, false, upgrade_level)
			local skill_value = math.round(skill_mod * base) - base_value
			skill_stats[stat.name] = {value = skill_value}
			skill_stats[stat.name].skill_in_effect = skill_value > 0
		elseif stat.name == "dodge" then
			local base = 0
			local mod = managers.player:body_armor_value("dodge", upgrade_level)
			base_stats[stat.name] = {
				value = math.round((base + mod) * 100)
			}
			skill_stats[stat.name] = {
				value = math.round(managers.player:skill_dodge_chance(false, false, false, name, detection_risk) * 100)
			}
		elseif stat.name == "damage_shake" then
			local base = tweak_data.gui.armor_damage_shake_base
			local mod = math.max(managers.player:body_armor_value("damage_shake", upgrade_level, nil, 1), 0.01)
			local skill = math.max(managers.player:upgrade_value("player", "damage_shake_multiplier", 1), 0.01)
			local base_value = base
			local mod_value = base / mod - base_value
			local skill_value = base / mod / skill - base_value - mod_value + managers.player:upgrade_value("player", "damage_shake_addend", 0)
			base_stats[stat.name] = {
				value = math.round((base_value + mod_value) * tweak_data.gui.stats_present_multiplier)
			}
			skill_stats[stat.name] = {
				value = math.round(skill_value * tweak_data.gui.stats_present_multiplier)
			}
		elseif stat.name == "stamina" then
			local stamina_data = tweak_data.player.movement_state.stamina
			local base = stamina_data.STAMINA_INIT
			local mod = managers.player:body_armor_value("stamina", upgrade_level)
			local skill = managers.player:stamina_multiplier()
			local base_value = base
			local mod_value = base * mod - base_value
			local skill_value = base * mod * skill - base_value - mod_value
			base_stats[stat.name] = {
				value = math.round(base_value + mod_value)
			}
			skill_stats[stat.name] = {
				value = math.round(skill_value)
			}
		end
		skill_stats[stat.name].skill_in_effect = skill_stats[stat.name].skill_in_effect or skill_stats[stat.name].value ~= 0
	end
	return base_stats, mods_stats, skill_stats
end

function BlackMarketGui:_get_stats(name, category, slot)
	local equipped_mods
	local silencer = false
	local single_mod = false
	local auto_mod = false
	local blueprint = managers.blackmarket:get_weapon_blueprint(category, slot)
	if blueprint then
		equipped_mods = deep_clone(blueprint)
		local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(name)
		local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
		for _, default_part in ipairs(default_blueprint) do
			table.delete(equipped_mods, default_part)
		end
		if equipped_mods then
			silencer = managers.weapon_factory:has_perk("silencer", factory_id, equipped_mods)
			single_mod = managers.weapon_factory:has_perk("fire_mode_single", factory_id, equipped_mods)
			auto_mod = managers.weapon_factory:has_perk("fire_mode_auto", factory_id, equipped_mods)
		end
	end
	local base_stats = self:_get_base_stats(name)
	local mods_stats = self:_get_mods_stats(name, base_stats, equipped_mods)
	local skill_stats = self:_get_skill_stats(name, category, slot, base_stats, mods_stats, silencer, single_mod, auto_mod)
	local clip_ammo, max_ammo, ammo_data = self:get_weapon_ammo_info(name, tweak_data.weapon[name].stats.extra_ammo, base_stats.totalammo.index + mods_stats.totalammo.index)
	base_stats.totalammo.value = ammo_data.base
	mods_stats.totalammo.value = ammo_data.mod
	skill_stats.totalammo.value = ammo_data.skill
	skill_stats.totalammo.skill_in_effect = ammo_data.skill_in_effect
	local my_clip = base_stats.magazine.value + mods_stats.magazine.value + skill_stats.magazine.value
	if max_ammo < my_clip then
		mods_stats.magazine.value = mods_stats.magazine.value + (max_ammo - my_clip)
	end
	return base_stats, mods_stats, skill_stats
end

function BlackMarketGui:_get_weapon_mod_stats(mod_name, weapon_name, base_stats, mods_stats, equipped_mods)
	local tweak_stats = tweak_data.weapon.stats
	local tweak_factory = tweak_data.weapon.factory.parts
	local modifier_stats = tweak_data.weapon[weapon_name].stats_modifiers
	local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_name)
	local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
	local part_data
	local mod_stats = {}
	mod_stats.chosen = {}
	mod_stats.equip = {}
	for _, stat in pairs(self._stats_shown) do
		mod_stats.chosen[stat.name] = 0
		mod_stats.equip[stat.name] = 0
	end
	mod_stats.chosen.name = mod_name
	if equipped_mods then
		for _, mod in ipairs(equipped_mods) do
			if tweak_factory[mod] and tweak_factory[mod_name].type == tweak_factory[mod].type then
				mod_stats.equip.name = mod
			else
			end
		end
	end
	local curr_stats = base_stats
	local index
	for _, mod in pairs(mod_stats) do
		part_data = nil
		if mod.name then
			part_data = managers.weapon_factory:get_part_data_by_part_id_from_weapon(mod.name, factory_id, default_blueprint)
		end
		for _, stat in pairs(self._stats_shown) do
			if part_data and part_data.stats then
				if stat.name == "magazine" then
					local ammo = part_data.stats.extra_ammo
					ammo = ammo and ammo + (tweak_data.weapon[weapon_name].stats.extra_ammo or 0)
					mod[stat.name] = ammo and tweak_data.weapon.stats.extra_ammo[ammo] or 0
				elseif stat.name == "totalammo" then
					local chosen_index = part_data.stats.total_ammo_mod or 0
					chosen_index = math.clamp(base_stats[stat.name].index + chosen_index, 1, #tweak_stats.total_ammo_mod)
					mod[stat.name] = math.round(base_stats[stat.name].value * tweak_stats.total_ammo_mod[chosen_index])
				else
					local chosen_index = part_data.stats[stat.name] or 0
					if tweak_stats[stat.name] then
						index = math.clamp(curr_stats[stat.name].index + chosen_index, 1, #tweak_stats[stat.name])
						mod[stat.name] = math.round(stat.index and index or tweak_stats[stat.name][index] * tweak_data.gui.stats_present_multiplier)
						local offset = math.round(math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier)
						if stat.offset then
							mod[stat.name] = mod[stat.name] - offset
						end
						if stat.revert then
							local max_stat = math.round(math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier)
							if stat.revert then
								max_stat = max_stat - offset
							end
							mod[stat.name] = max_stat - mod[stat.name]
						end
						if modifier_stats and modifier_stats[stat.name] then
							local mod_stat = modifier_stats[stat.name]
							if stat.revert and not stat.index then
								local real_base_value = tweak_stats[stat.name][index]
								local modded_value = real_base_value * mod_stat
								local offset = math.round(math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]))
								if stat.offset then
									modded_value = modded_value - offset
								end
								local max_stat = math.round(math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]))
								if stat.revert then
									max_stat = max_stat - offset
								end
								local new_value = math.round((max_stat - modded_value) * tweak_data.gui.stats_present_multiplier)
								if mod_stat ~= 0 and (modded_value > tweak_stats[stat.name][1] or modded_value < tweak_stats[stat.name][#tweak_stats[stat.name]]) then
									new_value = math.round((new_value + mod[stat.name] / mod_stat) / 2)
								end
								mod[stat.name] = new_value
							else
								mod[stat.name] = math.round(mod[stat.name] * mod_stat)
							end
						end
						mod[stat.name] = math.round(mod[stat.name] - curr_stats[stat.name].value)
					end
				end
			end
		end
	end
	return mod_stats
end

function BlackMarketGui:_get_stats_for_mod(mod_name, weapon_name, category, slot)
	local equipped_mods
	local blueprint = managers.blackmarket:get_weapon_blueprint(category, slot)
	if blueprint then
		equipped_mods = deep_clone(blueprint)
		local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_name)
		local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
		for _, default_part in ipairs(default_blueprint) do
			table.delete(equipped_mods, default_part)
		end
	end
	local base_stats = self:_get_base_stats(weapon_name)
	local mods_stats = self:_get_mods_stats(weapon_name, base_stats, equipped_mods)
	return self:_get_weapon_mod_stats(mod_name, weapon_name, base_stats, mods_stats, equipped_mods)
end

function BlackMarketGui:hide_melee_weapon_stats()
	for _, stat in ipairs(self._mweapon_stats_shown) do
		self._mweapon_stats_texts[stat.name].name:set_text("")
		self._mweapon_stats_texts[stat.name].equip:set_text("")
		self._mweapon_stats_texts[stat.name].base:set_text("")
		self._mweapon_stats_texts[stat.name].skill:set_text("")
		self._mweapon_stats_texts[stat.name].total:set_text("")
	end
end

function BlackMarketGui:hide_armor_stats()
	for _, stat in ipairs(self._armor_stats_shown) do
		self._armor_stats_texts[stat.name].name:set_text("")
		self._armor_stats_texts[stat.name].equip:set_text("")
		self._armor_stats_texts[stat.name].base:set_text("")
		self._armor_stats_texts[stat.name].skill:set_text("")
		self._armor_stats_texts[stat.name].total:set_text("")
	end
end

function BlackMarketGui:hide_weapon_stats()
	for _, stat in ipairs(self._stats_shown) do
		self._stats_texts[stat.name].name:set_text("")
		self._stats_texts[stat.name].equip:set_text("")
		self._stats_texts[stat.name].base:set_text("")
		self._stats_texts[stat.name].mods:set_text("")
		self._stats_texts[stat.name].skill:set_text("")
		self._stats_texts[stat.name].total:set_text("")
	end
end

function BlackMarketGui:set_stats_titles(...)
	local stat_title_changes = {
		...
	}
	for i, stat_title in ipairs(stat_title_changes) do
		local name = stat_title.name
		local text = stat_title.text or stat_title.text_id and managers.localization:to_upper_text(stat_title.text_id) or false
		local color = stat_title.color or false
		local alpha = stat_title.alpha or false
		local visible = stat_title.show or stat_title.visible or not stat_title.hide or false
		local x = stat_title.x or false
		local y = stat_title.y or false
		if self._stats_titles[name] then
			if text then
				self._stats_titles[name]:set_text(text)
			end
			if color then
				self._stats_titles[name]:set_color(color)
			end
			if alpha then
				self._stats_titles[name]:set_alpha(alpha)
			end
			if x then
				self._stats_titles[name]:set_x(x)
			end
			if y then
				self._stats_titles[name]:set_y(y)
			end
			self._stats_titles[name]:set_visible(visible)
		end
	end
end

function BlackMarketGui:populate_gloves(data)
	for i = 1, #data do
		data[i] = nil
	end

	local sort_data = {}
	local tweak, global_value_tweak = nil

	for i, glove_id in ipairs(tweak_data.blackmarket.glove_list) do
		tweak = tweak_data.blackmarket.gloves[glove_id]
		global_value_tweak = tweak_data.lootdrop.global_values[tweak.global_value]

		if Global.blackmarket_manager.gloves[glove_id] and (not global_value_tweak or not global_value_tweak.hide_unavailable or not not managers.dlc:is_global_value_unlocked(tweak.global_value)) then
			table.insert(sort_data, glove_id)
		end
	end

	local sort_table = {}

	for sort_number, glove_id in ipairs(sort_data) do
		tweak = tweak_data.blackmarket.gloves[glove_id]
		local unlocked = managers.blackmarket:glove_id_unlocked(glove_id)
		local global_value = tweak.global_value
		local dlc = tweak.dlc or global_value and managers.dlc:global_value_to_dlc(global_value)
		local achievement_locked = managers.dlc:is_content_achievement_locked("gloves", glove_id) or managers.dlc:is_content_achievement_milestone_locked("gloves", glove_id)
		local infamy_locked = managers.dlc:is_content_infamy_locked("gloves", glove_id)
		sort_table[glove_id] = {
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

	local achievement_locked_content = managers.dlc:achievement_locked_content().gloves or {}
	local mannequin_glove = data.mannequin_glove_id or managers.menu_scene and managers.menu_scene:get_glove_id() or "none"
	local default_glove_id = managers.blackmarket:get_default_glove_id()
	local new_data, allow_preview, glove_id, glove_data, guis_catalog, bundle_folder, customize_alpha = nil
	local equipped_glove_id = data.equipped_glove_id or managers.blackmarket:equipped_glove_id()
	local max_items = self:calc_max_items(#sort_data, data.override_slots)

	for i = 1, max_items do
		new_data = {
			comparision_data = nil,
			category = "gloves",
			slot = i
		}
		glove_id = sort_data[i]

		if glove_id then
			allow_preview = true
			glove_data = tweak_data.blackmarket.gloves[glove_id]
			guis_catalog = "guis/"
			bundle_folder = glove_data.texture_bundle_folder

			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end

			new_data.name = glove_id
			new_data.name_localized = managers.localization:text(glove_data.name_id)
			new_data.global_value = glove_data.global_value or "normal"
			new_data.unlocked = managers.blackmarket:glove_id_unlocked(glove_id)
			new_data.equipped = equipped_glove_id == glove_id
			new_data.lock_color = self:get_lock_color(new_data)

			if glove_id ~= default_glove_id then
				new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/gloves/" .. glove_id
			else
				new_data.bitmap_texture = "guis/dlcs/trd/textures/pd2/blackmarket/icons/player_styles/none"
			end

			local is_dlc_locked = not managers.dlc:is_global_value_unlocked(new_data.global_value)

			if is_dlc_locked then
				new_data.unlocked = false
				new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_dlc")
				new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
			else
				new_data.unlocked = true
			end

			if new_data.unlocked then
				if not new_data.equipped then
					table.insert(new_data, "hnd_equip")
				end
			else
				local dlc_data = Global.dlc_manager.all_dlc_data[new_data.global_value]

				if dlc_data and dlc_data.app_id and not dlc_data.external and not managers.dlc:is_dlc_unlocked(new_data.global_value) then
					table.insert(new_data, "bw_buy_dlc")
				end

				new_data.bitmap_locked_color = Color.white
				new_data.bitmap_locked_blend_mode = "normal"
				new_data.bitmap_locked_alpha = 0.4
			end

			if allow_preview and mannequin_glove ~= glove_id then
				table.insert(new_data, "hnd_preview")
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

function BlackMarketGui:populate_armor_skins(data)
	local new_data = {}
	local sort_data = {}
	local inventory_tradable = managers.blackmarket:get_inventory_tradable()

	for skin_id, skin_data in pairs(tweak_data.economy.armor_skins) do
		if skin_data.sorted == nil or skin_data.sorted then
			table.insert(sort_data, skin_id)
		end
	end

	table.sort(sort_data, function (a, b)
		local ad = tweak_data.economy.armor_skins[a]
		local bd = tweak_data.economy.armor_skins[b]
		local ar = tweak_data.economy.rarities[ad and ad.rarity or "common"].index
		local br = tweak_data.economy.rarities[bd and bd.rarity or "common"].index

		if ar ~= br then
			return br < ar
		elseif ad.sorting_idx or bd.sorting_idx then
			local as = ad.sorting_idx or -1
			local bs = bd.sorting_idx or -1

			if as ~= bs then
				return bs < as
			end
		end

		return managers.localization:text(ad and ad.name_id or "error") < managers.localization:text(bd and bd.name_id or "error")
	end)
	table.insert(sort_data, 1, "none")

	local guis_catalog = "guis/"
	local index = 0

	for i, skin_id in ipairs(sort_data) do
		local td = tweak_data.economy.armor_skins[skin_id]
		local name_id = td.name_id or ""
		local unlocked = managers.blackmarket:armor_skin_unlocked(skin_id)

		if not unlocked then
			for _, data in pairs(inventory_tradable) do
				if data.entry == skin_id then
					unlocked = true

					break
				end
			end
		end

		guis_catalog = "guis/"
		local bundle_folder = td.texture_bundle_folder

		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end

		index = index + 1
		new_data = {
			name = skin_id,
			name_localized = managers.localization:text(name_id),
			global_value = td.global_value or nil,
			category = "armor_skins",
			slot = index,
			unlocked = true,
			level = 0
		}
		local is_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].dlc and not managers.dlc:is_dlc_unlocked(new_data.global_value)

		if is_locked then
			new_data.unlocked = false
			new_data.lock_texture = "guis/textures/pd2/lock_incompatible"
			new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
		end

		new_data.equipped = skin_id == managers.blackmarket:equipped_armor_skin()

		if i ~= 1 then
			if skin_id == "none" then
				new_data.bitmap_texture = "guis/dlcs/trd/textures/pd2/blackmarket/icons/player_styles/none"
			else
				new_data.bitmap_texture = guis_catalog .. "armor_skins/" .. skin_id
			end
			new_data.bg_texture = managers.blackmarket:get_cosmetic_rarity_bg(td.rarity or "common")
		else
			new_data.button_text = managers.localization:to_upper_text("menu_casino_option_prefer_none")
		end

		new_data.comparision_data = {}
		new_data.cosmetic_unlocked = new_data.unlocked and unlocked or false
		new_data.cosmetic_rarity = td.rarity

		if not new_data.cosmetic_unlocked then
			new_data.lock_texture = "guis/textures/pd2/skilltree/padlock"
			new_data.bitmap_locked_color = Color.white
			new_data.bitmap_locked_blend_mode = "normal"
			new_data.bitmap_locked_alpha = 0.4
			new_data.bg_alpha = 0.4
		end

		if skin_id == "none" then
			new_data.bitmap_texture = "guis/dlcs/trd/textures/pd2/blackmarket/icons/player_styles/none"
		end

		if new_data.cosmetic_unlocked and not new_data.equipped then
			table.insert(new_data, "as_equip")
		end

		table.insert(new_data, "as_preview")
		table.insert(new_data, "as_workshop")

		data[index] = new_data
	end

	local max_armors = self:calc_max_items(#sort_data, data.override_slots)

	for i = 1, max_armors do
		if not data[i] then
			new_data = {
				name = "empty",
				name_localized = "",
				category = "armors",
				slot = #data,
				unlocked = true,
				equipped = false
			}

			table.insert(data, new_data)
		end
	end
end

function BlackMarketGui:populate_weapon_category(category, data)
	managers.blackmarket:clear_temporary()
	managers.blackmarket:clear_preview_blueprint()

	local crafted_category = managers.blackmarket:get_crafted_category(category) or {}
	local last_weapon = table.size(crafted_category) == 1
	local last_unlocked_weapon = nil

	if not last_weapon then
		local category_size = table.size(crafted_category)

		for i, crafted in pairs(crafted_category) do
			if not managers.blackmarket:weapon_unlocked(crafted.weapon_id) then
				category_size = category_size - 1
			end
		end

		last_unlocked_weapon = category_size == 1
	end

	local hold_crafted_item = managers.blackmarket:get_hold_crafted_item()
	local currently_holding = hold_crafted_item and hold_crafted_item.category == category
	local max_items = data.override_slots and data.override_slots[1] * data.override_slots[2] or 9
	local max_rows = tweak_data.gui.MAX_WEAPON_ROWS or 3
	max_items = max_rows * (data.override_slots and data.override_slots[2] or 3)

	for i = 1, max_items do
		data[i] = nil
	end

	local guis_catalog = "guis/"
	local weapon_data = Global.blackmarket_manager.weapons
	local new_data = {}
	local index = 0

	for i, crafted in pairs(crafted_category) do
		guis_catalog = "guis/"
		local bundle_folder = tweak_data.weapon[crafted.weapon_id] and tweak_data.weapon[crafted.weapon_id].texture_bundle_folder

		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end

		new_data = {
			name = crafted.weapon_id,
			name_localized = managers.blackmarket:get_weapon_name_by_category_slot(category, i),
			raw_name_localized = managers.weapon_factory:get_weapon_name_by_factory_id(crafted.factory_id),
			custom_name_text = managers.blackmarket:get_crafted_custom_name(category, i, true),
			category = category,
			slot = i,
			unlocked = managers.blackmarket:weapon_unlocked(crafted.weapon_id),
			level = managers.blackmarket:weapon_level(crafted.weapon_id),
			can_afford = true,
			equipped = crafted.equipped,
			skill_based = weapon_data[crafted.weapon_id].skill_based
		}
		new_data.skill_name = new_data.skill_based and "bm_menu_skill_locked_" .. new_data.name
		new_data.func_based = weapon_data[crafted.weapon_id].func_based
		new_data.price = managers.money:get_weapon_slot_sell_value(category, i)
		local bitmap_texture, bg_texture = managers.blackmarket:get_weapon_icon_path(crafted.weapon_id, crafted.cosmetics)
		new_data.bitmap_texture = bitmap_texture
		new_data.bg_texture = bg_texture
		new_data.comparision_data = managers.blackmarket:get_weapon_stats(category, i)
		new_data.global_value = tweak_data.weapon[new_data.name] and tweak_data.weapon[new_data.name].global_value or "normal"
		new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or nil
		new_data.lock_texture = self:get_lock_icon(new_data)
		new_data.holding = currently_holding and hold_crafted_item.slot == i
		local icon_list = managers.menu_component:create_weapon_mod_icon_list(crafted.weapon_id, category, crafted.factory_id, i)
		local icon_index = 1
		local new_parts = {}

		for _, part in pairs(managers.blackmarket:get_weapon_new_part_drops(crafted.factory_id) or {}) do
			local type = tweak_data.weapon.factory.parts[part].type
			new_parts[type] = true
		end

		if table.size(new_parts) > 0 then
			new_data.new_drop_data = {}
		end

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

			if new_parts[icon.type] then
				table.insert(new_data.mini_icons, {
					texture = "guis/textures/pd2/blackmarket/inv_mod_new",
					layer = 1,
					h = 8,
					stream = false,
					w = 16,
					alpha = 1,
					bottom = 16,
					right = (icon_index - 1) * 18
				})
			end

			icon_index = icon_index + 1
		end

		new_data.hide_unselected_mini_icons = true
		color_tweak = crafted.cosmetics and tweak_data.blackmarket.weapon_skins[crafted.cosmetics.id]

		if color_tweak and color_tweak.is_a_color_skin then
			guis_catalog = "guis/"
			bundle_folder = color_tweak.texture_bundle_folder

			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end

			table.insert(new_data.mini_icons, {
				stream = true,
				h = 32,
				layer = 0,
				w = 64,
				right = -16,
				texture = guis_catalog .. "textures/pd2/blackmarket/icons/weapon_color/" .. crafted.cosmetics.id,
				bottom = math.floor((#icon_list - 1) / 11) * 25 + 24
			})
		end

		if not new_data.unlocked then
			new_data.last_weapon = last_weapon
		else
			new_data.last_weapon = last_weapon or last_unlocked_weapon
		end

		if new_data.equipped then
			self._equipped_comparision_data = self._equipped_comparision_data or {}
			self._equipped_comparision_data[category] = new_data.comparision_data
		end

		if currently_holding then
			new_data.selected_text = managers.localization:to_upper_text("bm_menu_btn_swap_weapon")

			if new_data.slot ~= hold_crafted_item.slot then
				table.insert(new_data, "w_swap")
			end

			table.insert(new_data, "i_stop_move")
		else
			local has_mods = managers.weapon_factory:has_weapon_more_than_default_parts(crafted.factory_id)
			local can_mod = true

			if can_mod and has_mods and new_data.unlocked then
				table.insert(new_data, "w_mod")
			end

			if has_mods and new_data.unlocked and managers.workshop and managers.workshop:enabled() and not table.contains(managers.blackmarket:skin_editor():get_excluded_weapons(), new_data.name) then
				table.insert(new_data, "w_skin")
			end

			if not new_data.last_weapon then
				table.insert(new_data, "w_sell")
			end

			if not new_data.equipped and new_data.unlocked then
				table.insert(new_data, "w_equip")
			end

			if new_data.equipped and new_data.unlocked then
				table.insert(new_data, "w_move")
			end

			table.insert(new_data, "w_preview")
		end

		data[i] = new_data
		index = i
	end

	for i = 1, max_items do
		if not data[i] then
			local can_buy_weapon = managers.blackmarket:is_weapon_slot_unlocked(category, i)
			new_data = {}

			if can_buy_weapon then
				new_data.name = "bm_menu_btn_buy_new_weapon"
				new_data.name_localized = managers.localization:text("bm_menu_empty_weapon_slot")
				new_data.mid_text = {
					noselected_text = new_data.name_localized,
					noselected_color = tweak_data.screen_colors.button_stage_3
				}
				new_data.mid_text.selected_text = currently_holding and new_data.mid_text.noselected_text or managers.localization:text("bm_menu_btn_buy_new_weapon")
				new_data.mid_text.selected_color = currently_holding and new_data.mid_text.noselected_color or tweak_data.screen_colors.button_stage_2
				new_data.empty_slot = true
				new_data.category = category
				new_data.slot = i
				new_data.unlocked = true
				new_data.can_afford = true
				new_data.equipped = false

				if currently_holding then
					new_data.selected_text = managers.localization:to_upper_text("bm_menu_btn_place_weapon")

					table.insert(new_data, "w_place")
					table.insert(new_data, "i_stop_move")
				else
					table.insert(new_data, "ew_buy")
				end

				if managers.blackmarket:got_new_drop(new_data.category, "weapon_buy_empty", nil) then
					new_data.mini_icons = new_data.mini_icons or {}

					table.insert(new_data.mini_icons, {
						stream = false,
						name = "new_drop",
						h = 16,
						layer = 1,
						w = 16,
						texture = "guis/textures/pd2/blackmarket/inv_newdrop",
						visible = false,
						top = 0,
						right = 0
					})

					new_data.new_drop_data = {}
				end
			else
				new_data.name = "bm_menu_btn_buy_weapon_slot"
				new_data.name_localized = managers.localization:text("bm_menu_locked_weapon_slot")
				new_data.empty_slot = true
				new_data.category = category
				new_data.slot = i
				new_data.unlocked = true
				new_data.equipped = false
				new_data.lock_texture = "guis/textures/pd2/blackmarket/money_lock"
				new_data.lock_color = tweak_data.screen_colors.button_stage_3
				new_data.lock_shape = {
					w = 32,
					x = 0,
					h = 32,
					y = -32
				}
				new_data.locked_slot = true
				new_data.dlc_locked = managers.experience:cash_string(managers.money:get_buy_weapon_slot_price())
				new_data.mid_text = {
					noselected_text = new_data.name_localized,
					noselected_color = tweak_data.screen_colors.button_stage_3,
					is_lock_same_color = true
				}

				if currently_holding then
					new_data.mid_text.selected_text = new_data.mid_text.noselected_text
					new_data.mid_text.selected_color = new_data.mid_text.noselected_color

					table.insert(new_data, "i_stop_move")
				elseif managers.money:can_afford_buy_weapon_slot() then
					new_data.mid_text.selected_text = managers.localization:text("bm_menu_btn_buy_weapon_slot")
					new_data.mid_text.selected_color = tweak_data.screen_colors.button_stage_2

					table.insert(new_data, "ew_unlock")
				else
					new_data.mid_text.selected_text = managers.localization:text("bm_menu_cannot_buy_weapon_slot")
					new_data.mid_text.selected_color = tweak_data.screen_colors.important_1
					new_data.dlc_locked = new_data.dlc_locked .. "  " .. managers.localization:to_upper_text("bm_menu_cannot_buy_weapon_slot")
					new_data.mid_text.lock_noselected_color = tweak_data.screen_colors.important_1
					new_data.cannot_buy = true
				end
			end

			data[i] = new_data
		end
	end
end

function BlackMarketGui:show_stats()
	if not self._stats_panel or not self._rweapon_stats_panel or not self._armor_stats_panel or not self._mweapon_stats_panel then
		return
	end
	self._stats_panel:hide()
	self._rweapon_stats_panel:hide()
	self._armor_stats_panel:hide()
	self._mweapon_stats_panel:hide()
	if not self._slot_data then
		return
	end
	if not self._slot_data.comparision_data then
		return
	end
	if tweak_data.economy.armor_skins[self._slot_data.name] then
		return
	end
	local identifier = self._tabs[self._selected]._data.identifier
	if identifier == self.identifiers.weapon_cosmetic then
		return
	end
	local weapon = managers.blackmarket:get_crafted_category_slot(self._slot_data.category, self._slot_data.slot)
	local name = weapon and weapon.weapon_id or self._slot_data.name
	local category = self._slot_data.category
	local slot = self._slot_data.slot
	local value = 0
	local tweak_stats = tweak_data.weapon.stats

	if tweak_data.weapon[self._slot_data.name] then
		self:set_weapons_stats_columns()

		local equipped_item = managers.blackmarket:equipped_item(category)
		local equipped_slot = self._slot_data.equipped_slot or managers.blackmarket:equipped_weapon_slot(category)
		local equipped_name = self._slot_data.equipped_name or equipped_item.weapon_id

		if self._slot_data.default_blueprint then
			equipped_slot = slot
			equipped_name = name
		end

		local equip_base_stats, equip_mods_stats, equip_skill_stats = WeaponDescription._get_stats(equipped_name, category, equipped_slot)
		local base_stats, mods_stats, skill_stats = WeaponDescription._get_stats(name, category, slot, self._slot_data.default_blueprint)

		self._rweapon_stats_panel:show()
		self:hide_armor_stats()
		self:hide_melee_weapon_stats()
		self:set_stats_titles({
			x = 170,
			name = "base"
		}, {
			alpha = 0.75,
			name = "mod",
			text_id = "bm_menu_stats_mod",
			x = 215,
			color = tweak_data.screen_colors.stats_mods
		}, {
			alpha = 0.75,
			name = "skill"
		})

		if slot ~= equipped_slot then
			for _, title in pairs(self._stats_titles) do
				title:hide()
			end

			self:set_stats_titles({
				show = true,
				name = "total"
			}, {
				name = "equip",
				text_id = "bm_menu_equipped",
				alpha = 0.75,
				x = 105,
				show = true
			})
		else
			for _, title in pairs(self._stats_titles) do
				title:show()
			end

			self:set_stats_titles({
				hide = true,
				name = "total"
			}, {
				alpha = 1,
				name = "equip",
				x = 120,
				text_id = "bm_menu_stats_total"
			})
		end

		for _, stat in ipairs(self._stats_shown) do
			self._stats_texts[stat.name].name:set_text(utf8.to_upper(managers.localization:text("bm_menu_" .. stat.name)))
				value = math.max(base_stats[stat.name].value + mods_stats[stat.name].value + skill_stats[stat.name].value, 0)

			if slot == equipped_slot then
				local base = base_stats[stat.name].value
				
				self._stats_texts[stat.name].equip:set_alpha(1)
				self._stats_texts[stat.name].equip:set_text(format_round(value, stat.round_value))
				self._stats_texts[stat.name].base:set_text(format_round(base, stat.round_value))
				self._stats_texts[stat.name].mods:set_text(mods_stats[stat.name].value == 0 and "" or (mods_stats[stat.name].value > 0 and "+" or "") .. format_round(mods_stats[stat.name].value, stat.round_value))
				self._stats_texts[stat.name].skill:set_text(skill_stats[stat.name].skill_in_effect and (skill_stats[stat.name].value > 0 and "+" or "") .. format_round(skill_stats[stat.name].value, stat.round_value) or "")
				self._stats_texts[stat.name].total:set_text("")
				--self._stats_texts[stat.name].removed:set_text("")
				self._stats_texts[stat.name].base:set_alpha(0.75)
				self._stats_texts[stat.name].mods:set_alpha(0.75)
				self._stats_texts[stat.name].skill:set_alpha(0.75)
				if base < value then
					self._stats_texts[stat.name].equip:set_color(stat.inverted and tweak_data.screen_colors.stats_negative or tweak_data.screen_colors.stats_positive)
				elseif value < base then
					self._stats_texts[stat.name].equip:set_color(stat.inverted and tweak_data.screen_colors.stats_positive or tweak_data.screen_colors.stats_negative)
				else
					self._stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
				end
				self._stats_texts[stat.name].skill:set_color(tweak_data.screen_colors.resource)
				self._stats_texts[stat.name].total:set_color(tweak_data.screen_colors.text)
				if stat.percent then
					if math.round(value) >= 100 then
						self._stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stat_maxed)
					end
				elseif stat.index then
					-- Nothing
				elseif tweak_stats[stat.name] then
					local without_skill = math.round(base_stats[stat.name].value + mods_stats[stat.name].value)
					local max_stat = math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier * (modifier_stats and modifier_stats[stat.name] or 1)
					if stat.offset then
						local offset = math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier * (modifier_stats and modifier_stats[stat.name] or 1)
						max_stat = max_stat - offset
					end
					if without_skill >= max_stat then
						self._stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stat_maxed)
					end
				end
			else
				local equip = math.max(equip_base_stats[stat.name].value + equip_mods_stats[stat.name].value + equip_skill_stats[stat.name].value, 0)
				self._stats_texts[stat.name].equip:set_alpha(0.75)
				self._stats_texts[stat.name].equip:set_text(format_round(equip, stat.round_value))
				self._stats_texts[stat.name].base:set_text("")
				self._stats_texts[stat.name].mods:set_text("")
				self._stats_texts[stat.name].skill:set_text("")
				--self._stats_texts[stat.name].removed:set_text("")
				self._stats_texts[stat.name].total:set_text(format_round(value, stat.round_value))
				if equip < value then
					self._stats_texts[stat.name].total:set_color(stat.inverted and tweak_data.screen_colors.stats_negative or tweak_data.screen_colors.stats_positive)
				elseif value < equip then
					self._stats_texts[stat.name].total:set_color(stat.inverted and tweak_data.screen_colors.stats_positive or tweak_data.screen_colors.stats_negative)
				else
					self._stats_texts[stat.name].total:set_color(tweak_data.screen_colors.text)
				end
				self._stats_texts[stat.name].skill:set_color(tweak_data.screen_colors.resource)
				self._stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
				if stat.percent then
					if math.round(value) >= 100 then
						self._stats_texts[stat.name].total:set_color(tweak_data.screen_colors.stat_maxed)
					end
				elseif stat.index then
					-- Nothing
				elseif tweak_stats[stat.name] then
					local without_skill = math.round(base_stats[stat.name].value + mods_stats[stat.name].value)
					local max_stat = math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier * (modifier_stats and modifier_stats[stat.name] or 1)
					if stat.offset then
						local offset = math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier * (modifier_stats and modifier_stats[stat.name] or 1)
						max_stat = max_stat - offset
					end
					if without_skill >= max_stat then
						self._stats_texts[stat.name].total:set_color(tweak_data.screen_colors.stat_maxed)
					end
				end
			end
		end
	elseif tweak_data.blackmarket.armors[self._slot_data.name] then
		local equipped_item = managers.blackmarket:equipped_item(category)
		local equipped_slot = managers.blackmarket:equipped_armor_slot()
		local equip_base_stats, equip_mods_stats, equip_skill_stats = self:_get_armor_stats(equipped_item)
		local base_stats, mods_stats, skill_stats = self:_get_armor_stats(self._slot_data.name)
		self._armor_stats_panel:show()
		self:hide_weapon_stats()
		self:hide_melee_weapon_stats()
		self:set_stats_titles({name = "base", x = 185}, {
			name = "mod",
			text_id = "bm_menu_stats_skill",
			color = tweak_data.screen_colors.resource,
			x = 245
		}, {name = "skill", alpha = 0})
		if self._slot_data.name ~= equipped_slot then
			for _, title in pairs(self._stats_titles) do
				title:hide()
			end
			self:set_stats_titles({name = "total", show = true}, {
				name = "equip",
				show = true,
				text_id = "bm_menu_equipped",
				alpha = 0.75,
				x = 105
			})
		else
			for title_name, title in pairs(self._stats_titles) do
				title:show()
			end
			self:set_stats_titles({name = "total", hide = true}, {
				name = "equip",
				text_id = "bm_menu_stats_total",
				alpha = 1,
				x = 120
			})
		end
		for _, stat in ipairs(self._armor_stats_shown) do
			self._armor_stats_texts[stat.name].name:set_text(utf8.to_upper(managers.localization:text("bm_menu_" .. stat.name)))
			value = math.max(base_stats[stat.name].value + mods_stats[stat.name].value + skill_stats[stat.name].value, 0)
			if self._slot_data.name == equipped_slot then
				local base = base_stats[stat.name].value
				self._armor_stats_texts[stat.name].equip:set_alpha(1)
				self._armor_stats_texts[stat.name].equip:set_text(value)
				self._armor_stats_texts[stat.name].base:set_text(base)
				if skill_stats[stat.name].skill_in_effect then
				else
				end
				self._armor_stats_texts[stat.name].skill:set_text((0 < skill_stats[stat.name].value and "+" or "") .. skill_stats[stat.name].value or "")
				self._armor_stats_texts[stat.name].total:set_text("")
				self._armor_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
				if value ~= 0 and value > base then
					self._armor_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stats_positive)
				elseif value ~= 0 and value < base then
					self._armor_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stats_negative)
				else
					self._armor_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
				end
				self._armor_stats_texts[stat.name].total:set_color(tweak_data.screen_colors.text)
			else
				local equip = math.max(equip_base_stats[stat.name].value + equip_mods_stats[stat.name].value + equip_skill_stats[stat.name].value, 0)
				self._armor_stats_texts[stat.name].equip:set_alpha(0.75)
				self._armor_stats_texts[stat.name].equip:set_text(equip)
				self._armor_stats_texts[stat.name].base:set_text("")
				self._armor_stats_texts[stat.name].skill:set_text("")
				self._armor_stats_texts[stat.name].total:set_text(value)
				if value > equip then
					self._armor_stats_texts[stat.name].total:set_color(tweak_data.screen_colors.stats_positive)
				elseif value < equip then
					self._armor_stats_texts[stat.name].total:set_color(tweak_data.screen_colors.stats_negative)
				else
					self._armor_stats_texts[stat.name].total:set_color(tweak_data.screen_colors.text)
				end
				self._armor_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
			end
		end
	elseif tweak_data.economy.armor_skins[self._slot_data.name] then
		self:hide_melee_weapon_stats()
		self:hide_armor_stats()
		self:hide_weapon_stats()
		self._armor_stats_panel:hide()

		for _, title in pairs(self._stats_titles) do
			title:hide()
		end

		hide_stats = true
	elseif tweak_data.blackmarket.melee_weapons[self._slot_data.name] then
		self:hide_armor_stats()
		self:hide_weapon_stats()
		self._mweapon_stats_panel:show()
		self:set_stats_titles({name = "base", x = 185}, {
			name = "mod",
			text_id = "bm_menu_stats_skill",
			color = tweak_data.screen_colors.resource,
			x = 245
		}, {name = "skill", alpha = 0})
		local equipped_item = managers.blackmarket:equipped_item(category)
		local equip_base_stats, equip_mods_stats, equip_skill_stats = self:_get_melee_weapon_stats(equipped_item)
		local base_stats, mods_stats, skill_stats = self:_get_melee_weapon_stats(self._slot_data.name)
		if self._slot_data.name ~= equipped_item then
			for _, title in pairs(self._stats_titles) do
				title:hide()
			end
			self:set_stats_titles({name = "total", show = true}, {
				name = "equip",
				show = true,
				text_id = "bm_menu_equipped",
				alpha = 0.75,
				x = 105
			})
		else
			for title_name, title in pairs(self._stats_titles) do
				title:show()
			end
			self:set_stats_titles({name = "total", hide = true}, {
				name = "equip",
				text_id = "bm_menu_stats_total",
				alpha = 1,
				x = 120
			})
		end
		local value_min, value_max, skill_value_min, skill_value_max, skill_value
		for _, stat in ipairs(self._mweapon_stats_shown) do
			self._mweapon_stats_texts[stat.name].name:set_text(utf8.to_upper(managers.localization:text("bm_menu_" .. stat.name)))
			if stat.range then
				value_min = math.max(base_stats[stat.name].min_value + mods_stats[stat.name].min_value + skill_stats[stat.name].min_value, 0)
				value_max = math.max(base_stats[stat.name].max_value + mods_stats[stat.name].max_value + skill_stats[stat.name].max_value, 0)
			end
			value = math.max(base_stats[stat.name].value + mods_stats[stat.name].value + skill_stats[stat.name].value, 0)
			if self._slot_data.name == equipped_item then
				local base, base_min, base_max, skill, skill_min, skill_max
				if stat.range then
					base_min = base_stats[stat.name].min_value
					base_max = base_stats[stat.name].max_value
					skill_min = skill_stats[stat.name].min_value
					skill_max = skill_stats[stat.name].max_value
				end
				base = base_stats[stat.name].value
				skill = skill_stats[stat.name].value
				local format_string = "%0." .. tostring(stat.num_decimals or 0) .. "f"
				local equip_text = value and string.format(format_string, value)
				local base_text = base and string.format(format_string, base)
				local skill_text = skill_stats[stat.name].value and string.format(format_string, skill_stats[stat.name].value)
				local base_min_text = base_min and string.format(format_string, base_min)
				local base_max_text = base_max and string.format(format_string, base_max)
				local value_min_text = value_min and string.format(format_string, value_min)
				local value_max_text = value_max and string.format(format_string, value_max)
				local skill_min_text = skill_min and string.format(format_string, skill_min)
				local skill_max_text = skill_max and string.format(format_string, skill_max)
				if stat.range then
					if base_min ~= base_max then
						base_text = base_min_text .. " (" .. base_max_text .. ")"
					end
					if value_min ~= value_max then
						equip_text = value_min_text .. " (" .. value_max_text .. ")"
					end
					if skill_min ~= skill_max then
						skill_text = skill_min_text .. " (" .. skill_max_text .. ")"
					end
				end
				if stat.suffix then
					base_text = base_text .. tostring(stat.suffix)
					equip_text = equip_text .. tostring(stat.suffix)
					skill_text = skill_text .. tostring(stat.suffix)
				end
				if stat.prefix then
					base_text = tostring(stat.prefix) .. base_text
					equip_text = tostring(stat.prefix) .. equip_text
					skill_text = tostring(stat.prefix) .. skill_text
				end
				self._mweapon_stats_texts[stat.name].equip:set_alpha(1)
				self._mweapon_stats_texts[stat.name].equip:set_text(equip_text)
				self._mweapon_stats_texts[stat.name].base:set_text(base_text)
				if skill_stats[stat.name].skill_in_effect then
				else
				end
				self._mweapon_stats_texts[stat.name].skill:set_text((0 < skill_stats[stat.name].value and "+" or "") .. skill_text or "")
				self._mweapon_stats_texts[stat.name].total:set_text("")
				self._mweapon_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
				local positive = value ~= 0 and value > base
				local negative = value ~= 0 and value < base
				if stat.inverse then
					local temp = positive
					positive = negative
					negative = temp
				end
				if stat.range then
					if positive then
						self._mweapon_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stats_positive)
					elseif negative then
						self._mweapon_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stats_negative)
					end
				elseif positive then
					self._mweapon_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stats_positive)
				elseif negative then
					self._mweapon_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stats_negative)
				else
					self._mweapon_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
				end
				self._mweapon_stats_texts[stat.name].total:set_color(tweak_data.screen_colors.text)
			else
				local equip, equip_min, equip_max
				if stat.range then
					equip_min = math.max(equip_base_stats[stat.name].min_value + equip_mods_stats[stat.name].min_value + equip_skill_stats[stat.name].min_value, 0)
					equip_max = math.max(equip_base_stats[stat.name].max_value + equip_mods_stats[stat.name].max_value + equip_skill_stats[stat.name].max_value, 0)
				end
				equip = math.max(equip_base_stats[stat.name].value + equip_mods_stats[stat.name].value + equip_skill_stats[stat.name].value, 0)
				local format_string = "%0." .. tostring(stat.num_decimals or 0) .. "f"
				local equip_text = equip and string.format(format_string, equip)
				local total_text = value and string.format(format_string, value)
				local equip_min_text = equip_min and string.format(format_string, equip_min)
				local equip_max_text = equip_max and string.format(format_string, equip_max)
				local total_min_text = value_min and string.format(format_string, value_min)
				local total_max_text = value_max and string.format(format_string, value_max)
				local color_ranges = {}
				if stat.range then
					if equip_min ~= equip_max then
						equip_text = equip_min_text .. " (" .. equip_max_text .. ")"
					end
					if value_min ~= value_max then
						total_text = total_min_text .. " (" .. total_max_text .. ")"
					end
				end
				if stat.suffix then
					equip_text = equip_text .. tostring(stat.suffix)
					total_text = total_text .. tostring(stat.suffix)
				end
				if stat.prefix then
					equip_text = tostring(stat.prefix) .. equip_text
					total_text = tostring(stat.prefix) .. total_text
				end
				self._mweapon_stats_texts[stat.name].equip:set_alpha(0.75)
				self._mweapon_stats_texts[stat.name].equip:set_text(equip_text)
				self._mweapon_stats_texts[stat.name].base:set_text("")
				self._mweapon_stats_texts[stat.name].skill:set_text("")
				self._mweapon_stats_texts[stat.name].total:set_text(total_text)
				if stat.range then
					local positive = value_min > equip_min
					local negative = value_min < equip_min
					if stat.inverse then
						local temp = positive
						positive = negative
						negative = temp
					end
					local color_range_min = {
						start = 0,
						stop = utf8.len(total_min_text),
						color = nil
					}
					if positive then
						color_range_min.color = tweak_data.screen_colors.stats_positive
					elseif negative then
						color_range_min.color = tweak_data.screen_colors.stats_negative
					else
						color_range_min.color = tweak_data.screen_colors.text
					end
					table.insert(color_ranges, color_range_min)
					positive = value_max > equip_max
					negative = value_max < equip_max
					if stat.inverse then
						local temp = positive
						positive = negative
						negative = temp
					end
					local color_range_max = {
						start = color_range_min.stop + 1,
						stop = nil,
						color = nil
					}
					color_range_max.stop = color_range_max.start + 3 + utf8.len(total_max_text)
					if positive then
						color_range_max.color = tweak_data.screen_colors.stats_positive
					elseif negative then
						color_range_max.color = tweak_data.screen_colors.stats_negative
					else
						color_range_max.color = tweak_data.screen_colors.text
					end
					table.insert(color_ranges, color_range_max)
				else
					local positive = value > equip
					local negative = value < equip
					if stat.inverse then
						local temp = positive
						positive = negative
						negative = temp
					end
					local color_range = {
						start = 0,
						stop = utf8.len(equip_text),
						color = nil
					}
					if positive then
						color_range.color = tweak_data.screen_colors.stats_positive
					elseif negative then
						color_range.color = tweak_data.screen_colors.stats_negative
					else
						color_range.color = tweak_data.screen_colors.text
					end
					table.insert(color_ranges, color_range)
				end
				self._mweapon_stats_texts[stat.name].total:set_color(tweak_data.screen_colors.text)
				self._mweapon_stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
				for _, color_range in ipairs(color_ranges) do
					self._mweapon_stats_texts[stat.name].total:set_range_color(color_range.start, color_range.stop, color_range.color)
				end
			end
		end
	else
		local equip, stat_changed = nil
		local tweak_parts = tweak_data.weapon.factory.parts[self._slot_data.name]
		local unaltered_blueprint = managers.blackmarket:get_weapon_blueprint(category, slot)
		local blueprint = clone(unaltered_blueprint)
		local unaltered_total_base_stats, unaltered_total_mods_stats, unaltered_total_skill_stats = WeaponDescription._get_stats(name, category, slot, blueprint)

		managers.weapon_factory:change_part_blueprint_only(weapon.factory_id, self._slot_data.name, blueprint, false)

		local total_base_stats, total_mods_stats, total_skill_stats = WeaponDescription._get_stats(name, category, slot, blueprint)
		local mod_stats = self:_get_stats_for_mod(self._slot_data.name, name, category, slot)
		local hide_equip = mod_stats.equip.name == mod_stats.chosen.name
		local remove_stats = {}

		if self._slot_data.removes then
			for _, part_id in ipairs(self._slot_data.removes) do
				local part_stats = WeaponDescription.get_stats_for_mod(part_id, name, category, slot)

				for category, value in pairs(part_stats.chosen or {}) do
					if type(value) == "number" then
						remove_stats[category] = (remove_stats[category] or 0) + value
					end
				end
			end
		end

		self._rweapon_stats_panel:show()
		self:hide_armor_stats()
		self:hide_melee_weapon_stats()
		self:set_weapon_mods_stats_columns()

		for _, title in pairs(self._stats_titles) do
			title:hide()
		end

		if not mod_stats.equip.name then
			self._stats_titles.equip:hide()
		else
			self._stats_titles.equip:show()
			self._stats_titles.equip:set_text(utf8.to_upper(managers.localization:text("bm_menu_equipped")))
			self._stats_titles.equip:set_alpha(0.75)
			self._stats_titles.equip:set_x(105)
		end
		if not hide_equip then
			self._stats_titles.total:show()
		end

		local total_value, total_index, unaltered_total_value = nil

		for _, stat in ipairs(self._stats_shown) do
			self._stats_texts[stat.name].name:set_text(utf8.to_upper(managers.localization:text("bm_menu_" .. stat.name)))

			value = mod_stats.chosen[stat.name]
			equip = mod_stats.equip[stat.name]
			total_value = math.max(total_base_stats[stat.name].value + total_mods_stats[stat.name].value + total_skill_stats[stat.name].value, 0)
			unaltered_total_value = math.max(unaltered_total_base_stats[stat.name].value + unaltered_total_mods_stats[stat.name].value + unaltered_total_skill_stats[stat.name].value, 0)
			stat_changed = tweak_parts and tweak_parts.stats and tweak_parts.stats[stat.stat_name or stat.name] and value ~= 0
			stat_changed = stat_changed or remove_stats[stat.name] and remove_stats[stat.name] ~= 0
			for stat_name, stat_text in pairs(self._stats_texts[stat.name]) do
				if stat_name ~= "name" then
					stat_text:set_text("")
				end
			end
			for name, column in pairs(self._stats_texts[stat.name]) do
				column:set_alpha(stat_changed and 1 or 0.5)
			end
			local equip_text = equip == 0 and "" or (equip > 0 and "+" or "") .. format_round(equip, stat.round_value)
			self._stats_texts[stat.name].equip:set_alpha(0.75)
			self._stats_texts[stat.name].equip:set_text(equip_text)
			if not hide_equip then
				self._stats_texts[stat.name].total:set_text(value == 0 and "" or (value > 0 and "+" or "") .. format_round(value, stat.round_value))
			end
			if remove_stats[stat.name] and remove_stats[stat.name] ~= 0 then
				local stat_str = remove_stats[stat.name] == 0 and "" or (remove_stats[stat.name] > 0 and "+" or "") .. format_round(remove_stats[stat.name], stat.round_value)
				--self._stats_texts[stat.name].removed:set_text("(" .. tostring(stat_str) .. ")")
			else
				--self._stats_texts[stat.name].removed:set_text("")
			end
			equip = equip + math.round(remove_stats[stat.name] or 0)
			if value > equip then
				self._stats_texts[stat.name].total:set_color(tweak_data.screen_colors.stats_positive)
			elseif value < equip then
				self._stats_texts[stat.name].total:set_color(tweak_data.screen_colors.stats_negative)
			else
				self._stats_texts[stat.name].total:set_color(tweak_data.screen_colors.text)
			end
			self._stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.text)
			if stat.percent then
				if math.round(total_value) >= 100 then
					--self._stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stat_maxed)
				end
			elseif stat.index then
				-- Nothing
			elseif tweak_stats[stat.name] then
				local without_skill = math.round(total_base_stats[stat.name].value + total_mods_stats[stat.name].value)
				local max_stat = math.max(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier * (modifier_stats and modifier_stats[stat.name] or 1)
				if stat.offset then
					local offset = math.min(tweak_stats[stat.name][1], tweak_stats[stat.name][#tweak_stats[stat.name]]) * tweak_data.gui.stats_present_multiplier * (modifier_stats and modifier_stats[stat.name] or 1)
					max_stat = max_stat - offset
				end
				if without_skill >= max_stat then
					--self._stats_texts[stat.name].equip:set_color(tweak_data.screen_colors.stat_maxed)
				end
			end

			self._stats_texts[stat.name].base:set_color(tweak_data.screen_colors.text)
		end
	end
	local modslist_panel = self._stats_panel:child("modslist_panel")
	local y = 0
	if self._rweapon_stats_panel:visible() then
		for i, child in ipairs(self._rweapon_stats_panel:children()) do
			y = math.max(y, child:bottom())
		end
	elseif self._armor_stats_panel:visible() then
		for i, child in ipairs(self._armor_stats_panel:children()) do
			y = math.max(y, child:bottom())
		end
	elseif self._mweapon_stats_panel:visible() then
		for i, child in ipairs(self._mweapon_stats_panel:children()) do
			y = math.max(y, child:bottom())
		end
	end
	modslist_panel:set_top(y + 10)
	self._stats_panel:show()
end

function BlackMarketGui:_equip_weapon_color_callback(data)
	self._item_bought = true
	local instance_id = data.name

	if data.equip_weapon_cosmetics then
		instance_id = data.equip_weapon_cosmetics.instance_id
	end

	local cosmetics_data = {
		id = instance_id,
		quality = self._color_wear or "good",
		bonus = data.cosmetics_bonus,
		color_index = self._color_index or data.cosmetic_color_index,
		pattern_scale = self._color_pattern_scale or data.cosmetic_pattern_scale
	}

	managers.menu_component:post_event("item_buy")
	managers.blackmarket:on_equip_weapon_color(data.category, data.slot, cosmetics_data, true)
	self:reload()
end

function BlackMarketGui:set_scheme_callback()
	function set_scheme(index)
		self._color_index = index
	end
	local title = managers.localization:text("menu_weapon_color_index_title")
	local options = {}

	for i=1, 10 do
		local scheme = {
			text = managers.localization:text("menu_weapon_color_index_" .. i),
			callback = set_scheme,
			data = i
		}
		table.insert(options, scheme)
	end

	table.insert(options, {
		text = ""
	})
	table.insert(options, {
		text = managers.localization:text("dialog_cancel"),
		is_cancel_button = true,
	})

	local menu = QuickMenu:new(title, "", options)
	menu:show()
end

function BlackMarketGui:set_wear_callback()
	function set_wear(wear_str)
		self._color_wear = wear_str
	end
	local title = managers.localization:text("menu_weapon_color_quality")
	local options = {}
	local wear = {
		"mint",
		"fine",
		"good",
		"fair",
		"poor"
	}

	for i=1, 5 do
		local scheme = {
			text = managers.localization:text("bm_menu_quality_" .. wear[i]),
			callback = set_wear,
			data = wear[i]
		}
		table.insert(options, scheme)
	end

	table.insert(options, {
		text = ""
	})
	table.insert(options, {
		text = managers.localization:text("dialog_cancel"),
		is_cancel_button = true,
	})

	local menu = QuickMenu:new(title, "", options)
	menu:show()
end

function BlackMarketGui:set_scale_callback()
	function set_scale(index)
		self._color_pattern_scale = index
	end
	local title = managers.localization:text("menu_weapon_color_pattern_scale")
	local options = {}
	local scale = {
		"small",
		"medium",
		"large"
	}

	for i=1, 3 do
		local scheme = {
			text = managers.localization:text("menu_pattern_scale_" .. scale[i]),
			callback = set_scale,
			data = i
		}
		table.insert(options, scheme)
	end

	table.insert(options, {
		text = ""
	})
	table.insert(options, {
		text = managers.localization:text("dialog_cancel"),
		is_cancel_button = true,
	})

	local menu = QuickMenu:new(title, "", options)
	menu:show()
end

function BlackMarketGui:open_armor_skins_menu_callback(data)
	local new_node_data = {}

	table.insert(new_node_data, {
		name = "bm_menu_armor_skins",
		on_create_func_name = "populate_armor_skins",
		category = "armor_skins",
		override_slots = {
			3,
			3
		},
		identifier = BlackMarketGui.identifiers.armor_skins
	})

	new_node_data.topic_id = "bm_menu_armor_skins"
	new_node_data.panel_grid_w_mul = 0.6
	new_node_data.skip_blur = true
	new_node_data.use_bgs = true
	new_node_data.hide_detection_panel = true

	managers.menu:open_node(self._inception_node_name, {
		new_node_data
	})
end

function BlackMarketGui:_start_rename_item(category, slot)
	if not self._renaming_item then
		self._not_renaming_item = true
		local custom_name = managers.blackmarket:get_crafted_custom_name(category, slot) or ""
		self._renaming_item = {
			category = category,
			slot = slot,
			custom_name = custom_name
		}
		self._ws:connect_keyboard(Input:keyboard())
		self._panel:enter_text(callback(self, self, "enter_text"))
		self._panel:key_press(callback(self, self, "key_press"))
		self._panel:key_release(callback(self, self, "key_release"))
		self._rename_caret = self._panel:rect({
			name = "caret",
			layer = 2,
			x = 0,
			y = 0,
			w = 0,
			h = 0,
			color = Color(0.05, 1, 1, 1)
		})
		self._rename_caret:animate(self.blink)
		self._caret_connected = true
		self:update_info_text()
	end
end

function BlackMarketGui:_stop_rename_item()
	if self._renaming_item then
		managers.blackmarket:set_crafted_custom_name(self._renaming_item.category, self._renaming_item.slot, self._renaming_item.custom_name)
		self._renaming_item = nil
		self._rename_info_text = nil
		if self._caret_connected then
			self._ws:disconnect_keyboard()
			self._panel:enter_text(nil)
			self._panel:key_press(nil)
			self._panel:key_release(nil)
			self._panel:remove(self._rename_caret)
			self._rename_caret = nil
			self._caret_connected = nil
		end
		managers.menu_component:post_event("menu_enter")
		self._rename_highlight = false
		self:reload()
	end
end

function BlackMarketGui:_cancel_rename_item()
	if self._renaming_item then
		DelayedCalls:Add("wait_a_sec", 0.1, function()
			self._not_renaming_item = false
		end)
		self._renaming_item = nil
		self._rename_info_text = nil
		if self._caret_connected then
			self._ws:disconnect_keyboard()
			self._panel:enter_text(nil)
			self._panel:key_press(nil)
			self._panel:key_release(nil)
			self._panel:remove(self._rename_caret)
			self._rename_caret = nil
			self._caret_connected = nil
		end
		self._rename_highlight = false
		self._one_frame_input_delay = true
		self:update_info_text()
	end
end

function BlackMarketGui:_set_rename_info_text(info_text)
	self._rename_info_text = info_text
end

function BlackMarketGui:_shift()
	local k = Input:keyboard()
	return not k:down("left shift") and not k:down("right shift") and k:has_button("shift") and k:down("shift")
end

function BlackMarketGui.blink(o)
	while true do
		o:set_color(Color(0, 1, 1, 1))
		wait(0.3)
		o:set_color(Color.white)
		wait(0.3)
	end
end

function BlackMarketGui:enter_text(o, s)
	if self._renaming_item then
		local m = tweak_data:get_raw_value("gui", "rename_max_letters") or 20
		local n = utf8.len(self._renaming_item.custom_name)
		s = utf8.sub(s, 1, m - n)
		self._renaming_item.custom_name = self._renaming_item.custom_name .. tostring(s)
		self:update_info_text()
	end
end

function BlackMarketGui:update_key_down(o, k)
	wait(0.6)
	while self._key_pressed == k do
		if not self._renaming_item then
			return
		end
		local text = self._renaming_item.custom_name
		local n = utf8.len(text)
		if self._key_pressed == Idstring("backspace") then
			text = utf8.sub(text, 0, math.max(n - 1, 0))
		elseif self._key_pressed == Idstring("delete") then
		elseif self._key_pressed == Idstring("left") then
		elseif self._key_pressed == Idstring("right") then
			self._key_pressed = false
		elseif self._key_ctrl_pressed == true and k == Idstring("v") then
			return
		end
		if text ~= self._renaming_item.custom_name then
			self._renaming_item.custom_name = text
			self:update_info_text()
		end
		wait(0.03)
	end
end

function BlackMarketGui:key_release(o, k)
	if self._key_pressed == k then
		self._key_pressed = false
	end
	if k == Idstring("left ctrl") or k == Idstring("right ctrl") then
		self._key_ctrl_pressed = false
	end
end

function BlackMarketGui:key_press(o, k)
	local text = self._renaming_item.custom_name
	local n = utf8.len(text)
	self._key_pressed = k
	self._panel:stop()
	self._panel:animate(callback(self, self, "update_key_down"), k)
	if k == Idstring("backspace") then
		text = utf8.sub(text, 0, math.max(n - 1, 0))
	elseif k == Idstring("delete") then
	elseif k == Idstring("left") then
	elseif k == Idstring("right") then
	elseif self._key_pressed == Idstring("end") then
	elseif self._key_pressed == Idstring("home") then
	elseif k == Idstring("enter") then
	elseif k == Idstring("esc") then
		self:_cancel_rename_item()
		return
	elseif k == Idstring("left ctrl") or k == Idstring("right ctrl") then
		self._key_ctrl_pressed = true
	elseif self._key_ctrl_pressed == true and k == Idstring("v") then
		return
	end
	if text ~= self._renaming_item.custom_name then
		self._renaming_item.custom_name = text
		self:update_info_text()
	end
end

function BlackMarketGui:update_info_text()
	local slot_data = self._slot_data
	local tab_data = self._tabs[self._selected]._data
	local prev_data = tab_data.prev_node_data
	local ids_category = Idstring(slot_data.category)
	local identifier = tab_data.identifier
	local updated_texts = {
		{text = ""},
		{text = ""},
		{text = ""},
		{text = ""},
		{text = ""}
	}
	local ignore_lock = false
	self._stats_text_modslist:set_text("")
	local suspicion, max_reached, min_reached = managers.blackmarket:get_suspicion_offset_of_local(tweak_data.player.SUSPICION_OFFSET_LERP or 0.75)
	self:_set_detection(suspicion, max_reached, min_reached)
	self:_set_rename_info_text(nil)
	local is_renaming_this = self._renaming_item and not self._data.is_loadout and self._renaming_item.category == slot_data.category and self._renaming_item.slot == slot_data.slot
	if identifier == self.identifiers.weapon then
		local price = slot_data.price or 0
		if not slot_data.empty_slot then
			updated_texts[1].text = slot_data.name_localized
			local resource_color = {}
			updated_texts[2].resource_color = resource_color
			if price > 0 then
				updated_texts[2].text = "##" .. managers.localization:to_upper_text(slot_data.not_moddable and "st_menu_cost" or "st_menu_value") .. " " .. managers.experience:cash_string(price) .. "##"
				table.insert(resource_color, slot_data.can_afford and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1)
			end
			if not slot_data.not_moddable and not self._data.is_loadout then
				self:_set_rename_info_text(1)
			end
			if not slot_data.unlocked then
				local skill_based = slot_data.skill_based
				local level_based = slot_data.level and 0 < slot_data.level
				local dlc_based = tweak_data.lootdrop.global_values[slot_data.global_value] and tweak_data.lootdrop.global_values[slot_data.global_value].dlc and not tweak_data.dlc[slot_data.global_value].free and not managers.dlc:has_dlc(slot_data.global_value)
				local skill_text_id = skill_based and (slot_data.skill_name or "bm_menu_skilltree_locked") or false
				local level_text_id = level_based and "bm_menu_level_req" or false
				local dlc_text_id = dlc_based and slot_data.dlc_locked or false
				local text = ""
				if skill_text_id then
					text = text .. managers.localization:to_upper_text(skill_text_id, {
						slot_data.name_localized
					}) .. "\n"
				elseif dlc_text_id then
					text = text .. managers.localization:to_upper_text(dlc_text_id, {}) .. "\n"
				elseif level_text_id then
					text = text .. managers.localization:to_upper_text(level_text_id, {
						level = slot_data.level
					}) .. "\n"
				end
				updated_texts[3].text = text
				updated_texts[3].below_stats = true
			elseif self._slot_data.can_afford == false then
			end
			if slot_data.last_weapon then
				updated_texts[5].text = updated_texts[5].text .. managers.localization:to_upper_text("bm_menu_last_weapon_warning") .. "\n"
			end
			if slot_data.global_value and slot_data.global_value ~= "normal" then
				updated_texts[4].text = updated_texts[4].text .. "##" .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"
				updated_texts[4].resource_color = tweak_data.lootdrop.global_values[slot_data.global_value].color
				updated_texts[4].below_stats = true
			end
			if slot_data.not_moddable then
				local weapon_id = slot_data.name
				local weapon_tweak = weapon_id and tweak_data.weapon[weapon_id]
				local movement_penalty = weapon_tweak and tweak_data.upgrades.weapon_movement_penalty[weapon_tweak.category] or 1
				if movement_penalty < 1 then
					local penalty_as_string = string.format("%d%%", math.round((1 - movement_penalty) * 100))
					updated_texts[5].text = updated_texts[5].text .. managers.localization:to_upper_text("bm_menu_weapon_movement_penalty_info", {penalty = penalty_as_string})
				end
				if weapon_tweak.has_description then
					updated_texts[4].text = updated_texts[4].text .. [[


]] .. managers.localization:to_upper_text(tweak_data.weapon[slot_data.name].desc_id)
					updated_texts[4].below_stats = true
				end
			end
			updated_texts[5].below_stats = true
		elseif slot_data.locked_slot then
			ignore_lock = true
			updated_texts[1].text = managers.localization:to_upper_text("bm_menu_locked_weapon_slot")
			if slot_data.cannot_buy then
				updated_texts[3].text = slot_data.dlc_locked
			else
				updated_texts[2].text = slot_data.dlc_locked
			end
			updated_texts[4].text = managers.localization:text("bm_menu_locked_weapon_slot_desc")
		elseif not slot_data.is_loadout then
			local prefix = ""
			if not managers.menu:is_pc_controller() then
				prefix = managers.localization:get_default_macro("BTN_A")
			end
			updated_texts[1].text = prefix .. managers.localization:to_upper_text("bm_menu_btn_buy_new_weapon")
			updated_texts[4].text = managers.localization:text("bm_menu_empty_weapon_slot_buy_info")
		end
	elseif identifier == self.identifiers.weapon_cosmetic then
		updated_texts[1].text = managers.localization:to_upper_text("bm_menu_steam_item_name", {
			type = managers.localization:text("bm_menu_" .. slot_data.category),
			name = slot_data.name_localized
		})
		updated_texts[1].resource_color = tweak_data.screen_colors.text

		if slot_data.weapon_id then
			updated_texts[2].text = managers.weapon_factory:get_weapon_name_by_weapon_id(slot_data.weapon_id)
		end

		updated_texts[4].resource_color = {}
		local cosmetic_rarity = slot_data.cosmetic_rarity
		local cosmetic_quality = slot_data.cosmetic_quality
		local cosmetic_bonus = slot_data.cosmetic_bonus

		if slot_data.is_a_color_skin then
			if slot_data.equipped then
				local color_id = slot_data.name
				local color_tweak = tweak_data.blackmarket.weapon_skins[color_id]

				if not slot_data.unlocked then
					local global_value = slot_data.global_value
					local gvalue_tweak = tweak_data.lootdrop.global_values[global_value]
					local dlc = color_tweak.dlc or managers.dlc:global_value_to_dlc(global_value)
					local unlocked = not dlc or managers.dlc:is_dlc_unlocked(dlc)
					local have_color = managers.blackmarket:has_item(global_value, "weapon_skins", color_id)

					if not unlocked then
						updated_texts[5].text = managers.localization:text(gvalue_tweak and gvalue_tweak.unlock_id or "bm_menu_dlc_locked")
					elseif not have_color then
						local achievement_locked_content = managers.dlc:weapon_color_achievement_locked_content(color_id)
						local dlc_tweak = tweak_data.dlc[achievement_locked_content]
						local achievement = dlc_tweak and dlc_tweak.achievement_id

						if achievement and managers.achievment:get_info(achievement) then
							local achievement_visual = tweak_data.achievement.visual[achievement]
							updated_texts[5].text = managers.localization:text(achievement_visual and achievement_visual.desc_id or "achievement_" .. tostring(achievement) .. "_desc" or "bm_menu_dlc_locked")
						else
							updated_texts[5].text = managers.localization:text("bm_menu_dlc_locked")
						end
					end
				end

				local name_string = managers.localization:to_upper_text(color_tweak.name_id)
				local color_index_string = managers.localization:to_upper_text("bm_menu_weapon_color_index", {
					variation = managers.localization:text(tweak_data.blackmarket:get_weapon_color_index_string(slot_data.cosmetic_color_index))
				})
				local quality_string = managers.localization:to_upper_text("bm_menu_weapon_color_quality", {
					quality = managers.localization:text(tweak_data.economy.qualities[cosmetic_quality].name_id)
				})
				updated_texts[4].text = updated_texts[4].text

				table.insert(updated_texts[4].resource_color, tweak_data.screen_colors.text)
				table.insert(updated_texts[4].resource_color, tweak_data.economy.qualities[cosmetic_quality].color or tweak_data.screen_colors.text)
			else
				updated_texts[4].text = updated_texts[4].text .. managers.localization:text("bm_menu_customizable_weapon_color_desc")
			end
		else
			if not slot_data.unlocked then
				local safe = self:get_safe_for_economy_item(slot_data.name)
				safe = safe and safe.name_id or "invalid skin"
				local macros = {
					safe = managers.localization:text(safe)
				}
				local lock_text_id = slot_data.lock_text_id or "bm_menu_wcc_not_owned"
				updated_texts[5].text = (slot_data.default_blueprint and "" or "\n") .. managers.localization:text(lock_text_id, macros)
			end

			if cosmetic_rarity then
				updated_texts[4].text = updated_texts[4].text .. managers.localization:to_upper_text("bm_menu_steam_item_rarity", {
					rarity = managers.localization:text(tweak_data.economy.rarities[cosmetic_rarity].name_id)
				})

				table.insert(updated_texts[4].resource_color, tweak_data.economy.rarities[cosmetic_rarity].color or tweak_data.screen_colors.text)
			end

			if cosmetic_quality then
				updated_texts[4].text = updated_texts[4].text .. (cosmetic_rarity and "\n" or "") .. managers.localization:to_upper_text("bm_menu_steam_item_quality", {
					quality = managers.localization:text(tweak_data.economy.qualities[cosmetic_quality].name_id)
				})

				table.insert(updated_texts[4].resource_color, tweak_data.economy.qualities[cosmetic_quality].color or tweak_data.screen_colors.text)
			end

			if cosmetic_bonus then
				local bonus = tweak_data.blackmarket.weapon_skins[slot_data.cosmetic_id] and tweak_data.blackmarket.weapon_skins[slot_data.cosmetic_id].bonus

				if bonus then
					local bonus_tweak = tweak_data.economy.bonuses[bonus]
					local bonus_value = bonus_tweak.exp_multiplier and bonus_tweak.exp_multiplier * 100 - 100 .. "%" or bonus_tweak.money_multiplier and bonus_tweak.money_multiplier * 100 - 100 .. "%"
					updated_texts[4].text = updated_texts[4].text .. ((cosmetic_quality or cosmetic_rarity) and "\n" or "") .. managers.localization:text("dialog_new_tradable_item_bonus", {
						bonus = managers.localization:text(bonus_tweak.name_id, {
							team_bonus = bonus_value
						})
					})
				end
			end
		end

		if slot_data.desc_id and slot_data.unlocked then
			updated_texts[4].text = updated_texts[4].text .. "\n" .. managers.localization:text(slot_data.desc_id)
		end

		if slot_data.global_value and slot_data.global_value ~= "normal" then
			updated_texts[4].text = updated_texts[4].text

			table.insert(updated_texts[4].resource_color, tweak_data.lootdrop.global_values[slot_data.global_value].color)
		end

		updated_texts[4].below_stats = false
	elseif identifier == self.identifiers.melee_weapon then
		updated_texts[1].text = self._slot_data.name_localized
		if not slot_data.unlocked then
			local skill_based = slot_data.skill_based
			local level_based = slot_data.level and 0 < slot_data.level
			local dlc_based = not slot_data.dlc_based and tweak_data.lootdrop.global_values[slot_data.global_value] and tweak_data.lootdrop.global_values[slot_data.global_value].dlc and not tweak_data.dlc[slot_data.global_value].free and not managers.dlc:has_dlc(slot_data.global_value)
			local skill_text_id = skill_based and (slot_data.skill_name or "bm_menu_skilltree_locked") or false
			local level_text_id = level_based and "bm_menu_level_req" or false
			local dlc_text_id = dlc_based and slot_data.dlc_locked or false
			local text = ""
			if skill_text_id then
				text = text .. managers.localization:to_upper_text(skill_text_id, {
					slot_data.name_localized
				}) .. "\n"
			elseif dlc_text_id then
				text = text .. managers.localization:to_upper_text(dlc_text_id, {}) .. "\n"
			elseif level_text_id then
				text = text .. managers.localization:to_upper_text(level_text_id, {
					level = slot_data.level
				}) .. "\n"
			end
			updated_texts[3].text = text
			updated_texts[3].below_stats = true
		end
		updated_texts[4].resource_color = {}
		local desc_text = managers.localization:text(tweak_data.blackmarket.melee_weapons[slot_data.name].desc_id)
		if slot_data.global_value and slot_data.global_value ~= "normal" then
			updated_texts[4].text = updated_texts[4].text .. "##" .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"
			table.insert(updated_texts[4].resource_color, tweak_data.lootdrop.global_values[slot_data.global_value].color)
		end
		updated_texts[4].below_stats = true
	elseif identifier == self.identifiers.grenade then
		updated_texts[1].text = self._slot_data.name_localized
		if not slot_data.unlocked then
			local skill_based = slot_data.skill_based
			local level_based = slot_data.level and 0 < slot_data.level
			local dlc_based = not slot_data.dlc_based and tweak_data.lootdrop.global_values[slot_data.global_value] and tweak_data.lootdrop.global_values[slot_data.global_value].dlc and not tweak_data.dlc[slot_data.global_value].free and not managers.dlc:has_dlc(slot_data.global_value)
			local skill_text_id = skill_based and (slot_data.skill_name or "bm_menu_skilltree_locked") or false
			local level_text_id = level_based and "bm_menu_level_req" or false
			local dlc_text_id = dlc_based and slot_data.dlc_locked or false
			local text = ""
			if skill_text_id then
				text = text .. managers.localization:to_upper_text(skill_text_id, {
					slot_data.name_localized
				}) .. "\n"
			elseif dlc_text_id then
				text = text .. managers.localization:to_upper_text(dlc_text_id, {}) .. "\n"
			elseif level_text_id then
				text = text .. managers.localization:to_upper_text(level_text_id, {
					level = slot_data.level
				}) .. "\n"
			end
			updated_texts[3].text = text
		end
		updated_texts[4].resource_color = {}
		local desc_text = managers.localization:text(tweak_data.blackmarket.projectiles[slot_data.name].desc_id)
		updated_texts[4].text = desc_text .. "\n"
		if slot_data.global_value and slot_data.global_value ~= "normal" then
			updated_texts[4].text = updated_texts[4].text .. "##" .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"
			table.insert(updated_texts[4].resource_color, tweak_data.lootdrop.global_values[slot_data.global_value].color)
		end
		updated_texts[4].below_stats = true
	elseif identifier == self.identifiers.armor then
		updated_texts[1].text = self._slot_data.name_localized
		if not self._slot_data.unlocked then
			updated_texts[3].text = utf8.to_upper(managers.localization:text(slot_data.level == 0 and (slot_data.skill_name or "bm_menu_skilltree_locked") or "bm_menu_level_req", {
				level = slot_data.level,
				SKILL = slot_data.name
			}))
			updated_texts[3].below_stats = true
		end
	elseif identifier == self.identifiers.armor_skins then
		local skin_tweak = tweak_data.economy.armor_skins[self._slot_data.name]
		updated_texts[1].text = self._slot_data.name_localized
		local desc = ""
		local desc_colors = {}

		if self._slot_data.equipped then
			updated_texts[2].text = "##" .. managers.localization:to_upper_text("bm_menu_equipped") .. "##"
			updated_texts[2].resource_color = tweak_data.screen_colors.text
		elseif not self._slot_data.cosmetic_unlocked then
			if slot_data.dlc_locked then
				updated_texts[3].text = managers.localization:to_upper_text(slot_data.dlc_locked)
			else
				updated_texts[2].text = "##" .. managers.localization:to_upper_text("bm_menu_item_locked") .. "##"
				updated_texts[2].resource_color = tweak_data.screen_colors.important_1
			end
		end

		if self._slot_data.cosmetic_rarity then
			local rarity_color = tweak_data.economy.rarities[self._slot_data.cosmetic_rarity].color or tweak_data.screen_colors.text
			updated_texts[1].text = "##" .. self._slot_data.name_localized .. "##"
			updated_texts[1].resource_color = rarity_color
			local rarity = managers.localization:to_upper_text("bm_menu_steam_item_rarity", {
				rarity = managers.localization:text(tweak_data.economy.rarities[self._slot_data.cosmetic_rarity].name_id)
			})
			desc = desc .. rarity .. "\n\n"

			table.insert(desc_colors, rarity_color)
		end

		if skin_tweak.desc_id then
			local desc_text = managers.localization:text(skin_tweak.desc_id)

			if desc_text ~= " " then
				desc = desc .. desc_text
				desc = desc .. "\n\n"
			end
		end

		if skin_tweak.challenge_id then
			desc = desc .. "##" .. managers.localization:to_upper_text("menu_unlock_condition") .. "##\n"

			table.insert(desc_colors, tweak_data.screen_colors.challenge_title)

			desc = desc .. managers.localization:text(skin_tweak.challenge_id)
		elseif not skin_tweak.free then
			if skin_tweak.unlock_id then
				desc = desc .. managers.localization:text(skin_tweak.unlock_id) .. "\n"

				table.insert(desc_colors, tweak_data.screen_colors.challenge_title)
			else
				local safe = self:get_safe_for_economy_item(slot_data.name)
				safe = safe and safe.name_id and managers.localization:text(safe.name_id) or "invalid skin"
				desc = desc .. managers.localization:text("bm_menu_purchase_steam", {
					safe = safe
				}) .. "\n"

				table.insert(desc_colors, tweak_data.screen_colors.challenge_title)
			end
		end

		updated_texts[4].text = desc
		updated_texts[4].resource_color = desc_colors
		updated_texts[4].below_stats = false

		if slot_data.global_value and slot_data.global_value ~= "normal" then
			updated_texts[4].text = updated_texts[4].text .. "##" .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"

			table.insert(updated_texts[4].resource_color, tweak_data.lootdrop.global_values[slot_data.global_value].color)
		end
	elseif identifier == self.identifiers.mask then
		local price = slot_data.price
		if not price then
			if type(slot_data.unlocked) ~= "number" then
				price = managers.money:get_mask_slot_sell_value(slot_data.slot)
			else
				price = managers.money:get_mask_sell_value(slot_data.name, slot_data.global_value)
			end
		end
		if not slot_data.empty_slot then
			updated_texts[1].text = slot_data.name_localized
			if not self._data.is_loadout and slot_data.slot ~= 1 and slot_data.unlocked == true then
				self:_set_rename_info_text(1)
			end
			local resource_colors = {}
			if price > 0 and slot_data.slot ~= 1 then
				updated_texts[2].text = "##" .. managers.localization:to_upper_text("st_menu_value") .. " " .. managers.experience:cash_string(price) .. "##" .. "   "
				table.insert(resource_colors, slot_data.can_afford ~= false and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1)
			end
			if slot_data.num_backs then
				updated_texts[2].text = updated_texts[2].text .. "##" .. managers.localization:to_upper_text("bm_menu_item_amount", {
					amount = math.abs(slot_data.unlocked)
				}) .. "##"
				table.insert(resource_colors, tweak_data.screen_colors.text)
			end
			if #resource_colors == 1 then
				updated_texts[2].resource_color = resource_colors[1]
			else
				updated_texts[2].resource_color = resource_colors
			end
			local achievement_tracker = tweak_data.achievement.mask_tracker
			local mask_id = slot_data.name
			if slot_data.dlc_locked then
				updated_texts[3].text = managers.localization:to_upper_text(slot_data.dlc_locked)
			elseif slot_data.infamy_lock then
				updated_texts[3].text = managers.localization:to_upper_text("menu_infamy_lock_info")
			elseif mask_id and achievement_tracker[mask_id] and (type(slot_data.unlocked) ~= "number" and not slot_data.unlocked or slot_data.unlocked == 0) then
				local achievement_data = achievement_tracker[mask_id]
				local max_progress = achievement_data.max_progress
				local text_id = achievement_data.text_id
				local award = achievement_data.award
				local stat = achievement_data.stat
				if stat and max_progress > 0 then
					local progress_left = max_progress - (managers.achievment:get_stat(stat) or 0)
					if progress_left > 0 then
						local progress = tostring(progress_left)
						updated_texts[3].text = "##" .. managers.localization:text(achievement_data.text_id, {progress = progress}) .. "##"
						updated_texts[3].resource_color = tweak_data.screen_colors.button_stage_2
					end
				elseif award and not managers.achievment:get_info(award).awarded then
					updated_texts[3].text = "##" .. managers.localization:text(achievement_data.text_id) .. "##"
					updated_texts[3].resource_color = tweak_data.screen_colors.button_stage_2
				end
			end
			if mask_id then
				local desc_id = tweak_data.blackmarket.masks[mask_id].desc_id
				updated_texts[4].text = desc_id and managers.localization:text(desc_id) or Application:production_build() and "Add ##desc_id## to ##" .. mask_id .. "## in tweak_data.blackmarket.masks" or ""
				if managers.dlc:is_mask_achievement_locked(mask_id) and (not tweak_data.blackmarket.masks[mask_id].pcs or not (0 < #tweak_data.blackmarket.masks[mask_id].pcs)) then
					updated_texts[4].text = updated_texts[4].text .. managers.localization:text("bm_msk_achievement_postfix")
				end
				if slot_data.global_value and slot_data.global_value ~= "normal" then
					updated_texts[4].text = updated_texts[4].text .. [[

##]] .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"
					updated_texts[4].resource_color = tweak_data.lootdrop.global_values[slot_data.global_value].color
				end
				if Application:production_build() and not desc_id then
					updated_texts[4].resource_color = Color.red
				end
			end
		elseif slot_data.locked_slot then
			ignore_lock = true
			updated_texts[1].text = managers.localization:to_upper_text("bm_menu_locked_mask_slot")
			if slot_data.cannot_buy then
				updated_texts[3].text = slot_data.dlc_locked
			else
				updated_texts[2].text = slot_data.dlc_locked
			end
			updated_texts[4].text = managers.localization:text("bm_menu_locked_mask_slot_desc")
		else
			if slot_data.cannot_buy then
				updated_texts[2].text = managers.localization:to_upper_text("bm_menu_empty_mask_slot")
				updated_texts[3].text = managers.localization:to_upper_text("bm_menu_no_masks_in_stash_varning")
			else
				local prefix = ""
				if not managers.menu:is_pc_controller() then
					prefix = managers.localization:get_default_macro("BTN_A")
				end
				updated_texts[1].text = prefix .. managers.localization:to_upper_text("bm_menu_btn_buy_new_mask")
			end
			updated_texts[4].text = managers.localization:text("bm_menu_empty_mask_slot_buy_info")
		end
	elseif identifier == self.identifiers.weapon_mod then
		local price = slot_data.price or managers.money:get_weapon_modify_price(prev_data.name, slot_data.name, slot_data.global_value)
		updated_texts[1].text = slot_data.name_localized
		local resource_colors = {}

		if price > 0 then
			updated_texts[2].text = "##" .. managers.localization:to_upper_text("st_menu_cost") .. " " .. managers.experience:cash_string(price) .. "##"

			table.insert(resource_colors, slot_data.can_afford and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1)
		end

		local unlocked = slot_data.unlocked and slot_data.unlocked ~= true and slot_data.unlocked or 0
		updated_texts[2].text = updated_texts[2].text .. (price > 0 and "   " or "")

		if slot_data.previewing then
			updated_texts[2].text = updated_texts[2].text .. managers.localization:to_upper_text("bm_menu_mod_preview")
		elseif slot_data.free_of_charge then
			updated_texts[2].text = updated_texts[2].text .. (unlocked > 0 and managers.localization:to_upper_text("bm_menu_item_unlocked") or managers.localization:to_upper_text("bm_menu_item_locked"))
		else
			updated_texts[2].text = updated_texts[2].text .. "##" .. managers.localization:to_upper_text("bm_menu_item_amount", {
				amount = tostring(math.abs(unlocked))
			}) .. "##"

			table.insert(resource_colors, math.abs(unlocked) > 0 and tweak_data.screen_colors.text or tweak_data.screen_colors.important_1)
		end

		if #resource_colors == 1 then
			updated_texts[2].resource_color = resource_colors[1]
		else
			updated_texts[2].resource_color = resource_colors
		end

		local can_not_afford = slot_data.can_afford == false
		local conflicted = slot_data.conflict
		local out_of_item = slot_data.unlocked and slot_data.unlocked ~= true and slot_data.unlocked == 0

		if slot_data.install_lock then
			updated_texts[3].text = managers.localization:to_upper_text(slot_data.install_lock)
			updated_texts[3].below_stats = true
		elseif slot_data.dlc_locked then
			updated_texts[3].text = managers.localization:to_upper_text(slot_data.dlc_locked)
		elseif conflicted then
			updated_texts[3].text = managers.localization:to_upper_text("bm_menu_conflict", {
				conflict = slot_data.conflict
			})
		elseif slot_data.lock_texture then
			local achievement_lock_id = managers.dlc:is_weapon_mod_achievement_locked(slot_data.name)
			local achievement_milestone_lock_id = managers.dlc:is_weapon_mod_achievement_milestone_locked(slot_data.name)

			if achievement_lock_id then
				local dlc_tweak = tweak_data.dlc[achievement_lock_id]
				local achievement = dlc_tweak and dlc_tweak.achievement_id
				local achievement_visual = tweak_data.achievement.visual[achievement]

				if achievement_visual then
					updated_texts[3].text = managers.localization:to_upper_text(achievement_visual.desc_id)

					if achievement_visual.progress then
						updated_texts[3].text = updated_texts[3].text .. " (" .. tostring(achievement_visual.progress.get()) .. "/" .. tostring(achievement_visual.progress.max) .. ")"
					end

					updated_texts[3].below_stats = true
				end
			elseif achievement_milestone_lock_id then
				for _, data in ipairs(tweak_data.achievement.milestones) do
					if data.id == achievement_milestone_lock_id then
						updated_texts[3].text = managers.localization:to_upper_text("bm_menu_milestone_reward_unlock", {
							NUM = tostring(data.at)
						})
						updated_texts[3].below_stats = true

						break
					end
				end
			elseif managers.dlc:is_content_skirmish_locked("weapon_mods", slot_data.name) then
				updated_texts[3].text = managers.localization:to_upper_text("bm_menu_skirmish_content_reward")
				updated_texts[3].below_stats = true
			elseif managers.dlc:is_content_crimespree_locked("weapon_mods", slot_data.name) then
				updated_texts[3].text = managers.localization:to_upper_text("bm_menu_crimespree_content_reward")
				updated_texts[3].below_stats = true
			end
		end

		local part_id = slot_data.name
		local part_data = part_id and tweak_data.weapon.factory.parts[part_id]
		local perks = part_data and part_data.perks
		local is_gadget = part_data and part_data.type == "gadget" or perks and table.contains(perks, "gadget")
		local is_ammo = part_data and part_data.type == "ammo" or perks and table.contains(perks, "ammo")
		local is_bayonet = part_data and part_data.type == "bayonet" or perks and table.contains(perks, "bayonet")
		local is_bipod = part_data and part_data.type == "bipod" or perks and table.contains(perks, "bipod")
		local is_underbarrel_ammo = part_data and part_data.type == "underbarrel_ammo" or perks and table.contains(perks, "underbarrel_ammo")
		local has_desc = part_data and part_data.has_description == true
		updated_texts[4].resource_color = {}

		if is_gadget or is_ammo or is_bayonet or is_bipod or is_underbarrel_ammo or has_desc then
			local crafted = managers.blackmarket:get_crafted_category_slot(prev_data.category, prev_data.slot)
			updated_texts[4].text = managers.weapon_factory:get_part_desc_by_part_id_from_weapon(part_id, crafted.factory_id, crafted.blueprint)
		end

		if slot_data.global_value and slot_data.global_value ~= "normal" then
			if is_gadget or is_ammo or is_bayonet or is_underbarrel_ammo or has_desc then
				updated_texts[4].text = updated_texts[4].text .. "\n##" .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"
			else
				updated_texts[4].text = "##" .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"
			end

			table.insert(updated_texts[4].resource_color, tweak_data.lootdrop.global_values[slot_data.global_value].color)
		end

		local current_zoom = slot_data.comparision_data and slot_data.comparision_data.zoom or 1
		local zoom_stat = part_data and part_data.stats and part_data.stats.zoom
		local gadget_zoom_stat = part_data and part_data.stats and part_data.stats.gadget_zoom
		local gadget_zoom_add_stat = part_data and part_data.stats and part_data.stats.gadget_zoom_add
		local zoom_magnification = nil

		if zoom_stat then
			zoom_magnification = 1 + zoom_stat
		elseif gadget_zoom_stat then
			zoom_magnification = gadget_zoom_stat
		elseif gadget_zoom_add_stat then
			zoom_magnification = current_zoom + gadget_zoom_add_stat
		end

		if zoom_magnification then
			zoom_magnification = math.clamp(zoom_magnification, 1, #tweak_data.weapon.stats.zoom)
			zoom_magnification = tweak_data.weapon.stats.zoom[1] / tweak_data.weapon.stats.zoom[zoom_magnification]
			zoom_magnification = math.round(zoom_magnification * zoom_magnification, 0.25)

			if zoom_magnification > 1 then
				local zoom_level_string = managers.localization:text("bm_menu_sight_zoom_level", {
					zoom = zoom_magnification
				})
				updated_texts[1].text = updated_texts[1].text .. "  " .. zoom_level_string
			end
		end

		if perks and table.contains(perks, "bonus") then
			updated_texts[4].text = updated_texts[4].text .. "\n##" .. managers.localization:to_upper_text("bm_menu_disables_cosmetic_bonus") .. "##"

			table.insert(updated_texts[4].resource_color, tweak_data.screen_colors.text)
		end

		updated_texts[4].below_stats = true
		local weapon_id = managers.weapon_factory:get_factory_id_by_weapon_id(prev_data.name)

		local function get_forbids(weapon_id, part_id)
			local weapon_data = tweak_data.weapon.factory[weapon_id]

			if not weapon_data then
				return {}
			end

			local default_parts = {}

			for _, part in ipairs(weapon_data.default_blueprint) do
				table.insert(default_parts, part)

				local part_data = tweak_data.weapon.factory.parts[part]

				if part_data and part_data.adds then
					for _, part in ipairs(part_data.adds) do
						table.insert(default_parts, part)
					end
				end
			end

			local weapon_mods = {}

			for _, part in ipairs(weapon_data.uses_parts) do
				if not table.contains(default_parts, part) then
					local part_data = tweak_data.weapon.factory.parts[part]

					if part_data and not part_data.unatainable then
						weapon_mods[part] = {}
					end
				end
			end

			for part, _ in pairs(weapon_mods) do
				local part_data = tweak_data.weapon.factory.parts[part]

				if part_data.forbids then
					for other_part, _ in pairs(weapon_mods) do
						local other_part_data = tweak_data.weapon.factory.parts[part]

						if table.contains(part_data.forbids, other_part) then
							table.insert(weapon_mods[part], other_part)
							table.insert(weapon_mods[other_part], part)
						end
					end
				end
			end

			return weapon_mods[part_id]
		end

		local forbidden_parts = get_forbids(weapon_id, part_id)
		local droppable_mods = managers.blackmarket:get_dropable_mods_by_weapon_id(prev_data.name)

		if slot_data.removes and #slot_data.removes > 0 then
			local removed_mods = ""

			for i, name in ipairs(slot_data.removes) do
				local mod_data = tweak_data.weapon.factory.parts[name]

				if droppable_mods[mod_data.type] then
					local mod_name = mod_data and mod_data.name_id or name
					mod_name = managers.localization:text(mod_name)
					removed_mods = string.format("%s%s%s", removed_mods, i > 1 and ", " or "", mod_name)
				end
			end

			if #removed_mods > 0 then
				updated_texts[5].text = managers.localization:to_upper_text("bm_mod_equip_remove", {
					mod = removed_mods
				})
			end
		elseif forbidden_parts and #forbidden_parts > 0 then
			local forbids = {}

			for i, forbidden_part in ipairs(forbidden_parts) do
				local data = tweak_data.weapon.factory.parts[forbidden_part]

				if data then
					forbids[data.type] = (forbids[data.type] or 0) + 1
				end
			end

			local text = ""

			for category, amount in pairs(forbids) do
				if droppable_mods[category] then
					if text ~= "" then
						text = text .. "\n"
					end

					local category_count = 0
					local weapon_data = tweak_data.weapon.factory[weapon_id]

					for _, part_name in ipairs(weapon_data.uses_parts) do
						local part_data = tweak_data.weapon.factory.parts[part_name]

						if part_data and not part_data.unatainable and part_data.type == category and not table.contains(weapon_data.default_blueprint, part_name) then
							category_count = category_count + 1
						end
					end

					local percent_forbidden = amount / category_count
					local category = managers.localization:text("bm_menu_" .. tostring(category) .. "_plural")
					local quantifier = percent_forbidden == 1 and "all" or percent_forbidden > 0.66 and "most" or "some"
					quantifier = managers.localization:text("bm_mod_incompatibility_" .. tostring(quantifier))
					text = managers.localization:to_upper_text("bm_mod_incompatibilities", {
						quantifier = quantifier,
						category = category
					})
				end
			end

			updated_texts[5].text = text
		end
	elseif identifier == self.identifiers.mask_mod then
		if not managers.blackmarket:currently_customizing_mask() then
			return
		end

		local mask_mod_info = managers.blackmarket:info_customize_mask()
		local mask_base_price = managers.blackmarket:get_customize_mask_base_value()
		updated_texts[2].text = updated_texts[2].text .. managers.localization:to_upper_text("bm_menu_masks") .. ": " .. self._data.topic_params.mask_name

		if mask_base_price and mask_base_price > 0 then
			updated_texts[2].text = updated_texts[2].text .. " " .. managers.experience:cash_string(mask_base_price)
		end

		updated_texts[2].text = updated_texts[2].text .. "\n"
		local resource_color = {}
		local material_text = managers.localization:to_upper_text("bm_menu_materials")
		local pattern_text = managers.localization:to_upper_text("bm_menu_textures")
		local colors_text = managers.localization:to_upper_text("bm_menu_colors")
		local color_a_text = managers.localization:to_upper_text("bm_menu_color_a")
		local color_b_text = managers.localization:to_upper_text("bm_menu_color_b")

		if mask_mod_info[1].overwritten then
			updated_texts[2].text = updated_texts[2].text .. material_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_overwritten") .. "##" .. "\n"

			table.insert(resource_color, tweak_data.screen_colors.risk)
		elseif mask_mod_info[1].is_good then
			updated_texts[2].text = updated_texts[2].text .. material_text .. ": " .. managers.localization:text(mask_mod_info[1].text)

			if mask_mod_info[1].price and mask_mod_info[1].price > 0 then
				updated_texts[2].text = updated_texts[2].text .. " " .. managers.experience:cash_string(mask_mod_info[1].price)
			end

			updated_texts[2].text = updated_texts[2].text .. "\n"
		else
			updated_texts[2].text = updated_texts[2].text .. material_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_not_selected") .. "##" .. "\n"

			table.insert(resource_color, tweak_data.screen_colors.important_1)
		end

		if mask_mod_info[2].overwritten then
			updated_texts[2].text = updated_texts[2].text .. pattern_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_overwritten") .. "##" .. "\n"

			table.insert(resource_color, tweak_data.screen_colors.risk)
		elseif mask_mod_info[2].is_good then
			updated_texts[2].text = updated_texts[2].text .. pattern_text .. ": " .. managers.localization:text(mask_mod_info[2].text)

			if mask_mod_info[2].price and mask_mod_info[2].price > 0 then
				updated_texts[2].text = updated_texts[2].text .. " " .. managers.experience:cash_string(mask_mod_info[2].price)
			end

			updated_texts[2].text = updated_texts[2].text .. "\n"
		else
			updated_texts[2].text = updated_texts[2].text .. pattern_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_not_selected") .. "##" .. "\n"

			table.insert(resource_color, tweak_data.screen_colors.important_1)
		end

		local should_show_one_color = mask_mod_info[4].is_same or mask_mod_info[3].overwritten and mask_mod_info[4].overwritten

		if should_show_one_color then
			if mask_mod_info[3].overwritten then
				updated_texts[2].text = updated_texts[2].text .. colors_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_overwritten") .. "##" .. "\n"

				table.insert(resource_color, tweak_data.screen_colors.risk)
			elseif mask_mod_info[3].is_good then
				updated_texts[2].text = updated_texts[2].text .. colors_text .. ": " .. managers.localization:text(mask_mod_info[3].text)

				if mask_mod_info[3].price and mask_mod_info[3].price > 0 then
					updated_texts[2].text = updated_texts[2].text .. " " .. managers.experience:cash_string(mask_mod_info[3].price)
				end

				updated_texts[2].text = updated_texts[2].text .. "\n"
			else
				updated_texts[2].text = updated_texts[2].text .. colors_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_not_selected") .. "##" .. "\n"

				table.insert(resource_color, tweak_data.screen_colors.important_1)
			end
		else
			if mask_mod_info[3].overwritten then
				updated_texts[2].text = updated_texts[2].text .. color_a_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_overwritten") .. "##" .. "\n"

				table.insert(resource_color, tweak_data.screen_colors.risk)
			elseif mask_mod_info[3].is_good then
				updated_texts[2].text = updated_texts[2].text .. color_a_text .. ": " .. managers.localization:text(mask_mod_info[3].text)

				if mask_mod_info[3].price and mask_mod_info[3].price > 0 then
					updated_texts[2].text = updated_texts[2].text .. " " .. managers.experience:cash_string(mask_mod_info[3].price)
				end

				updated_texts[2].text = updated_texts[2].text .. "\n"
			else
				updated_texts[2].text = updated_texts[2].text .. color_a_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_not_selected") .. "##" .. "\n"

				table.insert(resource_color, tweak_data.screen_colors.important_1)
			end

			if mask_mod_info[4].overwritten then
				updated_texts[2].text = updated_texts[2].text .. color_b_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_overwritten") .. "##" .. "\n"

				table.insert(resource_color, tweak_data.screen_colors.risk)
			elseif mask_mod_info[4].is_good then
				updated_texts[2].text = updated_texts[2].text .. color_b_text .. ": " .. managers.localization:text(mask_mod_info[4].text)

				if mask_mod_info[4].price and mask_mod_info[4].price > 0 then
					updated_texts[2].text = updated_texts[2].text .. " " .. managers.experience:cash_string(mask_mod_info[4].price)
				end

				updated_texts[2].text = updated_texts[2].text .. "\n"
			else
				updated_texts[2].text = updated_texts[2].text .. color_b_text .. ": " .. "##" .. managers.localization:to_upper_text("menu_bm_not_selected") .. "##" .. "\n"

				table.insert(resource_color, tweak_data.screen_colors.important_1)
			end
		end

		updated_texts[2].text = updated_texts[2].text .. "\n"
		local price, can_afford = managers.blackmarket:get_customize_mask_value()

		if slot_data.global_value then
			local mask = managers.blackmarket:get_crafted_category("masks")[slot_data.prev_slot] or {}
			updated_texts[4].text = "\n\n" .. managers.localization:to_upper_text("menu_bm_highlighted") .. "\n" .. slot_data.name_localized
			local mod_price = managers.money:get_mask_part_price_modified(slot_data.category, slot_data.name, slot_data.global_value, mask.mask_id) or 0

			if mod_price > 0 then
				updated_texts[4].text = updated_texts[4].text .. " " .. managers.experience:cash_string(mod_price)
			else
				updated_texts[4].text = updated_texts[4].text
			end

			if slot_data.unlocked and slot_data.unlocked ~= true and slot_data.unlocked ~= 0 then
				updated_texts[4].text = updated_texts[4].text .. "\n" .. managers.localization:to_upper_text("bm_menu_item_amount", {
					amount = math.abs(slot_data.unlocked)
				})
			end

			updated_texts[4].resource_color = {}

			if slot_data.global_value and slot_data.global_value ~= "normal" then
				updated_texts[4].text = updated_texts[4].text .. "\n##" .. managers.localization:to_upper_text(tweak_data.lootdrop.global_values[slot_data.global_value].desc_id) .. "##"

				table.insert(updated_texts[4].resource_color, tweak_data.lootdrop.global_values[slot_data.global_value].color)
			end

			if slot_data.dlc_locked then
				updated_texts[3].text = managers.localization:to_upper_text(slot_data.dlc_locked)
			end

			local customize_mask_blueprint = managers.blackmarket:get_customize_mask_blueprint()
			local index = {
				colors = 3,
				materials = 1,
				textures = 2
			}
			index.mask_colors = index.colors
			index.colors = nil
			index = index[slot_data.category]

			if index == 1 then
				customize_mask_blueprint.material = {
					global_value = slot_data.global_value,
					id = slot_data.name
				}
			elseif index == 2 then
				customize_mask_blueprint.pattern = {
					global_value = slot_data.global_value,
					id = slot_data.name
				}
			elseif index == 3 then
				customize_mask_blueprint.color = {
					global_value = slot_data.global_value,
					id = slot_data.name
				}
			end

			local part_info = managers.blackmarket:get_info_from_mask_blueprint(customize_mask_blueprint, mask.mask_id)
			part_info = part_info[index]

			if part_info.override then
				updated_texts[4].text = updated_texts[4].text .. "\n##" .. managers.localization:to_upper_text("menu_bm_overwrite", {
					category = managers.localization:text("bm_menu_" .. part_info.override)
				}) .. "##"

				table.insert(updated_texts[4].resource_color, tweak_data.screen_colors.risk)
			end
		end

		if price and price > 0 then
			updated_texts[2].text = updated_texts[2].text .. managers.localization:to_upper_text("menu_bm_total_cost", {
				cost = (not can_afford and "##" or "") .. managers.experience:cash_string(price) .. (not can_afford and "##" or "")
			})

			if not can_afford then
				table.insert(resource_color, tweak_data.screen_colors.important_1)
			end
		end

		if #resource_color == 1 then
			updated_texts[2].resource_color = resource_color[1]
		else
			updated_texts[2].resource_color = resource_color
		end

		if not managers.blackmarket:can_finish_customize_mask() then
			local list_of_mods = ""
			local missed_mods = {}

			for _, data in ipairs(mask_mod_info) do
				if not data.is_good and not data.overwritten then
					table.insert(missed_mods, managers.localization:text(data.text))
				end
			end

			if #missed_mods > 1 then
				for i = 1, #missed_mods do
					list_of_mods = list_of_mods .. missed_mods[i]

					if i < #missed_mods - 1 then
						list_of_mods = list_of_mods .. ", "
					elseif i == #missed_mods - 1 then
						list_of_mods = list_of_mods .. ", "
					end
				end
			elseif #missed_mods == 1 then
				list_of_mods = missed_mods[1]
			end

			if slot_data.dlc_locked then
				updated_texts[3].text = updated_texts[3].text .. "\n" .. managers.localization:to_upper_text("bm_menu_missing_to_finalize_mask", {
					missed_mods = list_of_mods
				}) .. "\n"
			else
				updated_texts[3].text = managers.localization:to_upper_text("bm_menu_missing_to_finalize_mask", {
					missed_mods = list_of_mods
				}) .. "\n"
			end
		elseif price and managers.money:total() < price then
			if slot_data.dlc_locked then
				updated_texts[3].text = updated_texts[3].text .. "\n" .. managers.localization:to_upper_text("bm_menu_not_enough_cash") .. "\n"
			else
				updated_texts[3].text = managers.localization:to_upper_text("bm_menu_not_enough_cash") .. "\n"
			end
		end
	elseif identifier == self.identifiers.player_style then
		local player_style = slot_data.name
		local player_style_tweak = tweak_data.blackmarket.player_styles[player_style]
		updated_texts[1].text = slot_data.name_localized

		if not slot_data.unlocked then
			updated_texts[2].text = "##" .. managers.localization:to_upper_text("bm_menu_item_locked") .. "##"
			updated_texts[2].resource_color = tweak_data.screen_colors.important_1
			updated_texts[3].text = slot_data.dlc_locked and managers.localization:to_upper_text(slot_data.dlc_locked) or managers.localization:to_upper_text("bm_menu_dlc_locked")
		end

		local desc_id = player_style_tweak.desc_id
		local desc_colors = {}
		updated_texts[4].text = desc_id and managers.localization:text(desc_id) or ""

		if slot_data.global_value and slot_data.global_value ~= "normal" then
			local gvalue_tweak = tweak_data.lootdrop.global_values[slot_data.global_value]

			if gvalue_tweak.desc_id then
				updated_texts[4].text = updated_texts[4].text .. "\n##" .. managers.localization:to_upper_text(gvalue_tweak.desc_id) .. "##"

				table.insert(desc_colors, gvalue_tweak.color)
			end
		end

		if #desc_colors == 1 then
			updated_texts[4].resource_color = desc_colors[1]
		else
			updated_texts[4].resource_color = desc_colors
		end
	elseif identifier == self.identifiers.suit_variation then
		local player_style = self._data.prev_node_data.name
		local player_style_tweak = tweak_data.blackmarket.player_styles[player_style]
		local suit_variation = slot_data.name
		local suit_variation_tweak = player_style_tweak.material_variations[suit_variation]
		updated_texts[1].text = slot_data.name_localized

		if not slot_data.unlocked then
			updated_texts[2].text = "##" .. managers.localization:to_upper_text("bm_menu_item_locked") .. "##"
			updated_texts[2].resource_color = tweak_data.screen_colors.important_1
			updated_texts[3].text = slot_data.dlc_locked and managers.localization:to_upper_text(slot_data.dlc_locked) or managers.localization:to_upper_text("bm_menu_dlc_locked")
		end

		local desc_id = suit_variation_tweak and suit_variation_tweak.desc_id or "menu_default"
		local desc_colors = {}
		updated_texts[4].text = desc_id and managers.localization:text(desc_id) or ""

		if slot_data.global_value and slot_data.global_value ~= "normal" then
			local gvalue_tweak = tweak_data.lootdrop.global_values[slot_data.global_value]

			if gvalue_tweak.desc_id then
				updated_texts[4].text = updated_texts[4].text .. "\n##" .. managers.localization:to_upper_text(gvalue_tweak.desc_id) .. "##"

				table.insert(desc_colors, gvalue_tweak.color)
			end
		end

		if #desc_colors == 1 then
			updated_texts[4].resource_color = desc_colors[1]
		else
			updated_texts[4].resource_color = desc_colors
		end
	elseif identifier == self.identifiers.gloves then
		local glove_id = slot_data.name
		local glove_tweak = tweak_data.blackmarket.gloves[glove_id]
		updated_texts[1].text = slot_data.name_localized

		if not slot_data.unlocked then
			updated_texts[2].text = "##" .. managers.localization:to_upper_text("bm_menu_item_locked") .. "##"
			updated_texts[2].resource_color = tweak_data.screen_colors.important_1
			updated_texts[3].text = slot_data.dlc_locked and managers.localization:to_upper_text(slot_data.dlc_locked) or managers.localization:to_upper_text("bm_menu_dlc_locked")
		end

		local desc_id = glove_tweak.desc_id
		local desc_colors = {}
		updated_texts[4].text = desc_id and managers.localization:text(desc_id) or ""

		if slot_data.global_value and slot_data.global_value ~= "normal" then
			local gvalue_tweak = tweak_data.lootdrop.global_values[slot_data.global_value]

			if gvalue_tweak.desc_id then
				updated_texts[4].text = updated_texts[4].text .. "\n##" .. managers.localization:to_upper_text(gvalue_tweak.desc_id) .. "##"

				table.insert(desc_colors, gvalue_tweak.color)
			end
		end

		if #desc_colors == 1 then
			updated_texts[4].resource_color = desc_colors[1]
		else
			updated_texts[4].resource_color = desc_colors
		end
	elseif identifier == self.identifiers.deployable then
		updated_texts[1].text = slot_data.name_localized
		if not self._slot_data.unlocked then
			updated_texts[3].text = managers.localization:to_upper_text(slot_data.level == 0 and (slot_data.skill_name or "bm_menu_skilltree_locked") or "bm_menu_level_req", {
				level = slot_data.level,
				SKILL = slot_data.name
			})
			updated_texts[3].text = updated_texts[3].text .. "\n"
		end
		updated_texts[4].text = managers.localization:text(tweak_data.blackmarket.deployables[slot_data.name].desc_id, {
			BTN_INTERACT = managers.localization:btn_macro("interact", true),
			BTN_USE_ITEM = managers.localization:btn_macro("use_item", true)
		})
	elseif identifier == self.identifiers.character then
		updated_texts[1].text = slot_data.name_localized
		if not slot_data.unlocked then
			local dlc_text_id = slot_data.dlc_locked or "ERR"
			local text = managers.localization:to_upper_text(dlc_text_id, {}) .. "\n"
			updated_texts[3].text = text
		end
		updated_texts[4].text = managers.localization:text(slot_data.name .. "_desc")
	end
	if self._desc_mini_icons then
		for _, gui_object in pairs(self._desc_mini_icons) do
			self._panel:remove(gui_object[1])
		end
	end
	self._desc_mini_icons = {}
	local desc_mini_icons = self._slot_data.desc_mini_icons
	local info_box_panel = self._panel:child("info_box_panel")
	if desc_mini_icons and 0 < table.size(desc_mini_icons) then
		for _, mini_icon in pairs(desc_mini_icons) do
			local new_icon = self._panel:bitmap({
				texture = mini_icon.texture,
				x = info_box_panel:left() + 10 + mini_icon.right,
				w = mini_icon.w or 32,
				h = mini_icon.h or 32
			})
			table.insert(self._desc_mini_icons, {new_icon, 2})
		end
		updated_texts[2].text = string.rep("     ", table.size(desc_mini_icons)) .. updated_texts[2].text
	else
	end
	if not ignore_lock and slot_data.lock_texture and slot_data.lock_texture ~= true then
		local new_icon = self._panel:bitmap({
			texture = slot_data.lock_texture,
			x = info_box_panel:left() + 10,
			w = 20,
			h = 20,
			color = self._info_texts[3]:color(),
			blend_mode = "add"
		})
		updated_texts[3].text = "     " .. updated_texts[3].text
		table.insert(self._desc_mini_icons, {new_icon, 3})
	else
	end
	if is_renaming_this and self._rename_info_text then
		local text = self._renaming_item.custom_name ~= "" and self._renaming_item.custom_name or "##" .. tostring(slot_data.raw_name_localized) .. "##"
		updated_texts[self._rename_info_text].text = text
		updated_texts[self._rename_info_text].resource_color = tweak_data.screen_colors.text:with_alpha(0.35)
	end
	for id, _ in ipairs(self._info_texts) do
		self:set_info_text(id, updated_texts[id].text, updated_texts[id].resource_color)
	end
	local _, _, _, th = self._info_texts[1]:text_rect()
	self._info_texts[1]:set_h(th)
	local y = self._info_texts[1]:bottom()
	local title_offset = y
	local bg = self._info_texts_bg[1]
	if alive(bg) then
		bg:set_shape(self._info_texts[1]:shape())
	end
	local below_y
	for i = 2, #self._info_texts do
		local info_text = self._info_texts[i]
		info_text:set_font_size(small_font_size)
		_, _, _, th = info_text:text_rect()
		info_text:set_y(y)
		info_text:set_h(th)
		if updated_texts[i].below_stats then
			if slot_data.comparision_data and alive(self._stats_text_modslist) then
				info_text:set_world_y(below_y or self._stats_text_modslist:world_top())
				below_y = (below_y or info_text:world_y()) + th
			else
				info_text:set_top((below_y or info_text:top()) + 20)
				below_y = (below_y or info_text:top()) + th
			end
		end
		local scale = 1
		if info_text:bottom() > self._info_texts_panel:h() then
			scale = self._info_texts_panel:h() / info_text:bottom()
		end
		info_text:set_font_size(small_font_size * scale)
		_, _, _, th = info_text:text_rect()
		info_text:set_h(th)
		local bg = self._info_texts_bg[i]
		if alive(bg) then
			bg:set_shape(info_text:shape())
		end
		y = info_text:bottom()
	end
	for _, desc_mini_icon in ipairs(self._desc_mini_icons) do
		desc_mini_icon[1]:set_y(title_offset)
		desc_mini_icon[1]:set_world_top(self._info_texts[desc_mini_icon[2]]:world_top() + 1)
	end
	if is_renaming_this and self._rename_info_text and self._rename_caret then
		local info_text = self._info_texts[self._rename_info_text]
		local x, y, w, h = info_text:text_rect()
		if self._renaming_item.custom_name == "" then
			w = 0
		end
		self._rename_caret:set_w(2)
		self._rename_caret:set_h(h)
		self._rename_caret:set_world_position(x + w, y)
	end
end

function BlackMarketGui:animate_text_bounce(bounce_panel)
	local dt = 0
	local bounce_dir_up = true
	local top = bounce_panel:top()
	local move = 0
	while true do
		dt = coroutine.yield()
		if bounce_dir_up then
		else
		end
		bounce_panel:move(0, move)
		if move == 0 then
			bounce_dir_up = not bounce_dir_up
		end
	end
end

function BlackMarketGui:customize_player_style_callback(data)
	local new_node_data = {}

	table.insert(new_node_data, {
		name = "bm_menu_suit_variations",
		on_create_func_name = "populate_suit_variations",
		category = "suit_variations",
		override_slots = {
			3,
			3
		},
		identifier = BlackMarketGui.identifiers.suit_variation,
		prev_node_data = data
	})

	new_node_data.topic_id = "bm_menu_suit_variations"
	new_node_data.panel_grid_w_mul = 0.6
	new_node_data.skip_blur = true
	new_node_data.use_bgs = true
	new_node_data.hide_detection_panel = true
	new_node_data.prev_node_data = data

	local player_style = data.name
	local material_variation = managers.blackmarket:get_suit_variation(player_style)
	managers.menu:open_node(self._inception_node_name, {
			new_node_data
	})
end

function BlackMarketGui:set_info_text(id, new_string, resource_color)
	local info_text = self._info_texts[id]
	local text = new_string
	self._info_texts_bg[id]:set_visible(false)
	info_text:set_blend_mode("add")
	info_text:set_color(self._info_texts_color[id] or Color.white)
	info_text:clear_range_color(0, utf8.len(info_text:text()))
	local start_ci, end_ci, first_ci
	if resource_color then
		local text_dissected = utf8.characters(text)
		local idsp = Idstring("#")
		start_ci = {}
		end_ci = {}
		first_ci = true
		for i, c in ipairs(text_dissected) do
			if Idstring(c) == idsp then
				local next_c = text_dissected[i + 1]
				if next_c and Idstring(next_c) == idsp then
					if first_ci then
						table.insert(start_ci, i)
					else
						table.insert(end_ci, i)
					end
					first_ci = not first_ci
				end
			end
		end
		if #start_ci ~= #end_ci then
		else
			for i = 1, #start_ci do
				start_ci[i] = start_ci[i] - ((i - 1) * 4 + 1)
				end_ci[i] = end_ci[i] - (i * 4 - 1)
			end
		end
		text = string.gsub(text, "##", "")
	end
	info_text:set_text(text)
	info_text:set_alpha(1)
	if resource_color then
		info_text:clear_range_color(1, utf8.len(text))
		if #start_ci ~= #end_ci then
			Application:error("BlackMarketGui: Missing ##'s in :set_info_text() string!", id, new_string, #start_ci, #end_ci)
		else
			for i = 1, #start_ci do
				info_text:set_range_color(start_ci[i], end_ci[i], type(resource_color) == "table" and resource_color[i] or resource_color)
			end
		end
	end
end

function BlackMarketGui:_round_everything()
	if alive(self._panel) then
		for i, d in ipairs(self._panel:children()) do
			self:_rec_round_object(d)
		end
	end
	if alive(self._fullscreen_panel) then
		for i, d in ipairs(self._fullscreen_panel:children()) do
			self:_rec_round_object(d)
		end
	end
end

function BlackMarketGui:_rec_round_object(object)
	local x, y, w, h = object:shape()
	object:set_shape(math.round(x), math.round(y), math.round(w), math.round(h))
	if object.children then
		for i, d in ipairs(object:children()) do
			self:_rec_round_object(d)
		end
	end
end

function BlackMarketGui:mouse_moved(o, x, y)
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return true, "link"
	end
	local inside_tab_area = self._tab_area_panel:inside(x, y)
	local used = true
	local pointer = inside_tab_area and self._highlighted == self._selected and "arrow" or "link"
	local inside_tab_scroll = self._tab_scroll_panel:inside(x, y)
	local update_select = false
	if not self._highlighted then
		update_select = true
		used = false
		pointer = "arrow"
	elseif not inside_tab_scroll or self._tabs[self._highlighted] and not self._tabs[self._highlighted]:inside(x, y) then
		self._tabs[self._highlighted]:set_highlight(not self._pages, not self._pages)
		self._highlighted = nil
		update_select = true
		used = false
		pointer = "arrow"
	end
	if update_select then
		for i, tab in ipairs(self._tabs) do
			update_select = inside_tab_scroll and tab:inside(x, y)
			if update_select then
				self._highlighted = i
				self._tabs[self._highlighted]:set_highlight(self._selected ~= self._highlighted)
				used = true
				pointer = self._highlighted == self._selected and "arrow" or "link"
			end
		end
	end
	if self._tabs[self._selected] then
		local tab_used, tab_pointer = self._tabs[self._selected]:mouse_moved(x, y)
		if tab_used then
			local x, y = self._tabs[self._selected]:selected_slot_center()
			self._select_rect:set_world_center(x, y)
			self._select_rect:stop()
			self._select_rect_box:set_color(Color.white)
			self._select_rect:set_visible(y > self._tabs[self._selected]._grid_panel:top() and y < self._tabs[self._selected]._grid_panel:bottom())
			used = tab_used
			pointer = tab_pointer
		end
	end
	if self._panel:child("back_button"):inside(x, y) then
		used = true
		pointer = "link"

		if not self._back_button_highlighted then
			self._back_button_highlighted = true

			self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_2)
			managers.menu_component:post_event("highlight")

			return used, pointer
		end
	elseif self._back_button_highlighted then
		self._back_button_highlighted = false

		self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_3)
	end
	update_select = false
	if not self._button_highlighted then
		update_select = true
	elseif self._btns[self._button_highlighted] and not self._btns[self._button_highlighted]:inside(x, y) then
		self._btns[self._button_highlighted]:set_highlight(false)
		self._button_highlighted = nil
		update_select = true
	end
	if update_select then
		for i, btn in pairs(self._btns) do
			if not self._button_highlighted and btn:visible() and btn:inside(x, y) then
				self._button_highlighted = i
				btn:set_highlight(true)
			else
				btn:set_highlight(false)
			end
		end
	end
	if self._button_highlighted then
		used = true
		pointer = "link"
	end
	if self._tab_scroll_table.left and self._tab_scroll_table.left_klick then
		local color
		if self._tab_scroll_table.left:inside(x, y) then
			color = tweak_data.screen_colors.button_stage_2
			used = true
			pointer = "link"
		else
			color = tweak_data.screen_colors.button_stage_3
		end
		self._tab_scroll_table.left:set_color(color)
	end
	if self._tab_scroll_table.right and self._tab_scroll_table.right_klick then
		local color
		if self._tab_scroll_table.right:inside(x, y) then
			color = tweak_data.screen_colors.button_stage_2
			used = true
			pointer = "link"
		else
			color = tweak_data.screen_colors.button_stage_3
		end
		self._tab_scroll_table.right:set_color(color)
	end
	if self._rename_info_text then
		local text_button = self._info_texts and self._info_texts[self._rename_info_text]
		if text_button then
			if text_button:inside(x, y) then
				if not self._rename_highlight then
					self._rename_highlight = true
					text_button:set_blend_mode("add")
					text_button:set_color(tweak_data.screen_colors.button_stage_2)
					local bg = self._info_texts_bg[self._rename_info_text]
					if alive(bg) then
						bg:set_visible(true)
						bg:set_color(tweak_data.screen_colors.button_stage_3)
					end
					managers.menu_component:post_event("highlight")
				end
				used = true
				pointer = "link"
			elseif self._rename_highlight then
				self._rename_highlight = false
				text_button:set_blend_mode("normal")
				text_button:set_color(tweak_data.screen_colors.text)
				local bg = self._info_texts_bg[self._rename_info_text]
				if alive(bg) then
					bg:set_visible(false)
					bg:set_color(Color.black)
				end
			end
		end
	end
	return used, pointer
end

function BlackMarketGui:mouse_pressed(button, x, y)
	if not self._enabled then
		return
	end
	if self._renaming_item then
		self:_stop_rename_item()
		return
	end
	local holding_shift = false
	local scroll_button_pressed = button == Idstring("mouse wheel up") or button == Idstring("mouse wheel down")
	local inside_tab_area = self._tab_area_panel:inside(x, y)
	if inside_tab_area then
		if button == Idstring("mouse wheel down") then
			self:next_page(true)
			return
		elseif button == Idstring("mouse wheel up") then
			self:previous_page(true)
			return
		end
	elseif self._tabs[self._selected] and scroll_button_pressed and self._tabs[self._selected]:mouse_pressed(button, x, y) then
		local x, y = self._tabs[self._selected]:selected_slot_center()
		self._select_rect:set_world_center(x, y)
		self._select_rect:stop()
		self._select_rect_box:set_color(Color.white)
		self._select_rect:set_visible(y > self._tabs[self._selected]._grid_panel:top() and y < self._tabs[self._selected]._grid_panel:bottom())
		return
	end
	if button ~= Idstring("0") then
		return
	end
	if self._panel:child("back_button"):inside(x, y) then
		if managers.blackmarket:currently_customizing_mask() then
			local params = {
				yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_abort_customized_mask_callback")),
				no_func = callback(self, self, "_dialog_no")
			}
			self:_warn_abort_customized_mask_callback(params)
		else
			managers.menu_component:close_blackmarket_gui()
			managers.menu:back(true)
		end
		return
	end
	if self._tab_scroll_table.left_klick and self._tab_scroll_table.left:inside(x, y) then
		self:previous_page()
		return
	end
	if self._tab_scroll_table.right_klick and self._tab_scroll_table.right:inside(x, y) then
		self:next_page()
		return
	end
	if self._selected_slot and self._selected_slot._equipped_rect then
		self._selected_slot._equipped_rect:set_alpha(1)
	end
	if self._tab_scroll_panel:inside(x, y) and self._tabs[self._highlighted] and self._tabs[self._highlighted]:inside(x, y) ~= 1 then
		if self._selected ~= self._highlighted then
			self:set_selected_tab(self._highlighted)
		end
		return
	elseif self._tabs[self._selected] then
		local selected_slot = self._tabs[self._selected]:mouse_pressed(button, x, y)
		self:on_slot_selected(selected_slot)
		if selected_slot then
			return
		end
	end
	if self._rename_info_text then
		local text_button = self._info_texts and self._info_texts[self._rename_info_text]
		if self._slot_data and text_button and text_button:inside(x, y) then
			local category = self._slot_data.category
			local slot = self._slot_data.slot
			self:_start_rename_item(category, slot)
			return
		end
	end
	if self._btns[self._button_highlighted] and self._btns[self._button_highlighted]:inside(x, y) then
		local data = self._btns[self._button_highlighted]._data
		if data.callback and (not self._button_press_delay or self._button_press_delay < TimerManager:main():time()) then
			managers.menu_component:post_event("menu_enter")
			data.callback(self._slot_data, self._data.topic_params)
			self._button_press_delay = TimerManager:main():time() + 0.2
		end
	end
	if self._selected_slot and self._selected_slot._equipped_rect then
		self._selected_slot._equipped_rect:set_alpha(0.6)
	end
end

function BlackMarketGui:set_selected_tab(tab, no_sound)
	local selected_slot
	if self._tabs[self._selected] then
		selected_slot = 1 --self._tabs[self._selected]._slot_selected
		self._tabs[self._selected]:deselect(false)
	end
	if self._selected_slot then
		self._selected_slot:set_btn_text()
	end
	self._selected = tab
	self._node:parameters().menu_component_selected = self._selected
	self._tabs[self._selected]:select(false, no_sound)
	self._selected_slot = self._tabs[self._selected]:select_slot(selected_slot, true)
	self._slot_data = self._selected_slot._data
	local x, y = self._tabs[self._selected]:selected_slot_center()
	local grid_panel_w = self._panel:w() * WIDTH_MULTIPLIER
	local grid_panel_h = (self._panel:h() - (self._real_medium_font_size + 10) - 60) * GRID_H_MUL
	local square_w = grid_panel_w / 3
	local square_h = grid_panel_h / 3
	local slot_dim_x = self._tabs[self._selected].my_slots_dimensions[1]
	local slot_dim_y = self._tabs[self._selected].my_slots_dimensions[2]
	self._select_rect:set_size(square_w * 3 / slot_dim_x, square_h * 3 / slot_dim_y)
	self._select_rect_box:create_sides(self._select_rect, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	self._select_rect_box:set_clipping(false)
	self._select_rect:set_world_center(x, y)
	self._select_rect:stop()
	self._select_rect_box:set_color(Color.white)
	self._select_rect:set_visible(y > self._tabs[self._selected]._grid_panel:top() and y < self._tabs[self._selected]._grid_panel:bottom())
	self:show_btns(self._selected_slot)
	self:set_tab_positions()
	local visibility_visible = false
	if self._selected_slot then
		if self._selected_slot._equipped_rect then
			self._selected_slot._equipped_rect:set_alpha(0.6)
		end
		local slot_category = self._selected_slot._data.category
		visibility_visible = (slot_category == "primaries" or slot_category == "secondaries" or slot_category == "armors" or slot_category == "melee_weapons") and not self._data.buying_weapon
	end
	self._detection_panel:set_visible(visibility_visible)
	self:_update_borders()
	self:show_stats()
	self:update_info_text()
	self._box_panel:set_shape(self._tabs[self._selected]._grid_panel:shape())
	self._box:create_sides(self._box_panel, {
		sides = {
			1,
			1,
			1 + (#self._tabs > 1 and 1 or 0),
			1
		}
	})
	if managers.blackmarket:get_hold_crafted_item() then
		self:drop_hold_crafted_item_callback()
	end
end

function BlackMarketGui:on_slot_selected(selected_slot)
	if selected_slot then
		local x, y = self._tabs[self._selected]:selected_slot_center()
		self._select_rect:set_world_center(x, y)
		self._select_rect:stop()
		self._select_rect_box:set_color(Color.white)
		self._select_rect:set_visible(y > self._tabs[self._selected]._grid_panel:top() and y < self._tabs[self._selected]._grid_panel:bottom())
		if self._selected_slot then
			self._selected_slot:set_btn_text()
		end
		self._selected_slot = selected_slot
		self._slot_data = self._selected_slot._data
		self:show_btns(self._selected_slot)
		local visibility_visible = false
		if self._selected_slot then
			if self._selected_slot._equipped_rect then
				self._selected_slot._equipped_rect:set_alpha(0.6)
			end
			local slot_category = self._selected_slot._data.category
			visibility_visible = (slot_category == "primaries" or slot_category == "secondaries" or slot_category == "armors" or slot_category == "melee_weapons") and not self._data.buying_weapon
		end
		self._detection_panel:set_visible(visibility_visible)
		self:_update_borders()
		self:show_stats()
		self:update_info_text()
	end
end

function BlackMarketGui:move(mx, my)
	if not self._tabs[self._selected] then
		return
	end

	local slot = self._tabs[self._selected]._slot_selected

	if not slot then
		return
	end

	local dim_x = self._tabs[self._selected].my_slots_dimensions[1]
	local dim_y = self._tabs[self._selected].my_slots_dimensions[2]
	local scroll_y = self._tabs[self._selected].my_scroll_slots_y

	if dim_y == 1 then
		local new_selected = math.clamp(slot + mx, 1, #self._tabs[self._selected]:slots())
		local slot = self._tabs[self._selected]:select_slot(new_selected, new_selected == slot)

		self:on_slot_selected(slot)
	else
		local x = (slot - 1) % dim_x + 1
		local y = math.ceil(slot / dim_x)
		x = math.clamp(x + mx, 1, dim_x)
		y = math.clamp(y + my, 1, scroll_y)
		local new_selected = x + (y - 1) * dim_x
		local slot = self._tabs[self._selected]:select_slot(new_selected, new_selected == slot)

		self:on_slot_selected(slot)
	end
end

function BlackMarketGui:move_up()
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return
	end
	self:move(0, -1)
end

function BlackMarketGui:move_down()
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return
	end
	self:move(0, 1)
end

function BlackMarketGui:move_left()
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return
	end
	self:move(-1, 0)
end

function BlackMarketGui:move_right()
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return
	end
	self:move(1, 0)
end

function BlackMarketGui:next_page(no_sound)
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return
	end
	if self._pages then
		local old_selected = self._selected
		local s = math.min(self._selected + 1, #self._tabs)
		if old_selected == s then
			return
		end
		self:set_selected_tab(s, no_sound)
	else
		self:move(1, 0)
	end
end

function BlackMarketGui:previous_page(no_sound)
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return
	end
	if self._pages then
		local old_selected = self._selected
		local s = math.max(self._selected - 1, 1)
		if old_selected == s then
			return
		end
		self:set_selected_tab(s, no_sound)
	else
		self:move(-1, 0)
	end
end

function BlackMarketGui:press_pc_button(button)
	if not self._enabled then
		return
	end
	if button:key() == "d95354c7c30900a0" then
		if managers.blackmarket:currently_customizing_mask() then
			local params = {
				yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_abort_customized_mask_callback")),
				no_func = callback(self, self, "_dialog_no")
			}
			self:_warn_abort_customized_mask_callback(params)
		elseif self._not_renaming_item then
		else
			managers.menu_component:close_blackmarket_gui()
			managers.menu:back(true)
		end
	end
	local btn = self._controllers_pc_mapping and self._controllers_pc_mapping[button:key()]
	if btn and btn._data and btn._data.callback and (not self._button_press_delay or self._button_press_delay < TimerManager:main():time()) then
		managers.menu_component:post_event("menu_enter")
		btn._data.callback(self._slot_data, self._data.topic_params)
		self._button_press_delay = TimerManager:main():time() + 0.2
		return true
	end
	return false
end

function BlackMarketGui:press_button(button)
	if not self._enabled then
		return
	end
	if self._renaming_item then
		return
	end
	local btn = self._controllers_mapping and self._controllers_mapping[button:key()]
	if btn and btn._data and btn._data.callback then
		if not self._button_press_delay or self._button_press_delay < TimerManager:main():time() then
			managers.menu_component:post_event("menu_enter")
			btn._data.callback(self._slot_data, self._data.topic_params)
			self._button_press_delay = TimerManager:main():time() + 0.2
			return true
		end
	elseif self._select_rect_box then
		self:flash()
	end
	return false
end

function BlackMarketGui:flash()
	local box = self._select_rect_box
	local function flash_anim(panel)
		local b_color = Color.white
		local s = 0
		over(0.5, function(t)
			s = math.min(1, math.sin(t * 180) * 2)
			box:set_color(math.lerp(b_color, tweak_data.screen_colors.important_1, s))
		end
)
		box:set_color(b_color)
	end

	managers.menu_component:post_event("selection_next", true)
	self._select_rect:animate(flash_anim)
end

function BlackMarketGui:confirm_pressed()
	if not self._enabled then
		return
	end
	if self._renaming_item then
		self:_stop_rename_item()
		return
	end
	if managers.menu:is_pc_controller() then
		return self:press_first_btn(Idstring("0"))
	else
		return self:press_button("BTN_A")
	end
end

function BlackMarketGui:create_context_menu(x, y)
end

function BlackMarketGui:input_focus()
	if self._one_frame_input_delay then
		self._one_frame_input_delay = nil
		return true
	end
	return self._renaming_item and true or true
end

function BlackMarketGui:visible()
	return self._visible
end

function BlackMarketGui:show_btns(slot)
	local data = slot._data
	for _, btn in pairs(self._btns) do
		btn:hide()
	end
	local btns = {}
	for i, btn in ipairs(data) do
		if self._btns[btn] then
			self._btns[btn]:show()
			table.insert(btns, self._btns[btn])
		end
	end
	if not managers.menu:is_pc_controller() then
		local back_btn = self._btns.back_btn
		if back_btn then
			back_btn:show()
			table.insert(btns, back_btn)
		end
	end
	self._button_count = #btns
	table.sort(btns, function(x, y)
		return x._data.prio < y._data.prio
	end)
	self._controllers_mapping = {}
	self._controllers_pc_mapping = {}
	for i, btn in ipairs(btns) do
		if not managers.menu:is_pc_controller() and not btn._data.no_btn then
			btn:set_text_btn_prefix(btn._data.btn)
		end
		if btn._data.pc_btn then
			self._controllers_pc_mapping[btn._data.pc_btn:key()] = btn
		end
		self._controllers_mapping[btn._data.btn:key()] = btn
		btn:set_text_params(data.btn_text_params)
		btn:set_order(i)
	end
	local num_btns = #btns
	local h = self._real_small_font_size or small_font_size
	local info_box_panel = self._panel:child("info_box_panel")
	if self._info_panel then
		self._info_panel:set_size(info_box_panel:w() - 20, self._info_panel:num_children() / 2 * h)
		self._info_panel:set_rightbottom(self._panel:w() - 10, self._btn_panel:top() - 10)
	end
	if managers.menu:is_pc_controller() and #btns > 0 then
		slot:set_btn_text(btns[1]:btn_text())
	else
		slot:set_btn_text("")
	end

	self._visible_btns = btns

	self:_update_borders()
end

function BlackMarketGui:get_lock_icon(data, default)
	local category = data.category
	local global_value = data.global_value
	local name = data.name
	local unlocked = data.unlocked
	local level = data.level
	local skill_based = data.skill_based
	if unlocked and (type(unlocked) ~= "number" or unlocked > 0) then
		return nil
	end
	if skill_based then
		return "guis/textures/pd2/lock_skill"
	end
	local gv_tweak = tweak_data.lootdrop.global_values[global_value]
	if gv_tweak and gv_tweak.dlc and not managers.dlc:is_dlc_unlocked(global_value) then
		return gv_tweak.unique_lock_icon or "guis/textures/pd2/lock_dlc"
	end
	return default or "guis/textures/pd2/lock_level"
end

function BlackMarketGui:populate_characters(data)
	local new_data = {}
	local max_items = math.ceil(CriminalsManager.get_num_characters() / (data.override_slots[1] or 3)) * (data.override_slots[1] or 3)
	for i = 1, max_items do
		data[i] = nil
	end
	local guis_catalog = "guis/"
	for i = 1, CriminalsManager.get_num_characters() do
		local character = CriminalsManager.character_names()[i]
		local character_name = CriminalsManager.convert_old_to_new_character_workname(character)
		guis_catalog = "guis/"
		local character_table = tweak_data.blackmarket.characters[character] or tweak_data.blackmarket.characters.locked[character_name]
		local bundle_folder = character_table and character_table.texture_bundle_folder
		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end
		new_data = {}
		new_data.name = character
		new_data.name_localized = managers.localization:text("menu_" .. new_data.name)
		new_data.category = "characters"
		new_data.slot = i
		new_data.unlocked = not character_table or not character_table.dlc or managers.dlc:is_dlc_unlocked(character_table.dlc)
		new_data.equipped = managers.blackmarket:get_preferred_character() == character
		new_data.equipped_text = managers.localization:text("bm_menu_preferred")
		new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/characters/" .. character_name
		new_data.stream = false
		new_data.global_value = character_table.dlc
		new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_community")
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
		if not new_data.equipped and new_data.unlocked then
			table.insert(new_data, "c_equip")
		end
		data[i] = new_data
	end
	for i = 1, max_items do
		if not data[i] then
			new_data = {}
			new_data.name = "empty"
			new_data.name_localized = ""
			new_data.category = "characters"
			new_data.slot = i
			new_data.unlocked = true
			new_data.equipped = false
			data[i] = new_data
		end
	end
end

function BlackMarketGui:populate_grenades(data)
	local new_data = {}
	local sort_data = {}
	local xd, yd, x_td, y_td, x_sn, y_sn, x_gv, y_gv
	local m_tweak_data = tweak_data.blackmarket.projectiles
	local l_tweak_data = tweak_data.lootdrop.global_values
	for id, d in pairs(Global.blackmarket_manager.grenades) do
		table.insert(sort_data, {id, d})
	end
	table.sort(sort_data, function(x, y)
		xd = x[2]
		yd = y[2]
		x_td = m_tweak_data[x[1]]
		y_td = m_tweak_data[y[1]]
		if not xd.is_favorite ~= not yd.is_favorite then
			return xd.is_favorite
		end
		if xd.unlocked ~= yd.unlocked then
			return xd.unlocked
		end
		x_gv = x_td.global_value or x_td.dlc or "normal"
		y_gv = y_td.global_value or y_td.dlc or "normal"
		x_sn = l_tweak_data[x_gv]
		y_sn = l_tweak_data[y_gv]
		x_sn = x_sn and x_sn.sort_number or 1
		y_sn = y_sn and y_sn.sort_number or 1
		if x_sn ~= y_sn then
			return x_sn < y_sn
		end
		return x[1] < y[1]
	end
)
	local max_items = math.ceil(#sort_data / (data.override_slots[1] or 3)) * (data.override_slots[1] or 3)
	for i = 1, max_items do
		data[i] = nil
	end
	local index = 0
	local guis_catalog, m_tweak_data, melee_weapon_id
	for i, grenades_data in ipairs(sort_data) do
		melee_weapon_id = grenades_data[1]
		m_tweak_data = tweak_data.blackmarket.projectiles[grenades_data[1]] or {}
		guis_catalog = "guis/"
		local bundle_folder = m_tweak_data.texture_bundle_folder
		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end
		new_data = {}
		new_data.name = melee_weapon_id
		new_data.name_localized = managers.localization:text(tweak_data.blackmarket.projectiles[new_data.name].name_id)
		new_data.category = "grenades"
		new_data.slot = i
		new_data.unlocked = grenades_data[2].unlocked
		new_data.equipped = grenades_data[2].equipped
		new_data.level = grenades_data[2].level
		new_data.stream = true
		new_data.global_value = m_tweak_data.dlc or "normal"
		new_data.skill_based = grenades_data[2].skill_based
		new_data.skill_name = "bm_menu_skill_locked_" .. new_data.name
		new_data.equipped_text = not new_data.unlocked and new_data.equipped and " "
		if m_tweak_data and m_tweak_data.locks then
			local dlc = m_tweak_data.locks.dlc
			local achievement = m_tweak_data.locks.achievement
			local saved_job_value = m_tweak_data.locks.saved_job_value
			local level = m_tweak_data.locks.level
			new_data.dlc_based = true
			new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_community")
			if achievement and managers.achievment:get_info(achievement) and not managers.achievment:get_info(achievement).awarded then
				new_data.dlc_locked = "menu_bm_achievement_locked_" .. tostring(achievement)
			elseif dlc and not managers.dlc:is_dlc_unlocked(dlc) then
				new_data.dlc_locked = tweak_data.lootdrop.global_values[dlc] and tweak_data.lootdrop.global_values[dlc].unlock_id or "bm_menu_dlc_locked"
			else
				new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
			end
		else
			new_data.lock_texture = self:get_lock_icon(new_data)
			new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
		end
		new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/grenades/" .. tostring(new_data.name)
		if new_data.unlocked and not new_data.equipped then
			table.insert(new_data, "lo_g_equip")
		end
		if new_data.unlocked and data.allow_preview and m_tweak_data.unit then
			table.insert(new_data, "lo_g_preview")
		end
		data[i] = new_data
		index = i
	end
	for i = 1, max_items do
		if not data[i] then
			new_data = {}
			new_data.name = "empty"
			new_data.name_localized = ""
			new_data.category = "grenades"
			new_data.slot = i
			new_data.unlocked = true
			new_data.equipped = false
			data[i] = new_data
		end
	end
end

function BlackMarketGui:populate_choose_mask_mod(data)
	local new_data = {}
	local index = 1
	local equipped_mod = managers.blackmarket:customize_mask_category_id(data.category)
	local equipped_first, equipped_second = nil

	if data.category == "mask_colors" then
		equipped_first = data.is_first_color and managers.blackmarket:customize_mask_category_id("color_a")
		equipped_second = not data.is_first_color and managers.blackmarket:customize_mask_category_id("color_b")
	end

	local num_data = #data

	for i = 1, num_data do
		data[i] = nil
	end

	local type_func = type
	local guis_catalog = "guis/"

	for type, mods in pairs(data.on_create_data) do
		guis_catalog = "guis/"
		local bundle_folder = tweak_data.blackmarket[data.category][mods.id] and tweak_data.blackmarket[data.category][mods.id].texture_bundle_folder

		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end

		new_data = {
			name = mods.id
		}
		new_data.name_localized = managers.localization:text(tweak_data.blackmarket[data.category][new_data.name].name_id)
		new_data.category = data.category
		new_data.slot = index
		new_data.prev_slot = data.prev_node_data and data.prev_node_data.slot
		new_data.unlocked = mods.default or mods.amount
		new_data.equipped = equipped_mod == mods.id
		new_data.equipped_text = managers.localization:text("bm_menu_chosen")
		new_data.mods = mods
		new_data.stream = data.category ~= "colors"
		new_data.global_value = mods.global_value
		local is_locked = false

		if new_data.unlocked and type_func(new_data.unlocked) == "number" and tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].dlc and not managers.dlc:is_dlc_unlocked(new_data.global_value) then
			new_data.unlocked = -math.abs(new_data.unlocked)
			new_data.lock_texture = self:get_lock_icon(new_data)
			new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
			is_locked = true
		end

		local active = true
		new_data.equipped_text = ""

		if data.category == "mask_colors" then
			new_data.bitmap_texture = "guis/textures/pd2/blackmarket/icons/colors/color_bg"
			new_data.extra_bitmaps = {}
			table.insert(new_data.extra_bitmaps, "guis/dlcs/mcu/textures/pd2/blackmarket/icons/mask_color/mask_color_icon")
			new_data.extra_bitmaps_colors = {}
			table.insert(new_data.extra_bitmaps_colors, tweak_data.blackmarket.mask_colors[new_data.name].color)
		elseif data.category == "textures" then
			new_data.bitmap_texture = tweak_data.blackmarket[data.category][mods.id].texture
			new_data.render_template = Idstring("VertexColorTexturedPatterns")
		else
			new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/" .. tostring(data.category) .. "/" .. new_data.name
		end

		if managers.blackmarket:got_new_drop(new_data.global_value or "normal", new_data.category, new_data.name) then
			new_data.mini_icons = new_data.mini_icons or {}

			table.insert(new_data.mini_icons, {
				texture = "guis/textures/pd2/blackmarket/inv_newdrop",
				name = "new_drop",
				h = 16,
				w = 16,
				top = 0,
				layer = 3,
				stream = false,
				right = 0
			})

			new_data.new_drop_data = {
				new_data.global_value or "normal",
				new_data.category,
				new_data.name
			}
		end

		new_data.btn_text_params = {
			type = managers.localization:text("bm_menu_" .. data.category)
		}

		if not is_locked and active then
			if data.category == "mask_colors" then
				if data.is_first_color then
					table.insert(new_data, "mp_choose_first")
				else
					table.insert(new_data, "mp_choose_second")
				end
			else
				table.insert(new_data, "mp_choose")
			end

			table.insert(new_data, "mp_preview")
		end

		if managers.blackmarket:can_finish_customize_mask() and managers.blackmarket:can_afford_customize_mask() then
			table.insert(new_data, "mm_buy")
		end

		data[index] = new_data
		index = index + 1
	end

	if #data == 0 then
		new_data = {
			name = "bm_menu_nothing",
			empty_slot = true,
			category = data.category,
			slot = 1,
			unlocked = true,
			can_afford = true,
			equipped = false
		}

		table.insert(new_data, "mm_preview")

		data[1] = new_data
	end

	local max_mask_mods = #data.on_create_data

	for i = 1, math.ceil(max_mask_mods / data.override_slots[1]) * data.override_slots[1] do
		if not data[i] then
			new_data = {
				name = "empty",
				name_localized = "",
				category = data.category,
				slot = i,
				unlocked = true,
				equipped = false
			}
			data[i] = new_data
		end
	end
end

function BlackMarketGui:populate_masks(data)
	local new_data = {}
	local crafted_category = managers.blackmarket:get_crafted_category("masks") or {}
	local mini_icon_helper = math.round((self._panel:h() - (tweak_data.menu.pd2_medium_font_size + 10) - 60) * GRID_H_MUL / 3) - 16
	local max_items = data.override_slots and data.override_slots[1] * data.override_slots[2] or 9
	local start_crafted_item = data.start_crafted_item or 1
	local hold_crafted_item = managers.blackmarket:get_hold_crafted_item()
	local currently_holding = hold_crafted_item and hold_crafted_item.category == "masks"
	local max_rows = tweak_data.gui.MAX_MASK_ROWS
	max_items = max_rows * (data.override_slots and data.override_slots[2] or 3)
	for i = 1, max_items do
		data[i] = nil
	end
	local guis_catalog = "guis/"
	local index = 0
	for i, crafted in pairs(crafted_category) do
		index = i - start_crafted_item + 1
		local guis_mask_id = crafted.mask_id
		if tweak_data.blackmarket.masks[guis_mask_id].guis_id then
			guis_mask_id = tweak_data.blackmarket.masks[guis_mask_id].guis_id
		end
		guis_catalog = "guis/"
		local bundle_folder = tweak_data.blackmarket.masks[guis_mask_id] and tweak_data.blackmarket.masks[guis_mask_id].texture_bundle_folder
		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end
		new_data = {}
		new_data.name = crafted.mask_id
		new_data.name_localized = managers.blackmarket:get_mask_name_by_category_slot("masks", i)
		new_data.raw_name_localized = managers.localization:text(tweak_data.blackmarket.masks[new_data.name].name_id)
		new_data.custom_name_text = managers.blackmarket:get_crafted_custom_name("masks", i, true)
		new_data.custom_name_text_right = crafted.modded and -55 or -20
		new_data.custom_name_text_width = crafted.modded and 0.6
		new_data.category = "masks"
		new_data.global_value = crafted.global_value
		new_data.slot = i
		new_data.unlocked = true
		new_data.equipped = crafted.equipped
		new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/masks/" .. guis_mask_id
		new_data.stream = false
		new_data.holding = currently_holding and hold_crafted_item.slot == i
		local is_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].dlc and not managers.dlc:is_dlc_unlocked(new_data.global_value)
		local locked_parts = {}
		local mask_is_locked = is_locked
		if not is_locked then
			local name_converter = {
				material = "materials",
				pattern = "textures",
				color = "colors"
			}
			local default_blueprint = tweak_data.blackmarket.masks[crafted.mask_id] and tweak_data.blackmarket.masks[crafted.mask_id].default_blueprint or {}
			for type, part in pairs(crafted.blueprint) do
				if default_blueprint[type] ~= part.id and default_blueprint[name_converter[type]] ~= part.id and tweak_data.lootdrop.global_values[part.global_value] and tweak_data.lootdrop.global_values[part.global_value].dlc and not managers.dlc:is_dlc_unlocked(part.global_value) then
					locked_parts[type] = part.global_value
					is_locked = true
					locked_global_value = part.global_value or locked_global_value
				end
			end
		end
		if is_locked then
			new_data.unlocked = false
			if mask_is_locked then
				new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_incompatible")
				new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
			elseif 0 < table.size(locked_parts) then
				local t, gv = next(locked_parts)
				if gv then
					new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_incompatible")
					new_data.dlc_locked = tweak_data.lootdrop.global_values[gv] and tweak_data.lootdrop.global_values[gv].unlock_id or "bm_menu_dlc_locked"
				end
			end
		end
		if currently_holding then
			if i ~= 1 then
				new_data.selected_text = managers.localization:to_upper_text("bm_menu_btn_swap_mask")
			end
			if i ~= 1 and new_data.slot ~= hold_crafted_item.slot then
				table.insert(new_data, "m_swap")
			end
			table.insert(new_data, "i_stop_move")
		else
			if new_data.unlocked then
				if not new_data.equipped then
					table.insert(new_data, "m_equip")
				end
				if i ~= 1 and new_data.equipped then
					table.insert(new_data, "m_move")
				end
				if not crafted.modded and managers.blackmarket:can_modify_mask(i) and i ~= 1 then
					table.insert(new_data, "m_mod")
				end
				if i ~= 1 then
					table.insert(new_data, "m_preview")
				end
			end
			if i ~= 1 then
				if 0 < managers.money:get_mask_sell_value(new_data.name, new_data.global_value) then
					table.insert(new_data, "m_sell")
				else
					table.insert(new_data, "m_remove")
				end
				if not is_win32 or not managers.menu:is_pc_controller() then
				end
			end
		end
		if crafted.modded then
			new_data.mini_icons = {}
			local color_1 = tweak_data.blackmarket.mask_colors[crafted.blueprint.color_a.id].color
			local color_2 = tweak_data.blackmarket.mask_colors[crafted.blueprint.color_b.id].color
			table.insert(new_data.mini_icons, {
				texture = false,
				w = 16,
				h = 16,
				right = 0,
				bottom = 0,
				layer = 1,
				color = color_2
			})
			table.insert(new_data.mini_icons, {
				texture = false,
				w = 16,
				h = 16,
				right = 18,
				bottom = 0,
				layer = 1,
				color = color_1
			})
			if locked_parts.color then
				local texture = self:get_lock_icon({
					global_value = locked_parts.color
				})
				table.insert(new_data.mini_icons, {
					texture = texture,
					w = 32,
					h = 32,
					right = 2,
					bottom = -5,
					layer = 2,
					color = tweak_data.screen_colors.important_1
				})
			end
			local pattern = crafted.blueprint.pattern.id
			if pattern == "solidfirst" or pattern == "solidsecond" then
			else
				local material_id = crafted.blueprint.material.id
				guis_catalog = "guis/"
				local bundle_folder = tweak_data.blackmarket.materials[material_id] and tweak_data.blackmarket.materials[material_id].texture_bundle_folder
				if bundle_folder then
					guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
				end
				local right = -3
				local bottom = 38 - (NOT_WIN_32 and 20 or 10)
				local w = 42
				local h = 42
				table.insert(new_data.mini_icons, {
					texture = guis_catalog .. "textures/pd2/blackmarket/icons/materials/" .. material_id,
					right = right,
					bottom = bottom,
					w = w,
					h = h,
					layer = 1,
					stream = true
				})
				if locked_parts.material then
					local texture = self:get_lock_icon({
						global_value = locked_parts.material
					})
					table.insert(new_data.mini_icons, {
						texture = texture,
						w = 32,
						h = 32,
						right = right + (w - 32) / 2,
						bottom = bottom + (h - 32) / 2,
						layer = 2,
						color = tweak_data.screen_colors.important_1
					})
				end
			end
			do
				local right = -3
				local bottom = math.round(mini_icon_helper - 6 - 6 - 42)
				local w = 42
				local h = 42
				table.insert(new_data.mini_icons, {
					texture = tweak_data.blackmarket.textures[pattern].texture,
					right = right,
					bottom = bottom,
					w = h,
					h = w,
					layer = 1,
					stream = true,
					render_template = Idstring("VertexColorTexturedPatterns")
				})
				if locked_parts.pattern then
					local texture = self:get_lock_icon({
						global_value = locked_parts.pattern
					})
					table.insert(new_data.mini_icons, {
						texture = texture,
						w = 32,
						h = 32,
						right = right + (w - 32) / 2,
						bottom = bottom + (h - 32) / 2,
						layer = 2,
						color = tweak_data.screen_colors.important_1
					})
				end
			end
			new_data.mini_icons.borders = true
		elseif i ~= 1 and managers.blackmarket:can_modify_mask(i) and managers.blackmarket:got_new_drop("normal", "mask_mods", crafted.mask_id) then
			new_data.mini_icons = new_data.mini_icons or {}
			table.insert(new_data.mini_icons, {
				name = "new_drop",
				texture = "guis/textures/pd2/blackmarket/inv_newdrop",
				right = 0,
				top = 0,
				layer = 1,
				w = 16,
				h = 16,
				stream = false,
				visible = true
			})
			new_data.new_drop_data = {}
		end
		data[index] = new_data
	end
	local can_buy_masks = true
	for i = 1, max_items do
		if not data[i] then
			index = i + start_crafted_item - 1
			can_buy_masks = managers.blackmarket:is_mask_slot_unlocked(i)
			new_data = {}
			if can_buy_masks then
				new_data.name = "bm_menu_btn_buy_new_mask"
				new_data.name_localized = managers.localization:text("bm_menu_empty_mask_slot")
				new_data.mid_text = {}
				new_data.mid_text.noselected_text = new_data.name_localized
				new_data.mid_text.noselected_color = tweak_data.screen_colors.button_stage_3
				if not currently_holding or not new_data.mid_text.noselected_text then
				end
				new_data.mid_text.selected_text = managers.localization:text("bm_menu_btn_buy_new_mask")
				new_data.mid_text.selected_color = currently_holding and new_data.mid_text.noselected_color or tweak_data.screen_colors.button_stage_2
				new_data.empty_slot = true
				new_data.category = "masks"
				new_data.slot = index
				new_data.unlocked = true
				new_data.equipped = false
				new_data.num_backs = 0
				new_data.cannot_buy = not can_buy_masks
				if currently_holding then
					if i ~= 1 then
						new_data.selected_text = managers.localization:to_upper_text("bm_menu_btn_place_mask")
					end
					if i ~= 1 then
						table.insert(new_data, "m_place")
					end
					table.insert(new_data, "i_stop_move")
				else
					table.insert(new_data, "em_buy")
				end
				if index ~= 1 and managers.blackmarket:got_new_drop(nil, "mask_buy", nil) then
					new_data.mini_icons = new_data.mini_icons or {}
					table.insert(new_data.mini_icons, {
						name = "new_drop",
						texture = "guis/textures/pd2/blackmarket/inv_newdrop",
						right = 0,
						top = 0,
						layer = 1,
						w = 16,
						h = 16,
						stream = false,
						visible = false
					})
					new_data.new_drop_data = {}
				end
			else
				new_data.name = "bm_menu_btn_buy_mask_slot"
				new_data.name_localized = managers.localization:text("bm_menu_locked_mask_slot")
				new_data.empty_slot = true
				new_data.category = "masks"
				new_data.slot = index
				new_data.unlocked = true
				new_data.equipped = false
				new_data.num_backs = 0
				new_data.lock_texture = "guis/textures/pd2/blackmarket/money_lock"
				new_data.lock_color = tweak_data.screen_colors.button_stage_3
				new_data.lock_shape = {
					w = 32,
					h = 32,
					x = 0,
					y = -32
				}
				new_data.locked_slot = true
				new_data.dlc_locked = managers.experience:cash_string(managers.money:get_buy_mask_slot_price())
				new_data.mid_text = {}
				new_data.mid_text.noselected_text = new_data.name_localized
				new_data.mid_text.noselected_color = tweak_data.screen_colors.button_stage_3
				new_data.mid_text.is_lock_same_color = true
				if currently_holding then
					new_data.mid_text.selected_text = new_data.mid_text.noselected_text
					new_data.mid_text.selected_color = new_data.mid_text.noselected_color
					table.insert(new_data, "i_stop_move")
				elseif managers.money:can_afford_buy_mask_slot() then
					new_data.mid_text.selected_text = managers.localization:text("bm_menu_btn_buy_mask_slot")
					new_data.mid_text.selected_color = tweak_data.screen_colors.button_stage_2
					table.insert(new_data, "em_unlock")
				else
					new_data.mid_text.selected_text = managers.localization:text("bm_menu_cannot_buy_mask_slot")
					new_data.mid_text.selected_color = tweak_data.screen_colors.important_1
					new_data.dlc_locked = new_data.dlc_locked .. "  " .. managers.localization:to_upper_text("bm_menu_cannot_buy_mask_slot")
					new_data.mid_text.lock_noselected_color = tweak_data.screen_colors.important_1
					new_data.cannot_buy = true
				end
			end
			data[i] = new_data
		end
	end
end

function BlackMarketGui:populate_mods(data)
	local new_data = {}
	local default_mod = data.on_create_data.default_mod
	local global_values = managers.blackmarket:get_crafted_category(data.prev_node_data.category)[data.prev_node_data.slot].global_values or {}
	local gvs = {}
	local mod_t = {}
	local num_steps = #data.on_create_data
	local achievement_tracker = tweak_data.achievement.weapon_part_tracker
	local guis_catalog = "guis/"
	for index, mod_t in ipairs(data.on_create_data) do
		local mod_name = mod_t[1]
		local mod_default = mod_t[2]
		local mod_global_value = mod_t[3] or "normal"
		guis_catalog = "guis/"
		local bundle_folder = tweak_data.blackmarket.weapon_mods[mod_name] and tweak_data.blackmarket.weapon_mods[mod_name].texture_bundle_folder
		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end
		new_data = {}
		new_data.name = mod_name or data.prev_node_data.name
		if not mod_name or not managers.weapon_factory:get_part_name_by_part_id(mod_name) then
		end
		new_data.name_localized = managers.weapon_factory:get_part_name_by_part_id(mod_name) or managers.localization:text("bm_menu_no_mod")
		new_data.category = data.category or data.prev_node_data and data.prev_node_data.category
		new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/mods/" .. new_data.name
		new_data.slot = data.slot or data.prev_node_data and data.prev_node_data.slot
		new_data.global_value = mod_global_value
		new_data.unlocked = mod_default or managers.blackmarket:get_item_amount(new_data.global_value, "weapon_mods", new_data.name, true)
		new_data.equipped = false
		new_data.stream = true
		new_data.default_mod = default_mod
		new_data.is_internal = tweak_data.weapon.factory:is_part_internal(new_data.name)
		new_data.free_of_charge = tweak_data.blackmarket.weapon_mods[mod_name] and tweak_data.blackmarket.weapon_mods[mod_name].is_a_unlockable
		new_data.unlock_tracker = achievement_tracker[new_data.name] or false
		if tweak_data.lootdrop.global_values[mod_global_value] and tweak_data.lootdrop.global_values[mod_global_value].dlc and not tweak_data.dlc[mod_global_value].free and not managers.dlc:has_dlc(mod_global_value) then
			new_data.unlocked = -math.abs(new_data.unlocked)
			new_data.unlocked = new_data.unlocked ~= 0 and new_data.unlocked or false
			new_data.lock_texture = self:get_lock_icon(new_data)
			new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
		end
		local weapon_id = managers.blackmarket:get_crafted_category(new_data.category)[new_data.slot].weapon_id
		new_data.price = managers.money:get_weapon_modify_price(weapon_id, new_data.name, new_data.global_value)
		new_data.can_afford = managers.money:can_afford_weapon_modification(weapon_id, new_data.name, new_data.global_value)
		local font, font_size
		local no_upper = false
		if not new_data.lock_texture and (not new_data.unlocked or new_data.unlocked == 0) then
			local selected_text, noselected_text
			if not new_data.dlc_locked and new_data.unlock_tracker then
				local text_id = "bm_menu_no_items"
				local progress = ""
				local stat = new_data.unlock_tracker.stat or false
				local max_progress = new_data.unlock_tracker.max_progress or 0
				local award = new_data.unlock_tracker.award or false
				if new_data.unlock_tracker.text_id then
					if max_progress > 0 and stat then
						local progress_left = max_progress - (managers.achievment:get_stat(stat) or 0)
						if progress_left > 0 then
							progress = tostring(progress_left)
							text_id = new_data.unlock_tracker.text_id
							font = small_font
							font_size = small_font_size
							no_upper = true
						end
					elseif award then
						local achievement = managers.achievment:get_info(award)
						text_id = new_data.unlock_tracker.text_id
						font = small_font
						font_size = small_font_size
						no_upper = true
					end
					selected_text = managers.localization:text(text_id, {progress = progress})
				end
			end
			selected_text = selected_text or managers.localization:text("bm_menu_no_items")
			noselected_text = selected_text
			new_data.mid_text = {}
			new_data.mid_text.selected_text = selected_text
			new_data.mid_text.selected_color = tweak_data.screen_colors.text
			new_data.mid_text.noselected_text = noselected_text
			new_data.mid_text.noselected_color = tweak_data.screen_colors.text
			new_data.mid_text.vertical = "center"
			new_data.mid_text.font = font
			new_data.mid_text.font_size = font_size
			new_data.mid_text.no_upper = no_upper
			new_data.lock_texture = true
		end
		if mod_name then
			local forbid = managers.blackmarket:can_modify_weapon(new_data.category, new_data.slot, new_data.name)
			if forbid then
				if type(new_data.unlocked) == "number" then
					new_data.unlocked = -math.abs(new_data.unlocked)
				else
					new_data.unlocked = false
				end
				new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_incompatible")
				new_data.mid_text = nil
				new_data.conflict = managers.localization:text("bm_menu_" .. tostring(tweak_data.weapon.factory.parts[forbid] and tweak_data.weapon.factory.parts[forbid].type or forbid))
			end
			local weapon = managers.blackmarket:get_crafted_category_slot(data.prev_node_data.category, data.prev_node_data.slot) or {}
			local gadget
			local mod_type = tweak_data.weapon.factory.parts[new_data.name].type
			local sub_type = tweak_data.weapon.factory.parts[new_data.name].sub_type
			local is_auto = weapon and tweak_data.weapon[weapon.weapon_id] and tweak_data.weapon[weapon.weapon_id].FIRE_MODE == "auto"
			if mod_type == "gadget" then
				gadget = sub_type
			end
			local silencer = sub_type == "silencer" and true
			local texture = managers.menu_component:get_texture_from_mod_type(mod_type, sub_type, gadget, silencer, is_auto)
			new_data.desc_mini_icons = {}
			if DB:has(Idstring("texture"), texture) then
				table.insert(new_data.desc_mini_icons, {
					texture = texture,
					right = 0,
					bottom = 0,
					w = 16,
					h = 16
				})
			end
			local is_gadget = false
			if not new_data.conflict and new_data.unlocked and not is_gadget and not new_data.dlc_locked then
				new_data.comparision_data = managers.blackmarket:get_weapon_stats_with_mod(new_data.category, new_data.slot, mod_name)
			end
			if managers.blackmarket:got_new_drop(mod_global_value, "weapon_mods", mod_name) then
				new_data.mini_icons = new_data.mini_icons or {}
				table.insert(new_data.mini_icons, {
					name = "new_drop",
					texture = "guis/textures/pd2/blackmarket/inv_newdrop",
					right = 0,
					top = 0,
					layer = 1,
					w = 16,
					h = 16,
					stream = false
				})
				new_data.new_drop_data = {
					new_data.global_value or "normal",
					"weapon_mods",
					mod_name
				}
			end
		end
		if mod_name and new_data.unlocked then
			if type(new_data.unlocked) ~= "number" or new_data.unlocked > 0 then
				if new_data.can_afford then
					table.insert(new_data, "wm_buy")
				end
				table.insert(new_data, "wm_preview")
				if not new_data.is_internal then
					table.insert(new_data, "wm_preview_mod")
				end
			else
				table.insert(new_data, "wm_preview")
			end
		end
		data[index] = new_data
	end
	for i = 1, math.max(math.ceil(num_steps / 3), 3) * 3 do
		if not data[i] then
			new_data = {}
			new_data.name = "empty"
			new_data.name_localized = ""
			new_data.category = data.category
			new_data.slot = i
			new_data.unlocked = true
			new_data.equipped = false
			data[i] = new_data
		end
	end
	local weapon_blueprint = managers.blackmarket:get_weapon_blueprint(data.prev_node_data.category, data.prev_node_data.slot) or {}
	local equipped
	for i, mod in ipairs(data) do
		for _, weapon_mod in ipairs(weapon_blueprint) do
			if mod.name == weapon_mod and (not global_values[weapon_mod] or global_values[weapon_mod] == data[i].global_value) then
				equipped = i
			else
			end
		end
	end
	if equipped then
		data[equipped].equipped = true
		data[equipped].unlocked = data[equipped].unlocked or true
		data[equipped].mid_text = nil
		data[equipped].lock_texture = nil
		for i = 1, #data[equipped] do
			table.remove(data[equipped], 1)
		end
		data[equipped].price = 0
		data[equipped].can_afford = true
		table.insert(data[equipped], "wm_remove_buy")
		if not data[equipped].is_internal then
			table.insert(data[equipped], "wm_remove_preview_mod")
			table.insert(data[equipped], "wm_remove_preview")
		else
			table.insert(data[equipped], "wm_preview")
		end
		local factory = tweak_data.weapon.factory.parts[data[equipped].name]
		if not data[equipped].conflict then
			if data[equipped].default_mod then
				data[equipped].comparision_data = managers.blackmarket:get_weapon_stats_with_mod(data[equipped].category, data[equipped].slot, data[equipped].default_mod)
			else
				data[equipped].comparision_data = managers.blackmarket:get_weapon_stats_without_mod(data[equipped].category, data[equipped].slot, data[equipped].name)
			end
		end
	end
end

function BlackMarketGui:populate_weapon_cosmetics(data)
	local crafted = managers.blackmarket:get_crafted_category(data.category)[data.prev_node_data and data.prev_node_data.slot]
	local cosmetics_data = tweak_data.blackmarket.weapon_skins
	local my_cd, new_data, bitmap_texture, bg_texture = nil
	local inventory_tradable = managers.blackmarket:get_inventory_tradable()
	local cosmetics_instances = data.on_create_data.instances or {}
	local all_cosmetics = data.on_create_data.cosmetics or {}
	local cosmetic_data, cosmetic_id = nil
	local index_i = 1
	cosmetic_id = tweak_data.blackmarket.weapon_color_default
	cosmetic_data = cosmetics_data[cosmetic_id]
	local unlocked = true
	local equipped = false
	local quality = "good"
	local color_index = 1
	local pattern_scale = tweak_data.blackmarket.weapon_color_pattern_scale_default
	local color_texture = nil
	local equipped_cosmetic_id = crafted and crafted.cosmetics and crafted.cosmetics.id
	local equipped_tweak = cosmetics_data[equipped_cosmetic_id]

	data[index_i] = new_data

	for _, instance_id in ipairs(cosmetics_instances) do
		cosmetic_id = inventory_tradable[instance_id].entry
		my_cd = cosmetics_data[cosmetic_id]
		local quality = inventory_tradable[instance_id].quality
		local bonus = inventory_tradable[instance_id].bonus
		local equipped = crafted and crafted.cosmetics and crafted.cosmetics.instance_id == instance_id
		new_data = make_cosmetic_data(data, cosmetic_id, true, quality, bonus, equipped)
		new_data.name = instance_id

		if new_data.cosmetic_bonus then
			local bonuses = tweak_data.economy:get_bonus_icons(my_cd.bonus)
			local x = 0

			for _, texture_path in ipairs(bonuses) do
				new_data.mini_icons = new_data.mini_icons or {}

				table.insert(new_data.mini_icons, {
					name = "has_bonus",
					h = 16,
					layer = 1,
					w = 16,
					stream = false,
					bottom = 0,
					texture = texture_path,
					right = x
				})

				x = x + 17
			end
		end

		data[index_i] = new_data
		index_i = index_i + 1
	end

	for _, cosm_data in ipairs(all_cosmetics) do
		cosmetic_id = cosm_data.id
		cosmetic_data = cosm_data.data
		my_cd = cosmetics_data[cosmetic_id]

		if not my_cd.is_template then
			local global_value = my_cd and my_cd.global_value or "normal"
			local unlocked = managers.blackmarket:get_item_amount(global_value, "weapon_skins", cosmetic_id, true) > 0
			local equipped = crafted and crafted.cosmetics and crafted.cosmetics.instance_id == cosmetic_id
			new_data = make_cosmetic_data(data, cosmetic_id, unlocked, "mint", nil, equipped)
			data[index_i] = new_data
			index_i = index_i + 1
		end
	end

	local total_cosmetics = #cosmetics_instances + #all_cosmetics
	total_cosmetics = total_cosmetics + 1
	local new_data = nil
	local max_items = self:calc_max_items(total_cosmetics, data.override_slots or WEAPON_MODS_SLOTS)

	for i = 1, max_items do
		if not data[i] then
			new_data = {
				name = "empty",
				name_localized = "",
				category = data.category,
				slot = i,
				unlocked = true,
				equipped = false
			}
			data[i] = new_data
		end
	end
end

function BlackMarketGui:populate_buy_weapon(data)
	local new_data = {}
	local guis_catalog = "guis/"
	for i = 1, #data.on_create_data do
		local weapon_data = data.on_create_data[i]
		guis_catalog = "guis/"
		local bundle_folder = tweak_data.weapon[data.on_create_data[i].weapon_id] and tweak_data.weapon[data.on_create_data[i].weapon_id].texture_bundle_folder
		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end
		new_data = {}
		new_data.name = weapon_data.weapon_id
		new_data.name_localized = managers.weapon_factory:get_weapon_name_by_factory_id(weapon_data.factory_id)
		new_data.category = data.category
		new_data.slot = data.prev_node_data and data.prev_node_data.slot
		new_data.unlocked = weapon_data.unlocked
		new_data.level = not new_data.unlocked and weapon_data.level
		new_data.skill_based = weapon_data.skill_based
		new_data.equipped = false
		local texture_name = tweak_data.weapon[new_data.name].texture_name or tostring(new_data.name)
		new_data.bitmap_texture = guis_catalog .. "textures/pd2/blackmarket/icons/weapons/" .. texture_name
		new_data.comparision_data = deep_clone(tweak_data.weapon[new_data.name].stats)
		new_data.skill_name = weapon_data.skill_based and "bm_menu_skill_locked_" .. new_data.name
		new_data.can_afford = managers.money:can_afford_weapon(new_data.name)
		new_data.price = managers.money:get_weapon_price_modified(new_data.name)
		new_data.not_moddable = true
		new_data.global_value = tweak_data.weapon[new_data.name] and tweak_data.weapon[new_data.name].global_value or "normal"
		new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or nil
		new_data.lock_texture = self:get_lock_icon(new_data)
		if new_data.unlocked and not new_data.can_afford then
			new_data.mid_text = {}
			new_data.mid_text.selected_text = managers.localization:text("bm_menu_not_enough_cash")
			new_data.mid_text.selected_color = tweak_data.screen_colors.text
			new_data.mid_text.noselected_text = new_data.mid_text.selected_text
			new_data.mid_text.noselected_color = tweak_data.screen_colors.text
			new_data.mid_text.vertical = "center"
		end
		if new_data.unlocked then
			if new_data.can_afford then
				table.insert(new_data, "bw_buy")
			end
		elseif Global.dlc_manager.all_dlc_data[new_data.global_value] and Global.dlc_manager.all_dlc_data[new_data.global_value].app_id and not Global.dlc_manager.all_dlc_data[new_data.global_value].external and not managers.dlc:is_dlc_unlocked(new_data.global_value) then
			table.insert(new_data, "bw_buy_dlc")
		end
		table.insert(new_data, "bw_preview")
		table.insert(new_data, "bw_available_mods")
		local new_weapon = managers.blackmarket:got_new_drop(data.category, "weapon_buy", new_data.name)
		local got_mods = managers.blackmarket:got_new_drop("normal", new_data.category, data.on_create_data[i].factory_id)
		if new_weapon or got_mods then
			new_data.mini_icons = new_data.mini_icons or {}
			table.insert(new_data.mini_icons, {
				name = "new_drop",
				texture = "guis/textures/pd2/blackmarket/inv_newdrop",
				right = 0,
				top = 0,
				layer = 1,
				w = 16,
				h = 16,
				stream = false
			})
			new_data.new_drop_data = {
				"normal",
				data.category,
				new_data.name
			}
			if got_mods then
				new_data.new_drop_data = {}
			end
		end
		data[i] = new_data
	end
	for i = 1, math.ceil(#data.on_create_data / 3) * 3 do
		if not data[i] then
			new_data = {}
			new_data.name = "empty"
			new_data.name_localized = ""
			new_data.category = data.category
			new_data.slot = i
			new_data.unlocked = true
			new_data.equipped = false
			data[i] = new_data
		end
	end
end

function BlackMarketGui:_cleanup_blackmarket()
	local blackmarket_tweak_data = tweak_data.blackmarket
	local blackmarket_inventory = Global.blackmarket_manager.inventory
	for global_value, gv_table in pairs(blackmarket_inventory) do
		for type_id, type_table in pairs(gv_table) do
			if type_id ~= "weapon_mods" then
				local item_data = blackmarket_tweak_data[type_id]
				if item_data then
					for item_id, item_amount in pairs(type_table) do
						if not item_data[item_id] then
							print("BlackMarketGui:_cleanup_blackmarket: Missing '" .. item_id .. "' in BlackMarketTweakData. Removing it from stash!")
							type_table[item_id] = nil
						end
					end
				end
			else
			end
		end
	end
end

function BlackMarketGui:_start_page_data()
	local data = {}
	table.insert(data, {
		name = "bm_menu_primaries",
		category = "primaries",
		on_create_func_name = "populate_primaries",
		identifier = self.identifiers.weapon,
		override_slots = {3, 3}
	})
	table.insert(data, {
		name = "bm_menu_secondaries",
		category = "secondaries",
		on_create_func_name = "populate_secondaries",
		identifier = self.identifiers.weapon,
		override_slots = {3, 3}
	})
	table.insert(data, {
		name = "bm_menu_melee_weapons",
		category = "melee_weapons",
		on_create_func_name = "populate_melee_weapons",
		allow_preview = true,
		override_slots = {3, 3},
		identifier = self.identifiers.melee_weapon
	})
	table.insert(data, {
		name = "bm_menu_armors",
		category = "armors",
		on_create_func_name = "populate_armors",
		override_slots = {3, 3},
		identifier = self.identifiers.armor
	})
	table.insert(data, {
		name = "bm_menu_deployables",
		category = "deployables",
		on_create_func_name = "populate_deployables",
		override_slots = {4, 2},
		identifier = self.identifiers.deployable
	})
	table.insert(data, {
		name = "bm_menu_masks",
		category = "masks",
		on_create_func_name = "populate_masks",
		identifier = self.identifiers.mask,
		override_slots = {3, 3},
		start_crafted_item = 1
	})
	table.insert(data, {
		name = "bm_menu_player_styles",
		category = "player_styles",
		on_create_func_name = "populate_player_styles",
		override_slots = {4, 3},
		identifier = self.identifiers.player_style
	})
	table.insert(data, {
		name = "bm_menu_gloves",
		category = "gloves",
		on_create_func_name = "populate_gloves",
		override_slots = {4, 3},
		identifier = self.identifiers.gloves
	})
	if not managers.network:session() then
		table.insert(data, {
			name = "bm_menu_characters",
			category = "characters",
			on_create_func_name = "populate_characters",
			override_slots = {5, 3},
			identifier = self.identifiers.character
		})
	end
	data.topic_id = "menu_inventory"
	self:_cleanup_blackmarket()
	return data
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
				new_data.bitmap_texture = "guis/dlcs/trd/textures/pd2/blackmarket/icons/player_styles/none"	
			end

			local is_dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].dlc and not managers.dlc:is_dlc_unlocked(new_data.global_value)

			if is_dlc_locked then
				new_data.unlocked = false
				new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_dlc")
				new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
			else
				new_data.unlocked = true
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

function BlackMarketGui:populate_suit_variations(data)
	for i = 1, #data do
		data[i] = nil
	end

	local player_style = data.prev_node_data.name
	local player_style_data = tweak_data.blackmarket.player_styles[player_style]
	local material_variations = player_style_data and player_style_data.material_variations or {}
	local mannequin_suit_variation = managers.menu_scene and managers.menu_scene:get_suit_variation() or "default"
	local equipped_suit_variation = data.suit_variation or managers.blackmarket:get_suit_variation(player_style)
	local new_data, allow_preview, guis_catalog, bundle_folder, texture_path, suit_variation, suit_variation_data = nil
	local sort_data = managers.blackmarket:get_all_suit_variations(player_style)
	local max_items = self:calc_max_items(#sort_data, data.override_slots)

	for i = 1, max_items do
		new_data = {
			comparision_data = nil,
			category = "suit_variation",
			slot = i
		}
		suit_variation = sort_data[i]

		if suit_variation then
			allow_preview = true
			suit_variation_data = material_variations[suit_variation]
			guis_catalog = "guis/"
			bundle_folder = suit_variation_data and suit_variation_data.texture_bundle_folder or player_style_data.texture_bundle_folder

			if bundle_folder then
				guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
			end

			new_data.name = suit_variation
			new_data.name_localized = suit_variation_data and managers.localization:text(suit_variation_data.name_id) or managers.localization:text("menu_default")
			new_data.global_value = suit_variation_data and suit_variation_data.global_value or "normal"
			new_data.unlocked = managers.blackmarket:suit_variation_unlocked(player_style, suit_variation)
			new_data.equipped = equipped_suit_variation == suit_variation
			new_data.lock_color = self:get_lock_color(new_data)
			texture_path = guis_catalog .. "textures/pd2/blackmarket/icons/player_styles/" .. player_style

			if suit_variation_data then
				texture_path = texture_path .. "_" .. suit_variation or texture_path
			end

			new_data.bitmap_texture = texture_path
			local is_dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].dlc and not managers.dlc:is_dlc_unlocked(new_data.global_value)

			if is_dlc_locked then
				new_data.unlocked = false
				new_data.lock_texture = self:get_lock_icon(new_data, "guis/textures/pd2/lock_dlc")
				new_data.dlc_locked = tweak_data.lootdrop.global_values[new_data.global_value] and tweak_data.lootdrop.global_values[new_data.global_value].unlock_id or "bm_menu_dlc_locked"
			else
				new_data.unlocked = true
			end

			if new_data.unlocked then
				if not new_data.equipped then
					table.insert(new_data, "trd_mod_equip")
				end
			else
				new_data.bitmap_locked_color = Color.white
				new_data.bitmap_locked_blend_mode = "normal"
				new_data.bitmap_locked_alpha = 0.4
				local dlc_data = Global.dlc_manager.all_dlc_data[new_data.global_value]

				if dlc_data and dlc_data.app_id and not dlc_data.external and not managers.dlc:is_dlc_unlocked(new_data.global_value) then
					table.insert(new_data, "bw_buy_dlc")
				end
			end

			if allow_preview and mannequin_suit_variation ~= suit_variation then
				table.insert(new_data, "trd_mod_preview")
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

function BlackMarketGui:populate_weapon_colors(data)
	--[[if equipped_tweak and equipped_tweak.is_a_color_skin then
		cosmetic_id = equipped_cosmetic_id
		cosmetic_data = equipped_tweak
		quality = crafted.cosmetics.quality
		color_index = crafted.cosmetics.color_index
		pattern_scale = crafted.cosmetics.pattern_scale
		equipped = true
		local dlc = cosmetic_data.dlc or managers.dlc:global_value_to_dlc(cosmetic_data.global_value)
		local global_value = cosmetic_data.global_value or managers.dlc:dlc_to_global_value(dlc)
		local dlc_unlocked = not dlc or managers.dlc:is_dlc_unlocked(dlc)
		local have_color = managers.blackmarket:has_item(global_value, "weapon_skins", equipped_cosmetic_id)
		unlocked = dlc_unlocked and have_color
		local guis_catalog = "guis/"
		local bundle_folder = equipped_tweak.texture_bundle_folder

		if bundle_folder then
			guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
		end

		color_texture = guis_catalog .. "textures/pd2/blackmarket/icons/weapon_color/" .. cosmetic_id
	end

	local global_value = cosmetic_data.global_value or "normal"
	new_data = make_cosmetic_data(data, cosmetic_id, unlocked, quality, nil, equipped)
	new_data.akimbo_gui_data = nil
	new_data.name_localized = managers.localization:text("bm_menu_customizable_weapon_color")
	new_data.is_a_color_skin = true
	new_data.bitmap_texture = color_texture
	new_data.cosmetic_color_index = color_index
	new_data.cosmetic_pattern_scale = pattern_scale
	new_data.mid_text_no_change_alpha = true
	new_data.mid_text = {
		selected_text = new_data.name_localized,
		selected_color = tweak_data.screen_colors.text
	}
	new_data.mid_text.noselected_text = new_data.mid_text.selected_text
	new_data.mid_text.noselected_color = tweak_data.screen_colors.text
	new_data.mid_text.font = small_font
	new_data.mid_text.font_size = small_font_size
	new_data.mid_text.vertical = "center"

	if equipped then
		table.insert(new_data, "wcs_customize_color")
	end

	local equip_index = table.get_vector_index(new_data, "wcc_equip")

	if equip_index then
		new_data[equip_index] = "wcs_equip"
	end]]--

	local crafted = managers.blackmarket:get_crafted_category(data.category)[data.prev_node_data and data.prev_node_data.slot]
	local cosmetics_data = tweak_data.blackmarket.weapon_skins
	local my_cd, new_data, bitmap_texture, bg_texture = nil
	local inventory_tradable = managers.blackmarket:get_inventory_tradable()
	local cosmetics_instances = data.on_create_data.instances or {}
	local all_cosmetics = data.on_create_data.cosmetics or {}
	local cosmetic_data, cosmetic_id = nil
	local index_i = 1
	cosmetic_id = tweak_data.blackmarket.weapon_color_default
	cosmetic_data = cosmetics_data[cosmetic_id]
	local unlocked = true
	local equipped = false
	local quality = self._color_wear or "good"
	local color_index = self._color_index or 1
	local pattern_scale = self._color_pattern_scale or tweak_data.blackmarket.weapon_color_pattern_scale_default
	local color_texture = nil
	local equipped_cosmetic_id = crafted and crafted.cosmetics and crafted.cosmetics.id
	local equipped_tweak = cosmetics_data[equipped_cosmetic_id]

	data[index_i] = new_data

	for _, cosm_data in ipairs(all_cosmetics) do
		cosmetic_id = cosm_data.id
		cosmetic_data = cosm_data.data
		my_cd = cosmetics_data[cosmetic_id]

		if not my_cd.is_template then
			local global_value = my_cd and my_cd.global_value or "normal"
			local dlc = cosmetic_data.dlc or managers.dlc:global_value_to_dlc(cosmetic_data.global_value)
			local dlc_unlocked = not dlc or managers.dlc:is_dlc_unlocked(dlc)
			local unlocked = dlc_unlocked
			local equipped = crafted and crafted.cosmetics and crafted.cosmetics.instance_id == cosmetic_id
			new_data = make_cosmetic_data_color(data, cosmetic_id, unlocked, "mint", nil, equipped)
			new_data.is_a_color_skin = true
			new_data.cosmetic_color_index = color_index
			new_data.cosmetic_pattern_scale = pattern_scale
			new_data.cosmetic_quality = quality
			data[index_i] = new_data
			index_i = index_i + 1
		end
	end

	local total_cosmetics = #cosmetics_instances + #all_cosmetics
	total_cosmetics = total_cosmetics + 1
	local new_data = nil
	local max_items = self:calc_max_items(total_cosmetics, data.override_slots or WEAPON_MODS_SLOTS)

	for i = 1, max_items do
		if not data[i] then
			new_data = {
				name = "empty",
				name_localized = "",
				category = data.category,
				slot = i,
				unlocked = true,
				equipped = false
			}
			data[i] = new_data
		end
	end
end

function BlackMarketGui:choose_weapon_mods_callback(data)
	local dropable_mods = managers.blackmarket:get_dropable_mods_by_weapon_id(data.name, {
		category = data.category,
		slot = data.slot
	})
	local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(data.name)
	local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
	local mods = {}
	for i, d in pairs(dropable_mods) do
		mods[i] = d
	end
	local new_node_data = {}
	local sort_mods = {}
	for id, _ in pairs(mods) do
		table.insert(sort_mods, id)
	end
	table.sort(sort_mods, function(x, y)
		return x < y
	end)
	local cosmetic_instances = managers.blackmarket:get_cosmetics_instances_by_weapon_id(data.name)
	local all_cosmetics = managers.blackmarket:get_cosmetics_by_weapon_id(data.name)

	for id, data in pairs(all_cosmetics) do
		if managers.blackmarket:is_weapon_skin_tam(id) then
			all_cosmetics[id] = nil
		end
	end

	if table.size(all_cosmetics) > 0 then
		local all_cosmetics_sorted = {}

		for id, data in pairs(all_cosmetics) do
			if data.is_a_color_skin then
				table.insert(all_cosmetics_sorted, {
					id = id,
					data = data
				})
			end
		end

		local sort_table = {}

		local dlc_sort_table = {}

		for sort_number, weapon_color in ipairs(all_cosmetics_sorted) do
			tweak = tweak_data.blackmarket.weapon_skins[weapon_color.id]
			if tweak.dlc and dlc_sort_table[tweak.dlc] == nil then
				dlc_sort_table[tweak.dlc] = {
					sort_number = table.size(dlc_sort_table) + 1 + 500
				}
			end
			local dlc_sort_number = nil
			if tweak.dlc then
				dlc_sort_number = dlc_sort_table[tweak.dlc].sort_number
			end
			local global_value = weapon_color.data.global_value or "normal"
			local dlc = tweak.dlc or managers.dlc:global_value_to_dlc(global_value)
			local dlc_unlocked = not dlc or managers.dlc:is_dlc_unlocked(dlc)
			local unlocked = dlc_unlocked
			local achievement_locked = managers.dlc:is_content_achievement_locked("weapon_skin", weapon_color.id) or managers.dlc:is_content_achievement_milestone_locked("weapon_skin", weapon_color.id)
			local infamy_locked = managers.dlc:is_content_infamy_locked("weapon_skin", weapon_color.id)
			sort_table[weapon_color] = {
				unlocked = unlocked,
				locked_sort = tweak_data.gui:get_locked_sort_number(dlc, achievement_locked, infamy_locked),
				sort_number = dlc_sort_number or tweak.sort_number or 10000
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

		table.sort(all_cosmetics_sorted, sort_func)

		table.insert(new_node_data, {
			prev_node_data = data,
			on_create_func_name = "populate_weapon_colors",
			name = "weapon_colors",
			category = data.category,
			name_localized = managers.localization:text("bm_menu_weapon_colors"),
			on_create_data = {
				cosmetics = all_cosmetics_sorted
			},
			identifier = BlackMarketGui.identifiers.weapon_cosmetics,
			override_slots = WEAPON_MODS_SLOTS
		})
	end

	if table.size(all_cosmetics) > 0 then
		local inventory_tradable = managers.blackmarket:get_inventory_tradable()
		local td = tweak_data.blackmarket.weapon_skins
		local rtd = tweak_data.economy.rarities
		local x_td, y_td, x_rar, y_rar, x_quality, y_quality, weapon_skin_id = nil

		local function sort_func_instances(x, y)
			x_td = td[inventory_tradable[x].entry]
			y_td = td[inventory_tradable[y].entry]
			x_rar = rtd[x_td.rarity]
			y_rar = rtd[y_td.rarity]

			if x_rar.index ~= y_rar.index then
				return x_rar.index < y_rar.index
			end

			if inventory_tradable[x].entry ~= inventory_tradable[y].entry then
				return inventory_tradable[y].entry < inventory_tradable[x].entry
			end

			x_quality = tweak_data.economy.qualities[inventory_tradable[x].quality]
			y_quality = tweak_data.economy.qualities[inventory_tradable[y].quality]

			if x_quality.index ~= y_quality.index then
				return y_quality.index < x_quality.index
			end

			return y < x
		end

		local function sort_func_cosmetics(x, y)
			x_td = td[x.id]
			x_rar = rtd[x_td.rarity or "common"]
			y_td = td[y.id]
			y_rar = rtd[y_td.rarity or "common"]

			if x_rar.index ~= y_rar.index then
				return y_rar.index < x_rar.index
			end

			return y.id < x.id
		end

		table.sort(cosmetic_instances, sort_func_instances)

		for _, instance_id in ipairs(cosmetic_instances) do
			weapon_skin_id = inventory_tradable[instance_id].entry
			all_cosmetics[weapon_skin_id] = nil
		end

		local all_cosmetics_sorted = {}

		for id, data in pairs(all_cosmetics) do
			if not data.is_a_color_skin then
				table.insert(all_cosmetics_sorted, {
					id = id,
					data = data
				})
			end
		end

		table.sort(all_cosmetics_sorted, sort_func_cosmetics)
		table.insert(new_node_data, {
			name = "weapon_cosmetics",
			on_create_func_name = "populate_weapon_cosmetics",
			name_localized = managers.localization:text("bm_menu_weapon_cosmetics"),
			category = data.category,
			prev_node_data = data,
			on_create_data = {
				instances = cosmetic_instances,
				cosmetics = all_cosmetics_sorted
			},
			override_slots = WEAPON_MODS_SLOTS,
			identifier = BlackMarketGui.identifiers.weapon_cosmetic
		})
	end
	for i, id in ipairs(sort_mods) do
		do
			local my_mods = deep_clone(mods[id])
			local factory_id = managers.blackmarket:get_crafted_category(data.category)[data.slot].factory_id
			local default_blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
			local default_mod
			local ids_id = Idstring(id)
			for i, d_mod in ipairs(default_blueprint) do
				if Idstring(tweak_data.weapon.factory.parts[d_mod].type) == ids_id then
					default_mod = d_mod
				else
				end
			end
			local sort_td = tweak_data.blackmarket.weapon_mods
			local x_td, y_td, x_pc, y_pc
			table.sort(my_mods, function(x, y)
				x_td = sort_td[x[1]]
				y_td = sort_td[y[1]]
				x_pc = x_td.value or x_td.pc or x_td.pcs and x_td.pcs[1] or 10
				y_pc = y_td.value or y_td.pc or y_td.pcs and y_td.pcs[1] or 10
				x_pc = x_pc + (x[2] and tweak_data.lootdrop.global_values[x[2]].sort_number or 0)
				y_pc = y_pc + (y[2] and tweak_data.lootdrop.global_values[y[2]].sort_number or 0)
				return x_pc < y_pc or x_pc == y_pc and x[1] < y[1]
			end)
			local mod_data = {}
			for a = 1, #my_mods do
				table.insert(mod_data, {
					my_mods[a][1],
					false,
					my_mods[a][2]
				})
			end
			mod_data.default_mod = default_mod
			table.insert(new_node_data, {
				name = id,
				category = data.category,
				prev_node_data = data,
				name_localized = managers.localization:text("bm_menu_" .. id),
				on_create_func_name = "populate_mods",
				on_create_data = mod_data,
				identifier = self.identifiers.weapon_mod
			})
		end
	end
	new_node_data.topic_id = "bm_menu_blackmarket_title"
	new_node_data.topic_params = {
		item = data.name_localized
	}
	new_node_data.show_tabs = true
	new_node_data.open_callback_name = "set_equipped_comparision"
	new_node_data.open_callback_params = {
		category = data.category,
		slot = data.slot
	}
	new_node_data.blur_fade = self._data.blur_fade
	managers.menu:open_node(self._inception_node_name, {new_node_data})
end

function BlackMarketGui:choose_mod_type_callback(data)
	local mods = managers.blackmarket:get_dropable_mods_by_weapon_id(data.name)
	local new_node_data = {}
	local mods_list = {}
	for id, data in pairs(mods) do
		table.insert(mods_list, id)
	end
	local mod_data = {}
	for i = 1, math.max(1, math.ceil(#mods_list / 9)) do
		mod_data = {}
		for id = (i - 1) * 9 + 1, math.min(i * 9, #mods_list) do
			mod_data[mods_list[id]] = mods[mods_list[id]]
		end
		table.insert(new_node_data, {
			name = tostring(i),
			category = data.category,
			prev_node_data = data,
			name_localized = tostring(i),
			on_create_func_name = "populate_mod_types",
			on_create_data = mod_data,
			identifier = self.identifiers.weapon_mod
		})
	end
	new_node_data.topic_id = "bm_menu_blackmarket_title"
	new_node_data.topic_params = {
		item = data.name_localized
	}
	new_node_data.blur_fade = self._data.blur_fade
	managers.menu:open_node(self._inception_node_name, {new_node_data})
end

function BlackMarketGui:set_preferred_character_callback(data)
	managers.blackmarket:set_preferred_character(data.name)
	self:reload()
end

function BlackMarketGui:pickup_crafted_item_callback(data)
	managers.blackmarket:pickup_crafted_item(data.category, data.slot)
	self:reload()
end

function BlackMarketGui:place_crafted_item_callback(data)
	managers.blackmarket:place_crafted_item(data.category, data.slot)
	self:reload()
end

function BlackMarketGui:drop_hold_crafted_item_callback(data)
	managers.blackmarket:drop_hold_crafted_item()
	self:reload()
end

function BlackMarketGui:rename_item_with_gamepad_callback(data)
	print("[BlackMarketGui:rename_item_with_gamepad_callback]", inspect(data))
	if is_win32 then
		local desc = managers.localization:text("menu_bm_rename_text_input_desc", {
			item = utf8.to_upper(data.name_localized),
			slot = data.slot,
			category = managers.localization:to_upper_text("bm_menu_" .. data.category)
		})
		local custom_name = managers.blackmarket:get_crafted_custom_name(data.category, data.slot) or ""
		local id = Idstring("BlackMarketGui:rename_item_with_gamepad_callback")
		local key = id:key()
		local params = {
			nil,
			nil,
			desc,
			tweak_data:get_raw_value("gui", "rename_max_letters") or 20,
			custom_name
		}
		if managers.network.account:show_gamepad_text_input(key, callback(self, self, "_rename_gamepad_callback"), params) then
			self._renaming_item = {
				category = data.category,
				slot = data.slot,
				custom_name = custom_name
			}
			self._rename_clbk_id = key
		elseif Steam:overlay_enabled() then
			managers.menu:show_requires_big_picture()
		else
			managers.menu:show_enable_steam_overlay()
		end
	end
end

function BlackMarketGui:_rename_gamepad_callback(submitted, submitted_text)
	print("BlackMarketGui:_rename_gamepad_callback", "submitted", submitted, "submitted_text", submitted_text)
	self._rename_clbk_id = nil
	if not submitted then
		self:_cancel_rename_item()
	elseif self._renaming_item then
		self._renaming_item.custom_name = submitted_text
		self:_stop_rename_item()
	end
end

function BlackMarketGui:equip_weapon_callback(data)
	managers.blackmarket:equip_weapon(data.category, data.slot)
	self:reload()
end

function BlackMarketGui:equip_armor_callback(data)
	managers.blackmarket:equip_armor(data.name)
	self:reload()
end

function BlackMarketGui:equip_mask_callback(data)
	managers.blackmarket:equip_mask(data.slot)
	self:reload()
end

function BlackMarketGui:open_inventory_list_node()
	managers.menu:open_node("inventory_list_node", {})
end

function BlackMarketGui:_open_preview_node()
	managers.menu:open_node(self._preview_node_name, {})
end

function BlackMarketGui:_preview_weapon(data)
	managers.blackmarket:view_weapon(data.category, data.slot, callback(self, self, "_open_preview_node"))
end

function BlackMarketGui:preview_weapon_callback(data)
	self:_preview_weapon(data)
end

function BlackMarketGui:_preview_mask(data)
	managers.blackmarket:view_mask(data.slot)
	managers.menu:open_node("blackmarket_preview_mask_node", {})
end

function BlackMarketGui:preview_mask_callback(data)
	self:_preview_mask(data)
end

function BlackMarketGui:sell_item_callback(data)
	print("sell_item_callback", inspect(data))
	local params = {}
	params.name = data.name_localized or data.name
	params.category = data.category
	params.slot = data.slot
	params.money = managers.experience:cash_string(managers.money:get_weapon_slot_sell_value(params.category, params.slot))
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_sell_weapon_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_sell(params)
end

function BlackMarketGui:sell_stashed_mask_callback(data)
	local blueprint = {}
	blueprint.color = {id = "nothing", global_value = "normal"}
	blueprint.pattern = {
		id = "no_color_no_material",
		global_value = "normal"
	}
	blueprint.material = {id = "plastic", global_value = "normal"}
	local params = {}
	params.name = data.name_localized or data.name
	params.global_value = data.global_value
	params.money = managers.experience:cash_string(managers.money:get_mask_sell_value(data.name, data.global_value, blueprint))
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_sell_inventory_mask_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_sell_no_slot(params)
end

function BlackMarketGui:_sell_inventory_mask_callback(data)
	managers.menu_component:post_event("item_sell")
	managers.blackmarket:on_sell_inventory_mask(data.name, data.global_value)
	local x, y = self._selected_slot._bitmap:world_center()
	self:reload()
end

function BlackMarketGui:remove_mask_callback(data)
	local value = managers.money:get_mask_slot_sell_value(data.slot)
	local crafted = managers.blackmarket:get_crafted_category_slot("masks", data.slot)
	local blueprint = crafted and crafted.blueprint or {}
	local params = {}
	params.name = data.name_localized or data.name
	params.category = data.category
	params.slot = data.slot
	params.money = managers.experience:cash_string(value)
	params.skip_money = value == 0
	params.mods_readded = {}
	for category, part in pairs(blueprint) do
		local converted_category = category == "color" and "colors" or category == "material" and "materials" or category == "pattern" and "textures" or category
		local default = managers.blackmarket:customize_mask_category_default(converted_category, true) or {}
		if default.id ~= part.id and part.id ~= "no_color_no_material" and managers.money:get_mask_part_price(converted_category, part.id, part.global_value) == 0 then
			local category_tweak = tweak_data.blackmarket[converted_category]
			local part_tweak = category_tweak and category_tweak[part.id]
			if part_tweak then
				table.insert(params.mods_readded, managers.localization:to_upper_text(part_tweak.name_id))
			end
		end
	end
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_remove_mask_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_mask_remove(params)
end

function BlackMarketGui:sell_mask_callback(data)
	local value = managers.money:get_mask_slot_sell_value(data.slot)
	local crafted = managers.blackmarket:get_crafted_category_slot("masks", data.slot)
	local blueprint = crafted and crafted.blueprint or {}
	local params = {}
	params.name = data.name_localized or data.name
	params.category = data.category
	params.slot = data.slot
	params.money = managers.experience:cash_string(value)
	params.skip_money = value == 0
	params.mods_readded = {}
	for category, part in pairs(blueprint) do
		local converted_category = category == "color" and "colors" or category == "material" and "materials" or category == "pattern" and "textures" or category
		local default = managers.blackmarket:customize_mask_category_default(converted_category, true) or {}
		if default.id ~= part.id and part.id ~= "no_color_no_material" and managers.money:get_mask_part_price(converted_category, part.id, part.global_value) == 0 then
			local category_tweak = tweak_data.blackmarket[converted_category]
			local part_tweak = category_tweak and category_tweak[part.id]
			if part_tweak then
				table.insert(params.mods_readded, managers.localization:to_upper_text(part_tweak.name_id))
			end
		end
	end
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_sell_mask_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_mask_sell(params)
end

function BlackMarketGui:_sell_weapon_callback(data)
	managers.menu_component:post_event("item_sell")
	managers.blackmarket:on_sell_weapon(data.category, data.slot)
	self:reload()
end

function BlackMarketGui:_remove_mask_callback(data)
	managers.menu_component:post_event("item_sell")
	managers.blackmarket:on_sell_mask(data.slot)
	self:reload()
end

function BlackMarketGui:_sell_mask_callback(data)
	managers.menu_component:post_event("item_sell")
	managers.blackmarket:on_sell_mask(data.slot)
	self:reload()
end

function BlackMarketGui:open_reticle_switch_menu(data)
	managers.menu:open_node("blackmarket_reticle_switch", {data})
end

function BlackMarketGui:sell_weapon_mods_callback(data)
	local params = {}
	params.name = data.name_localized or data.name
	params.category = data.category
	params.slot = data.slot
	params.money = managers.experience:cash_string(managers.money:get_weapon_part_sell_value(data.name, data.global_value))
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_sell_weapon_mod_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_sell(params)
end

function BlackMarketGui:_sell_weapon_mod_callback(data)
	managers.menu_component:post_event("item_sell")
	managers.blackmarket:on_sell_weapon_part(data.name, data.global_value)
	self:reload()
end

function BlackMarketGui:choose_weapon_buy_callback(data)
	local blackmarket_items = managers.blackmarket:get_weapon_category(data.category) or {}
	local new_node_data = {}
	local weapon_tweak = tweak_data.weapon
	local x_id, y_id, x_level, y_level, x_unlocked, y_unlocked, x_skill, y_skill, x_gv, y_gv, x_sn, y_sn
	local item_categories = {}
	for _, item in ipairs(blackmarket_items) do
		local weapon_data = tweak_data.weapon[item.weapon_id]
		local category = tweak_data.gui.buy_weapon_category_groups[weapon_data.category] or weapon_data.category
		item_categories[category] = item_categories[category] or {}
		table.insert(item_categories[category], item)
	end
	local sorted_categories = {}
	for category, items in pairs(item_categories) do
		table.insert(sorted_categories, category)
		table.sort(items, function(x, y)
			x_unlocked = x.unlocked
			y_unlocked = y.unlocked
			if x_unlocked ~= y_unlocked then
				return x_unlocked
			end
			x_id = x.weapon_id
			y_id = y.weapon_id
			x_gv = weapon_tweak[x_id].global_value
			y_gv = weapon_tweak[y_id].global_value
			x_sn = x_gv and tweak_data.lootdrop.global_values[x_gv].sort_number or 0
			y_sn = y_gv and tweak_data.lootdrop.global_values[y_gv].sort_number or 0
			if x_sn ~= y_sn then
				return x_sn < y_sn
			end
			x_skill = x.skill_based
			y_skill = y.skill_based
			if x_skill ~= y_skill then
				return y_skill
			end
			x_level = x.level or 0
			y_level = y.level or 0
			if x_level ~= y_level then
				return x_level < y_level
			end
			return x_id < y_id
		end)
	end
	table.sort(sorted_categories, function(x, y)
		return #item_categories[x] > #item_categories[y]
	end)
	local item_data
	for _, category in ipairs(sorted_categories) do
		local items = item_categories[category]
		item_data = {}
		for _, item in ipairs(items) do
			table.insert(item_data, item)
		end
		local name_id = managers.localization:to_upper_text("menu_" .. category)
		table.insert(new_node_data, {
			name = category,
			category = data.category,
			prev_node_data = data,
			name_localized = name_id,
			on_create_func_name = "populate_buy_weapon",
			on_create_data = item_data,
			identifier = self.identifiers.weapon
		})
	end
	new_node_data.buying_weapon = true
	new_node_data.topic_id = "bm_menu_buy_weapon_title"
	new_node_data.topic_params = {
		weapon_category = managers.localization:text("bm_menu_" .. data.category)
	}
	new_node_data.blur_fade = self._data.blur_fade
	managers.menu:open_node(self._inception_node_name, {new_node_data})
end

function BlackMarketGui:choose_weapon_buy_callback2(data)
	local items = managers.blackmarket:get_weapon_category(data.category) or {}
	local new_node_data = {}
	local weapon_tweak = tweak_data.weapon
	local x_id, y_id, x_level, y_level, x_unlocked, y_unlocked, x_skill, y_skill, x_gv, y_gv, x_sn, y_sn
	table.sort(items, function(x, y)
		x_unlocked = x.unlocked
		y_unlocked = y.unlocked
		if x_unlocked ~= y_unlocked then
			return x_unlocked
		end
		x_id = x.weapon_id
		y_id = y.weapon_id
		x_gv = weapon_tweak[x_id].global_value
		y_gv = weapon_tweak[y_id].global_value
		x_sn = x_gv and tweak_data.lootdrop.global_values[x_gv].sort_number or 0
		y_sn = y_gv and tweak_data.lootdrop.global_values[y_gv].sort_number or 0
		if x_sn ~= y_sn then
			return x_sn < y_sn
		end
		x_skill = x.skill_based
		y_skill = y.skill_based
		if x_skill ~= y_skill then
			return y_skill
		end
		x_level = x.level or 0
		y_level = y.level or 0
		if x_level ~= y_level then
			return x_level < y_level
		end
		return x_id < y_id
	end
)
	local item_data = {}
	for i = 1, math.ceil(#items / 9) do
		item_data = {}
		for id = (i - 1) * 9 + 1, math.min(i * 9, #items) do
			table.insert(item_data, items[id])
		end
		table.insert(new_node_data, {
			name = tostring(i),
			category = data.category,
			prev_node_data = data,
			name_localized = tostring(i),
			on_create_func_name = "populate_buy_weapon",
			on_create_data = item_data,
			identifier = self.identifiers.weapon
		})
	end
	new_node_data.buying_weapon = true
	new_node_data.topic_id = "bm_menu_buy_weapon_title"
	new_node_data.topic_params = {
		weapon_category = managers.localization:text("bm_menu_" .. data.category)
	}
	new_node_data.blur_fade = self._data.blur_fade
	managers.menu:open_node(self._inception_node_name, {new_node_data})
end

function BlackMarketGui:choose_mask_global_value_callback(data)
	local masks = managers.blackmarket:get_inventory_masks() or {}
	local new_node_data = {}
	local items = {}
	for _, mask in pairs(masks) do
		local new_global_value = true
		for _, global_value in ipairs(items) do
			if global_value == mask.global_value then
				new_global_value = false
			end
		end
		if new_global_value then
			table.insert(items, mask.global_value)
		end
	end
	table.sort(items, function(x, y)
		local global_values = {
			normal = 1,
			superior = 2,
			exceptional = 3,
			infamous = 4
		}
		if global_values[x] and global_values[y] then
			return global_values[x] < global_values[y]
		end
	end)
	local item_data = {}
	for i = 1, math.ceil(#items / 9) do
		item_data = {}
		for id = (i - 1) * 9 + 1, math.min(i * 9, #items) do
			table.insert(item_data, items[id])
		end
		table.insert(new_node_data, {
			name = tostring(i),
			category = data.category,
			prev_node_data = data,
			name_localized = tostring(i),
			on_create_func_name = "populate_mask_global_value",
			on_create_data = item_data,
			identifier = self.identifiers.mask
		})
	end
	new_node_data.topic_id = "bm_menu_choose_global_value_title"
	new_node_data.topic_params = {
		category = managers.localization:text("bm_menu_buy_mask_title")
	}
	new_node_data.blur_fade = self._data.blur_fade
	managers.menu:open_node(self._inception_node_name, {new_node_data})
end

function BlackMarketGui:choose_weapon_slot_unlock_callback(data)
	local params = {}
	params.money = managers.experience:cash_string(managers.money:get_buy_weapon_slot_price())
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_buy_weapon_slot_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_buy_weapon_slot(params)
end

function BlackMarketGui:choose_mask_slot_unlock_callback(data)
	local params = {}
	params.money = managers.experience:cash_string(managers.money:get_buy_mask_slot_price())
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_buy_mask_slot_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_buy_mask_slot(params)
end

function BlackMarketGui:choose_mask_buy_callback(data)
	local masks_data = tweak_data.blackmarket.masks
	local masks = managers.blackmarket:get_inventory_masks() or {}
	local new_node_data = {}
	local items = {}
	local itemids = {}
	local function func_add_item(global_value, item_id, item)
		if not masks_data[item_id] or masks_data[item_id].inaccessible then
			return
		end
		local category = tweak_data.lootdrop.global_values[global_value].category
		if category then
			global_value = category
		end
		itemids[global_value] = itemids[global_value] or {}
		items[global_value] = items[global_value] or {}
		if not table.contains(itemids[global_value], item_id) then
			table.insert(items[global_value], item)
			table.insert(itemids[global_value], item_id)
		end
	end

	for _, mask in ipairs(masks) do
		func_add_item(mask.global_value, mask.mask_id, mask)
	end
	for mask_id, mask in pairs(masks_data) do
		if mask.pc or mask.pcs then
			local global_values = {}
			if mask.dlc or mask.dlcs then
				local dlcs = {}
				if mask.dlc then
					table.insert(dlcs, mask.dlc)
				end
				for i, dlc in ipairs(mask.dlcs or {}) do
					table.insert(dlcs, dlc)
				end
				local add_dlc = false
				local dlc_tweak, global_value_tweak, global_value
				for _, dlc in ipairs(dlcs) do
					global_value = mask.global_value or dlc
					dlc_tweak = tweak_data.dlc[dlc] or {}
					global_value_tweak = tweak_data.lootdrop.global_values[global_value] or {}
					add_dlc = not global_value_tweak.hide_unavailable or dlc_tweak.free or managers.dlc:has_dlc(dlc)
					if add_dlc then
						table.insert(global_values, global_value)
						if mask.global_value then
						end
					else
					end
				end
			elseif mask.global_value then
				table.insert(global_values, mask.global_value)
			else
				table.insert(global_values, mask.infamous and "infamous" or "normal")
			end
			for _, global_value in ipairs(global_values) do
				func_add_item(global_value, mask_id, {
					amount = 0,
					global_value = global_value,
					mask_id = mask_id
				})
			end
		end
	end
	local iso = tweak_data.gui.masks_sort_order
	local x_iso, y_iso
	local sort_td = tweak_data.blackmarket.masks
	local x_td, y_td, x_sn, y_sn
	local global_value_sort = {}
	local loc_man = managers.localization
	local saved_locs = {}
	local function sort_func(x, y)
		x_td = sort_td[x.mask_id]
		y_td = sort_td[y.mask_id]
		x_sn = tweak_data.lootdrop.global_values[x.global_value].sort_number or 0
		y_sn = tweak_data.lootdrop.global_values[y.global_value].sort_number or 0
		x_sn = x_sn + (x_td.sort_number or 0)
		y_sn = y_sn + (y_td.sort_number or 0)
		x_iso = table.get_key(iso, x.mask_id) or 0
		y_iso = table.get_key(iso, y.mask_id) or 0
		if x_td.value == 0 and y_td.value ~= 0 then
			return false
		elseif x_td.value ~= 0 and y_td.value == 0 then
			return true
		end
		if x_sn ~= y_sn then
			return x_sn < y_sn
		end
		if x_iso ~= y_iso then
			return x_iso < y_iso
		end
		local x_loc = saved_locs[x.mask_id] or loc_man:to_upper_text(x_td.name_id)
		local y_loc = saved_locs[y.mask_id] or loc_man:to_upper_text(y_td.name_id)
		saved_locs[x.mask_id] = x_loc
		saved_locs[y.mask_id] = y_loc
		if x_loc ~= y_loc then
			return x_loc < y_loc
		end
		return x.mask_id < y.mask_id
	end

	for global_value, gv_items in pairs(items) do
		table.insert(global_value_sort, global_value)
		table.sort(gv_items, sort_func)
	end
	table.sort(global_value_sort, function(x, y)
		x_td = tweak_data.lootdrop.global_value_category[x] or tweak_data.lootdrop.global_values[x]
		y_td = tweak_data.lootdrop.global_value_category[y] or tweak_data.lootdrop.global_values[y]
		x_sn = x_td and x_td.sort_number or 1
		y_sn = y_td and y_td.sort_number or 1
		return x_sn < y_sn
	end
)
	local item_data
	for _, global_value in ipairs(global_value_sort) do
		item_data = {}
		for _, mask in ipairs(items[global_value]) do
			table.insert(item_data, mask)
		end
		local name_id = tweak_data.lootdrop.global_value_category[global_value] and tweak_data.lootdrop.global_value_category[global_value].name_id or tweak_data.lootdrop.global_values[global_value].name_id
		table.insert(new_node_data, {
			name = global_value,
			category = data.category,
			prev_node_data = data,
			name_localized = managers.localization:to_upper_text(name_id),
			on_create_func_name = "populate_buy_mask",
			on_create_data = item_data,
			override_slots = {6, 3},
			identifier = self.identifiers.mask
		})
	end
	new_node_data.topic_id = "bm_menu_buy_mask_title"
	new_node_data.topic_params = {}
	new_node_data.blur_fade = self._data.blur_fade
	managers.menu:open_node(self._inception_node_name, {new_node_data})
end

function BlackMarketGui:buy_mask_callback(data)
	if self._item_bought then
		return
	end
	local params = {}
	params.name = data.name_localized or data.name
	params.category = data.category
	params.slot = data.slot
	params.weapon = data.name
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_buy_mask_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_assemble(params)
end

function BlackMarketGui:preview_customized_mask_callback(data)
	if not managers.blackmarket:can_view_customized_mask() then
	end
	managers.menu:open_node("blackmarket_preview_mask_node", {})
	managers.blackmarket:view_customized_mask()
end

function BlackMarketGui:preview_customized_mask_with_mod_callback(data)
	if not managers.blackmarket:can_view_customized_mask_with_mod(data.category, data.name, data.global_value) then
		return
	end
	managers.menu:open_node("blackmarket_preview_mask_node", {})
	managers.blackmarket:view_customized_mask_with_mod(data.category, data.name)
end

function BlackMarketGui:_warn_abort_customized_mask_callback(params)
	return managers.blackmarket:warn_abort_customize_mask(params)
end

function BlackMarketGui:_abort_customized_mask_callback()
	managers.blackmarket:abort_customize_mask()
	managers.menu_component:close_blackmarket_gui()
	managers.menu:back(true)
end

function BlackMarketGui:buy_customized_mask_callback(data)
	if self._item_bought then
		return
	end
	local params = {}
	params.name = managers.localization:text(tweak_data.blackmarket.masks[managers.blackmarket:get_customize_mask_id()].name_id)
	params.category = data.category
	params.slot = data.slot
	params.money = managers.experience:cash_string(managers.blackmarket:get_customize_mask_value())
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_buy_customized_mask_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_finalize(params)
end

function BlackMarketGui:_buy_customized_mask_callback(data)
	self._item_bought = true
	managers.menu_component:post_event("finalize_mask")
	managers.blackmarket:finish_customize_mask()
	managers.menu_component:close_blackmarket_gui()
	managers.menu:back(true)
end

function BlackMarketGui:choose_mask_part_callback(data)
	if managers.blackmarket:select_customize_mask(data.category, data.name, data.global_value) then
		self:reload()
	end
end

function BlackMarketGui:buy_weapon_callback(data)
	if self._item_bought then
		return
	end
	local params = {}
	params.name = data.name_localized or data.name
	params.category = data.category
	params.slot = data.slot
	params.weapon = data.name
	params.money = managers.experience:cash_string(managers.money:get_weapon_price_modified(data.name))
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_buy_weapon_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_buy(params)
end

function BlackMarketGui:show_buy_dlc_callback(data)
	local dlc_data = Global.dlc_manager.all_dlc_data[data.global_value]
	local app_id = dlc_data and dlc_data.app_id
	if app_id and not dlc_data.external then
		Steam:overlay_activate("store", app_id)
	end
end

function BlackMarketGui:_buy_mask_slot_callback(data)
	self._item_bought = true
	managers.menu_component:post_event("item_buy")
	managers.blackmarket:buy_unlock_mask_slot(data.slot)
	self:reload()
end

function BlackMarketGui:_buy_weapon_slot_callback(data)
	self._item_bought = true
	managers.menu_component:post_event("item_buy")
	managers.blackmarket:buy_unlock_weapon_slot(data.category, data.slot)
	self:reload()
end

function BlackMarketGui:_buy_mask_callback(data)
	self._item_bought = true
	managers.menu_component:post_event("item_buy")
	managers.blackmarket:on_buy_mask_to_inventory(data.name, data.global_value, data.slot)
	managers.menu_component:close_blackmarket_gui()
	managers.menu:back(true, math.max(data.num_backs - 1, 0))
end

function BlackMarketGui:_buy_weapon_callback(data)
	self._item_bought = true
	managers.menu_component:post_event("item_buy")
	managers.blackmarket:on_buy_weapon_platform(data.category, data.name, data.slot)
	managers.menu_component:close_blackmarket_gui()
	managers.menu:back(true)
end

function BlackMarketGui:preview_buy_weapon_callback(data)
	managers.blackmarket:view_weapon_platform(data.name, callback(self, self, "_open_preview_node"))
end

function BlackMarketGui:preview_buy_mask_callback(data)
	managers.menu:open_node("blackmarket_preview_mask_node", {})
	managers.blackmarket:view_mask_with_mask_id(data.name)
end

function BlackMarketGui:choose_mod_callback(data, prev_node_params)
	local mods = deep_clone(data.mods) or {}
	local new_node_data = {}
	local factory_id = managers.blackmarket:get_crafted_category(data.category)[data.slot].factory_id
	local mod_data = {}
	for i = 1, math.ceil(#mods / 9) do
		mod_data = {}
		for id = (i - 1) * 9 + 1, math.min(i * 9, #mods) do
			table.insert(mod_data, {
				mods[id],
				false
			})
		end
		table.insert(new_node_data, {
			name = tostring(i),
			category = data.category,
			prev_node_data = data,
			name_localized = tostring(i),
			on_create_func_name = "populate_mods",
			on_create_data = mod_data,
			identifier = self.identifiers.weapon_mod
		})
	end
	new_node_data.topic_id = "bm_menu_blackmarket_title"
	new_node_data.topic_params = {
		item = prev_node_params.weapon_name
	}
	new_node_data.show_tabs = true
	managers.menu:open_node(self._inception_node_name, {new_node_data})
end

function BlackMarketGui:buy_mod_callback(data)
	if self._item_bought then
		return
	end
	local params = {}
	params.name = data.name_localized or data.name
	params.category = data.category
	params.slot = data.slot
	params.weapon_name = managers.weapon_factory:get_weapon_name_by_factory_id(managers.blackmarket:get_crafted_category(data.category)[data.slot].factory_id)
	params.add = true
	local weapon_id = managers.blackmarket:get_crafted_category(data.category)[data.slot].weapon_id
	local cost = managers.money:get_weapon_modify_price(weapon_id, data.name, data.global_value) or 0
	params.money = cost > 0 and managers.experience:cash_string(cost)
	local replaces, removes = managers.blackmarket:get_modify_weapon_consequence(data.category, data.slot, data.name)
	params.replaces = replaces or {}
	params.removes = removes or {}
	if data.default_mod then
		table.delete(replaces, data.default_mod)
		table.delete(removes, data.default_mod)
	end
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_buy_mod_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_mod(params)
end

function BlackMarketGui:_buy_mod_callback(data)
	self._item_bought = true
	managers.menu_component:post_event("item_buy")
	managers.blackmarket:buy_and_modify_weapon(data.category, data.slot, data.global_value, data.name, false, data.free_of_charge)
	local factory = tweak_data.weapon.factory.parts[data.name]
	if factory then
		local texture_switch = factory.texture_switch
		if texture_switch then
			managers.blackmarket:set_part_texture_switch(data.category, data.slot, data.name, "1 1")
		end
	end
	self:reload()
end

function BlackMarketGui:preview_weapon_with_mod_callback(data)
	managers.blackmarket:view_weapon_with_mod(data.category, data.slot, data.name, callback(self, self, "_open_preview_node"))
end

function BlackMarketGui:remove_mod_callback(data)
	local params = {}
	params.name = managers.localization:text(tweak_data.weapon.factory.parts[data.name].name_id)
	params.category = data.category
	params.slot = data.slot
	params.weapon_name = managers.weapon_factory:get_weapon_name_by_factory_id(managers.blackmarket:get_crafted_category(data.category)[data.slot].factory_id)
	params.add = false
	params.ignore_lost_mods = data.free_of_charge
	if data.default_mod then
	end
	local replaces, removes = managers.blackmarket:get_modify_weapon_consequence(data.category, data.slot, data.default_mod or data.name, true)
	local weapon_id = managers.blackmarket:get_crafted_category(data.category)[data.slot].weapon_id
	local cost = managers.money:get_weapon_modify_price(weapon_id, data.name, data.global_value) or 0
	params.money = cost > 0 and managers.experience:cash_string(cost)
	params.replaces = replaces
	params.removes = removes
	params.yes_func = callback(self, self, "_dialog_yes", callback(self, self, "_remove_mod_callback", data))
	params.no_func = callback(self, self, "_dialog_no")
	managers.menu:show_confirm_blackmarket_mod(params)
end

function BlackMarketGui:_remove_mod_callback(data)
	managers.menu_component:post_event("item_sell")
	if data.default_mod then
		managers.blackmarket:buy_and_modify_weapon(data.category, data.slot, data.global_value, data.default_mod, true, true)
	else
		managers.blackmarket:remove_weapon_part(data.category, data.slot, data.global_value, data.name)
	end
	local factory = tweak_data.weapon.factory.parts[data.name]
	if factory then
		local texture_switch = factory.texture_switch
		if texture_switch then
			managers.blackmarket:set_part_texture_switch(data.category, data.slot, data.name, "1 1")
		end
	end
	self:reload()
end

function BlackMarketGui:preview_weapon_without_mod_callback(data)
	if data.default_mod then
		managers.blackmarket:view_weapon_with_mod(data.category, data.slot, data.default_mod, callback(self, self, "_open_preview_node"))
	else
		managers.blackmarket:view_weapon_without_mod(data.category, data.slot, data.name, callback(self, self, "_open_preview_node"))
	end
end

function BlackMarketGui:lo_equip_grenade_callback(data)
	managers.blackmarket:equip_grenade(data.name)
	self:reload()
end

function BlackMarketGui:preview_grenade_callback(data)
	managers.menu:open_node(self._preview_node_name, {})
	managers.blackmarket:preview_grenade(data.name)
end

function BlackMarketGui:lo_equip_melee_weapon_callback(data)
	managers.blackmarket:equip_melee_weapon(data.name)
	self:reload()
end

function BlackMarketGui:preview_melee_weapon_callback(data)
	managers.menu:open_node(self._preview_node_name, {})
	managers.blackmarket:preview_melee_weapon(data.name)
end

function BlackMarketGui:add_melee_weapon_favorite(data)
	self:_set_melee_weapon_favorite(data.name, true, data)
end

function BlackMarketGui:remove_melee_weapon_favorite(data)
	self:_set_melee_weapon_favorite(data.name, false, data)
end

function BlackMarketGui:_set_melee_weapon_favorite(melee_weapon_id, favorite, data)
	managers.blackmarket:set_melee_weapon_favorite(melee_weapon_id, favorite)
	self:reload()
	local tab_data = self._data[self._selected]
	if tab_data and data and tab_data.category == data.category and self._tabs[self._selected] then
		local selected = self._tabs[self._selected]._slot_selected or 1
		local new_selected = selected
		for i, item in ipairs(tab_data) do
			if item.name == melee_weapon_id then
				new_selected = i
			else
			end
		end
		local slot = self._tabs[self._selected]:select_slot(new_selected, new_selected == selected)
		self:on_slot_selected(slot)
	end
end

function BlackMarketGui:update_mod_mask()
	if not managers.blackmarket:currently_customizing_mask() then
		managers.menu_component:close_blackmarket_gui()
		managers.menu:back(true)
	else
		managers.blackmarket:view_customized_mask()
	end
end

function BlackMarketGui:_dialog_yes(clbk)
	if clbk and type(clbk) == "function" then
		clbk()
	end
end

function BlackMarketGui:_dialog_no(clbk)
	if clbk and type(clbk) == "function" then
		clbk()
	end
end

function BlackMarketGui:destroy()
	for i, tab in pairs(self._tabs) do
		tab:destroy()
	end
end

function BlackMarketGui:close()
	if self._rename_clbk_id then
		managers.network.account:remove_gamepad_text_listener(self._rename_clbk_id)
		self._rename_clbk_id = nil
	end
	WalletGuiObject.close_wallet(self._panel)
	self:destroy()
	managers.blackmarket:drop_hold_crafted_item()
	self._ws:panel():remove(self._panel)
	self._fullscreen_ws:panel():remove(self._fullscreen_panel)
	if not managers.menu_component._menuscene_info_gui then
		managers.menu:active_menu().renderer.ws:show()
	end
end

function BlackMarketGui:_pre_reload()
	self._temp_panel = self._panel
	self._temp_fullscreen_panel = self._fullscreen_panel
	WalletGuiObject.close_wallet(self._panel)
	self:destroy()
	self._panel = nil
	self._fullscreen_panel = nil
	if alive(self._temp_panel) then
		self._temp_panel:hide()
	end
	if alive(self._temp_fullscreen_panel) then
		self._temp_fullscreen_panel:hide()
	end
end

function BlackMarketGui:_post_reload()
	self._ws:panel():remove(self._temp_panel)
	self._fullscreen_ws:panel():remove(self._temp_fullscreen_panel)
	self._temp_panel = nil
	self._temp_fullscreen_panel = nil
end

function BlackMarketGui:reload()
	if self._rename_clbk_id then
		managers.network.account:remove_gamepad_text_listener(self._rename_clbk_id)
		self._rename_clbk_id = nil
	end
	self:_pre_reload()
	self._tabs = {}
	self._btns = {}
	self._equipped_comparision_data = {}
	BlackMarketGui._setup(self, false, self._data)
	self:_post_reload()
end