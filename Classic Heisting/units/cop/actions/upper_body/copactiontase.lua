Hooks:PostHook(CopActionTase, "on_attention", "sh_on_attention", function (self)
    if self._line_of_fire_slotmask then
        self._line_of_fire_slotmask = self._line_of_fire_slotmask - managers.slot:get_mask("persons")
    end
end)

function CopActionTase:update(t)
	if self._expired then
		return
	end

	local shoot_from_pos = self._ext_movement:m_head_pos()
	local target_dis
	local target_vec = temp_vec1
	local target_pos = temp_vec2

	self._attention.unit:character_damage():shoot_pos_mid(target_pos)

	target_dis = mvector3.direction(target_vec, shoot_from_pos, target_pos)
	local target_vec_flat = target_vec:with_z(0)

	mvector3.normalize(target_vec_flat)

	local fwd_dot = mvector3.dot(self._common_data.fwd, target_vec_flat)
    
	if fwd_dot > 0.7 then
		if not self._modifier_on then
			self._modifier_on = true
			self._machine:force_modifier(self._modifier_name)
			self._mod_enable_t = t + 0.5
		end

		self._modifier:set_target_y(target_vec)
	else
		if self._modifier_on then
			self._modifier_on = nil
			self._machine:allow_modifier(self._modifier_name)
		end

		if self._turn_allowed and not self._ext_anim.walk and not self._ext_anim.turn and not self._ext_movement:chk_action_forbidden("walk") then
			local spin = target_vec:to_polar_with_reference(self._common_data.fwd, math.UP).spin
			local abs_spin = math.abs(spin)
			if abs_spin > 27 then
				local new_action_data = {}
				new_action_data.type = "turn"
				new_action_data.body_part = 2
				new_action_data.angle = spin
				self._ext_movement:action_request(new_action_data)
			end

		end

		target_vec = nil
	end

	if self._ext_anim.reload or self._ext_anim.equip then
	elseif self._discharging then
		local vis_ray = self._unit:raycast("ray", shoot_from_pos, target_pos, "slot_mask", self._line_of_fire_slotmask, "ignore_unit", self._tasing_local_unit, "report")
		if not self._tasing_local_unit:movement():tased() or vis_ray then
			if Network:is_server() then
				self._expired = true
			else
				self._tasing_local_unit:movement():on_tase_ended()
				self._attention.unit:movement():on_targetted_for_attack(false, self._unit)
				self._discharging = nil
				self._tasing_player = nil
				self._tasing_local_unit = nil
				self.update = self._upd_empty
			end

		end

	elseif self._shoot_t and target_vec and self._common_data.allow_fire and t > self._shoot_t and t > self._mod_enable_t then
		if self._tase_effect then
			World:effect_manager():fade_kill(self._tase_effect)
		end

		self._tase_effect = World:effect_manager():spawn({
			effect = Idstring("effects/payday2/particles/character/taser_thread"),
			parent = self._ext_inventory:equipped_unit():get_object(Idstring("fire")),
			force_synch = true
		})
		if self._tasing_local_unit and mvector3.distance(shoot_from_pos, target_pos) < self._w_usage_tweak.tase_distance then
			local record = managers.groupai:state():criminal_record(self._tasing_local_unit:key())
			if not record or record.status or self._tasing_local_unit:movement():chk_action_forbidden("hurt") or self._tasing_local_unit:movement():zipline_unit() then
				if Network:is_server() then
					self._expired = true
				end

			else
				local vis_ray = self._unit:raycast("ray", shoot_from_pos, target_pos, "slot_mask", self._line_of_fire_slotmask, "ignore_unit", self._tasing_local_unit, "report")
				if not vis_ray then
					self._common_data.ext_network:send("action_tase_fire")
					local attack_data = {
						attacker_unit = self._unit
					}
					self._attention.unit:character_damage():damage_tase(attack_data)
					self._discharging = true
					if not self._tasing_local_unit:base().is_local_player then
						self._tasered_sound = self._unit:sound():play("tasered_3rd", nil)
					end

					local redir_res = self._ext_movement:play_redirect("recoil")
					if redir_res then
						self._machine:set_parameter(redir_res, "hvy", 0)
					end

					self._shoot_t = nil
					if managers.player:has_category_upgrade("player", "taser_malfunction") then
						self._malfunction_clbk_id = "tase_malf" .. tostring(self._unit:key())
						local delay = math.rand(tweak_data.upgrades.taser_malfunction_min or 1, tweak_data.upgrades.taser_malfunction_max or 3)
						managers.enemy:add_delayed_clbk(self._malfunction_clbk_id, callback(self, self, "clbk_malfunction"), t + delay)
					end

				end

			end

		elseif not self._tasing_local_unit then
			self._tasered_sound = self._unit:sound():play("tasered_3rd", nil)
			local redir_res = self._ext_movement:play_redirect("recoil")
			if redir_res then
				self._machine:set_parameter(redir_res, "hvy", 0)
			end

			self._shoot_t = nil
		end

	end

end

