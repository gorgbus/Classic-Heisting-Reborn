local NOT_WIN_32 = SystemInfo:platform() ~= Idstring("WIN32")
local WIDTH_MULTIPLIER = NOT_WIN_32 and 0.6 or 0.6
local SPEC_WIDTH_MULTIPLIER = NOT_WIN_32 and 0.7 or 0.7
local CONSOLE_PAGE_ADJUSTMENT = NOT_WIN_32 and 0 or 0
local TOP_ADJUSTMENT = NOT_WIN_32 and 50 or 55
local BOX_GAP = 54
local NUM_TREES_PER_PAGE = 4

local function make_fine_text(text)
	local x, y, w, h = text:text_rect()

	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))
end

function SkillTreeSkillItem:init(skill_id, tier_panel, num_skills, i, tree, tier, w, h, skill_refresh_skills)
	SkillTreeSkillItem.super.init(self)

	self._skill_id = skill_id
	self._tree = tree
	self._tier = tier
	local skill_panel = tier_panel:panel({
		name = skill_id,
		w = w,
		h = h
	})
	self._skill_panel = skill_panel
	self._skill_refresh_skills = skill_refresh_skills
	local skill = tweak_data.skilltree.skills[skill_id]
	self._skill_name = managers.localization:text(skill.name_id)
	local texture_rect_x = skill.icon_xy and skill.icon_xy[1] or 0
	local texture_rect_y = skill.icon_xy and skill.icon_xy[2] or 0
	self._base_size = h - 10
	local state_image = skill_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/icons_atlas",
		name = "state_image",
		layer = 1,
		texture_rect = {
			texture_rect_x * 64,
			texture_rect_y * 64,
			64,
			64
		},
		color = tweak_data.screen_colors.item_stage_3
	})

	state_image:set_size(self._base_size, self._base_size)
	state_image:set_blend_mode("add")

	local skill_text = skill_panel:text({
		word_wrap = true,
		name = "skill_text",
		vertical = "center",
		wrap = true,
		align = "left",
		blend_mode = "add",
		text = "",
		layer = 3,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.text,
		x = self._base_size + 10,
		w = skill_panel:w() - self._base_size - 10
	})

	state_image:set_x(5)
	state_image:set_center_y(skill_panel:h() / 2)

	self._inside_panel = skill_panel:panel({
		w = w - 10,
		h = h - 10
	})

	self._inside_panel:set_center(skill_panel:w() / 2, skill_panel:h() / 2)

	local cx = tier_panel:w() / num_skills
	skill_panel:set_x((i - 1) * w)

	self._box = BoxGuiObject:new(skill_panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})

	self._box:hide()

	local state_indicator = skill_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/ace",
		name = "state_indicator",
		alpha = 0,
		layer = 0,
		color = Color.white:with_alpha(1)
	})

	state_indicator:set_size(state_image:w() * 2, state_image:h() * 2)
	state_indicator:set_blend_mode("add")
	state_indicator:set_rotation(360)
	state_indicator:set_center(state_image:center())
end

