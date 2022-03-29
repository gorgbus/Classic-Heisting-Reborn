local mvec_to = Vector3()
local mvec_spread_direction = Vector3()
function RaycastWeaponBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, shoot_player, spread_mul, autohit_mul, suppr_mul)
	local result = {}
	local hit_unit
	local spread = self:_get_spread(user_unit)
	mvector3.set(mvec_spread_direction, direction)
	if spread then
		mvector3.spread(mvec_spread_direction, spread * (spread_mul or 1))
	end
	mvector3.set(mvec_to, mvec_spread_direction)
	mvector3.multiply(mvec_to, 20000)
	mvector3.add(mvec_to, from_pos)
	local damage = self:_get_current_damage(dmg_mul)
	local col_ray = World:raycast("ray", from_pos, mvec_to, "slot_mask", self._bullet_slotmask, "ignore_unit", self._setup.ignore_units)
	local autoaim, suppression_enemies = self:check_autoaim(from_pos, direction)
	if self._autoaim then
		local weight = 0.1
		if col_ray and col_ray.unit:in_slot(managers.slot:get_mask("enemies")) then
			self._autohit_current = (self._autohit_current + weight) / (1 + weight)
			hit_unit = InstantBulletBase:on_collision(col_ray, self._unit, user_unit, damage)
		elseif autoaim then
			local autohit_chance = 1 - math.clamp((self._autohit_current - self._autohit_data.MIN_RATIO) / (self._autohit_data.MAX_RATIO - self._autohit_data.MIN_RATIO), 0, 1)
			if autohit_mul then
				autohit_chance = autohit_chance * autohit_mul
			end
			if autohit_chance > math.random() then
				self._autohit_current = (self._autohit_current + weight) / (1 + weight)
				hit_unit = InstantBulletBase:on_collision(autoaim, self._unit, user_unit, damage)
			else
				self._autohit_current = self._autohit_current / (1 + weight)
			end
		elseif col_ray then
			hit_unit = InstantBulletBase:on_collision(col_ray, self._unit, user_unit, damage)
		end
		self._shot_fired_stats_table.hit = hit_unit and true or false
		managers.statistics:shot_fired(self._shot_fired_stats_table)
	elseif col_ray then
		hit_unit = InstantBulletBase:on_collision(col_ray, self._unit, user_unit, damage)
	end
	if suppression_enemies and self._suppression then
		result.enemies_in_cone = suppression_enemies
	end
	if hit_unit and hit_unit.type == "death" and self:weapon_tweak_data().category == tweak_data.achievement.easy_as_breathing.weapon_type then
		self._kills_without_releasing_trigger = (self._kills_without_releasing_trigger or 0) + 1
		if self._kills_without_releasing_trigger >= tweak_data.achievement.easy_as_breathing.count then
			managers.achievment:award(tweak_data.achievement.easy_as_breathing.award)
		end
	end
	if (col_ray and col_ray.distance > 600 or not col_ray) and alive(self._obj_fire) then
		self._obj_fire:m_position(self._trail_effect_table.position)
		mvector3.set(self._trail_effect_table.normal, mvec_spread_direction)
		local trail = World:effect_manager():spawn(self._trail_effect_table)
		if col_ray then
			World:effect_manager():set_remaining_lifetime(trail, math.clamp((col_ray.distance - 600) / 10000, 0, col_ray.distance))
		end
	end
	result.hit_enemy = hit_unit
	if self._alert_events then
		result.rays = {col_ray}
	end
	return result
end