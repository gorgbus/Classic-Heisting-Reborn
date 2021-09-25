local function make_fine_text(text)
	local x, y, w, h = text:text_rect()

	text:set_size(w, h)
	text:set_position(math.round(text:x()), math.round(text:y()))

	return x, y, w, h
end

local max_speed_up = 5
HUDStageEndScreen.stages = {
	{
		"stage_money_counter_init",
		max_speed_up
	},
	{
		"stage_money_counter_count",
		max_speed_up
	},
	{
		"stage_money_counter_hide",
		max_speed_up
	},
	{
		"stage_experience_init",
		max_speed_up
	},
	{
		"stage_experience_count_exp",
		max_speed_up
	},
	{
		"stage_experience_spin_up",
		max_speed_up
	},
	{
		"stage_experience_show_all",
		max_speed_up
	},
	{
		"stage_experience_spin_levels",
		max_speed_up
	},
	{
		"stage_experience_spin_slowdown",
		max_speed_up
	},
	{
		"stage_experience_end",
		max_speed_up
	},
	{
		"stage_done",
		max_speed_up
	}
}

function HUDStageEndScreen:init(hud, workspace)
	self._backdrop = MenuBackdropGUI:new(workspace)

	if not _G.IS_VR then
		self._backdrop:create_black_borders()
	end

	self._hud = hud
	self._workspace = workspace
	self._singleplayer = Global.game_settings.single_player
	local bg_font = tweak_data.menu.pd2_massive_font
	local title_font = tweak_data.menu.pd2_large_font
	local content_font = tweak_data.menu.pd2_medium_font
	local small_font = tweak_data.menu.pd2_small_font
	local bg_font_size = tweak_data.menu.pd2_massive_font_size
	local title_font_size = tweak_data.menu.pd2_large_font_size
	local content_font_size = tweak_data.menu.pd2_medium_font_size
	local small_font_size = tweak_data.menu.pd2_small_font_size
	local massive_font = bg_font
	local large_font = title_font
	local medium_font = content_font
	local massive_font_size = bg_font_size
	local large_font_size = title_font_size
	local medium_font_size = content_font_size
	self._background_layer_safe = self._backdrop:get_new_background_layer()
	self._background_layer_full = self._backdrop:get_new_background_layer()
	self._foreground_layer_safe = self._backdrop:get_new_foreground_layer()
	self._foreground_layer_full = self._backdrop:get_new_foreground_layer()

	self._backdrop:set_panel_to_saferect(self._background_layer_safe)
	self._backdrop:set_panel_to_saferect(self._foreground_layer_safe)

	if managers.job:has_active_job() then
		local current_contact_data = managers.job:current_contact_data()
		local contact_gui = current_contact_data and self._background_layer_full:gui(current_contact_data.assets_gui, {
			empty = true
		})
		local contact_pattern = contact_gui and contact_gui:has_script() and contact_gui:script().pattern

		if contact_pattern then
			self._backdrop:set_pattern(contact_pattern)
		end
	end

	local padding_y = 0
	self._paygrade_panel = self._background_layer_safe:panel({
		w = 210,
		h = 70,
		y = padding_y
	})
	local pg_text = self._foreground_layer_safe:text({
		name = "pg_text",
		vertical = "center",
		h = 32,
		align = "right",
		text = utf8.to_upper(managers.localization:text("menu_risk")),
		y = padding_y,
		font_size = content_font_size,
		font = content_font,
		color = tweak_data.screen_colors.risk
	})
	local _, _, w, h = pg_text:text_rect()

	pg_text:set_size(w, h)

	local job_stars = managers.job:has_active_job() and managers.job:current_job_stars() or 1
	local job_and_difficulty_stars = managers.job:has_active_job() and managers.job:current_job_and_difficulty_stars() or 1
	local difficulty_stars = managers.job:has_active_job() and managers.job:current_difficulty_stars() or 0
	local risk_color = tweak_data.screen_colors.risk
	local risks = {
		"risk_swat",
		"risk_fbi",
		"risk_death_squad"
	}

	if not Global.SKIP_OVERKILL_290 then
		table.insert(risks, "risk_murder_squad")
	end
	local prank = managers.experience:current_rank()
	if prank >= 22 then
	elseif prank >= 21 then
		table.insert(risks, "risk_sm_wish")
	end

	local num_stars = 0
	local panel_w = 0
	local panel_h = 0
	local x = 0
	local y = 0
	local filled_star_rect = {0, 32, 32, 32}
	for i, name in ipairs(risks) do
		local texture, rect = tweak_data.hud_icons:get_icon_data(name)
		local active = i <= difficulty_stars
		local color = active and risk_color or tweak_data.screen_colors.text
		local alpha = active and 1 or 0.25
		local risk = self._paygrade_panel:bitmap({
			y = 0,
			x = 0,
			name = name,
			texture = texture,
			texture_rect = rect,
			alpha = alpha,
			color = color
		})

		risk:set_position(x, y - 2)

		x = x + risk:w() - 4
		panel_w = math.max(panel_w, risk:right())
		panel_h = math.max(panel_h, risk:h())
	end

	self._paygrade_panel:set_h(panel_h)
	self._paygrade_panel:set_w(panel_w)
	self._paygrade_panel:set_right(self._background_layer_safe:w())
	pg_text:set_right(self._paygrade_panel:left())

	if managers.skirmish:is_skirmish() then
		self._paygrade_panel:set_visible(false)
		pg_text:set_visible(false)

		local min, max = managers.skirmish:wave_range()
		local wave_range_text = self._foreground_layer_safe:text({
			name = "wave_range",
			vertical = "center",
			h = 32,
			align = "right",
			text = managers.localization:to_upper_text("menu_skirmish_wave_range", {
				min = min,
				max = max
			}),
			y = padding_y,
			font_size = content_font_size,
			font = content_font,
			color = tweak_data.screen_colors.skirmish_color
		})

		managers.hud:make_fine_text(wave_range_text)
		wave_range_text:set_right(self._background_layer_safe:w())
	end

	self._stage_name = managers.job:current_level_id() and managers.localization:to_upper_text(tweak_data.levels[managers.job:current_level_id()].name_id) or ""

	if managers.skirmish:is_skirmish() then
		if managers.skirmish:is_weekly_skirmish() then
			self._stage_name = managers.localization:to_upper_text("menu_weekly_skirmish")
		else
			self._stage_name = managers.localization:to_upper_text("menu_skirmish")
		end
	end

	self._foreground_layer_safe:text({
		name = "stage_text",
		vertical = "center",
		align = "left",
		text = self._stage_name,
		h = title_font_size,
		font_size = title_font_size,
		font = title_font,
		color = tweak_data.screen_colors.text
	})

	local bg_text = self._background_layer_full:text({
		name = "stage_text",
		vertical = "top",
		alpha = 0.4,
		align = "left",
		text = self._stage_name,
		h = bg_font_size,
		font_size = bg_font_size,
		font = bg_font,
		color = tweak_data.screen_colors.button_stage_3
	})

	bg_text:set_world_center_y(self._foreground_layer_safe:child("stage_text"):world_center_y())
	bg_text:set_world_x(self._foreground_layer_safe:child("stage_text"):world_x())
	bg_text:move(-13, 9)
	self._backdrop:animate_bg_text(bg_text)

	self._coins_backpanel = self._background_layer_safe:panel({
		name = "coins_backpanel",
		y = 70,
		w = self._background_layer_safe:w() / 2 - 10,
		h = self._background_layer_safe:h() / 2
	})
	self._coins_forepanel = self._foreground_layer_safe:panel({
		name = "coins_forepanel",
		y = 70,
		w = self._foreground_layer_safe:w() / 2 - 10,
		h = self._foreground_layer_safe:h() / 2
	})
	local level_progress_text = self._coins_forepanel:text({
		vertical = "top",
		name = "coin_progress_text",
		align = "left",
		y = 10,
		x = 10,
		text = managers.localization:to_upper_text("menu_es_coins_progress"),
		h = content_font_size + 2,
		font_size = content_font_size,
		font = content_font,
		color = tweak_data.screen_colors.text
	})
	local _, _, lw, lh = level_progress_text:text_rect()

	level_progress_text:set_size(lw, lh)

	local coins_bg_circle = self._coins_backpanel:bitmap({
		texture = "guis/textures/pd2/endscreen/exp_ring",
		name = "bg_progress_circle",
		alpha = 0.6,
		blend_mode = "normal",
		h = self._coins_backpanel:h() - content_font_size,
		w = self._coins_backpanel:h() - content_font_size,
		y = content_font_size,
		color = Color.black
	})
	self._coins_circle = self._coins_backpanel:bitmap({
		texture = "guis/textures/pd2/endscreen/exp_ring",
		name = "progress_circle",
		blend_mode = "add",
		render_template = "VertexColorTexturedRadial",
		layer = 1,
		h = self._coins_backpanel:h() - content_font_size,
		w = self._coins_backpanel:h() - content_font_size,
		y = content_font_size,
		color = Color(0, 1, 1)
	})
	self._coins_text = self._coins_forepanel:text({
		name = "coins_text",
		vertical = "center",
		align = "center",
		text = "",
		font_size = bg_font_size,
		font = bg_font,
		h = self._coins_backpanel:h() - content_font_size,
		w = self._coins_backpanel:h() - content_font_size,
		y = content_font_size,
		color = tweak_data.screen_colors.text
	})
	self._coins_box = BoxGuiObject:new(self._coins_backpanel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})

	------------------- Level Progress
	self._lp_backpanel = self._background_layer_safe:panel( { name="lp_backpanel", w=self._background_layer_safe:w()/2-10, h=self._background_layer_safe:h()/2, y=70 } )
	self._lp_forepanel = self._foreground_layer_safe:panel( { name="lp_forepanel", w=self._foreground_layer_safe:w()/2-10, h=self._foreground_layer_safe:h()/2, y=70 } )
	
	self._lp_forepanel:text( { name="level_progress_text", text=managers.localization:to_upper_text( "menu_es_level_progress" ), align="left", vertical="top", h=content_font_size+2, font_size=content_font_size, font=content_font, color=tweak_data.screen_colors.text, x=10, y=10 } )
	
	local lp_bg_circle = self._lp_backpanel:bitmap( { name="bg_progress_circle", texture="guis/textures/pd2/endscreen/exp_ring", h=self._lp_backpanel:h()-content_font_size, w=self._lp_backpanel:h()-content_font_size, y=content_font_size, color=Color.black, alpha=0.6,  blend_mode="normal" } )
	self._lp_circle = self._lp_backpanel:bitmap( { name="progress_circle", texture="guis/textures/pd2/endscreen/exp_ring", h=self._lp_backpanel:h()-content_font_size, w=self._lp_backpanel:h()-content_font_size, y=content_font_size, color=Color(0, 1, 1), render_template="VertexColorTexturedRadial", blend_mode="add", layer=1 } )
	self._lp_text = self._lp_forepanel:text( { name="level_text", text="", align="center", vertical="center", font_size=bg_font_size, font=bg_font, h=self._lp_backpanel:h()-content_font_size, w=self._lp_backpanel:h()-content_font_size, y=content_font_size, color=tweak_data.screen_colors.text } )
	
	self._lp_curr_xp 		= self._lp_forepanel:text( { name="current_xp", text=managers.localization:to_upper_text( "menu_es_current_xp" ), align="left", vertical="center", h=small_font_size ,font_size=small_font_size, font=small_font, color=tweak_data.screen_colors.text } )
	self._lp_xp_gained 	= self._lp_forepanel:text( { name="xp_gained", text= managers.localization:to_upper_text( "menu_es_xp_gained" ), align="left", vertical="center", h=content_font_size ,font_size=content_font_size, font=content_font, color=tweak_data.screen_colors.text } )
	self._lp_next_level	= self._lp_forepanel:text( { name="next_level", text=managers.localization:to_upper_text( "menu_es_next_level" ), align="left", vertical="center", h=small_font_size ,font_size=small_font_size, font=small_font, color=tweak_data.screen_colors.text } )
	self._lp_skill_points	= self._lp_forepanel:text( { name="skill_points", text=managers.localization:to_upper_text( "menu_es_skill_points_gained" ), align="left", vertical="center", h=small_font_size ,font_size=small_font_size, font=small_font, color=tweak_data.screen_colors.text } )
	
	self._lp_xp_curr 	= self._lp_forepanel:text( { name="c_xp", text="", align="left", vertical="top", h=small_font_size, font_size=small_font_size, font=small_font, color=tweak_data.screen_colors.text } )
	self._lp_xp_gain	= self._lp_forepanel:text( { name="xp_g", text="", align="left", vertical="top", h=content_font_size, font_size=content_font_size, font=content_font, color=tweak_data.screen_colors.text } )
	self._lp_xp_nl		= self._lp_forepanel:text( { name="xp_nl", text="", align="left", vertical="top", h=small_font_size, font_size=small_font_size, font=small_font, color=tweak_data.screen_colors.text } )
	self._lp_sp_gain	= self._lp_forepanel:text( { name="sp_g", text="0", align="left", vertical="center", h=small_font_size, font_size=small_font_size, font=small_font, color=tweak_data.screen_colors.text } )
	
	local _, _, cw, ch = self._lp_curr_xp:text_rect()
	local _, _, gw, gh = self._lp_xp_gained:text_rect()
	local _, _, nw, nh = self._lp_next_level:text_rect()
	local _, _, sw, sh = self._lp_skill_points:text_rect()
	
	local w = math.ceil( math.max( cw, gw, nw, sw ) ) + 20
	
	local squeeze_more_pixels = false
	if not (SystemInfo:platform() == Idstring( "WIN32" )) and w > 170 then
		w = 170
		squeeze_more_pixels = true
	end
	
	self._num_skill_points_gained = 0
	
	
	self._lp_sp_info = self._lp_forepanel:text( { name="sp_info", text=managers.localization:text("menu_es_skill_points_info", {SKILL_MENU=managers.localization:to_upper_text("menu_skilltree")}), align="left", vertical="top", h=small_font_size, font_size=small_font_size, font=small_font, color=tweak_data.screen_colors.text, wrap=true, word_wrap=true } )
	self._lp_sp_info:grow( -self._lp_circle:right() - 20, 0 )
	
	local _, _, iw, ih = self._lp_sp_info:text_rect()
	self._lp_sp_info:set_h( ih )
	
	self._lp_sp_info:set_leftbottom( self._lp_circle:right()+0, self._lp_forepanel:h()-10 )
	
	
	self._lp_skill_points:set_h( sh )
	self._lp_skill_points:set_left( self._lp_sp_info:left() )
	self._lp_skill_points:set_bottom( self._lp_sp_info:top() )
	
	self._lp_sp_gain:set_h( sh )
	self._lp_sp_gain:set_left( self._lp_skill_points:left() + w )
	self._lp_sp_gain:set_top( self._lp_skill_points:top() )
	
	
	
	self._lp_next_level:set_h( nh )
	self._lp_next_level:set_left( self._lp_sp_info:left() )
	self._lp_next_level:set_bottom( self._lp_skill_points:top() )
	
	self._lp_xp_nl:set_h( nh )
	self._lp_xp_nl:set_left( self._lp_next_level:left() + w  )
	self._lp_xp_nl:set_top( self._lp_next_level:top() )
	
	
	
	self._lp_curr_xp:set_left( self._lp_sp_info:left() )
	self._lp_curr_xp:set_bottom( self._lp_next_level:top() )
	self._lp_curr_xp:set_h( gh )
	
	self._lp_xp_curr:set_left( self._lp_curr_xp:left() + w  )
	self._lp_xp_curr:set_top( self._lp_curr_xp:top() )
	self._lp_xp_curr:set_h( ch )
	
	
	
	
	self._lp_xp_gained:set_left( self._lp_curr_xp:left() )
	-- self._lp_xp_gained:set_bottom( self._lp_circle:center_y() - self._lp_xp_gained:h() )
	self._lp_xp_gained:set_h( ch )
	
	self._lp_xp_gain:set_left( self._lp_xp_gained:x() + w + 5  )
	-- self._lp_xp_gain:set_top( self._lp_xp_gained:y() )
	self._lp_xp_gain:set_h( gh )
	
	
	--[[
	self._lp_curr_xp:set_left( self._lp_circle:right() + 15 )
	self._lp_curr_xp:set_top( self._lp_circle:top() )
	self._lp_curr_xp:set_h( ch )
	
	self._lp_xp_gained:set_left( self._lp_curr_xp:left() )
	self._lp_xp_gained:set_top( self._lp_curr_xp:bottom() + 0 )
	self._lp_xp_gained:set_h( gh )
	]]
	
	
	if squeeze_more_pixels then
		lp_bg_circle:move( -20, 0 )
		self._lp_circle:move( -20, 0 )
		self._lp_text:move( -20, 0 )
		self._lp_curr_xp:move( -30, 0 )
		self._lp_xp_gained:move( -30, 0 )
		self._lp_next_level:move( -30, 0 )
		self._lp_skill_points:move( -30, 0 )
		self._lp_sp_info:move( -30, 0 )
	end

	self._box = BoxGuiObject:new(self._lp_backpanel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})

	WalletGuiObject.set_wallet(self._foreground_layer_safe)
	WalletGuiObject.hide_wallet()

	self._package_forepanel = self._foreground_layer_safe:panel({
		alpha = 1,
		name = "package_forepanel",
		y = 70,
		w = self._foreground_layer_safe:w() / 2 - 10,
		h = self._foreground_layer_safe:h() / 2 - 70 - 10
	})

	self._package_forepanel:set_right(self._foreground_layer_safe:w())
	self._package_forepanel:text({
		text = "",
		name = "title_text",
		y = 10,
		x = 10,
		font = content_font,
		font_size = content_font_size
	})

	local package_box_panel = self._foreground_layer_safe:panel()

	package_box_panel:set_shape(self._package_forepanel:shape())
	package_box_panel:set_layer(self._package_forepanel:layer())

	self._package_box = BoxGuiObject:new(package_box_panel, {
		sides = {
			1,
			1,
			1,
			1
		}
	})
	self._package_items = {}

	self:clear_stage()

	if self._data then
		self:start_experience_gain()
	end

	for i, child in ipairs(self._lp_forepanel:children()) do
		if child.text then
			local text = child:text()

			child:set_text(string.gsub(text, ":", ""))
		end
	end

	local skip_panel = self._foreground_layer_safe:panel({
		name = "skip_forepanel",
		y = 70,
		w = self._foreground_layer_safe:w() / 2 - 10,
		h = self._foreground_layer_safe:h() / 2
	})
	local macros = {
		BTN_SPEED = managers.localization:btn_macro("menu_challenge_claim", true)
	}

	if not managers.menu:is_pc_controller() then
		macros.BTN_SPEED = managers.localization:get_default_macro("BTN_SWITCH_WEAPON")
	end

	self._skip_text = skip_panel:text({
		name = "skip_text",
		visible = false,
		alpha = 0.5,
		font = small_font,
		font_size = small_font_size,
		text = managers.localization:to_upper_text("menu_stageendscreen_speed_up", macros)
	})

	make_fine_text(self._skip_text)
	self._skip_text:set_right(skip_panel:w() - 10)
	self._skip_text:set_bottom(skip_panel:h() - 10)
	skip_panel:hide()