function SkillTreePage:init(tree, data, parent_panel, fullscreen_panel, tree_tab_h, skill_prerequisites)
	self._items = {}
	self._selected_item = nil
	self._tree = tree
	local tree_panel = parent_panel:panel({
		y = 0,
		visible = false,
		name = tostring(tree),
		w = math.round(parent_panel:w() * WIDTH_MULTIPLIER)
	})
	self._tree_panel = tree_panel
	self._bg_image = fullscreen_panel:bitmap({
		name = "bg_image",
		blend_mode = "add",
		layer = 1,
		texture = data.background_texture,
		w = fullscreen_panel:w(),
		h = fullscreen_panel:h()
	})

	self._bg_image:set_alpha(0.6)

	local aspect = fullscreen_panel:w() / fullscreen_panel:h()
	local texture_width = self._bg_image:texture_width()
	local texture_height = self._bg_image:texture_height()
	local sw = math.max(texture_width, texture_height * aspect)
	local sh = math.max(texture_height, texture_width / aspect)
	local dw = texture_width / sw
	local dh = texture_height / sh

	self._bg_image:set_size(dw * fullscreen_panel:w(), dh * fullscreen_panel:h())
	self._bg_image:set_right(fullscreen_panel:w())
	self._bg_image:set_center_y(fullscreen_panel:h() / 2)

	local panel_h = 0
	local h = (parent_panel:h() - tree_tab_h - TOP_ADJUSTMENT) / (8 - CONSOLE_PAGE_ADJUSTMENT)
	for i = 1, 7 do
		local color = Color.black
		local rect = tree_panel:rect({
			h = 2,
			blend_mode = "add",
			name = "rect" .. i,
			color = color
		})

		rect:set_bottom(tree_panel:h() - (i - CONSOLE_PAGE_ADJUSTMENT) * h)

		if true or i == 1 then
			rect:set_alpha(0)
			rect:hide()
		end
	end

	local tier_panels = tree_panel:panel({
		name = "tier_panels"
	})
	if data.skill then
		local tier_panel = tier_panels:panel({
			name = "tier_panel0",
			h = h
		})
		tier_panel:set_bottom(tree_panel:child("rect1"):top())
		local item = SkillTreeUnlockItem:new(data.skill, tier_panel, tree, tier_panel:w() / 3, h)
		table.insert(self._items, item)
		item:refresh(false)
	end
	for tier, tier_data in ipairs(data.tiers) do
		local unlocked = managers.skilltree:tier_unlocked(tree, tier)
		local tier_panel = tier_panels:panel({
			name = "tier_panel" .. tier,
			h = h
		})
		local num_skills = #tier_data

		tier_panel:set_bottom(tree_panel:child("rect" .. tostring(tier + 1)):top())

		local base_size = h
		local base_w = tier_panel:w() / math.max(#tier_data, 1)

		for i, skill_id in ipairs(tier_data) do
			local item = SkillTreeSkillItem:new(skill_id, tier_panel, num_skills, i, tree, tier, base_w, base_size, skill_prerequisites[skill_id])

			table.insert(self._items, item)
			item:refresh(not unlocked)
		end

		local tier_string = tostring(tier)
		local debug_text = tier_panel:text({
			word_wrap = false,
			name = "debug_text",
			wrap = false,
			align = "right",
			vertical = "bottom",
			blend_mode = "add",
			rotation = 360,
			layer = 2,
			text = tier_string,
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			h = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.item_stage_3
		})

		debug_text:set_world_bottom(tree_panel:child("rect" .. tostring(tier + 1)):world_top() + 2)

		local _, _, tw, _ = debug_text:text_rect()

		debug_text:move(tw * 2, 0)

		local lock_image = tier_panel:bitmap({
			texture = "guis/textures/pd2/skilltree/padlock",
			name = "lock",
			layer = 3,
			w = tweak_data.menu.pd2_small_font_size,
			h = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.item_stage_3
		})

		lock_image:set_blend_mode("add")
		lock_image:set_rotation(360)
		lock_image:set_world_position(debug_text:world_right(), debug_text:world_y() - 2)
		lock_image:set_visible(false)

		local add_infamy_glow = false

		if managers.experience:current_rank() > 0 then
			local tree_name = tweak_data.skilltree.trees[tree].skill

			for infamy, item in pairs(tweak_data.infamy.items) do
				if managers.infamy:owned(infamy) then
					local skilltree = item.upgrades and item.upgrades.skilltree

					if skilltree then
						local tree = skilltree.tree
						local trees = skilltree.trees

						if tree and tree == tree_name or trees and table.contains(trees, tree_name) then
							add_infamy_glow = true

							break
						end
					end
				end
			end
		end

		local cost_string = (managers.skilltree:tier_cost(tree, tier) < 10 and "0" or "") .. tostring(managers.skilltree:tier_cost(tree, tier))
		local cost_text = tier_panel:text({
			word_wrap = false,
			name = "cost_text",
			wrap = false,
			align = "left",
			vertical = "bottom",
			blend_mode = "add",
			rotation = 360,
			layer = 2,
			text = cost_string,
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			h = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.item_stage_3
		})
		local x, y, w, h = cost_text:text_rect()

		cost_text:set_size(w, h)
		cost_text:set_world_bottom(tree_panel:child("rect" .. tostring(tier + 1)):world_top() + 2)
		cost_text:set_x(debug_text:right() + tw * 3)

		if add_infamy_glow then
			local glow = tier_panel:bitmap({
				texture = "guis/textures/pd2/crimenet_marker_glow",
				name = "cost_glow",
				h = 56,
				blend_mode = "add",
				w = 56,
				rotation = 360,
				color = tweak_data.screen_colors.button_stage_3
			})

			local function anim_pulse_glow(o)
				local t = 0
				local dt = 0

				while true do
					dt = coroutine.yield()
					t = (t + dt * 0.5) % 1

					o:set_alpha((math.sin(t * 180) * 0.5 + 0.5) * 0.8)
				end
			end

			glow:set_center(cost_text:center())
			glow:animate(anim_pulse_glow)
		end

		local color = unlocked and tweak_data.screen_colors.item_stage_1 or tweak_data.screen_colors.item_stage_2

		debug_text:set_color(color)
		cost_text:set_color(color)

		if not unlocked then
			-- Nothing
		end
	end

	local ps = managers.skilltree:points_spent(self._tree)
	local max_points = 1

	for _, tier in ipairs(tweak_data.skilltree.trees[self._tree].tiers) do
		for _, skill in ipairs(tier) do
			for to_unlock, _ in ipairs(tweak_data.skilltree.skills[skill]) do
				max_points = max_points + managers.skilltree:get_skill_points(skill, to_unlock)
			end
		end
	end

	local prev_tier_p = 0
	local next_tier_p = max_points
	local ct = 0

	for i = 1, 6 do
		local tier_unlocks = managers.skilltree:tier_cost(self._tree, i)

		if ps < tier_unlocks then
			next_tier_p = tier_unlocks

			break
		end

		ct = i
		prev_tier_p = tier_unlocks
	end

	local diff_p = next_tier_p - prev_tier_p
	local diff_ps = ps - prev_tier_p
	local dh = self._tree_panel:child("rect2"):bottom()
	local prev_tier_object = self._tree_panel:child("rect" .. tostring(ct + 1))
	local next_tier_object = self._tree_panel:child("rect" .. tostring(ct + 2))
	local prev_tier_y = prev_tier_object and prev_tier_object:top() or 0
	local next_tier_y = next_tier_object and next_tier_object:top() or 0

	if not next_tier_object then
		next_tier_object = self._tree_panel:child("rect" .. tostring(ct))
		next_tier_y = next_tier_object and next_tier_object:top() or 0
		next_tier_y = 2 * prev_tier_y - next_tier_y
	end

	if ct > 0 then
		dh = math.max(2, tier_panels:child("tier_panel1"):world_bottom() - math.lerp(prev_tier_y, next_tier_y, diff_ps / diff_p))
	else
		dh = 0
	end

	local points_spent_panel = tree_panel:panel({
		w = 4,
		name = "points_spent_panel",
		h = dh
	})
	self._points_spent_line = BoxGuiObject:new(points_spent_panel, {
		sides = {
			2,
			2,
			0,
			0
		}
	})

	self._points_spent_line:set_clipping(dh == 0)
	points_spent_panel:set_world_center_x(tier_panels:child("tier_panel1"):child("lock"):world_center())
	points_spent_panel:set_world_bottom(tier_panels:child("tier_panel1"):world_bottom())

	for i, item in ipairs(self._items) do
		item:link(i, self._items)
	end
end

function SkillTreePage:on_points_spent()
	local points_spent_panel = self._tree_panel:child("points_spent_panel")
	local tier_panels = self._tree_panel:child("tier_panels")
	local ps = managers.skilltree:points_spent(self._tree)
	local max_points = 1

	for _, tier in ipairs(tweak_data.skilltree.trees[self._tree].tiers) do
		for _, skill in ipairs(tier) do
			for to_unlock, _ in ipairs(tweak_data.skilltree.skills[skill]) do
				max_points = max_points + managers.skilltree:get_skill_points(skill, to_unlock)
			end
		end
	end

	local prev_tier_p = 0
	local next_tier_p = max_points
	local ct = 0

	for i = 1, 6 do
		local tier_unlocks = managers.skilltree:tier_cost(self._tree, i)

		if ps < tier_unlocks then
			next_tier_p = tier_unlocks

			break
		end

		ct = i
		prev_tier_p = tier_unlocks
	end

	local diff_p = next_tier_p - prev_tier_p
	local diff_ps = ps - prev_tier_p
	local dh = self._tree_panel:child("rect2"):bottom()
	local prev_tier_object = self._tree_panel:child("rect" .. tostring(ct + 1))
	local next_tier_object = self._tree_panel:child("rect" .. tostring(ct + 2))
	local prev_tier_y = prev_tier_object and prev_tier_object:top() or 0
	local next_tier_y = next_tier_object and next_tier_object:top() or 0

	if not next_tier_object then
		next_tier_object = self._tree_panel:child("rect" .. tostring(ct))
		next_tier_y = next_tier_object and next_tier_object:top() or 0
		next_tier_y = 2 * prev_tier_y - next_tier_y
	end

	if ct > 0 then
		dh = math.max(2, tier_panels:child("tier_panel1"):world_bottom() - math.lerp(prev_tier_y, next_tier_y, diff_ps / diff_p))
	else
		dh = 0
	end

	points_spent_panel:set_h(dh)
	self._points_spent_line:create_sides(points_spent_panel, {
		sides = {
			2,
			2,
			2,
			2
		}
	})
	self._points_spent_line:set_clipping(dh == 0)
	points_spent_panel:set_world_center_x(tier_panels:child("tier_panel1"):child("lock"):world_center())
	points_spent_panel:set_world_bottom(tier_panels:child("tier_panel1"):world_bottom())
end

Hooks:PreHook(SkillTreeGui, "_update_borders", "perks", function(self)
	local tree_tabs_panel = self._skill_tree_panel:child("tree_tabs_panel")
	local spec_tabs_panel = self._specialization_panel:child("spec_tabs_panel")
	tree_tabs_panel:set_y(TOP_ADJUSTMENT + 1)
	spec_tabs_panel:set_y(TOP_ADJUSTMENT + 1)
end)

function SkillTreeGui:_setup(add_skilltree, add_specialization)
	if alive(self._panel) then
		self._ws:panel():remove(self._panel)
	end

	local scaled_size = managers.gui_data:scaled_size()
	self._panel = self._ws:panel():panel({
		valign = "center",
		visible = true,
		layer = self._init_layer
	})
	self._fullscreen_panel = self._fullscreen_ws:panel():panel()

	WalletGuiObject.set_wallet(self._panel)

	local skilltree_text = self._panel:text({
		vertical = "top",
		name = "skilltree_text",
		align = "left",
		text = utf8.to_upper(managers.localization:text("menu_st_skilltree")),
		h = tweak_data.menu.pd2_large_font_size,
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.text
	})
	local x, y, w, h = skilltree_text:text_rect()

	skilltree_text:set_size(w, h)

	self._skilltree_text_highlighted = false
	self._specialization_text_highlighted = false
	self._is_skilltree_page_active = true
	local bg_text = self._fullscreen_panel:text({
		name = "title_bg",
		vertical = "top",
		h = 90,
		alpha = 0.4,
		align = "left",
		blend_mode = "add",
		layer = 1,
		text = utf8.to_upper(managers.localization:text("menu_st_skilltree")),
		font_size = tweak_data.menu.pd2_massive_font_size,
		font = tweak_data.menu.pd2_massive_font,
		color = tweak_data.screen_colors.button_stage_3
	})
	local x, y = managers.gui_data:safe_to_full_16_9(self._panel:child("skilltree_text"):world_x(), self._panel:child("skilltree_text"):world_center_y())

	bg_text:set_world_left(x)
	bg_text:set_world_center_y(y)
	bg_text:move(-13, 9)
	MenuBackdropGUI.animate_bg_text(self, bg_text)

	self._skill_tree_panel = self._panel:panel({
		visible = true,
		name = "skill_tree_panel"
	})
	self._specialization_panel = self._panel:panel({
		visible = false,
		name = "skill_tree_panel"
	})
	self._skill_tree_fullscreen_panel = self._fullscreen_panel:panel({
		visible = true,
		name = "skill_tree_panel"
	})
	self._specialization_fullscreen_panel = self._fullscreen_panel:panel({
		visible = false,
		name = "skill_tree_panel"
	})
	local points_text = self._skill_tree_panel:text({
		word_wrap = false,
		name = "points_text",
		vertical = "top",
		wrap = false,
		align = "left",
		layer = 1,
		text = utf8.to_upper(managers.localization:text("st_menu_available_skill_points", {
			points = managers.skilltree:points()
		})),
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text
	})

	points_text:set_left(self._skill_tree_panel:w() * WIDTH_MULTIPLIER * 2 / 3 + 10)

	if managers.menu:is_pc_controller() then
		self._panel:text({
			vertical = "bottom",
			name = "back_button",
			align = "right",
			blend_mode = "add",
			text = utf8.to_upper(managers.localization:text("menu_back")),
			h = tweak_data.menu.pd2_large_font_size,
			font_size = tweak_data.menu.pd2_large_font_size,
			font = tweak_data.menu.pd2_large_font,
			color = tweak_data.screen_colors.button_stage_3
		})
		self:make_fine_text(self._panel:child("back_button"))
		self._panel:child("back_button"):set_right(self._panel:w())
		self._panel:child("back_button"):set_bottom(self._panel:h())

		local bg_back = self._fullscreen_panel:text({
			name = "back_button",
			vertical = "bottom",
			h = 90,
			align = "right",
			alpha = 0.4,
			blend_mode = "add",
			layer = 1,
			text = utf8.to_upper(managers.localization:text("menu_back")),
			font_size = tweak_data.menu.pd2_massive_font_size,
			font = tweak_data.menu.pd2_massive_font,
			color = tweak_data.screen_colors.button_stage_3
		})
		local x, y = managers.gui_data:safe_to_full_16_9(self._panel:child("back_button"):world_right(), self._panel:child("back_button"):world_center_y())

		bg_back:set_world_right(x)
		bg_back:set_world_center_y(y)
		bg_back:move(13, -9)
		MenuBackdropGUI.animate_bg_text(self, bg_back)
	end

	local prefix = (not managers.menu:is_pc_controller() or managers.menu:is_steam_controller()) and managers.localization:get_default_macro("BTN_Y") or ""

	self._skill_tree_panel:text({
		vertical = "top",
		name = "respec_tree_button",
		align = "left",
		blend_mode = "add",
		text = prefix .. managers.localization:to_upper_text("st_menu_respec_tree"),
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = Color.black
	})
	self:make_fine_text(self._skill_tree_panel:child("respec_tree_button"))
	self._skill_tree_panel:child("respec_tree_button"):set_left(points_text:left())

	self._respec_text_id = "st_menu_respec_tree"
	--[[local skill_set_text = self._skill_tree_panel:text({
		name = "skill_set_text",
		vertical = "top",
		blend_mode = "add",
		align = "left",
		layer = 1,
		text = managers.localization:text("menu_st_skill_switch_set", {
			skill_switch = managers.skilltree:get_skill_switch_name(managers.skilltree:get_selected_skill_switch(), true)
		}),
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text
	})
	local skill_set_bg = self._skill_tree_panel:rect({
		name = "skill_set_bg",
		alpha = 0,
		blend_mode = "add",
		color = tweak_data.screen_colors.button_stage_3
	})

	self:make_fine_text(skill_set_text)

	local skill_switch_button = self._skill_tree_panel:text({
		vertical = "top",
		name = "switch_skills_button",
		wrap = true,
		align = "left",
		word_wrap = true,
		blend_mode = "add",
		layer = 0,
		text = prefix .. managers.localization:to_upper_text("menu_st_skill_switch_title"),
		font_size = tweak_data.menu.pd2_medium_font_size,
		font = tweak_data.menu.pd2_medium_font,
		color = Color.black,
		w = self._skill_tree_panel:w() * WIDTH_MULTIPLIER * 1 / 3 - 10
	})
	local _, _, _, h = skill_switch_button:text_rect()

	skill_switch_button:set_h(h)]]--

	local black_rect = self._fullscreen_panel:rect({
		layer = 1,
		color = Color(0.4, 0, 0, 0)
	})
	local blur = self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		render_template = "VertexColorTexturedBlur3D",
		layer = -1,
		w = self._fullscreen_ws:panel():w(),
		h = self._fullscreen_ws:panel():h()
	})

	local function func(o)
		over(0.6, function (p)
			o:set_alpha(p)
		end)
	end

	blur:animate(func)

	local tree_tab_h = math.round(self._skill_tree_panel:h() / 14)
	local tree_tabs_panel = self._skill_tree_panel:panel({
		name = "tree_tabs_panel",
		w = self._skill_tree_panel:w() * WIDTH_MULTIPLIER,
		h = tree_tab_h,
		y = TOP_ADJUSTMENT + 1
	})
	local controller_page_tab_panel = self._skill_tree_panel:panel({
		name = "controller_page_tab_panel"
	})

	controller_page_tab_panel:set_shape(tree_tabs_panel:shape())

	local skill_title_panel = self._skill_tree_panel:panel({
		name = "skill_title_panel",
		w = math.round(self._skill_tree_panel:w() * 0.4 - 54),
		h = math.round(tweak_data.menu.pd2_medium_font_size * 2)
	})
	self._skill_title_panel = skill_title_panel

	skill_title_panel:text({
		name = "text",
		vertical = "top",
		word_wrap = true,
		wrap = true,
		align = "left",
		blend_mode = "add",
		text = "",
		layer = 1,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size,
		color = tweak_data.screen_colors.text
	})

	local skill_description_panel = self._skill_tree_panel:panel({
		name = "skill_description_panel",
		w = math.round(self._skill_tree_panel:w() * (1 - WIDTH_MULTIPLIER) - BOX_GAP),
		h = math.round(self._skill_tree_panel:h() * 0.8)
	})
	self._skill_description_panel = skill_description_panel

	skill_description_panel:text({
		word_wrap = true,
		name = "text",
		vertical = "top",
		wrap = true,
		align = "left",
		valign = "scale",
		text = "",
		halign = "scale",
		layer = 1,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.text
	})
	skill_description_panel:text({
		word_wrap = true,
		name = "prerequisites_text",
		wrap = true,
		align = "left",
		text = "",
		vertical = "top",
		blend_mode = "add",
		valign = "scale",
		halign = "scale",
		layer = 1,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		h = tweak_data.menu.pd2_small_font_size + 10,
		color = tweak_data.screen_colors.important_1
	})

	self._tab_items = {}
	self._pages_order = {}
	self._pages = {}
	self._tree_tabs_scroll_panel = tree_tabs_panel:panel({
		name = "tree_tabs_scroll_panel",
		w = tree_tabs_panel:w() * WIDTH_MULTIPLIER
	})
	local tab_x = 0

	if not managers.menu:is_pc_controller() or managers.menu:is_steam_controller() then
		local button = managers.menu:is_steam_controller() and managers.localization:steam_btn("bumper_l") or managers.localization:get_default_macro("BTN_BOTTOM_L")
		local prev_page = controller_page_tab_panel:text({
			name = "prev_page",
			y = 0,
			w = 0,
			layer = 2,
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			text = button
		})
		local _, _, w = prev_page:text_rect()

		prev_page:set_w(w)
		prev_page:set_left(tab_x)

		tab_x = math.round(tab_x + w + 15)

		tree_tabs_panel:grow(-tab_x, 0)
		tree_tabs_panel:move(tab_x, 0)
	end

	tab_x = 0
	local skill_prerequisites = {}

	for skill_id, data in pairs(tweak_data.skilltree.skills) do
		if data.prerequisites then
			for _, id in ipairs(data.prerequisites) do
				skill_prerequisites[id] = skill_prerequisites[id] or {}

				table.insert(skill_prerequisites[id], skill_id)
			end
		end
	end

	for tree, data in ipairs(tweak_data.skilltree.trees) do
		local w = math.round(self._tree_tabs_scroll_panel:w() / #tweak_data.skilltree.trees * WIDTH_MULTIPLIER)
		local tab_item = SkillTreeTabItem:new(self._tree_tabs_scroll_panel, tree, data, w, tab_x)

		table.insert(self._tab_items, tab_item)

		local page = SkillTreePage:new(tree, data, self._skill_tree_panel, self._skill_tree_fullscreen_panel, tab_item._tree_tab:h(), skill_prerequisites)

		table.insert(self._pages_order, tree)

		self._pages[tree] = page
		local _, _, tw, _ = self._tab_items[tree]._tree_tab:child("tree_tab_name"):text_rect()
		tab_x = math.round(tab_x + tw + 15 + 5)
	end

	self._tree_tabs_scroll_panel:set_w(tab_x)

	local top_tier_panel = self._skill_tree_panel:child("1"):child("tier_panels"):child("tier_panel" .. tostring(#tweak_data.skilltree.trees[1].tiers))
	local bottom_tier_panel = self._skill_tree_panel:child("1"):child("tier_panels"):child("tier_panel1")

	skill_description_panel:set_right(self._skill_tree_panel:w())
	skill_description_panel:set_h(bottom_tier_panel:world_bottom() - top_tier_panel:world_top())
	skill_description_panel:set_world_top(top_tier_panel:world_top())

	local skill_box_panel = self._skill_tree_panel:panel({
		w = skill_description_panel:w(),
		h = skill_description_panel:h()
	})

	skill_box_panel:set_position(skill_description_panel:position())
	BoxGuiObject:new(skill_box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	points_text:set_top(skill_box_panel:bottom() + 10)

	local _, _, _, pth = points_text:text_rect()

	points_text:set_h(pth)

	local respec_tree_button = self._skill_tree_panel:child("respec_tree_button")

	if alive(respec_tree_button) then
		respec_tree_button:set_top(points_text:bottom())
	end

	local switch_skills_button = self._skill_tree_panel:child("switch_skills_button")

	if alive(switch_skills_button) then
		skill_set_text:set_top(points_text:top())
		switch_skills_button:set_top(points_text:bottom())
		skill_set_bg:set_shape(skill_set_text:left(), skill_set_text:top(), self._skill_tree_panel:w() * WIDTH_MULTIPLIER * 1 / 3 - 10, skill_set_text:h())
	end

	--self._skill_switch_highlight = true

	--self:check_skill_switch_button()
	skill_title_panel:set_left(skill_box_panel:left() + 10)
	skill_title_panel:set_top(skill_box_panel:top() + 10)
	skill_title_panel:set_w(skill_box_panel:w() - 20)
	skill_description_panel:set_top(skill_title_panel:bottom())
	skill_description_panel:set_h(skill_box_panel:h() - 20 - skill_title_panel:h())
	skill_description_panel:set_left(skill_box_panel:left() + 10)
	skill_description_panel:set_w(skill_box_panel:w() - 20)

	local tiers_box_panel = self._skill_tree_panel:panel({
		name = "tiers_box_panel"
	})

	tiers_box_panel:set_world_shape(top_tier_panel:world_left(), top_tier_panel:world_top(), top_tier_panel:w(), bottom_tier_panel:world_bottom() - top_tier_panel:world_top())
	BoxGuiObject:new(tiers_box_panel, {
		sides = {
			1,
			1,
			2,
			1
		}
	})

	if not managers.menu:is_pc_controller() or managers.menu:is_steam_controller() then
		local button = managers.menu:is_steam_controller() and managers.localization:steam_btn("bumper_r") or managers.localization:get_default_macro("BTN_BOTTOM_R")
		local next_page = controller_page_tab_panel:text({
			name = "next_page",
			y = 0,
			w = 0,
			layer = 2,
			h = tweak_data.menu.pd2_medium_font_size,
			font_size = tweak_data.menu.pd2_medium_font_size,
			font = tweak_data.menu.pd2_medium_font,
			text = button
		})
		local _, _, w = next_page:text_rect()

		next_page:set_w(w)
		next_page:set_right(controller_page_tab_panel:w())

		tab_x = math.round(w + 15)

		tree_tabs_panel:grow(-tab_x, 0)
	end

	self._spec_tab_items = {}
	self._spec_tree_items = {}
	self._specialization_highlighted = {}
	local specialization_data = tweak_data.skilltree.specializations or {}

	if #specialization_data > 0 then
		self._active_spec_tree = nil
		self._selected_spec_tier = nil
		local skill_tree_h = math.round(self._specialization_panel:h() / 14)
		local h = (self._specialization_panel:h() - skill_tree_h - TOP_ADJUSTMENT) / 8 * 7 + 10
		local spec_box_panel = self._specialization_panel:panel({
			name = "spec_box_panel"
		})

		spec_box_panel:set_shape(tiers_box_panel:x(), tiers_box_panel:y(), self._specialization_panel:w() * SPEC_WIDTH_MULTIPLIER, h)

		local spec_box = BoxGuiObject:new(spec_box_panel, {
			sides = {
				1,
				1,
				2,
				1
			}
		})

		spec_box:set_clipping(false)

		local desc_box_panel = self._specialization_panel:panel({
			name = "desc_box_panel"
		})

		desc_box_panel:set_shape(spec_box_panel:right() + 20, spec_box_panel:y(), 0, spec_box_panel:h())
		desc_box_panel:set_w(self._specialization_panel:w() - desc_box_panel:x())

		self._btns = {}
		local BTNS = {
			activate_spec = {
				btn = "BTN_Y",
				name = "menu_st_activate_spec",
				prio = 1,
				pc_btn = "menu_modify_item",
				callback = callback(self, self, "activate_specialization")
			},
			add_points = {
				btn = "BTN_A",
				prio = 2,
				name = "menu_st_add_spec_points"
			},
			remove_points = {
				btn = "BTN_X",
				name = "menu_st_remove_spec_points",
				prio = 3,
				pc_btn = "menu_remove_item"
			},
			max_points = {
				btn = "BTN_STICK_R",
				name = "menu_st_max_perk_deck",
				prio = 3,
				pc_btn = "menu_preview_item",
				callback = callback(self, self, "max_specialization")
			}
		}
		self._btn_panel = self._specialization_panel:panel({
			name = "btn_panel",
			h = 136,
			x = desc_box_panel:x(),
			w = desc_box_panel:w()
		})

		self._btn_panel:set_bottom(desc_box_panel:bottom())

		self._button_border = BoxGuiObject:new(self._btn_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})

		self._button_border:set_clipping(false)

		self._buttons = self._btn_panel:panel({})
		local btn_x = 10

		for btn, btn_data in pairs(BTNS) do
			local new_btn = SpecializationGuiButtonItem:new(self._buttons, btn_data, btn_x)
			self._btns[btn] = new_btn
		end

		desc_box_panel:grow(0, -self._btn_panel:h() - 10)

		self._desc_box = BoxGuiObject:new(desc_box_panel, {
			sides = {
				1,
				1,
				1,
				1
			}
		})

		self._desc_box:set_clipping(false)

		local spec_tab_h = skill_tree_h
		local spec_tabs_panel = self._specialization_panel:panel({
			name = "spec_tabs_panel",
			w = self._specialization_panel:w() * SPEC_WIDTH_MULTIPLIER,
			h = tree_tab_h,
			y = TOP_ADJUSTMENT + 1
		})
		self._spec_tabs_scroll_panel = spec_tabs_panel:panel({
			name = "spec_tabs_scroll_panel",
			w = spec_tabs_panel:w() * SPEC_WIDTH_MULTIPLIER
		})
		local controller_page_tab_panel = self._specialization_panel:panel({
			name = "controller_page_tab_panel"
		})

		controller_page_tab_panel:set_shape(spec_tabs_panel:shape())

		local tab_x = 0

		if not managers.menu:is_pc_controller() or managers.menu:is_steam_controller() then
			local button = managers.menu:is_steam_controller() and managers.localization:steam_btn("bumper_l") or managers.localization:get_default_macro("BTN_BOTTOM_L")
			local prev_page = controller_page_tab_panel:text({
				name = "prev_page",
				y = 0,
				w = 0,
				layer = 2,
				h = tweak_data.menu.pd2_medium_font_size,
				font_size = tweak_data.menu.pd2_medium_font_size,
				font = tweak_data.menu.pd2_medium_font,
				text = button
			})
			local _, _, w = prev_page:text_rect()

			prev_page:set_w(w)
			prev_page:set_left(tab_x)

			tab_x = math.round(tab_x + prev_page:w() + 15)

			spec_tabs_panel:grow(-tab_x, 0)
			spec_tabs_panel:move(tab_x, 0)
		end

		tab_x = 0
		local specialization_page_panel = spec_box_panel:panel({
			y = 0
		})

		for tree, data in ipairs(specialization_data) do
			local w = math.round(self._spec_tabs_scroll_panel:w() / #specialization_data * SPEC_WIDTH_MULTIPLIER)
			local tab_item = SpecializationTabItem:new(self._spec_tabs_scroll_panel, tree, data, w, tab_x)

			table.insert(self._spec_tab_items, tab_item)

			local tree_item = SpecializationTreeItem:new(tree, specialization_page_panel, tab_item)

			table.insert(self._spec_tree_items, tree_item)

			local _, _, tw, _ = self._spec_tab_items[tree]._spec_tab:child("spec_tab_name"):text_rect()
			tab_x = math.round(tab_x + tw + 15 + 5)
		end

		self._spec_tabs_scroll_panel:set_w(tab_x)
		specialization_page_panel:set_h(self._spec_tree_items[#self._spec_tree_items]:panel():bottom())

		self._specialization_page_panel = specialization_page_panel
		self._spec_scroll_up_box = BoxGuiObject:new(spec_box_panel, {
			sides = {
				0,
				0,
				2,
				0
			}
		})
		self._spec_scroll_down_box = BoxGuiObject:new(spec_box_panel, {
			sides = {
				0,
				0,
				0,
				2
			}
		})
		self._specialization_scroll_y = 1

		self._spec_scroll_up_box:set_visible(false)
		self._spec_scroll_down_box:set_visible(NUM_TREES_PER_PAGE < #self._spec_tree_items)

		self._spec_tree_height = self._spec_tree_items[2]:panel():top()

		if not managers.menu:is_pc_controller() or managers.menu:is_steam_controller() then
			local button = managers.menu:is_steam_controller() and managers.localization:steam_btn("bumper_r") or managers.localization:get_default_macro("BTN_BOTTOM_R")
			local next_page = controller_page_tab_panel:text({
				name = "next_page",
				y = 0,
				w = 0,
				layer = 2,
				h = tweak_data.menu.pd2_medium_font_size,
				font_size = tweak_data.menu.pd2_medium_font_size,
				font = tweak_data.menu.pd2_medium_font,
				text = button
			})
			local _, _, w = next_page:text_rect()

			next_page:set_w(w)
			next_page:set_right(controller_page_tab_panel:w())

			tab_x = math.round(next_page:w() + 15)

			spec_tabs_panel:grow(-tab_x, 0)
		end

		self._spec_scroll_bar_panel = self._specialization_panel:panel({
			w = 20,
			name = "spec_scroll_bar_panel",
			h = spec_box_panel:h()
		})

		self._spec_scroll_bar_panel:set_world_left(spec_box_panel:world_right())
		self._spec_scroll_bar_panel:set_world_top(spec_box_panel:world_top())

		local texture, rect = tweak_data.hud_icons:get_icon_data("scrollbar_arrow")
		local scroll_up_indicator_arrow = self._spec_scroll_bar_panel:bitmap({
			name = "scroll_up_indicator_arrow",
			layer = 2,
			texture = texture,
			texture_rect = rect,
			color = Color.white
		})

		scroll_up_indicator_arrow:set_center_x(self._spec_scroll_bar_panel:w() / 2)

		local texture, rect = tweak_data.hud_icons:get_icon_data("scrollbar_arrow")
		local scroll_down_indicator_arrow = self._spec_scroll_bar_panel:bitmap({
			name = "scroll_down_indicator_arrow",
			layer = 2,
			rotation = 180,
			texture = texture,
			texture_rect = rect,
			color = Color.white
		})

		scroll_down_indicator_arrow:set_bottom(self._spec_scroll_bar_panel:h())
		scroll_down_indicator_arrow:set_center_x(self._spec_scroll_bar_panel:w() / 2)

		local bar_h = scroll_down_indicator_arrow:top() - scroll_up_indicator_arrow:bottom()

		self._spec_scroll_bar_panel:rect({
			alpha = 0.05,
			w = 4,
			color = Color.black,
			y = scroll_up_indicator_arrow:bottom(),
			h = bar_h
		}):set_center_x(self._spec_scroll_bar_panel:w() / 2)

		bar_h = scroll_down_indicator_arrow:bottom() - scroll_up_indicator_arrow:top()
		local scroll_bar = self._spec_scroll_bar_panel:panel({
			name = "scroll_bar",
			layer = 2,
			h = bar_h
		})
		local scroll_bar_box_panel = scroll_bar:panel({
			w = 4,
			name = "scroll_bar_box_panel",
			valign = "scale",
			halign = "scale"
		})
		self._spec_scroll_bar_box_class = BoxGuiObject:new(scroll_bar_box_panel, {
			sides = {
				2,
				2,
				0,
				0
			}
		})

		self._spec_scroll_bar_box_class:set_aligns("scale", "scale")
		scroll_bar_box_panel:set_w(8)
		scroll_bar_box_panel:set_center_x(scroll_bar:w() / 2)
		scroll_bar:set_top(scroll_up_indicator_arrow:top())
		scroll_bar:set_center_x(scroll_up_indicator_arrow:center_x())

		local points_text = self._specialization_panel:text({
			word_wrap = false,
			name = "points_text",
			vertical = "top",
			wrap = false,
			align = "left",
			layer = 1,
			text = utf8.to_upper(managers.localization:text("menu_st_available_spec_points", {
				points = managers.money:add_decimal_marks_to_string(tostring(managers.skilltree:specialization_points()))
			})),
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.text
		})

		make_fine_text(points_text)
		points_text:set_right(spec_box_panel:right())
		points_text:set_top(spec_box_panel:bottom() + 20)

		local spec_description_panel = desc_box_panel:panel({
			halign = "grow",
			valign = "grow"
		})

		spec_description_panel:grow(-20, -20)
		spec_description_panel:move(10, 10)

		self._spec_description_title = spec_description_panel:text({
			word_wrap = true,
			blend_mode = "normal",
			wrap = true,
			text = "",
			halign = "grow",
			valign = "grow",
			font = tweak_data.menu.pd2_medium_font,
			font_size = tweak_data.menu.pd2_medium_font_size,
			color = tweak_data.screen_colors.text
		})
		self._spec_description_locked = spec_description_panel:text({
			word_wrap = true,
			blend_mode = "add",
			wrap = true,
			text = "",
			halign = "grow",
			valign = "grow",
			font = tweak_data.menu.pd2_medium_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.important_1
		})
		self._spec_description_text = spec_description_panel:text({
			word_wrap = true,
			blend_mode = "normal",
			wrap = true,
			text = "",
			halign = "grow",
			valign = "grow",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.text
		})
		self._spec_description_progress = spec_description_panel:text({
			word_wrap = true,
			blend_mode = "normal",
			wrap = true,
			text = "",
			halign = "grow",
			valign = "grow",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			color = tweak_data.screen_colors.text
		})
	end

	self:show_btns()
	self:_set_active_skill_page(managers.skilltree:get_most_progressed_tree())
	self:_set_active_spec_tree(managers.skilltree:get_specialization_value("current_specialization"))
	self:set_selected_item(self._active_page:item(), true)

	self._use_skilltree = add_skilltree or false
	self._use_specialization = add_specialization or false

	if not self._use_skilltree then
		skilltree_text:hide()
		specialization_text:set_left(skilltree_text:left())
	end

	self:set_skilltree_page_active(self._use_skilltree)
	self:_rec_round_object(self._panel)
end

function SkillTreeGui:mouse_pressed(button, x, y)
	if self._renaming_skill_switch then
		--self:_stop_rename_skill_switch()

		return
	end

	if not self._enabled then
		return
	end

	if self._spec_placing_points then
		return
	end

	if button == Idstring("mouse wheel down") then
		if self._is_skilltree_page_active and self._use_skilltree then
			self:activate_next_tree_panel()
		elseif not self._is_skilltree_page_active and self._use_specialization then
			if self._spec_scroll_bar_panel:inside(x, y) or self._specialization_panel:child("spec_box_panel"):inside(x, y) then
				self:set_spec_scroll_indicators(self._specialization_scroll_y + 1)
			elseif self._specialization_panel:child("spec_tabs_panel"):inside(x, y) then
				self:activate_next_spec_panel()
			end
		end

		return
	elseif button == Idstring("mouse wheel up") then
		if self._is_skilltree_page_active and self._use_skilltree then
			self:activate_prev_tree_panel()
		elseif not self._is_skilltree_page_active and self._use_specialization then
			if self._spec_scroll_bar_panel:inside(x, y) or self._specialization_panel:child("spec_box_panel"):inside(x, y) then
				self:set_spec_scroll_indicators(self._specialization_scroll_y - 1)
			elseif self._specialization_panel:child("spec_tabs_panel"):inside(x, y) then
				self:activate_prev_spec_panel()
			end
		end

		return
	end

	if button == Idstring("0") then
		local skilltree_text = self._panel:child("skilltree_text")
		local title_bg = self._fullscreen_panel:child("title_bg")

		if not self._is_skilltree_page_active and self._use_skilltree and skilltree_text:inside(x, y) then
			self:set_skilltree_page_active(true)

			return
		end

		if self._panel:child("back_button"):inside(x, y) then
			managers.menu:back()

			return
		end

		if self._is_skilltree_page_active and self._use_skilltree then
			if self._skill_tree_panel:child("respec_tree_button"):inside(x, y) then
				self:respec_active_tree()

				return
			end

			--[[if self._skill_tree_panel:child("switch_skills_button"):inside(x, y) then
				managers.menu:open_node("skill_switch", {})

				return
			end

			if self._skill_tree_panel:child("skill_set_bg"):inside(x, y) then
				self:_start_rename_skill_switch()

				return
			end]]--

			if self._active_page then
				for _, item in ipairs(self._active_page._items) do
					if item:inside(x, y) then
						self:place_point(item)

						return true
					end
				end
			end

			for _, tab_item in ipairs(self._tab_items) do
				if tab_item:inside(x, y) then
					if self._active_tree ~= tab_item:tree() then
						self:set_active_page(tab_item:tree(), true)
					end

					return true
				end
			end
		elseif not self._is_skilltree_page_active and self._use_specialization then
			if self._specialization_panel:child("spec_tabs_panel"):inside(x, y) then
				for _, tab_item in ipairs(self._spec_tab_items) do
					if tab_item:inside(x, y) then
						if self._active_spec_tree ~= tab_item:tree() then
							self:set_active_page(tab_item:tree(), true)
						end

						return true
					end
				end
			end

			for _, tree_item in ipairs(self._spec_tree_items) do
				local selected_item = tree_item:selected_item(x, y)

				if selected_item then
					self:set_active_page(selected_item:tree(), true)

					return true
				else
					local count_dir = tree_item:selected_btn(x, y)

					if count_dir then
						self:start_spec_place_points(count_dir, tree_item:tree())

						return
					end
				end
			end

			if self:check_spec_grab_scroll_bar(x, y) then
				return
			end

			if self._spec_scroll_bar_panel:child("scroll_up_indicator_arrow"):inside(x, y) then
				self:set_spec_scroll_indicators(self._specialization_scroll_y - 1)

				return
			elseif self._spec_scroll_bar_panel:child("scroll_down_indicator_arrow"):inside(x, y) then
				self:set_spec_scroll_indicators(self._specialization_scroll_y + 1)

				return
			end

			if self._button_highlighted and self._btns[self._button_highlighted] and self._btns[self._button_highlighted]:inside(x, y) then
				local data = self._btns[self._button_highlighted]:data()

				if data.callback and (not self._button_press_delay or self._button_press_delay < TimerManager:main():time()) then
					managers.menu_component:post_event("menu_enter")
					data.callback(self._active_spec_tree, self._selected_spec_tier)

					self._button_press_delay = TimerManager:main():time() + 0.2
				end
			end
		end
	end
end

function SkillTreeGui:mouse_moved(o, x, y)
	if self._renaming_skill_switch then
		return true, "link"
	end

	if not self._enabled then
		return
	end

	if self._spec_placing_points then
		return true, "grab"
	end

	local inside = false
	local pointer = "arrow"

	if not self._is_skilltree_page_active and self._use_skilltree then
		local skilltree_text = self._panel:child("skilltree_text")

		if skilltree_text:inside(x, y) then
			if not self._skilltree_text_highlighted then
				self._skilltree_text_highlighted = true

				skilltree_text:set_color(tweak_data.screen_colors.button_stage_2)
				managers.menu_component:post_event("highlight")
			end

			inside = true
			pointer = "link"
		elseif self._skilltree_text_highlighted then
			self._skilltree_text_highlighted = false

			skilltree_text:set_color(tweak_data.screen_colors.button_stage_3)
		end
	end

	if self._is_skilltree_page_active and self._use_skilltree then
		if self:check_respec_button(x, y) then
			inside = true
			pointer = "link"
		--[[elseif self:check_skill_switch_button(x, y) then
			inside = true
			pointer = "link"]]--
		end

		if self._active_page then
			for _, item in ipairs(self._active_page._items) do
				if item:inside(x, y) then
					self:set_selected_item(item)

					inside = true
					pointer = "link"
				end
			end
		end

		for _, tab_item in ipairs(self._tab_items) do
			if tab_item:inside(x, y) then
				local same_tab_item = self._active_tree == tab_item:tree()

				self:set_selected_item(tab_item, true)

				inside = true
				pointer = same_tab_item and "arrow" or "link"
			end
		end
	elseif not self._is_skilltree_page_active and self._use_specialization then
		local inside2, pointer2 = self:moved_scroll_bar(x, y)

		if inside2 then
			return inside2, pointer2
		end

		if self._specialization_panel:child("spec_tabs_panel"):inside(x, y) then
			for _, tab_item in ipairs(self._spec_tab_items) do
				if tab_item:inside(x, y) then
					local same_tab_item = self._active_spec_tree == tab_item:tree()

					self:set_selected_item(tab_item, true)

					inside = true
					pointer = same_tab_item and "arrow" or "link"
				end
			end
		end

		for _, tab_item in ipairs(self._spec_tree_items) do
			local selected_item = tab_item:selected_item(x, y)

			if selected_item then
				self:set_hover_spec_item(selected_item)

				inside = true
				pointer = "link"

				break
			elseif tab_item:selected_btn(x, y) then
				inside = true
				pointer = "hand"

				break
			end
		end

		local update_select = false

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
	end

	if managers.menu:is_pc_controller() then
		if self._panel:child("back_button"):inside(x, y) then
			if not self._back_highlight then
				self._back_highlight = true

				self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_2)
				managers.menu_component:post_event("highlight")
			end

			inside = true
			pointer = "link"
		elseif self._back_highlight then
			self._back_highlight = false

			self._panel:child("back_button"):set_color(tweak_data.screen_colors.button_stage_3)
		end
	end

	if not inside and self._panel:inside(x, y) then
		inside = true
		pointer = "arrow"
	end

	return inside, pointer
end

function SkillTreeGui:set_skilltree_page_active(active)
	if self._is_skilltree_page_active ~= active then
		local specialization_text = self._panel:child("specialization_text")
		local skilltree_text = self._panel:child("skilltree_text")
		local title_bg = self._fullscreen_panel:child("title_bg")
		self._is_skilltree_page_active = active

		skilltree_text:set_color(active and tweak_data.screen_colors.text or tweak_data.screen_colors.button_stage_3)
		title_bg:set_text((active and skilltree_text):text())

		local wx = active and skilltree_text:world_x()
		local wy = active and skilltree_text:world_center_y()
		local x, y = managers.gui_data:safe_to_full_16_9(wx, wy)

		title_bg:set_world_left(x)
		title_bg:set_world_center_y(y)
		title_bg:move(-13, 9)
		self._skill_tree_panel:set_visible(active)
		self._specialization_panel:set_visible(not active)
		self._skill_tree_fullscreen_panel:set_visible(active)
		self._specialization_fullscreen_panel:set_visible(not active)

		self._skilltree_text_highlighted = active

		if self._is_skilltree_page_active then
			self:set_selected_item(self._active_page:item(), true)
		else
			self:_set_active_spec_tree(managers.skilltree:get_specialization_value("current_specialization"))

			local current_tier = managers.skilltree:get_specialization_value(self._active_spec_tree, "tiers", "current_tier") + 1
			local next_tier = math.clamp(current_tier, 1, managers.skilltree:get_specialization_value(self._active_spec_tree, "tiers", "max_tier"))

			self:set_selected_item(self._spec_tree_items[self._active_spec_tree]:item(next_tier), true)
		end

		if not active then
			self:_chk_specialization_present()
		end
	end
end