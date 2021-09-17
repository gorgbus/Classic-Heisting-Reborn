function SentryGunBase.spawn(owner, pos, rot, peer_id, verify_equipment, unit_idstring_index, fire_mode_index)
	local attached_data = SentryGunBase._attach(pos, rot)

	if not attached_data then
		Application:error("[SentryGunBase.spawn] Failed attaching sentry gun", owner, pos, rot, peer_id, verify_equipment, unit_idstring_index)

		return
	end

	if verify_equipment and not managers.player:verify_equipment(peer_id, "sentry_gun") then
		Application:error("[SentryGunBase.spawn] Player equipment verification failed", owner, pos, rot, peer_id, verify_equipment, unit_idstring_index)

		return
	end

	local sentry_owner = nil

	if owner and owner:base().upgrade_value then
		sentry_owner = owner
	end

    local player_skill = PlayerSkill
	local ap_bullets = player_skill.has_skill("sentry_gun", "ap_bullets", sentry_owner)
	local id_string = Idstring("units/payday2/equipment/gen_equipment_sentry/gen_equipment_sentry")

    local spread_level, rot_speed_level, has_shield, ammo_multiplier, armor_multiplier, damage_multiplier

    if owner and owner:base().upgrade_value then
        damage_multiplier = owner:base():upgrade_value("sentry_gun", "damage_multiplier") or 1
        ammo_multiplier = owner:base():upgrade_value("sentry_gun", "extra_ammo_multiplier") or 1
        armor_multiplier = 1 + owner:base():upgrade_value("sentry_gun", "armor_multiplier", 1) - 1
		spread_level = owner:base():upgrade_value("sentry_gun", "spread_multiplier") or 1
		rot_speed_level = owner:base():upgrade_value("sentry_gun", "rot_speed_multiplier") or 1
		has_shield = owner:base():upgrade_value("sentry_gun", "shield")
	else
        damage_multiplier = managers.player:upgrade_value("sentry_gun", "damage_multiplier", 1) or 1
        ammo_multiplier = managers.player:upgrade_value("sentry_gun", "extra_ammo_multiplier") or 1
        armor_multiplier = 1 + managers.player:upgrade_value("sentry_gun", "armor_multiplier", 1) - 1
		spread_level = managers.player:upgrade_value("sentry_gun", "spread_multiplier", 1)
		rot_speed_level = managers.player:upgrade_value("sentry_gun", "rot_speed_multiplier", 1)
		has_shield = managers.player:has_category_upgrade("sentry_gun", "shield")
	end

	if unit_idstring_index then
		id_string = tweak_data.equipments.sentry_id_strings[unit_idstring_index]
	end

	local unit = World:spawn_unit(id_string, pos, rot)

	managers.network:session():send_to_peers_synched("sync_equipment_setup", unit, 0, peer_id or 0)

	unit:base():setup(owner, ammo_multiplier, armor_multiplier, damage_multiplier, spread_level, rot_speed_level, has_shield, attached_data, fire_mode_index)

	local owner_id = unit:base():get_owner_id()

	if ap_bullets and owner_id then
		local fire_mode_unit = World:spawn_unit(Idstring("units/payday2/equipment/gen_equipment_sentry/gen_equipment_sentry_fire_mode"), unit:position(), unit:rotation())

		unit:weapon():interaction_setup(fire_mode_unit, owner_id)
		managers.network:session():send_to_peers_synched("sync_fire_mode_interaction", unit, fire_mode_unit, owner_id)
	end

	local team = nil

	if owner then
		team = owner:movement():team()
	else
		team = managers.groupai:state():team_data(tweak_data.levels:get_default_team_ID("player"))
	end

	unit:movement():set_team(team)
	unit:brain():set_active(true)

	SentryGunBase.deployed = (SentryGunBase.deployed or 0) + 1

	return unit, spread_level, rot_speed_level
end

function SentryGunBase:setup(owner, ammo_multiplier, armor_multiplier, damage_multiplier, spread_multiplier, rot_speed_multiplier, has_shield, attached_data)
	if Network:is_client() and not self._skip_authentication then
		self._validate_clbk_id = "sentry_gun_validate" .. tostring(unit:key())

		managers.enemy:add_delayed_clbk(self._validate_clbk_id, callback(self, self, "_clbk_validate"), Application:time() + 60)
	end

	self._attached_data = attached_data
	self._ammo_multiplier = ammo_multiplier
	self._armor_multiplier = armor_multiplier
	self._spread_multiplier = spread_multiplier
	self._rot_speed_multiplier = rot_speed_multiplier

	if has_shield then
		self:enable_shield()
	end

	local ammo_amount = tweak_data.upgrades.sentry_gun_base_ammo * ammo_multiplier

	self._unit:weapon():set_ammo(ammo_amount)

	local armor_amount = tweak_data.upgrades.sentry_gun_base_armor * armor_multiplier

	self._unit:character_damage():set_health(armor_amount, 0)

	self._owner = owner

	if owner then
		local peer = managers.network:session():peer_by_unit(owner)

		if peer then
			self._owner_id = peer:id()

			if self._unit:interaction() then
				self._unit:interaction():set_owner_id(self._owner_id)
			end
		end
	end

	self._unit:movement():setup(rot_speed_multiplier)
	self._unit:brain():setup(1 / rot_speed_multiplier)
	self:register()
	self._unit:movement():set_team(owner:movement():team())

	local setup_data = {
		expend_ammo = true,
		autoaim = true,
		alert_AI = true,
		creates_alerts = true,
		user_unit = self._owner,
		ignore_units = {
			self._unit,
			self._owner
		},
		alert_filter = self._owner:movement():SO_access(),
		spread_mul = spread_multiplier
	}

	self._unit:weapon():setup(setup_data, damage_multiplier)
	self._unit:set_extension_update_enabled(Idstring("base"), true)

	return true
end