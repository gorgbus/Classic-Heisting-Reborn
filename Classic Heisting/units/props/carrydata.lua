function CarryData:_update_throw_link(unit, t, dt)
end

local mvec1 = Vector3()

function CarryData:_explode()
	managers.mission:call_global_event("loot_exploded")

	local pos = self._unit:position()
	local normal = math.UP
	local range = CarryData.EXPLOSION_SETTINGS.range
	local effect = CarryData.EXPLOSION_SETTINGS.effect
	local slot_mask = managers.slot:get_mask("explosion_targets")

	self:_local_player_explosion_damage()
	managers.explosion:play_sound_and_effects(pos, normal, range, CarryData.EXPLOSION_CUSTOM_PARAMS)

	local hit_units, splinters = managers.explosion:detect_and_give_dmg({
		player_damage = 0,
		hit_pos = pos,
		range = range,
		collision_slotmask = slot_mask,
		curve_pow = CarryData.EXPLOSION_SETTINGS.curve_pow,
		damage = CarryData.EXPLOSION_SETTINGS.damage,
		ignore_unit = self._unit
	})

	for _, unit in pairs(hit_units) do
		if unit ~= self._unit and unit:carry_data() then
			mvector3.set(mvec1, unit:position())

			local distance = mvector3.distance(pos, mvec1)
			local chance = math.lerp(1, 0, math.max(distance - range / 2, 0) / range)

			if math.rand(1) < chance then
				for i_splinter, s_pos in ipairs(splinters) do
					local ray_hit = not World:raycast("ray", s_pos, mvec1, "slot_mask", slot_mask, "ignore_unit", {
						self._unit,
						unit
					}, "report")

					if ray_hit then
						--unit:carry_data():start_explosion(0)

						break
					end
				end
			end
		end
	end

	QuickFlashGrenade:make_flash(pos, range, {
		self._unit
	})
	managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "carry_data", CarryData.EVENT_IDS.explode)
	self._unit:set_slot(0)
end