local _hit_direction_actual = PlayerDamage._hit_direction
function PlayerDamage:_hit_direction(position_vector, ...)
	if position_vector then
		local dir = (self._unit:camera():position() - position_vector):normalized()
		local infront = math.dot(self._unit:camera():forward(), dir)
		if infront < -0.9 then
			managers.environment_controller:hit_feedback_front()
		elseif infront > 0.9 then
			managers.environment_controller:hit_feedback_back()
		else
			local polar = self._unit:camera():forward():to_polar_with_reference(-dir, Vector3(0, 0, 1))
			local direction = Vector3(polar.spin, polar.pitch, 0):normalized()
			if math.abs(direction.x) > math.abs(direction.y) then
				if 0 > direction.x then
					managers.environment_controller:hit_feedback_left()
				else
					managers.environment_controller:hit_feedback_right()
				end
			elseif 0 > direction.y then
				managers.environment_controller:hit_feedback_up()
			else
				managers.environment_controller:hit_feedback_down()
			end
		end
	end
	return _hit_direction_actual(self, position_vector, ...)
end

function PlayerDamage:damage_bullet(attack_data)
	local damage_info = {
		result = {type = "hurt", variant = "bullet"},
		attacker_unit = attack_data.attacker_unit
	}
	local dmg_mul = managers.player:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered", 1) * managers.player:upgrade_value("player", "damage_dampener", 1)
	if self._unit:movement()._current_state and self._unit:movement()._current_state:_interacting() then
		dmg_mul = dmg_mul * managers.player:upgrade_value("player", "interacting_damage_multiplier", 1)
	end

	attack_data.damage = attack_data.damage * dmg_mul
	local dodge_roll = math.rand(1)
	local dodge_value = tweak_data.player.damage.DODGE_INIT or 0
	local armor_dodge_chance = managers.player:body_armor_value("dodge")
	local skill_dodge_chance = managers.player:skill_dodge_chance(self._unit:movement():running(), self._unit:movement():crouching())
	dodge_value = dodge_value + armor_dodge_chance + skill_dodge_chance
	if dodge_roll < dodge_value then
		if attack_data.damage > 0 then
			self:_send_damage_drama(attack_data, 0)
		end

		self:_call_listeners(damage_info)
		self:play_whizby(attack_data.col_ray.position)
		self:_hit_direction(attack_data.col_ray)
		self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + self._dmg_interval, true)
		self._last_received_dmg = attack_data.damage
		return
	end

	if self._god_mode then
		if attack_data.damage > 0 then
			self:_send_damage_drama(attack_data, attack_data.damage)
		end

		self:_call_listeners(damage_info)
		return
	elseif self._invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() then
		return
	elseif self:is_friendly_fire(attack_data.attacker_unit) then
		return
	elseif self:_chk_dmg_too_soon(attack_data.damage) then
		return
	elseif self._revive_miss and math.random() < self._revive_miss then
		self:play_whizby(attack_data.col_ray.position)
		return
	end

	if attack_data.attacker_unit:base()._tweak_table == "tank" then
		managers.achievment:set_script_data("dodge_this_fail", true)
	end

	if 0 < self:get_real_armor() then
		self._unit:sound():play("player_hit")
	else
		self._unit:sound():play("player_hit_permadamage")
	end

	local shake_multiplier = math.clamp(attack_data.damage, 0.2, 2) * managers.player:body_armor_value("damage_shake") * managers.player:upgrade_value("player", "damage_shake_multiplier", 1)
	self._unit:camera():play_shaker("player_bullet_damage", 1 * shake_multiplier)
	managers.rumble:play("damage_bullet")
	self:_hit_direction(attack_data.col_ray)
	managers.player:check_damage_carry(attack_data)
	if self._bleed_out then
		self:_bleed_out_damage(attack_data)
		return
	end

	if not self:is_suppressed() then
		return
	end

	local armor_reduction_multiplier = 0
	if 0 >= self:get_real_armor() then
		armor_reduction_multiplier = 1
	end

	local pre_armor = self:get_real_armor()
	local health_subtracted = self:_calc_armor_damage(attack_data)
	local post_armor = self:get_real_armor()
	local is_berserker_active = managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier")
	if not is_berserker_active and managers.player:has_category_upgrade("temporary", "berserker_damage_multiplier") then
		local berserker_triggered = pre_armor > 0 and post_armor <= 0
		if berserker_triggered then
			managers.player:activate_temporary_upgrade("temporary", "berserker_damage_multiplier")
			is_berserker_active = true
			self._check_berserker_done = true
		end

	end

	if attack_data.armor_piercing then
		attack_data.damage = attack_data.damage - health_subtracted
	else
		attack_data.damage = attack_data.damage * armor_reduction_multiplier
	end

	health_subtracted = health_subtracted + self:_calc_health_damage(attack_data)
	managers.player:activate_temporary_upgrade("temporary", "wolverine_health_regen")
	self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + self._dmg_interval, true)
	self._last_received_dmg = health_subtracted
	if not self._bleed_out and health_subtracted > 0 then
		self:_send_damage_drama(attack_data, health_subtracted)
	elseif self._bleed_out then
		managers.challenges:set_flag("bullet_to_bleed_out")
		if attack_data.attacker_unit and attack_data.attacker_unit:alive() and attack_data.attacker_unit:base()._tweak_table == "tank" then
			self._kill_taunt_clbk_id = "kill_taunt" .. tostring(self._unit:key())
			managers.enemy:add_delayed_clbk(self._kill_taunt_clbk_id, callback(self, self, "clbk_kill_taunt", attack_data), managers.player:player_timer():time() + tweak_data.timespeed.downed.fade_in + tweak_data.timespeed.downed.sustain + tweak_data.timespeed.downed.fade_out)
		end

	end

	self:_call_listeners(damage_info)
end

function PlayerDamage:_chk_dmg_too_soon(damage)
	local next_allowed_dmg_t = type(self._next_allowed_dmg_t) == "number" and self._next_allowed_dmg_t or Application:digest_value(self._next_allowed_dmg_t, false)
	if damage <= self._last_received_dmg and next_allowed_dmg_t > managers.player:player_timer():time() then
		return true
	end

end
