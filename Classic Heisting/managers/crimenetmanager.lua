function CrimeNetManager:_get_jobs_by_jc()
	local t = {}
	local plvl = managers.experience:current_level()

	for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local is_cooldown_ok = managers.job:check_ok_with_cooldown(job_id)
		local is_not_wrapped = not tweak_data.narrative.jobs[job_id].wrapped_to_job
		local dlc = tweak_data.narrative:job_data(job_id).dlc
		local is_not_dlc_or_got = not dlc or managers.dlc:is_dlc_unlocked(dlc)
		local pass_all_tests = is_cooldown_ok and is_not_wrapped and is_not_dlc_or_got
		pass_all_tests = pass_all_tests and not tweak_data.narrative:is_job_locked(job_id)

		if pass_all_tests then
			local job_data = tweak_data.narrative:job_data(job_id)
			local start_difficulty = job_data.professional and 1 or 0
			local num_difficulties = Global.SKIP_OVERKILL_290 and 5 or job_data.professional and 6 or 6

			for i = start_difficulty, num_difficulties, 1 do
				local job_jc = math.clamp(job_data.jc + i * 10, 0, 100)
				local difficulty_id = 2 + i
				local difficulty = tweak_data:index_to_difficulty(difficulty_id)
				local level_lock = tweak_data.difficulty_level_locks[difficulty_id] or 0
				local is_not_level_locked = level_lock <= plvl

				if is_not_level_locked then
					t[job_jc] = t[job_jc] or {}

					table.insert(t[job_jc], {
						job_id = job_id,
						difficulty_id = difficulty_id,
						difficulty = difficulty,
						marker_dot_color = job_data.marker_dot_color or nil,
						color_lerp = job_data.color_lerp or nil
					})
				end
			end
		else
			print("SKIP DUE TO COOLDOWN OR THE JOB IS WRAPPED INSIDE AN OTHER JOB", job_id)
		end
	end

	return t
end