end

function HUDStageEndScreen:stage_experience_init(t, dt)
	local data = self._data

	self._lp_text:show()
	self._lp_circle:show()
	self._lp_backpanel:child("bg_progress_circle"):show()
	self._lp_forepanel:child("level_progress_text"):show()

	if false and managers.experience:reached_level_cap() then
		self._lp_text:set_text(tostring(data.start_t.level))
		self._lp_circle:set_color(Color(1, 1, 1))
		managers.menu_component:post_event("box_tick")
		self:step_stage_to_end()

		return
	end

	self._lp_circle:set_alpha(0)
	self._lp_backpanel:child("bg_progress_circle"):set_alpha(0)
	self._lp_text:set_alpha(0)

	self._lp_circle:set_alpha( 0 )
	self._lp_backpanel:child("bg_progress_circle"):set_alpha( 0 )
	self._lp_text:set_alpha( 0 )
	
	self._bonuses_panel = self._lp_forepanel:panel( { x=self._lp_curr_xp:x(), y=10 } )
	self._bonuses_panel:grow( -self._bonuses_panel:x(), -self._bonuses_panel:y() )

	--[[self._bonuses_panel = self._lp_forepanel:panel({
		y = 10,
		x = self._lp_xp_gained:x(),
		w = self._lp_forepanel:w() - self._lp_xp_gained:left() - 10,
		h = self._lp_xp_gained:top() - 10
	})]]--
	self._anim_exp_bonus = nil
	local bonus_params = {
		panel = self._bonuses_panel,
		color = tweak_data.screen_colors.text,
		title = managers.localization:to_upper_text("menu_experience"),
		bonus = 0
	}
	local exp = self:_create_bonus(bonus_params)

	exp:child("sign"):hide()

	self._experience_text_panel = exp

	self._experience_text_panel:set_alpha(0)
	self._experience_text_panel:hide()

	self._experience_added = 0
	self._bonuses = {}

	if data.bonuses.stage_xp and data.bonuses.stage_xp ~= 0 then
		bonus_params.title = managers.localization:to_upper_text("menu_es_base_xp_stage")
		bonus_params.bonus = data.bonuses.stage_xp
		local stage = self:_create_bonus(bonus_params)

		stage:set_right(0)
		stage:set_top(exp:bottom())
		table.insert(self._bonuses, {
			stage,
			bonus_params.bonus
		})
	end

	local job = nil

	if data.bonuses.last_stage and data.bonuses.job_xp ~= 0 then
		bonus_params.title = managers.localization:to_upper_text("menu_es_base_xp_job")
		bonus_params.bonus = data.bonuses.job_xp
		job = self:_create_bonus(bonus_params)

		job:set_right(0)
		job:set_top(exp:bottom())
		table.insert(self._bonuses, {
			job,
			bonus_params.bonus
		})
	end

	local stage_text = managers.localization:to_upper_text( "menu_es_base_xp_stage" )
	local base_text = self._bonuses_panel:text( { name="base_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=stage_text } )
	local xp_text = self._bonuses_panel:text( { name="xp_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=managers.money:add_decimal_marks_to_string( tostring(data.bonuses.stage_xp) ) } )
	
	local _, _, tw, th = base_text:text_rect()
	base_text:set_h( th )
	
	xp_text:set_world_left( self._lp_xp_curr:world_left() )

	local delay = 0.8
	local y = math.round( base_text:bottom() )

	if data.bonuses.last_stage then
		local job_text = managers.localization:to_upper_text( "menu_es_base_xp_job" )
		local job_xp_fade_panel = self._bonuses_panel:panel( {alpha=0} )
		local base_text = job_xp_fade_panel:text( { name="base_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=job_text, y=y } )
		local sign_text = job_xp_fade_panel:text( { name="sign_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, y=y, text="+", align="right" } )
		local xp_text = job_xp_fade_panel:text( { name="xp_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, y=y, text=managers.money:add_decimal_marks_to_string( tostring(data.bonuses.job_xp) ) } )
		
		local _, _, tw, th = base_text:text_rect()
		base_text:set_h( th )
		
		xp_text:set_world_left( self._lp_xp_curr:world_left() )
		sign_text:set_world_right( self._lp_xp_curr:world_left() )
		
		delay = 0.85+0.60
		y = math.round( base_text:bottom() )
		job_xp_fade_panel:animate( callback( self, self, "spawn_animation" ), 0.60, "box_tick" )
	end

	if data.bonuses.rounding_error ~= 0 then
		Application:debug("GOT A ROUNDING ERROR IN EXPERIENCE GIVING:", data.bonuses.rounding_error)
	end

	local bonuses_to_string_converter = { "bonus_risk", "bonus_failed", "bonus_days", "bonus_low_level", "in_custody", "bonus_num_players", "bonus_skill", "bonus_infamy", "bonus_ghost", "heat_xp" }
		
	local index = 2
	for i, func_name in ipairs( bonuses_to_string_converter ) do
		local bonus = data.bonuses[func_name] 
		if bonus and bonus~=0 then
			local panel = self._bonuses_panel:panel( { alpha=0, y=y } )
			delay = (callback( self, self, func_name )( panel, delay, bonus ) or delay) + 0.60
			
			y = y + panel:h()
			index = index + 1
		end
	end

	
	local sum_line = self._bonuses_panel:rect( { color=Color(0.0, 1, 1, 1), alpha=0.0, h=2 } )
	sum_line:set_y( y )
	-- sum_line:animate( callback( self, self, "spawn_animation" ), delay )

	self._lp_xp_gain:set_world_top( sum_line:world_top() )
	if SystemInfo:platform() == Idstring( "WIN32" ) then
		self._lp_xp_gain:move( 0, self._lp_xp_gain:h() )
	end
	self._lp_xp_gained:set_top( self._lp_xp_gain:top() )

	local sum_text = self._bonuses_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, text="= ", align="right", alpha=0 } )
	sum_text:set_world_righttop( self._lp_xp_gain:world_left(), self._lp_xp_gain:world_top() )
	sum_text:animate( callback( self, self, "spawn_animation" ), delay+1, "box_tick" )

	self._lp_circle:set_color(Color(data.start_t.current / data.start_t.total, 1, 1))

	self._wait_t = 1
	self._start_ramp_up_t = delay
	self._ramp_up_timer = 0

	managers.menu_component:post_event("box_tick")
	self:step_stage_up()
end

function HUDStageEndScreen:stage_experience_count_exp(t, dt)
	local data = self._data

	if self._start_ramp_up_t then
		self._ramp_up_timer = math.min(self._ramp_up_timer + dt, self._start_ramp_up_t)

		if self._ramp_up_timer == self._start_ramp_up_t then
			self._start_ramp_up_t = 1

			self:step_stage_up()
		end

		return
	end

	self:step_stage_up()
end

function HUDStageEndScreen:stage_experience_spin_up( t, dt )
	local data = self._data
	
	if self._start_ramp_up_t then
		self._ramp_up_timer = math.min( self._ramp_up_timer + dt, self._start_ramp_up_t )
		local ratio = (self._ramp_up_timer/self._start_ramp_up_t)*(data.start_t.current / data.start_t.total)
		-- self._lp_circle:set_color( Color( ratio, 1, 1 ) )
		
		ratio = (self._ramp_up_timer/self._start_ramp_up_t)
		self._lp_circle:set_alpha( ratio )
		self._lp_backpanel:child("bg_progress_circle"):set_alpha( ratio * 0.6 )
		self._lp_text:set_alpha( ratio )
		
		if self._ramp_up_timer == self._start_ramp_up_t then
			self._static_current_xp = data.start_t.xp
			self._static_gained_xp = 0
			self._static_start_xp = data.start_t.current
			
			self._current_xp = self._static_current_xp
			self._gained_xp = self._static_gained_xp
			self._next_level_xp = data.start_t.total - data.start_t.current
			self._speed = 1
			self._wait_t = 2.4
			
			self._ramp_up_timer = nil
			self._start_ramp_up_t = nil
			
			
			ratio = 1
			self._lp_circle:set_alpha( ratio )
			self._lp_backpanel:child("bg_progress_circle"):set_alpha( ratio * 0.6 )
			self._lp_text:set_alpha( ratio )
		
			self._lp_text:stop()
			self._lp_text:set_font_size( tweak_data.menu.pd2_massive_font_size )
			self._lp_text:set_text( tostring( data.start_t.level ) )
			
			self._lp_xp_curr:set_text( managers.money:add_decimal_marks_to_string( tostring( math.floor( data.start_t.xp ) ) ) )
			self._lp_xp_gain:set_text( managers.money:add_decimal_marks_to_string( tostring( math.floor( 0 ) ) ) )
			self._lp_xp_nl:set_text( managers.money:add_decimal_marks_to_string( tostring( math.floor( data.start_t.total - data.start_t.current ) ) ) )
			
			
			local clbk = callback( self, self, "spawn_animation" )
	
			
			self._lp_curr_xp:show()
			self._lp_xp_gained:show()
			self._lp_next_level:show()
			
			self._lp_xp_gain:show()
			self._lp_xp_curr:show()
			self._lp_xp_nl:show()
			
			
		-- 	managers.menu_component:post_event("box_tick")
			self._lp_curr_xp:animate(clbk, 0)
			self._lp_xp_gained:animate(clbk, 0)
			self._lp_next_level:animate(clbk, 0)
			
			self._lp_xp_gain:animate(clbk, 0)
			self._lp_xp_curr:animate(clbk, 0)
			self._lp_xp_nl:animate(clbk, 0)
			
			-- self._bonuses_panel:animate( callback( self, self, "destroy_animation" ), 1 )
			self:step_stage_up()
		end
	end
end

function HUDStageEndScreen:bonus_ghost(panel, delay, bonus)
	local text = panel:text({
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.ghost_color,
		text = managers.localization:to_upper_text("menu_es_ghost_bonus")
	})
	local _, _, w, h = text:text_rect()

	panel:set_h(h)
	text:set_size(w, h)
	text:set_center_y(panel:h() / 2)
	text:set_position(math.round(text:x()), math.round(text:y()))
	panel:animate(callback(self, self, "spawn_animation"), delay, "box_tick")

	local sign_text = panel:text({
		text = "+",
		alpha = 0,
		align = "right",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.ghost_color
	})

	make_fine_text(sign_text)
	sign_text:set_world_right(self._lp_xp_curr:world_left())
	sign_text:animate(callback(self, self, "spawn_animation"), delay + 0, false)

	local value_text = panel:text({
		alpha = 0,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.screen_colors.ghost_color,
		text = managers.money:add_decimal_marks_to_string(tostring(math.abs(bonus)))
	})

	value_text:set_world_left(self._lp_xp_curr:world_left())
	value_text:animate(callback(self, self, "spawn_animation"), delay + 0, false)
	make_fine_text(value_text)

	return delay + 0
end

function HUDStageEndScreen:bonus_infamy(panel, delay, bonus)
	local text = panel:text({
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.lootdrop.global_values.infamy.color,
		text = managers.localization:to_upper_text("menu_es_infamy_bonus")
	})
	local _, _, w, h = text:text_rect()

	panel:set_h(h)
	text:set_size(w, h)
	text:set_center_y(panel:h() / 2)
	text:set_position(math.round(text:x()), math.round(text:y()))
	panel:animate(callback(self, self, "spawn_animation"), delay, "box_tick")

	local sign_text = panel:text({
		text = "+",
		alpha = 0,
		align = "right",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.lootdrop.global_values.infamy.color
	})

	make_fine_text(sign_text)
	sign_text:set_world_right(self._lp_xp_curr:world_left())
	sign_text:animate(callback(self, self, "spawn_animation"), delay + 0, false)

	local value_text = panel:text({
		alpha = 0,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		color = tweak_data.lootdrop.global_values.infamy.color,
		text = managers.money:add_decimal_marks_to_string(tostring(math.abs(bonus)))
	})

	value_text:set_world_left(self._lp_xp_curr:world_left())
	value_text:animate(callback(self, self, "spawn_animation"), delay + 0, false)
	make_fine_text(value_text)

	return delay + 0
end

function HUDStageEndScreen:stage_experience_show_all( t, dt )
	self._lp_curr_xp:show()
	self._lp_xp_gained:show()
	self._lp_next_level:show()
	
	self._lp_xp_gain:show()
	self._lp_xp_curr:show()
	self._lp_xp_nl:show()
	self:step_stage_up()
end