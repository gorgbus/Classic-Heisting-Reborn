LevelLoadingScreenGuiScript = LevelLoadingScreenGuiScript or class()
function LevelLoadingScreenGuiScript:init(scene_gui, res, progress, base_layer)
	self._scene_gui = scene_gui
	self._res = res
	self._base_layer = base_layer
	self._level_tweak_data = arg.load_level_data.level_tweak_data
	self._gui_tweak_data = arg.load_level_data.gui_tweak_data
	self._menu_tweak_data = arg.load_level_data.menu_tweak_data
	self._scale_tweak_data = arg.load_level_data.scale_tweak_data
	self._gui_data = arg.load_level_data.gui_data
	self._workspace_size = self._gui_data.workspace_size
	self._saferect_size = self._gui_data.saferect_size
	local challenges = arg.load_level_data.challenges
	local safe_rect_pixels = self._gui_data.safe_rect_pixels
	local safe_rect = self._gui_data.safe_rect
	local aspect_ratio = self._gui_data.aspect_ratio
	self._safe_rect_pixels = safe_rect_pixels
	self._safe_rect = safe_rect
	self._gui_data_manager = GuiDataManager:new(self._scene_gui, res, safe_rect_pixels, safe_rect, aspect_ratio)
	self._back_drop_gui = MenuBackdropGUI:new(nil, self._gui_data_manager, true)

	self._back_drop_gui:set_pattern("guis/textures/loading/loading_foreground", 1)

	local base_panel = self._back_drop_gui:get_new_base_layer()
	local level_image = base_panel:bitmap({
		layer = 0,
		texture = "guis/textures/loading/loading_bg"
	})

	level_image:set_alpha(0.5)

	local level_image_ratio = level_image:texture_width() / level_image:texture_height()

	level_image:set_size(level_image:parent():h() * level_image_ratio, level_image:parent():h())
	level_image:set_center_x(level_image:parent():w() / 2)
	level_image:set_y(0)

	local background_fullpanel = self._back_drop_gui:get_new_background_layer()
	local background_safepanel = self._back_drop_gui:get_new_background_layer()

	self._back_drop_gui:set_panel_to_saferect(background_safepanel)

	if arg.load_level_data.tip then
		self._loading_hint = self:_make_loading_hint(background_safepanel, arg.load_level_data.tip)
	end

	self._indicator = background_safepanel:bitmap({
		texture = "guis/textures/icon_loading",
		name = "indicator",
		layer = 0
	})
	self._level_title_text = background_safepanel:text({
		y = 0,
		vertical = "bottom",
		h = 36,
		text_id = "debug_loading_level",
		font_size = 36,
		align = "left",
		font = "fonts/font_large_mf",
		halign = "left",
		layer = 0,
		color = Color.white
	})

	self._level_title_text:set_text(utf8.to_upper(self._level_title_text:text()))

	local _, _, w, h = self._level_title_text:text_rect()

	self._level_title_text:set_size(w, h)
	self._indicator:set_right(self._indicator:parent():w())
	self._level_title_text:set_right(self._indicator:left())

	local bg_loading_text = background_fullpanel:text({
		vertical = "top",
		h = 80,
		text_id = "debug_loading_level",
		font_size = 80,
		align = "right",
		font = "fonts/font_eroded",
		y = 0,
		layer = 0,
		color = Color(0.3, 0.3803921568627451, 0.8392156862745098, 1)
	})

	bg_loading_text:set_text(utf8.to_upper(bg_loading_text:text()))

	local x = self._level_title_text:world_right()
	local y = self._level_title_text:world_center_y()

	bg_loading_text:set_world_right(x)
	bg_loading_text:set_world_center_y(y)
	bg_loading_text:move(13, 3)
	self._back_drop_gui:animate_bg_text(bg_loading_text)

	local coords = arg.load_level_data.controller_coords

	if coords then
		self._controller = self:_make_controller_hint(background_safepanel, coords)

		if arg.load_level_data.tip then
			self._controller:move(0, -110)
		end
	end
end