function CrimeNetManager:_setup()
	if self._presets then
		return
	end

	self._presets = {}
	local plvl = managers.experience:current_level()
	local player_stars = math.clamp(math.ceil((plvl + 1) / 10), 1, 10)
	local stars = player_stars
	local jc = math.lerp(0, 100, stars / 10)
	local jcs = tweak_data.narrative.STARS[stars].jcs
	local no_jcs = #jcs
	local chance_curve = tweak_data.narrative.STARS_CURVES[player_stars]
	local start_chance = tweak_data.narrative.JC_CHANCE
	local jobs_by_jc = self:_get_jobs_by_jc()
	local no_picks = self:_number_of_jobs(jcs, jobs_by_jc)
	local j = 0
	local tests = 0

	while j < no_picks do
		for i = 1, no_jcs do
			local chance = nil

			if no_jcs - 1 == 0 then
				chance = 1
			else
				chance = math.lerp(start_chance, 1, math.pow((i - 1) / (no_jcs - 1), chance_curve))
			end

			if not jobs_by_jc[jcs[i]] then
				-- Nothing
			elseif #jobs_by_jc[jcs[i]] ~= 0 then
				local job_data = nil

				if self._debug_mass_spawning then
					job_data = jobs_by_jc[jcs[i]][math.random(#jobs_by_jc[jcs[i]])]
				else
					job_data = table.remove(jobs_by_jc[jcs[i]], math.random(#jobs_by_jc[jcs[i]]))
				end

				local job_tweak = tweak_data.narrative:job_data(job_data.job_id)
				local chance_multiplier = job_tweak and job_tweak.spawn_chance_multiplier or 1
				job_data.chance = chance * chance_multiplier

				table.insert(self._presets, job_data)

				j = j + 1

				break
			end
		end

		tests = tests + 1

		if self._debug_mass_spawning then
			if tweak_data.gui.crime_net.debug_options.mass_spawn_limit <= tests then
				break
			end
		elseif no_picks <= tests then
			break
		end
	end

	local old_presets = self._presets
	self._presets = {}

	while #old_presets > 0 do
		table.insert(self._presets, table.remove(old_presets, math.random(#old_presets)))
	end
end

function CrimeNetManager:update_difficulty_filter()
	if self._presets then
		self._presets = nil

		self:_setup()
	end
end

function CrimeNetGui:add_special_contracts(no_casino, no_quickplay)

	for index, special_contract in ipairs(tweak_data.gui.crime_net.special_contracts) do
		local skip = false

		if managers.custom_safehouse:unlocked() and special_contract.id == "challenge" or not managers.custom_safehouse:unlocked() and special_contract.id == "safehouse" then
			skip = true
		end

		skip = skip or special_contract.sp_only and not Global.game_settings.single_player
		skip = skip or special_contract.mp_only and Global.game_settings.single_player
		skip = skip or special_contract.no_session_only and managers.network:session()

		if not skip then
			self:add_special_contract(special_contract, no_casino, no_quickplay)
		end
	end
end

function CrimeNetGui:open_filters(o, k)
	if k == Idstring("f") and alive(self._panel:child("filters_button")) then
		if _G.already_open and managers.chat._crimenet_chat_state then
			managers.menu:open_node("crimenet_filters", {})
			_G.already_open = false
		end
	end
end

Hooks:PreHook(CrimeNetGui, "update_job_gui", "old_skulls", function(data, job, inside)
	local stars_panel = job.side_panel:child("stars_panel")
	stars_panel:set_w(44)
end)

local orig_mouse_pressed = CrimeNetGui.mouse_pressed
function CrimeNetGui:mouse_pressed(o, button, x, y)
	if not self._crimenet_enabled or self._getting_hacked then
		return
	end
	local filters_button = self._panel:child("filters_button")
	if alive(filters_button) and filters_button:inside(x, y) then
		managers.menu:open_node("crimenet_filters", {}) 
		return true
	end
	return orig_mouse_pressed(self, o, button, x, y)
end

Hooks:PostHook(CrimeNetGui, "mouse_moved", "mouse_movedFilter", function(self, o, x, y)
	if not self._crimenet_enabled or self._getting_hacked then
		return
	end
	local filters_button = self._panel:child("filters_button")
	if alive(filters_button) then
		if filters_button:inside(x, y) then
			if not self._filters_highlighted then
				self._filters_highlighted = true
				filters_button:set_color(tweak_data.screen_colors.button_stage_2)
				managers.menu_component:post_event("highlight")
			end
		elseif self._filters_highlighted then
			self._filters_highlighted = false
			filters_button:set_color(tweak_data.screen_colors.button_stage_3)
		end
	end
end)

function CrimeNetGui:init(ws, fullscreeen_ws, node)
	self._tweak_data = tweak_data.gui.crime_net
	self._crimenet_enabled = true

	managers.crimenet:set_getting_hacked(false)
	managers.menu_component:post_event("crime_net_startup")
	managers.menu_component:close_contract_gui()

	local no_servers = node:parameters().no_servers

	if no_servers then
		managers.crimenet:start_no_servers()
	else
		managers.crimenet:start()
	end

	managers.menu:active_menu().renderer.ws:hide()

	local safe_scaled_size = managers.gui_data:safe_scaled_size()
	self._ws = ws
	self._fullscreen_ws = fullscreeen_ws
	self._fullscreen_panel = self._fullscreen_ws:panel():panel({
		name = "fullscreen"
	})
	self._panel = self._ws:panel():panel({
		name = "main"
	})
	local full_16_9 = managers.gui_data:full_16_9_size()

	self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_top",
		render_template = "VertexColorTexturedBlur3D",
		rotation = 360,
		x = 0,
		layer = 1001,
		w = self._fullscreen_ws:panel():w(),
		h = full_16_9.convert_y * 2,
		y = -full_16_9.convert_y
	})
	self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_right",
		render_template = "VertexColorTexturedBlur3D",
		rotation = 360,
		y = 0,
		layer = 1001,
		w = full_16_9.convert_x * 2,
		h = self._fullscreen_ws:panel():h(),
		x = self._fullscreen_ws:panel():w() - full_16_9.convert_x
	})
	self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_bottom",
		render_template = "VertexColorTexturedBlur3D",
		rotation = 360,
		x = 0,
		layer = 1001,
		w = self._fullscreen_ws:panel():w(),
		h = full_16_9.convert_y * 2,
		y = self._fullscreen_ws:panel():h() - full_16_9.convert_y
	})
	self._fullscreen_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "blur_left",
		render_template = "VertexColorTexturedBlur3D",
		rotation = 360,
		y = 0,
		layer = 1001,
		w = full_16_9.convert_x * 2,
		h = self._fullscreen_ws:panel():h(),
		x = -full_16_9.convert_x
	})
	self._panel:rect({
		blend_mode = "add",
		h = 2,
		y = 0,
		x = 0,
		layer = 1,
		w = self._panel:w(),
		color = tweak_data.screen_colors.crimenet_lines
	})
	self._panel:rect({
		blend_mode = "add",
		h = 2,
		y = 0,
		x = 0,
		layer = 1,
		w = self._panel:w(),
		color = tweak_data.screen_colors.crimenet_lines
	}):set_bottom(self._panel:h())
	self._panel:rect({
		blend_mode = "add",
		y = 0,
		w = 2,
		x = 0,
		layer = 1,
		h = self._panel:h(),
		color = tweak_data.screen_colors.crimenet_lines
	}):set_right(self._panel:w())
	self._panel:rect({
		blend_mode = "add",
		y = 0,
		w = 2,
		x = 0,
		layer = 1,
		h = self._panel:h(),
		color = tweak_data.screen_colors.crimenet_lines
	})

	self._rasteroverlay = self._fullscreen_panel:bitmap({
		texture = "guis/textures/crimenet_map_rasteroverlay",
		name = "rasteroverlay",
		layer = 3,
		wrap_mode = "wrap",
		blend_mode = "mul",
		texture_rect = {
			0,
			0,
			32,
			256
		},
		color = Color(1, 1, 1, 1),
		w = self._fullscreen_panel:w(),
		h = self._fullscreen_panel:h()
	})

	self._fullscreen_panel:bitmap({
		texture = "guis/textures/crimenet_map_vignette",
		name = "vignette",
		blend_mode = "mul",
		layer = 2,
		color = Color(1, 1, 1, 1),
		w = self._fullscreen_panel:w(),
		h = self._fullscreen_panel:h()
	})

	local bd_light = self._fullscreen_panel:bitmap({
		texture = "guis/textures/pd2/menu_backdrop/bd_light",
		name = "bd_light",
		layer = 4
	})

	bd_light:set_size(self._fullscreen_panel:size())
	bd_light:set_alpha(0)
	bd_light:set_blend_mode("add")

	local function light_flicker_animation(o)
		local alpha = 0
		local acceleration = 0
		local wanted_alpha = math.rand(1) * 0.3
		local flicker_up = true

		while true do
			wait(0.009, self._fixed_dt)
			over(0.045, function (p)
				o:set_alpha(math.lerp(alpha, wanted_alpha, p))
			end, self._fixed_dt)

			flicker_up = not flicker_up
			alpha = o:alpha()
			wanted_alpha = math.rand(flicker_up and alpha or 0.2, not flicker_up and alpha or 0.3)
		end
	end

	bd_light:animate(light_flicker_animation)

	local back_button = self._panel:text({
		vertical = "bottom",
		name = "back_button",
		blend_mode = "add",
		align = "right",
		layer = 40,
		text = managers.localization:to_upper_text("menu_back"),
		font_size = tweak_data.menu.pd2_large_font_size,
		font = tweak_data.menu.pd2_large_font,
		color = tweak_data.screen_colors.button_stage_3
	})

	self:make_fine_text(back_button)
	back_button:set_right(self._panel:w() - 10)
	back_button:set_bottom(self._panel:h() - 10)
	back_button:set_visible(managers.menu:is_pc_controller())

	local blur_object = self._panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "controller_legend_blur",
		render_template = "VertexColorTexturedBlur3D",
		layer = back_button:layer() - 1
	})

	blur_object:set_shape(back_button:shape())

	if not managers.menu:is_pc_controller() then
		blur_object:set_size(self._panel:w() * 0.5, tweak_data.menu.pd2_medium_font_size)
		blur_object:set_rightbottom(self._panel:w() - 2, self._panel:h() - 2)
	end

	WalletGuiObject.set_wallet(self._panel)
	WalletGuiObject.set_layer(30)
	WalletGuiObject.move_wallet(10, -10)

	local text_id = Global.game_settings.single_player and "menu_crimenet_offline" or "cn_menu_num_players_offline"
	local num_players_text = self._panel:text({
		vertical = "top",
		name = "num_players_text",
		align = "left",
		layer = 40,
		text = managers.localization:to_upper_text(text_id, {
			amount = "1"
		}),
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = tweak_data.screen_colors.text
	})

	self:make_fine_text(num_players_text)
	num_players_text:set_left(10)
	num_players_text:set_top(10)

	local blur_object = self._panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "num_players_blur",
		render_template = "VertexColorTexturedBlur3D",
		layer = num_players_text:layer() - 1
	})

	blur_object:set_shape(num_players_text:shape())

	local legends_button = self._panel:text({
		name = "legends_button",
		blend_mode = "add",
		layer = 40,
		text = managers.localization:to_upper_text("menu_cn_legend_show", {
			BTN_X = managers.localization:btn_macro("menu_toggle_legends")
		}),
		font_size = tweak_data.menu.pd2_small_font_size,
		font = tweak_data.menu.pd2_small_font,
		color = tweak_data.screen_colors.text
	})

	self:make_fine_text(legends_button)
	legends_button:set_left(10)
	legends_button:set_top(30)
	legends_button:set_align("left")

	local blur_object = self._panel:bitmap({
		texture = "guis/textures/test_blur_df",
		name = "legends_button_blur",
		render_template = "VertexColorTexturedBlur3D",
		layer = legends_button:layer() - 1
	})

	blur_object:set_shape(legends_button:shape())

	if managers.menu:is_pc_controller() then
		legends_button:set_color(tweak_data.screen_colors.button_stage_3)
	end

	local w, h = nil
	local mw = 0
	local mh = nil
	local legend_panel = self._panel:panel({
		name = "legend_panel",
		visible = false,
		x = 10,
		layer = 40,
		y = legends_button:bottom() + 4
	})
	local host_icon = legend_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_legend_host",
		x = 10,
		y = 10
	})
	local host_text = legend_panel:text({
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = host_icon:right() + 2,
		y = host_icon:top(),
		text = managers.localization:to_upper_text("menu_cn_legend_host")
	})
	mw = math.max(mw, self:make_fine_text(host_text))
	local next_y = host_text:bottom()
	local join_icon = legend_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_legend_join",
		x = 10,
		y = next_y
	})
	local join_text = legend_panel:text({
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = host_text:left(),
		y = next_y,
		text = managers.localization:to_upper_text("menu_cn_legend_join")
	})
	mw = math.max(mw, self:make_fine_text(join_text))

	self:make_color_text(join_text, tweak_data.screen_colors.regular_color)

	next_y = join_text:bottom()
	local friends_icon = legend_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_legend_join",
		x = 10,
		y = next_y,
		color = tweak_data.screen_colors.friend_color
	})
	local friends_text = legend_panel:text({
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = host_text:left(),
		y = next_y,
		text = managers.localization:to_upper_text("menu_cn_legend_friends")
	})
	mw = math.max(mw, self:make_fine_text(friends_text))

	self:make_color_text(friends_text, tweak_data.screen_colors.friend_color)

	next_y = friends_text:bottom()

	if managers.crimenet:no_servers() or is_xb1 then
		next_y = host_text:bottom()

		join_icon:hide()
		join_text:hide()
		friends_icon:hide()
		friends_text:hide()
		friends_text:set_bottom(next_y)
	end

	local risk_icon = legend_panel:bitmap({
		texture = "guis/textures/pd2/crimenet_legend_risklevel",
		x = 10,
		y = next_y
	})
	local risk_text = legend_panel:text({
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = host_text:left(),
		y = next_y,
		text = managers.localization:to_upper_text("menu_cn_legend_risk"),
		color = tweak_data.screen_colors.risk
	})
	mw = math.max(mw, self:make_fine_text(risk_text))
	next_y = risk_text:bottom()
	local ghost_icon = legend_panel:bitmap({
		texture = "guis/textures/pd2/cn_minighost",
		x = 7,
		y = next_y + 4,
		color = tweak_data.screen_colors.ghost_color
	})
	local ghost_text = legend_panel:text({
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = host_text:left(),
		y = next_y,
		text = managers.localization:to_upper_text("menu_cn_legend_ghostable"),
		color = tweak_data.screen_colors.ghost_color
	})
	mw = math.max(mw, self:make_fine_text(ghost_text))
	next_y = ghost_text:bottom()
	local kick_none_icon = legend_panel:bitmap({
		texture = "guis/textures/pd2/cn_kick_marker",
		x = 10,
		y = next_y + 2
	})
	local kick_none_text = legend_panel:text({
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = host_text:left(),
		y = next_y,
		text = managers.localization:to_upper_text("menu_cn_kick_disabled")
	})
	mw = math.max(mw, self:make_fine_text(kick_none_text))
	local kick_vote_icon = legend_panel:bitmap({
		texture = "guis/textures/pd2/cn_votekick_marker",
		x = 10,
		y = kick_none_text:bottom() + 2
	})
	local kick_vote_text = legend_panel:text({
		blend_mode = "add",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = host_text:left(),
		y = kick_none_text:bottom(),
		text = managers.localization:to_upper_text("menu_kick_vote")
	})
	mw = math.max(mw, self:make_fine_text(kick_vote_text))
	local last_text = kick_vote_text
	local job_plan_loud_icon, job_plan_loud_text, job_plan_stealth_icon, job_plan_stealth_text = nil

	if MenuCallbackHandler:bang_active() then
		job_plan_loud_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_playstyle_loud",
			x = 10,
			y = kick_vote_text:bottom() + 2
		})
		job_plan_loud_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = kick_vote_text:bottom(),
			text = managers.localization:to_upper_text("menu_plan_loud")
		})
		mw = math.max(mw, self:make_fine_text(job_plan_loud_text))
		job_plan_stealth_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_playstyle_stealth",
			x = 10,
			y = job_plan_loud_text:bottom() + 2
		})
		job_plan_stealth_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = job_plan_loud_text:bottom(),
			text = managers.localization:to_upper_text("menu_plan_stealth")
		})
		mw = math.max(mw, self:make_fine_text(job_plan_stealth_text))
		last_text = job_plan_stealth_text
	end

	if managers.crimenet:no_servers() or is_xb1 then
		kick_none_icon:hide()
		kick_none_text:hide()
		kick_vote_icon:hide()
		kick_vote_text:hide()
		kick_vote_text:set_bottom(ghost_text:bottom())

		if MenuCallbackHandler:bang_active() then
			job_plan_loud_icon:hide()
			job_plan_loud_text:hide()
			job_plan_stealth_icon:hide()
			job_plan_stealth_text:hide()
		end
	end

	legend_panel:set_size(host_text:left() + mw + 10, last_text:bottom() + 10)
	legend_panel:rect({
		alpha = 0.4,
		layer = -1,
		color = Color.black
	})
	BoxGuiObject:new(legend_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	legend_panel:bitmap({
		texture = "guis/textures/test_blur_df",
		render_template = "VertexColorTexturedBlur3D",
		layer = -1,
		w = legend_panel:w(),
		h = legend_panel:h()
	})
	legend_panel:set_left(10)

	local w, h = nil
	local mw = 0
	local mh = nil
	local global_bonuses_panel = self._panel:panel({
		y = 10,
		name = "global_bonuses_panel",
		layer = 40,
		h = tweak_data.menu.pd2_small_font_size * 3
	})

	local function mul_to_procent_string(multiplier)
		local pro = math.round(multiplier * 100)
		local procent_string = nil

		if pro == 0 and multiplier ~= 0 then
			procent_string = string.format("%0.2f", math.abs(multiplier * 100))
		else
			procent_string = tostring(math.abs(pro))
		end

		return procent_string, multiplier >= 0
	end

	local has_ghost_bonus = managers.job:has_ghost_bonus()

	if has_ghost_bonus then
		local ghost_bonus_mul = managers.job:get_ghost_bonus()
		local job_ghost_string = mul_to_procent_string(ghost_bonus_mul)
		local ghost_text = global_bonuses_panel:text({
			blend_mode = "add",
			align = "center",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			text = managers.localization:to_upper_text("menu_ghost_bonus", {
				exp_bonus = job_ghost_string
			}),
			color = tweak_data.screen_colors.ghost_color
		})
	end

	if false then
		local skill_bonus = managers.player:get_skill_exp_multiplier()
		skill_bonus = skill_bonus - 1

		if skill_bonus > 0 then
			local skill_string = mul_to_procent_string(skill_bonus)
			local skill_text = global_bonuses_panel:text({
				blend_mode = "add",
				align = "center",
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = managers.localization:to_upper_text("menu_cn_skill_bonus", {
					exp_bonus = skill_string
				}),
				color = tweak_data.screen_colors.skill_color
			})
		end

		local infamy_bonus = managers.player:get_infamy_exp_multiplier()
		infamy_bonus = infamy_bonus - 1

		if infamy_bonus > 0 then
			local infamy_string = mul_to_procent_string(infamy_bonus)
			local infamy_text = global_bonuses_panel:text({
				blend_mode = "add",
				align = "center",
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = managers.localization:to_upper_text("menu_cn_infamy_bonus", {
					exp_bonus = infamy_string
				}),
				color = tweak_data.lootdrop.global_values.infamy.color
			})
		end

		local limited_bonus = managers.player:get_limited_exp_multiplier(nil, nil)
		limited_bonus = limited_bonus - 1

		if limited_bonus > 0 then
			local limited_string = mul_to_procent_string(limited_bonus)
			local limited_text = global_bonuses_panel:text({
				blend_mode = "add",
				align = "center",
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				text = managers.localization:to_upper_text("menu_cn_limited_bonus", {
					exp_bonus = limited_string
				}),
				color = tweak_data.screen_colors.button_stage_2
			})
		end
	end

	if #global_bonuses_panel:children() > 1 then
		for i, child in ipairs(global_bonuses_panel:children()) do
			child:set_alpha(0)
		end

		local function global_bonuses_anim(panel)
			local child_num = 1
			local viewing_child = panel:children()[child_num]
			local t = 0
			local dt = 0

			while alive(viewing_child) do
				if not self._crimenet_enabled then
					coroutine.yield()
				else
					viewing_child:set_alpha(0)
					over(0.5, function (p)
						viewing_child:set_alpha(math.sin(p * 90))
					end)
					viewing_child:set_alpha(1)
					over(4, function (p)
						viewing_child:set_alpha((math.cos(p * 360 * 2) + 1) * 0.5 * 0.2 + 0.8)
					end)
					over(0.5, function (p)
						viewing_child:set_alpha(math.cos(p * 90))
					end)
					viewing_child:set_alpha(0)

					child_num = child_num % #panel:children() + 1
					viewing_child = panel:children()[child_num]
				end
			end
		end

		global_bonuses_panel:animate(global_bonuses_anim)
	elseif #global_bonuses_panel:children() == 1 then
		local function global_bonuses_anim(panel)
			while alive(panel) do
				if not self._crimenet_enabled then
					coroutine.yield()
				else
					over(2, function (p)
						panel:set_alpha((math.sin(p * 360) + 1) * 0.5 * 0.2 + 0.8)
					end)
				end
			end
		end

		global_bonuses_panel:animate(global_bonuses_anim)
	end

	if not no_servers and not is_xb1 then
		local id = is_x360 and "menu_cn_friends" or "menu_cn_filter"
	elseif not no_servers and is_xb1 then
		local id = "menu_cn_smart_matchmaking"
		local smart_matchmaking_button = self._panel:text({
			name = "smart_matchmaking_button",
			blend_mode = "add",
			layer = 40,
			text = managers.localization:to_upper_text(id, {
				BTN_Y = managers.localization:btn_macro("menu_toggle_filters")
			}),
			font_size = tweak_data.menu.pd2_large_font_size,
			font = tweak_data.menu.pd2_large_font,
			color = tweak_data.screen_colors.button_stage_3
		})

		self:make_fine_text(smart_matchmaking_button)
		smart_matchmaking_button:set_right(self._panel:w() - 10)
		smart_matchmaking_button:set_top(10)

		local blur_object = self._panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "smart_matchmaking_button_blur",
			render_template = "VertexColorTexturedBlur3D",
			layer = smart_matchmaking_button:layer() - 1
		})

		blur_object:set_shape(smart_matchmaking_button:shape())
	end

	self._map_size_w = 2048
	self._map_size_h = 1024
	local gui_width, gui_height = managers.gui_data:get_base_res()
	local aspect = gui_width / gui_height
	local sw = math.min(self._map_size_w, self._map_size_h * aspect)
	local sh = math.min(self._map_size_h, self._map_size_w / aspect)
	local dw = self._map_size_w / sw
	local dh = self._map_size_h / sh
	self._map_size_w = dw * gui_width
	self._map_size_h = dh * gui_height
	local pw = self._map_size_w
	local ph = self._map_size_h
	self._pan_panel_border = 2.7777777777777777
	self._pan_panel_job_border_x = full_16_9.convert_x + self._pan_panel_border * 2
	self._pan_panel_job_border_y = full_16_9.convert_y + self._pan_panel_border * 2
	self._pan_panel = self._panel:panel({
		name = "pan",
		layer = 0,
		w = pw,
		h = ph
	})

	self._pan_panel:set_center(self._fullscreen_panel:w() / 2, self._fullscreen_panel:h() / 2)

	self._jobs = {}
	self._deleting_jobs = {}
	self._map_panel = self._fullscreen_panel:panel({
		name = "map",
		w = pw,
		h = ph
	})

	self._map_panel:bitmap({
		texture = "guis/textures/crimenet_map",
		name = "map",
		layer = 0,
		w = pw,
		h = ph
	})
	self._map_panel:child("map"):set_halign("scale")
	self._map_panel:child("map"):set_valign("scale")
	self._map_panel:set_shape(self._pan_panel:shape())

	self._map_x, self._map_y = self._map_panel:position()

	if not managers.menu:is_pc_controller() then
		managers.mouse_pointer:confine_mouse_pointer(self._panel)
		managers.menu:active_menu().input:activate_controller_mouse()
		managers.mouse_pointer:set_mouse_world_position(managers.gui_data:safe_to_full(self._panel:world_center()))
	end

	self.MIN_ZOOM = 1
	self.MAX_ZOOM = 9
	self._zoom = 1
	local cross_indicator_h1 = self._fullscreen_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
		name = "cross_indicator_h1",
		h = 2,
		alpha = 0.1,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 17,
		w = self._fullscreen_panel:w(),
		color = tweak_data.screen_colors.crimenet_lines
	})
	local cross_indicator_h2 = self._fullscreen_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
		name = "cross_indicator_h2",
		h = 2,
		alpha = 0.1,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 17,
		w = self._fullscreen_panel:w(),
		color = tweak_data.screen_colors.crimenet_lines
	})
	local cross_indicator_v1 = self._fullscreen_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
		name = "cross_indicator_v1",
		w = 2,
		alpha = 0.1,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 17,
		h = self._fullscreen_panel:h(),
		color = tweak_data.screen_colors.crimenet_lines
	})
	local cross_indicator_v2 = self._fullscreen_panel:bitmap({
		texture = "guis/textures/pd2/skilltree/dottedline",
		name = "cross_indicator_v2",
		w = 2,
		alpha = 0.1,
		wrap_mode = "wrap",
		blend_mode = "add",
		layer = 17,
		h = self._fullscreen_panel:h(),
		color = tweak_data.screen_colors.crimenet_lines
	})
	local line_indicator_h1 = self._fullscreen_panel:rect({
		blend_mode = "add",
		name = "line_indicator_h1",
		h = 2,
		w = 0,
		alpha = 0.1,
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines
	})
	local line_indicator_h2 = self._fullscreen_panel:rect({
		blend_mode = "add",
		name = "line_indicator_h2",
		h = 2,
		w = 0,
		alpha = 0.1,
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines
	})
	local line_indicator_v1 = self._fullscreen_panel:rect({
		blend_mode = "add",
		name = "line_indicator_v1",
		h = 0,
		w = 2,
		alpha = 0.1,
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines
	})
	local line_indicator_v2 = self._fullscreen_panel:rect({
		blend_mode = "add",
		name = "line_indicator_v2",
		h = 0,
		w = 2,
		alpha = 0.1,
		layer = 17,
		color = tweak_data.screen_colors.crimenet_lines
	})
	local fw = self._fullscreen_panel:w()
	local fh = self._fullscreen_panel:h()

	cross_indicator_h1:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
	cross_indicator_h2:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
	cross_indicator_v1:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))
	cross_indicator_v2:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))
	self:_create_locations()

	self._num_layer_jobs = 0
	local player_level = managers.experience:current_level()
	local positions_tweak_data = tweak_data.gui.crime_net.map_start_positions
	local start_position = nil

	for _, position in ipairs(positions_tweak_data) do
		if player_level <= position.max_level then
			start_position = position

			break
		end
	end

	if start_position then
		self:_goto_map_position(start_position.x, start_position.y)
	end

	self._special_contracts_id = {}

	self:add_special_contracts(node:parameters().no_casino, no_servers)

	if not false or not managers.features:can_announce("crimenet_hacked") then
		managers.features:announce_feature("crimenet_welcome")

		if is_win32 then
			managers.features:announce_feature("thq_feature")
		end

		if is_win32 and SystemInfo:distribution() == Idstring("STEAM") and Steam:logged_on() and not managers.dlc:is_dlc_unlocked("pd2_clan") and math.random() < 0.2 then
			managers.features:announce_feature("join_pd2_clan")
		end

		if managers.dlc:is_dlc_unlocked("gage_pack_jobs") then
			managers.features:announce_feature("dlc_gage_pack_jobs")
		end
	end

	managers.challenge:fetch_challenges()

	if not Global.game_settings.single_player then
		local filters_button = self._panel:text({
			name = "filters_button",
			text = string.upper("[F] Filters"),
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.screen_colors.button_stage_3,
			layer = 40,
			y = 10,
			blend_mode = "add"
		})
		self:make_fine_text(filters_button)
		filters_button:set_right(self._panel:w() - 10)
		self._fullscreen_ws:connect_keyboard(Input:keyboard())  
		_G.already_open = true
		self._fullscreen_panel:key_press(callback(self, self, "open_filters")) 
	end
end

CriminalsManager = CriminalsManager or class()
CriminalsManager.MAX_NR_TEAM_AI = 2