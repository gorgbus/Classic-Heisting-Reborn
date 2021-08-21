local mvec3_set = mvector3.set
local mvec3_set_z = mvector3.set_z
local mvec3_sub = mvector3.subtract
local mvec3_norm = mvector3.normalize
local mvec3_dir = mvector3.direction
local mvec3_set_l = mvector3.set_length
local mvec3_add = mvector3.add
local mvec3_dot = mvector3.dot
local mvec3_cross = mvector3.cross
local mvec3_rot = mvector3.rotate_with
local mvec3_rand_orth = mvector3.random_orthogonal
local mvec3_lerp = mvector3.lerp
local mrot_axis_angle = mrotation.set_axis_angle
local temp_vec1 = Vector3()
local temp_vec2 = Vector3()
local temp_vec3 = Vector3()
local temp_rot1 = Rotation()
local bezier_curve = {
	0,
	0,
	1,
	1
}

function CopActionShoot:_get_unit_shoot_pos(t, pos, dis, w_tweak, falloff, i_range, shooting_local_player)
	local shoot_hist = self._shoot_history
	local focus_delay, focus_prog = nil

	if shoot_hist.focus_delay then
		focus_delay = (shooting_local_player and self._attention.unit:character_damage():focus_delay_mul() or 1) * shoot_hist.focus_delay
		focus_prog = focus_delay > 0 and (t - shoot_hist.focus_start_t) / focus_delay

		if not focus_prog or focus_prog >= 1 then
			shoot_hist.focus_delay = nil
			focus_prog = 1
		end
	else
		focus_prog = 1
	end

	local dis_lerp = nil
	local hit_chances = falloff.acc
	local hit_chance = nil

	if i_range == 1 then
		dis_lerp = dis / falloff.r
		hit_chance = math.lerp(hit_chances[1], hit_chances[2], focus_prog)
	else
		local prev_falloff = w_tweak.FALLOFF[i_range - 1]
		dis_lerp = math.min(1, (dis - prev_falloff.r) / (falloff.r - prev_falloff.r))
		local prev_range_hit_chance = math.lerp(prev_falloff.acc[1], prev_falloff.acc[2], focus_prog)
		hit_chance = math.lerp(prev_range_hit_chance, math.lerp(hit_chances[1], hit_chances[2], focus_prog), dis_lerp)
	end

	if self._common_data.is_suppressed then
		hit_chance = hit_chance * 0.5
	end

	if self._common_data.active_actions[2] and self._common_data.active_actions[2]:type() == "dodge" then
		hit_chance = hit_chance * self._common_data.active_actions[2]:accuracy_multiplier()
	end

	hit_chance = hit_chance * self._unit:character_damage():accuracy_multiplier()

	if self:_pseudorandom() < hit_chance then
		mvec3_set(shoot_hist.m_last_pos, pos)
	else
		local enemy_vec = temp_vec2

		mvec3_set(enemy_vec, pos)
		mvec3_sub(enemy_vec, self._ext_movement:m_head_pos())

		local error_vec = Vector3()

		mvec3_cross(error_vec, enemy_vec, math.UP)
		mrot_axis_angle(temp_rot1, enemy_vec, math.random(360))
		mvec3_rot(error_vec, temp_rot1)

		local miss_min_dis = shooting_local_player and 31 or 150
		local error_vec_len = miss_min_dis + w_tweak.spread + w_tweak.miss_dis * math.random() * (1 - focus_prog)

		mvec3_set_l(error_vec, error_vec_len)
		mvec3_add(error_vec, pos)
		mvec3_set(shoot_hist.m_last_pos, error_vec)

		return error_vec
	end
end
