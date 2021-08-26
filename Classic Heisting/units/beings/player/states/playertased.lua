function PlayerTased:call_teammate(line, t, no_gesture, skip_alert)
	local voice_type, plural, prime_target = self:_get_unit_intimidation_action(true, false, false, true, false)
	local interact_type, queue_name = nil

	if voice_type == "stop_cop" or voice_type == "mark_cop" then
		local prime_target_tweak = tweak_data.character[prime_target.unit:base()._tweak_table]
		local shout_sound = prime_target_tweak.priority_shout

		if managers.groupai:state():whisper_mode() then
			shout_sound = prime_target_tweak.silent_priority_shout or shout_sound
		end

		if shout_sound then
			interact_type = "cmd_point"
			queue_name = "s07x_sin"

			if managers.player:has_category_upgrade("player", "special_enemy_highlight") then
				prime_target.unit:contour():add(managers.player:get_contour_for_marked_enemy(), true, managers.player:upgrade_value("player", "mark_enemy_time_multiplier", 1))
			end
			if not self._tase_ended and managers.player:has_category_upgrade("player", "taser_self_shock") and prime_target.unit:key() == self._unit:character_damage():tase_data().attacker_unit:key() then
				self:_start_action_counter_tase(t, prime_target)
			end
		end
	end

	if interact_type then
		self:_do_action_intimidate(t, not no_gesture and interact_type or nil, queue_name, skip_alert)
	end
end

function PlayerTased:_on_tased_event(taser_unit, tased_unit)
	if self._unit == tased_unit then
		self._taser_unit = taser_unit

		--[[if managers.player:has_category_upgrade("player", "taser_malfunction") then
			local data = managers.player:upgrade_value("player", "taser_malfunction")

			if data then
				managers.player:register_message(Message.SendTaserMalfunction, "taser_malfunction", function ()
					self:_on_malfunction_to_taser_event()
				end)
				managers.player:add_coroutine("taser_malfunction", PlayerAction.TaserMalfunction, managers.player, data.interval, data.chance_to_trigger)
			end
		end]]--

		if managers.player:has_category_upgrade("player", "escape_taser") then
			local interact_string = managers.localization:text("hud_int_escape_taser", {
				BTN_INTERACT = managers.localization:btn_macro("interact", false)
			})

			managers.hud:show_interact({
				icon = "mugshot_electrified",
				text = interact_string
			})

			local target_time = managers.player:upgrade_value("player", "escape_taser", 2)

			managers.player:add_coroutine("escape_tase", PlayerAction.EscapeTase, managers.player, managers.hud, Application:time() + target_time)

			local function clbk()
				self:give_shock_to_taser_no_damage()
			end

			managers.player:register_message(Message.EscapeTase, "escape_tase", clbk)
		end
	end
end