function Setup:_start_loading_screen()
	if Global.is_loading then
		Application:stack_dump_error("[LoadingEnvironment] Tried to start loading screen when it was already started.")

		return
	elseif not SystemInfo:threaded_renderer() then
		cat_print("loading_environment", "[LoadingEnvironment] Skipped (renderer is not threaded).")

		Global.is_loading = true

		return
	end

	cat_print("loading_environment", "[LoadingEnvironment] Start.")

	local setup = nil

	if not LoadingEnvironmentScene:loaded() then
		LoadingEnvironmentScene:load("levels/zone", false)
	end

	local load_level_data = nil

	if Global.load_level then
		if not PackageManager:loaded("packages/load_level") then
			PackageManager:load("packages/load_level")
		end

		local using_steam_controller = false
		local show_controller = managers.user:get_setting("loading_screen_show_controller")
		setup = "lib/setups/LevelLoadingSetup"
		load_level_data = {
			level_data = Global.level_data,
			level_tweak_data = tweak_data.levels[Global.level_data.level_id] or {}
		}
		load_level_data.level_tweak_data.name = load_level_data.level_tweak_data.name_id and managers.localization:text(load_level_data.level_tweak_data.name_id)
		load_level_data.gui_tweak_data = tweak_data.load_level
		load_level_data.menu_tweak_data = tweak_data.menu
		load_level_data.scale_tweak_data = tweak_data.scale

		if show_controller then
			if not using_steam_controller then
				local coords = tweak_data:get_controller_help_coords()
				load_level_data.controller_coords = coords and coords[table.random({
					"normal",
					"vehicle"
				})]
				load_level_data.controller_image = "guis/textures/controller"
				load_level_data.controller_shapes = {
					{
						position = {
							cy = 0.5,
							cx = 0.5
						},
						texture_rect = {
							0,
							0,
							512,
							256
						}
					}
				}
			end

			if load_level_data.controller_coords then
				for id, data in pairs(load_level_data.controller_coords) do
					data.string = data.localize == false and data.id or managers.localization:to_upper_text(data.id)
					data.color = (data.id == "menu_button_unassigned" or data.localize == false) and Color(0.5, 0.5, 0.5) or Color.white
				end
			end
		end

		local load_data = load_level_data.level_tweak_data.load_data
		local safe_rect_pixels = managers.viewport:get_safe_rect_pixels()
		local safe_rect = managers.viewport:get_safe_rect()
		local aspect_ratio = managers.viewport:aspect_ratio()
		local res = RenderSettings.resolution
		local job_data = managers.job:current_job_data() or {}
		local bg_texture = load_level_data.level_tweak_data.load_screen or job_data.load_screen or load_data and load_data.image
		load_level_data.gui_data = {
			safe_rect_pixels = safe_rect_pixels,
			safe_rect = safe_rect,
			aspect_ratio = aspect_ratio,
			res = res,
			workspace_size = {
				x = 0,
				y = 0,
				w = res.x,
				h = res.y
			},
			saferect_size = {
				x = safe_rect.x,
				y = safe_rect.y,
				w = safe_rect.width,
				h = safe_rect.height
			},
			bg_texture = bg_texture or "guis/textures/loading/loading_bg"
		}
	elseif not Global.boot_loading_environment_done then
		setup = "lib/setups/LightLoadingSetup"
	else
		setup = "lib/setups/HeavyLoadingSetup"
	end

	self:_setup_loading_environment()

	local data = {
		res = RenderSettings.resolution,
		layer = tweak_data.gui.LOADING_SCREEN_LAYER,
		load_level_data = load_level_data,
		is_win32 = SystemInfo:platform() == Idstring("WIN32"),
		vr_overlays = Global.__vr_overlays
	}

	LoadingEnvironment:start(setup, "LoadingEnvironmentScene", data)

	Global.is_loading = true
end