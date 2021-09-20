function HUDManager:safe_house_challenge_popup(id, c_type)
end

function HUDManager:challenge_popup(d)
end

local data = HUDManager.init

function HUDManager:_add_name_label(data)
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	local last_id = self._hud.name_labels[#self._hud.name_labels] and self._hud.name_labels[#self._hud.name_labels].id or 0
	local id = last_id + 1
	local character_name = data.name
	local rank = 0
	local peer_id = nil
	local is_husk_player = data.unit:base().is_husk_player

	if is_husk_player then
		peer_id = data.unit:network():peer():id()
		local level = data.unit:network():peer():level()
		rank = data.unit:network():peer():rank()

		if level then
			local experience = (rank > 0 and managers.experience:rank_string(rank) .. "-" or "") .. level
			data.name = data.name .. " (" .. experience .. ")"
		end
	end

	local panel = hud.panel:panel({name = "name_label" .. id})
	local radius = 24
	local interact = CircleBitmapGuiObject:new(panel, {
		blend_mode = "add",
		use_bg = true,
		layer = 0,
		radius = radius,
		color = Color.white
	})

	interact:set_visible(false)

	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bag_rect = {
		2,
		34,
		20,
		17
	}
	local color_id = managers.criminals:character_color_id_by_unit(data.unit)
	local crim_color = tweak_data.chat_colors[color_id] or tweak_data.chat_colors[#tweak_data.chat_colors]
	local text = panel:text({
		name = "text",
		vertical = "top",
		h = 18,
		w = 256,
		align = "left",
		layer = -1,
		text = utf8.to_upper(data.name),		--text = data.name, --no upper
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = crim_color
	})
	local bag = panel:bitmap({
		name = "bag",
		layer = 0,
		visible = false,
		y = 1,
		x = 1,
		texture = tabs_texture,
		texture_rect = bag_rect,
		color = (crim_color * 1.1):with_alpha(1)
	})

	panel:text({
		w = 256,
		name = "cheater",
		h = 18,
		align = "center",
		visible = false,
		layer = -1,
		text = utf8.to_upper(managers.localization:text("menu_hud_cheater")),
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = tweak_data.screen_colors.pro_color
	})
	panel:text({
		vertical = "bottom",
		name = "action",
		h = 18,
		w = 256,
		align = "left",
		visible = false,
		rotation = 360,
		layer = -1,
		text = utf8.to_upper("Fixing"),
		font = tweak_data.hud.medium_font,
		font_size = tweak_data.hud.name_label_font_size,
		color = (crim_color * 1.1):with_alpha(1)
	})

	if rank > 0 then
		local infamy_icon = tweak_data.hud_icons:get_icon_data("infamy_icon")

		panel:bitmap({
			name = "infamy",
			h = 32,
			w = 16,
			layer = 0,
			texture = infamy_icon,
			color = crim_color
		})
	end

	self:align_teammate_name_label(panel, interact)
	table.insert(self._hud.name_labels, {
		movement = data.unit:movement(),
		panel = panel,
		text = text,
		id = id,
		peer_id = peer_id,
		character_name = character_name,
		interact = interact,
		bag = bag
	})

	return id
end