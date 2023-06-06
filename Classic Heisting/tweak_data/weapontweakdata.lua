Hooks:PostHook(WeaponTweakData, "init", "restore_init", function(self, tweak_data)
	local total_damage_primary = 300
	local total_damage_secondary = 150

	-- NPC Weapons
	self.c45_npc.NR_CLIPS_MAX = 5
	self.beretta92_npc.NR_CLIPS_MAX = 4
	self.m4_npc.CLIP_AMMO_MAX = 20
	self.ak47_npc.CLIP_AMMO_MAX = 20
	self.m14_npc.CLIP_AMMO_MAX = 12
	self.r870_npc.DAMAGE = 7
	self.mossberg_npc.CLIP_AMMO_MAX = 4
	self.mossberg_npc.NR_CLIPS_MAX = 6
	self.mac11_npc.CLIP_AMMO_MAX = 32
	self.g36_npc.CLIP_AMMO_MAX = 20
	self.mp9_npc.CLIP_AMMO_MAX = 32
	self.sentry_gun.DAMAGE = 1
	self.saiga_npc.DAMAGE = 5
	self.saiga_npc.CLIP_AMMO_MAX = 20
	--
	self.new_m4.stats = {
		damage = 10,
		spread = 7,
		recoil = 7,
		spread_moving = 7,
		zoom = 3,
		concealment = 20,
		suppression = 10,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.glock_17.stats = {
		damage = 6,
		spread = 7,
		recoil = 7,
		spread_moving = 7,
		zoom = 1,
		concealment = 30,
		suppression = 16,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.mp9.stats = {
		damage = 9,
		spread = 7,
		recoil = 7,
		spread_moving = 8,
		zoom = 3,
		concealment = 24,
		suppression = 16,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.r870.stats = {
		damage = 23,
		spread = 8,
		recoil = 3,
		spread_moving = 6,
		zoom = 3,
		concealment = 11,
		suppression = 5,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.glock_18c.stats = {
		damage = 9,
		spread = 5,
		recoil = 6,
		spread_moving = 9,
		zoom = 1,
		concealment = 29,
		suppression = 16,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.amcar.stats = {
		damage = 7,
		spread = 6,
		recoil = 8,
		spread_moving = 6,
		zoom = 3,
		concealment = 21,
		suppression = 10,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.m16.stats = {
		damage = 13,
		spread = 7,
		recoil = 10,
		spread_moving = 5,
		zoom = 4,
		concealment = 17,
		suppression = 10,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.olympic.stats = {
		damage = 8,
		spread = 8,
		recoil = 10,
		spread_moving = 8,
		zoom = 3,
		concealment = 24,
		suppression = 10,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.ak74.stats = {
		damage = 12,
		spread = 6,
		recoil = 6,
		spread_moving = 6,
		zoom = 3,
		concealment = 16,
		suppression = 10,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.akm.stats = {
		damage = 17,
		spread = 6,
		recoil = 5,
		spread_moving = 6,
		zoom = 3,
		concealment = 13,
		suppression = 8,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.akmsu.stats = {
		damage = 11,
		spread = 7,
		recoil = 6,
		spread_moving = 9,
		zoom = 3,
		concealment = 21,
		suppression = 8,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.saiga.stats = {
		damage = 15,
		spread = 6,
		recoil = 4,
		spread_moving = 7,
		zoom = 3,
		concealment = 13,
		suppression = 5,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.ak5.stats = {
		damage = 9,
		spread = 9,
		recoil = 12,
		spread_moving = 6,
		zoom = 3,
		concealment = 18,
		suppression = 10,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.aug.stats = {
		damage = 12,
		spread = 8,
		recoil = 5,
		spread_moving = 7,
		zoom = 3,
		concealment = 20,
		suppression = 10,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.g36.stats = {
		damage = 11,
		spread = 7,
		recoil = 8,
		spread_moving = 8,
		zoom = 3,
		concealment = 19,
		suppression = 11,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.p90.stats = {
		damage = 9,
		spread = 8,
		recoil = 9,
		spread_moving = 9,
		zoom = 3,
		concealment = 23,
		suppression = 12,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.new_m14.stats = {
		damage = 26,
		spread = 9,
		recoil = 2,
		spread_moving = 5,
		zoom = 3,
		concealment = 6,
		suppression = 4,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.deagle.stats = {
		damage = 19,
		spread = 6,
		recoil = 3,
		spread_moving = 6,
		zoom = 3,
		concealment = 28,
		suppression = 7,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.new_mp5.stats = {
		damage = 8,
		spread = 7,
		recoil = 11,
		spread_moving = 8,
		zoom = 3,
		concealment = 23,
		suppression = 17,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.colt_1911.stats = {
		damage = 10,
		spread = 7,
		recoil = 5,
		spread_moving = 5,
		zoom = 3,
		concealment = 29,
		suppression = 14,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.mac10.stats = {
		damage = 11,
		spread = 5,
		recoil = 6,
		spread_moving = 8,
		zoom = 3,
		concealment = 27,
		suppression = 14,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.serbu.stats = {
		damage = 24,
		spread = 5,
		recoil = 3,
		spread_moving = 6,
		zoom = 3,
		concealment = 26,
		suppression = 5,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.huntsman.stats = {
		damage = 28,
		spread = 7,
		recoil = 2,
		spread_moving = 6,
		zoom = 3,
		concealment = 7,
		suppression = 2,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.b92fs.stats = {
		damage = 8,
		spread = 8,
		recoil = 8,
		spread_moving = 5,
		zoom = 3,
		concealment = 30,
		suppression = 17,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.new_raging_bull.stats = {
		damage = 22,
		spread = 7,
		recoil = 2,
		spread_moving = 5,
		zoom = 3,
		concealment = 26,
		suppression = 7,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.saw.stats = {
		alert_size = 9,
		suppression = 7,
		zoom = 1,
		spread = 3,
		recoil = 7,
		spread_moving = 7,
		damage = 10,
		concealment = 16,
		value = 1,
		extra_ammo = 6,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.usp.stats = {
		damage = 9,
		spread = 7,
		recoil = 9,
		spread_moving = 8,
		zoom = 1,
		concealment = 29,
		suppression = 16,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.m45.stats = {
		damage = 12,
		spread = 6,
		recoil = 7,
		spread_moving = 8,
		zoom = 1,
		concealment = 24,
		suppression = 14,
		alert_size = 7,
		extra_ammo = 6,
		value = 5,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.s552.stats = {
		damage = 12,
		spread = 6,
		recoil = 9,
		spread_moving = 5,
		zoom = 3,
		concealment = 22,
		suppression = 12,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.ppk.stats = {
		damage = 8,
		spread = 9,
		recoil = 9,
		spread_moving = 9,
		zoom = 3,
		concealment = 30,
		suppression = 18,
		alert_size = 7,
		extra_ammo = 6,
		value = 1,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.mp7.stats = {
		damage = 12,
		spread = 7,
		recoil = 8,
		spread_moving = 7,
		zoom = 1,
		concealment = 23,
		suppression = 16,
		alert_size = 7,
		extra_ammo = 6,
		value = 7,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.scar.stats = {
		damage = 18,
		spread = 7,
		recoil = 5,
		spread_moving = 5,
		zoom = 3,
		concealment = 8,
		suppression = 8,
		alert_size = 7,
		extra_ammo = 6,
		value = 9,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.p226.stats = {
		damage = 10,
		spread = 7,
		recoil = 7,
		spread_moving = 7,
		zoom = 3,
		concealment = 29,
		suppression = 15,
		alert_size = 7,
		extra_ammo = 6,
		value = 4,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.hk21.stats = {
		damage = 14,
		spread = 6,
		recoil = 5,
		spread_moving = 8,
		zoom = 3,
		concealment = 2,
		suppression = 2,
		alert_size = 8,
		extra_ammo = 6,
		value = 9,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.m249.stats = {
		damage = 12,
		spread = 4,
		recoil = 7,
		spread_moving = 9,
		zoom = 1,
		concealment = 2,
		suppression = 4,
		alert_size = 8,
		extra_ammo = 6,
		value = 9,
		total_ammo_mod = 21,
		reload = 11,
	}
	self.rpk.stats = {
		damage = 13,
		spread = 5,
		recoil = 6,
		spread_moving = 6,
		zoom = 2,
		concealment = 5,
		suppression = 8,
		alert_size = 7,
		extra_ammo = 6,
		value = 9,
		total_ammo_mod = 21,
		reload = 11,
	}

	self.r870.damage_near = 700
	self.r870.damage_far = 1500
	self.saiga.damage_near = 700
	self.saiga.damage_far = 1800
	self.serbu.damage_near = 800
	self.serbu.damage_far = 1200
	self.huntsman.damage_near = 1000
	self.huntsman.damage_far = 2000

	self.new_m4.timers = {}
	self.new_m4.timers.reload_not_empty = 2.25
	self.new_m4.timers.reload_empty = 3
	self.new_m4.timers.unequip = 0.75
	self.new_m4.timers.equip = 0.7
	self.new_m4.CLIP_AMMO_MAX = 30
	self.new_m4.NR_CLIPS_MAX = math.round(total_damage_primary / 2 / self.new_m4.CLIP_AMMO_MAX)
	self.new_m4.AMMO_MAX = self.new_m4.CLIP_AMMO_MAX * self.new_m4.NR_CLIPS_MAX
	self.new_m4.AMMO_PICKUP = self:_pickup_chance(self.new_m4.AMMO_MAX, 2)
	self.new_m4.fire_mode_data.fire_rate = 0.1
	self.new_m4.spread.standing = 3.5
	self.new_m4.spread.crouching = self.new_m4.spread.standing
	self.new_m4.spread.steelsight = 1
	self.new_m4.spread.moving_standing = self.new_m4.spread.standing
	self.new_m4.spread.moving_crouching = self.new_m4.spread.standing
	self.new_m4.spread.moving_steelsight = self.new_m4.spread.steelsight * 2

	self.glock_17.timers = {}
	self.glock_17.timers.reload_not_empty = 1.47
	self.glock_17.timers.reload_empty = 2.12
	self.glock_17.timers.unequip = 0.5
	self.glock_17.timers.equip = 0.5
	self.glock_17.CLIP_AMMO_MAX = 17
	self.glock_17.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.15 / self.glock_17.CLIP_AMMO_MAX)
	self.glock_17.AMMO_MAX = self.glock_17.CLIP_AMMO_MAX * self.glock_17.NR_CLIPS_MAX
	self.glock_17.AMMO_PICKUP = self:_pickup_chance(self.glock_17.AMMO_MAX, 1)
	self.glock_17.fire_mode_data.fire_rate = 0.12
	self.glock_17.spread.standing = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.crouching = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.steelsight = self.new_m4.spread.steelsight
	self.glock_17.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.glock_17.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.mp9.timers = {}
	self.mp9.timers.reload_not_empty = 1.51
	self.mp9.timers.reload_empty = 2.48
	self.mp9.timers.unequip = 0.7
	self.mp9.timers.equip = 0.55
	self.mp9.CLIP_AMMO_MAX = 30
	self.mp9.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.15 / self.mp9.CLIP_AMMO_MAX)
	self.mp9.AMMO_MAX = self.mp9.CLIP_AMMO_MAX * self.mp9.NR_CLIPS_MAX
	self.mp9.AMMO_PICKUP = self:_pickup_chance(self.mp9.AMMO_MAX, 1)
	self.mp9.fire_mode_data.fire_rate = 0.063
	self.mp9.spread.standing = self.new_m4.spread.standing * 0.75
	self.mp9.spread.crouching = self.new_m4.spread.standing * 0.75
	self.mp9.spread.steelsight = self.new_m4.spread.steelsight
	self.mp9.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.mp9.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.mp9.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.r870.CLIP_AMMO_MAX = 6
	self.r870.NR_CLIPS_MAX = math.round(total_damage_primary / 6.5 / self.r870.CLIP_AMMO_MAX)
	self.r870.AMMO_MAX = self.r870.CLIP_AMMO_MAX * self.r870.NR_CLIPS_MAX
	self.r870.AMMO_PICKUP = self:_pickup_chance(self.r870.AMMO_MAX, 2)
	self.r870.fire_mode_data.fire_rate = 0.575
	self.r870.spread.standing = self.new_m4.spread.standing * 1
	self.r870.spread.crouching = self.new_m4.spread.standing * 1
	self.r870.spread.steelsight = self.new_m4.spread.standing * 0.8
	self.r870.spread.moving_standing = self.new_m4.spread.standing * 1
	self.r870.spread.moving_crouching = self.new_m4.spread.standing * 1
	self.r870.spread.moving_steelsight = self.new_m4.spread.standing * 0.8
	self.r870.kick.standing = {
		1.9,
		2,
		-0.2,
		0.2,
	}
	self.r870.kick.crouching = self.r870.kick.standing

	self.glock_18c.timers = {}
	self.glock_18c.timers.reload_not_empty = 1.47
	self.glock_18c.timers.reload_empty = 2.12
	self.glock_18c.timers.unequip = 0.55
	self.glock_18c.timers.equip = 0.55
	self.glock_18c.CLIP_AMMO_MAX = 20
	self.glock_18c.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.15 / self.glock_18c.CLIP_AMMO_MAX)
	self.glock_18c.AMMO_MAX = self.glock_18c.CLIP_AMMO_MAX * self.glock_18c.NR_CLIPS_MAX
	self.glock_18c.AMMO_PICKUP = self:_pickup_chance(self.glock_18c.AMMO_MAX, 1)
	self.glock_18c.fire_mode_data.fire_rate = 0.066
	self.glock_18c.spread.standing = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.crouching = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.steelsight = self.new_m4.spread.steelsight
	self.glock_18c.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.glock_18c.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.amcar.timers = {}
	self.amcar.timers.reload_not_empty = 2.25
	self.amcar.timers.reload_empty = 3
	self.amcar.timers.unequip = 0.8
	self.amcar.timers.equip = 0.7
	self.amcar.CLIP_AMMO_MAX = 20
	self.amcar.NR_CLIPS_MAX = math.round(total_damage_primary / 1.6 / self.amcar.CLIP_AMMO_MAX)
	self.amcar.AMMO_MAX = self.amcar.CLIP_AMMO_MAX * self.amcar.NR_CLIPS_MAX
	self.amcar.AMMO_PICKUP = self:_pickup_chance(self.amcar.AMMO_MAX, 2)
	self.amcar.fire_mode_data.fire_rate = 0.11
	self.amcar.spread.standing = self.new_m4.spread.standing
	self.amcar.spread.crouching = self.new_m4.spread.standing
	self.amcar.spread.steelsight = self.new_m4.spread.steelsight
	self.amcar.spread.moving_standing = self.new_m4.spread.standing
	self.amcar.spread.moving_crouching = self.new_m4.spread.standing
	self.amcar.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.m16.timers = {}
	self.m16.timers.reload_not_empty = 2.25
	self.m16.timers.reload_empty = 3
	self.m16.timers.unequip = 0.8
	self.m16.timers.equip = 0.8
	self.m16.CLIP_AMMO_MAX = 30
	self.m16.NR_CLIPS_MAX = math.round(total_damage_primary / 3 / self.m16.CLIP_AMMO_MAX)
	self.m16.AMMO_MAX = self.m16.CLIP_AMMO_MAX * self.m16.NR_CLIPS_MAX
	self.m16.AMMO_PICKUP = self:_pickup_chance(self.m16.AMMO_MAX, 2)
	self.m16.fire_mode_data.fire_rate = 0.07
	self.m16.spread.standing = self.new_m4.spread.standing
	self.m16.spread.crouching = self.new_m4.spread.standing
	self.m16.spread.steelsight = self.new_m4.spread.steelsight
	self.m16.spread.moving_standing = self.new_m4.spread.standing
	self.m16.spread.moving_crouching = self.new_m4.spread.standing
	self.m16.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.olympic.timers = {}
	self.olympic.timers.reload_not_empty = 2.535
	self.olympic.timers.reload_empty = 3.49
	self.olympic.timers.unequip = 0.6
	self.olympic.timers.equip = 0.5
	self.olympic.CLIP_AMMO_MAX = 25
	self.olympic.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.6 / self.olympic.CLIP_AMMO_MAX)
	self.olympic.AMMO_MAX = self.olympic.CLIP_AMMO_MAX * self.olympic.NR_CLIPS_MAX
	self.olympic.AMMO_PICKUP = self:_pickup_chance(self.olympic.AMMO_MAX, 1)
	self.olympic.fire_mode_data.fire_rate = 0.088
	self.olympic.spread.standing = self.new_m4.spread.standing * 0.8
	self.olympic.spread.crouching = self.new_m4.spread.standing * 0.8
	self.olympic.spread.steelsight = self.new_m4.spread.steelsight
	self.olympic.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.olympic.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.olympic.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.ak74.timers = {}
	self.ak74.timers.reload_not_empty = 2.8
	self.ak74.timers.reload_empty = 3.87
	self.ak74.timers.unequip = 0.8
	self.ak74.timers.equip = 0.8
	self.ak74.CLIP_AMMO_MAX = 30
	self.ak74.NR_CLIPS_MAX = math.round(total_damage_primary / 2.5 / self.ak74.CLIP_AMMO_MAX)
	self.ak74.AMMO_MAX = self.ak74.CLIP_AMMO_MAX * self.ak74.NR_CLIPS_MAX
	self.ak74.AMMO_PICKUP = self:_pickup_chance(self.ak74.AMMO_MAX, 2)
	self.ak74.fire_mode_data.fire_rate = 0.092
	self.ak74.spread.standing = self.new_m4.spread.standing
	self.ak74.spread.crouching = self.new_m4.spread.standing
	self.ak74.spread.steelsight = self.new_m4.spread.steelsight
	self.ak74.spread.moving_standing = self.new_m4.spread.standing
	self.ak74.spread.moving_crouching = self.new_m4.spread.standing
	self.ak74.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.akm.timers = {}
	self.akm.timers.reload_not_empty = 2.8
	self.akm.timers.reload_empty = 3.87
	self.akm.timers.unequip = 0.8
	self.akm.timers.equip = 0.8
	self.akm.CLIP_AMMO_MAX = 30
	self.akm.NR_CLIPS_MAX = math.round(total_damage_primary / 4 / self.akm.CLIP_AMMO_MAX)
	self.akm.AMMO_MAX = self.akm.CLIP_AMMO_MAX * self.akm.NR_CLIPS_MAX
	self.akm.AMMO_PICKUP = self:_pickup_chance(self.akm.AMMO_MAX, 2)
	self.akm.fire_mode_data.fire_rate = 0.107
	self.akm.spread.standing = self.new_m4.spread.standing
	self.akm.spread.crouching = self.new_m4.spread.standing
	self.akm.spread.steelsight = self.new_m4.spread.steelsight
	self.akm.spread.moving_standing = self.new_m4.spread.standing
	self.akm.spread.moving_crouching = self.new_m4.spread.standing
	self.akm.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.akmsu.timers = {}
	self.akmsu.timers.reload_not_empty = 2.8
	self.akmsu.timers.reload_empty = 3.87
	self.akmsu.timers.unequip = 0.65
	self.akmsu.timers.equip = 0.6
	self.akmsu.CLIP_AMMO_MAX = 30
	self.akmsu.NR_CLIPS_MAX = math.round(total_damage_secondary / 2.75 / self.akmsu.CLIP_AMMO_MAX)
	self.akmsu.AMMO_MAX = self.akmsu.CLIP_AMMO_MAX * self.akmsu.NR_CLIPS_MAX
	self.akmsu.AMMO_PICKUP = self:_pickup_chance(self.akmsu.AMMO_MAX, 1)
	self.akmsu.fire_mode_data.fire_rate = 0.073
	self.akmsu.spread.standing = self.new_m4.spread.standing
	self.akmsu.spread.crouching = self.new_m4.spread.standing
	self.akmsu.spread.steelsight = self.new_m4.spread.steelsight
	self.akmsu.spread.moving_standing = self.new_m4.spread.standing
	self.akmsu.spread.moving_crouching = self.new_m4.spread.standing
	self.akmsu.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.saiga.timers = {}
	self.saiga.timers.reload_not_empty = 2.8
	self.saiga.timers.reload_empty = 3.87
	self.saiga.timers.unequip = 0.85
	self.saiga.timers.equip = 0.85
	self.saiga.CLIP_AMMO_MAX = 7
	self.saiga.NR_CLIPS_MAX = math.round(total_damage_primary / 4.5 / self.saiga.CLIP_AMMO_MAX)
	self.saiga.AMMO_MAX = self.saiga.CLIP_AMMO_MAX * self.saiga.NR_CLIPS_MAX
	self.saiga.AMMO_PICKUP = self:_pickup_chance(self.saiga.AMMO_MAX, 2)
	self.saiga.fire_mode_data.fire_rate = 0.18
	self.saiga.spread.standing = self.r870.spread.standing
	self.saiga.spread.crouching = self.r870.spread.crouching
	self.saiga.spread.steelsight = self.r870.spread.steelsight
	self.saiga.spread.moving_standing = self.r870.spread.moving_standing
	self.saiga.spread.moving_crouching = self.r870.spread.moving_crouching
	self.saiga.spread.moving_steelsight = self.r870.spread.moving_steelsight

	self.ak5.timers = {}
	self.ak5.timers.reload_not_empty = 2.25
	self.ak5.timers.reload_empty = 3.47
	self.ak5.timers.unequip = 0.8
	self.ak5.timers.equip = 0.8
	self.ak5.CLIP_AMMO_MAX = 30
	self.ak5.NR_CLIPS_MAX = math.round(total_damage_primary / 2 / self.ak5.CLIP_AMMO_MAX)
	self.ak5.AMMO_MAX = self.ak5.CLIP_AMMO_MAX * self.ak5.NR_CLIPS_MAX
	self.ak5.AMMO_PICKUP = self:_pickup_chance(self.ak5.AMMO_MAX, 2)
	self.ak5.fire_mode_data.fire_rate = 0.085
	self.ak5.spread.standing = self.new_m4.spread.standing
	self.ak5.spread.crouching = self.new_m4.spread.standing
	self.ak5.spread.steelsight = self.new_m4.spread.steelsight
	self.ak5.spread.moving_standing = self.new_m4.spread.standing
	self.ak5.spread.moving_crouching = self.new_m4.spread.standing
	self.ak5.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.aug.timers = {}
	self.aug.timers.reload_not_empty = 2.5
	self.aug.timers.reload_empty = 3.3
	self.aug.timers.unequip = 0.8
	self.aug.timers.equip = 0.8
	self.aug.CLIP_AMMO_MAX = 30
	self.aug.NR_CLIPS_MAX = math.round(total_damage_primary / 2.25 / self.aug.CLIP_AMMO_MAX)
	self.aug.AMMO_MAX = self.aug.CLIP_AMMO_MAX * self.aug.NR_CLIPS_MAX
	self.aug.AMMO_PICKUP = self:_pickup_chance(self.aug.AMMO_MAX, 2)
	self.aug.fire_mode_data.fire_rate = 0.08
	self.aug.spread.standing = self.new_m4.spread.standing * 2.5
	self.aug.spread.crouching = self.new_m4.spread.standing * 2.5
	self.aug.spread.steelsight = self.new_m4.spread.steelsight
	self.aug.spread.moving_standing = self.new_m4.spread.standing * 3.5
	self.aug.spread.moving_crouching = self.new_m4.spread.standing * 3.5
	self.aug.spread.moving_steelsight = self.new_m4.spread.moving_steelsight * 1.5

	self.g36.timers = {}
	self.g36.timers.reload_not_empty = 2.5
	self.g36.timers.reload_empty = 3.45
	self.g36.timers.unequip = 0.85
	self.g36.timers.equip = 0.85
	self.g36.CLIP_AMMO_MAX = 30
	self.g36.NR_CLIPS_MAX = math.round(total_damage_primary / 1.75 / self.g36.CLIP_AMMO_MAX)
	self.g36.AMMO_MAX = self.g36.CLIP_AMMO_MAX * self.g36.NR_CLIPS_MAX
	self.g36.AMMO_PICKUP = self:_pickup_chance(self.g36.AMMO_MAX, 2)
	self.g36.fire_mode_data.fire_rate = 0.085
	self.g36.spread.standing = self.new_m4.spread.standing * 0.8
	self.g36.spread.crouching = self.new_m4.spread.standing * 0.8
	self.g36.spread.steelsight = self.new_m4.spread.steelsight
	self.g36.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.g36.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.g36.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.p90.timers = {}
	self.p90.timers.reload_not_empty = 2.9
	self.p90.timers.reload_empty = 3.9
	self.p90.timers.unequip = 0.68
	self.p90.timers.equip = 0.65
	self.p90.CLIP_AMMO_MAX = 50
	self.p90.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.45 / self.p90.CLIP_AMMO_MAX)
	self.p90.AMMO_MAX = self.p90.CLIP_AMMO_MAX * self.p90.NR_CLIPS_MAX
	self.p90.AMMO_PICKUP = self:_pickup_chance(self.p90.AMMO_MAX, 1)
	self.p90.fire_mode_data.fire_rate = 0.066
	self.p90.spread.standing = self.new_m4.spread.standing * 1.35
	self.p90.spread.crouching = self.new_m4.spread.standing * 1.35
	self.p90.spread.steelsight = self.new_m4.spread.steelsight
	self.p90.spread.moving_standing = self.new_m4.spread.standing * 1.35
	self.p90.spread.moving_crouching = self.new_m4.spread.standing * 1.35
	self.p90.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.new_m14.timers = {}
	self.new_m14.timers.reload_not_empty = 1.97
	self.new_m14.timers.reload_empty = 3.2
	self.new_m14.timers.unequip = 0.9
	self.new_m14.timers.equip = 0.9
	self.new_m14.CLIP_AMMO_MAX = 10
	self.new_m14.NR_CLIPS_MAX = math.round(total_damage_primary / 8 / self.new_m14.CLIP_AMMO_MAX)
	self.new_m14.AMMO_MAX = self.new_m14.CLIP_AMMO_MAX * self.new_m14.NR_CLIPS_MAX
	self.new_m14.AMMO_PICKUP = self:_pickup_chance(self.new_m14.AMMO_MAX, 2)
	self.new_m14.fire_mode_data.fire_rate = 0.085
	self.new_m14.spread.standing = self.new_m4.spread.standing * 2
	self.new_m14.spread.crouching = self.new_m4.spread.standing * 2
	self.new_m14.spread.steelsight = self.new_m4.spread.steelsight
	self.new_m14.spread.moving_standing = self.new_m4.spread.standing * 2.5
	self.new_m14.spread.moving_crouching = self.new_m4.spread.standing * 2.5
	self.new_m14.spread.moving_steelsight = self.new_m4.spread.moving_steelsight * 1.5

	self.deagle.timers = {}
	self.deagle.timers.reload_not_empty = 1.85
	self.deagle.timers.reload_empty = 2.75
	self.deagle.timers.unequip = 0.6
	self.deagle.timers.equip = 0.6
	self.deagle.CLIP_AMMO_MAX = 10
	self.deagle.NR_CLIPS_MAX = math.round(total_damage_secondary / 4.5 / self.deagle.CLIP_AMMO_MAX)
	self.deagle.AMMO_MAX = self.deagle.CLIP_AMMO_MAX * self.deagle.NR_CLIPS_MAX
	self.deagle.AMMO_PICKUP = self:_pickup_chance(self.deagle.AMMO_MAX, 1)
	self.deagle.fire_mode_data.fire_rate = 0.15
	self.deagle.spread.standing = self.new_m4.spread.standing
	self.deagle.spread.crouching = self.new_m4.spread.standing
	self.deagle.spread.steelsight = self.new_m4.spread.steelsight
	self.deagle.spread.moving_standing = self.new_m4.spread.standing
	self.deagle.spread.moving_crouching = self.new_m4.spread.standing
	self.deagle.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.new_mp5.timers = {}
	self.new_mp5.timers.reload_not_empty = 2.4
	self.new_mp5.timers.reload_empty = 3.3
	self.new_mp5.timers.unequip = 0.75
	self.new_mp5.timers.equip = 0.7
	self.new_mp5.CLIP_AMMO_MAX = 30
	self.new_mp5.NR_CLIPS_MAX = math.round(total_damage_secondary / 1 / self.new_mp5.CLIP_AMMO_MAX)
	self.new_mp5.AMMO_MAX = self.new_mp5.CLIP_AMMO_MAX * self.new_mp5.NR_CLIPS_MAX
	self.new_mp5.AMMO_PICKUP = self:_pickup_chance(self.new_mp5.AMMO_MAX, 1)
	self.new_mp5.fire_mode_data.fire_rate = 0.08
	self.new_mp5.spread.standing = self.new_m4.spread.standing
	self.new_mp5.spread.crouching = self.new_m4.spread.standing
	self.new_mp5.spread.steelsight = self.new_m4.spread.steelsight
	self.new_mp5.spread.moving_standing = self.new_m4.spread.standing
	self.new_mp5.spread.moving_crouching = self.new_m4.spread.standing
	self.new_mp5.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.colt_1911.timers = {}
	self.colt_1911.timers.reload_not_empty = 1.47
	self.colt_1911.timers.reload_empty = 2.12
	self.colt_1911.timers.unequip = 0.55
	self.colt_1911.timers.equip = 0.55
	self.colt_1911.CLIP_AMMO_MAX = 10
	self.colt_1911.NR_CLIPS_MAX = math.round(total_damage_secondary / 2.5 / self.colt_1911.CLIP_AMMO_MAX)
	self.colt_1911.AMMO_MAX = self.colt_1911.CLIP_AMMO_MAX * self.colt_1911.NR_CLIPS_MAX
	self.colt_1911.AMMO_PICKUP = self:_pickup_chance(self.colt_1911.AMMO_MAX, 1)
	self.colt_1911.fire_mode_data.fire_rate = 0.12
	self.colt_1911.spread.standing = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.crouching = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.steelsight = self.new_m4.spread.steelsight
	self.colt_1911.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.colt_1911.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.mac10.timers = {}
	self.mac10.timers.reload_not_empty = 1.7
	self.mac10.timers.reload_empty = 2.5
	self.mac10.timers.unequip = 0.7
	self.mac10.timers.equip = 0.5
	self.mac10.CLIP_AMMO_MAX = 40
	self.mac10.NR_CLIPS_MAX = math.round(total_damage_secondary / 2.2 / self.mac10.CLIP_AMMO_MAX)
	self.mac10.AMMO_MAX = self.mac10.CLIP_AMMO_MAX * self.mac10.NR_CLIPS_MAX
	self.mac10.AMMO_PICKUP = self:_pickup_chance(self.mac10.AMMO_MAX, 1)
	self.mac10.fire_mode_data.fire_rate = 0.06
	self.mac10.spread.standing = self.new_m4.spread.standing * 0.75
	self.mac10.spread.crouching = self.new_m4.spread.standing * 0.75
	self.mac10.spread.steelsight = self.new_m4.spread.steelsight
	self.mac10.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.mac10.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.mac10.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.serbu.timers = {}
	self.serbu.timers.unequip = 0.7
	self.serbu.timers.equip = 0.6
	self.serbu.CLIP_AMMO_MAX = 6
	self.serbu.NR_CLIPS_MAX = math.round(total_damage_secondary / 5.5 / self.serbu.CLIP_AMMO_MAX)
	self.serbu.AMMO_MAX = self.serbu.CLIP_AMMO_MAX * self.serbu.NR_CLIPS_MAX
	self.serbu.AMMO_PICKUP = self:_pickup_chance(self.serbu.AMMO_MAX, 1)
	self.serbu.fire_mode_data.fire_rate = 0.375
	self.serbu.spread.standing = self.r870.spread.standing
	self.serbu.spread.crouching = self.r870.spread.crouching
	self.serbu.spread.steelsight = self.r870.spread.steelsight
	self.serbu.spread.moving_standing = self.r870.spread.moving_standing
	self.serbu.spread.moving_crouching = self.r870.spread.moving_crouching
	self.serbu.spread.moving_steelsight = self.r870.spread.moving_steelsight

	self.huntsman.timers = {}
	self.huntsman.timers.reload_not_empty = 2.5
	self.huntsman.timers.reload_empty = self.huntsman.timers.reload_not_empty
	self.huntsman.timers.unequip = 0.85
	self.huntsman.timers.equip = 0.85
	self.huntsman.CLIP_AMMO_MAX = 2
	self.huntsman.NR_CLIPS_MAX = math.round(total_damage_primary / 12 / self.huntsman.CLIP_AMMO_MAX)
	self.huntsman.AMMO_MAX = self.huntsman.CLIP_AMMO_MAX * self.huntsman.NR_CLIPS_MAX
	self.huntsman.AMMO_PICKUP = self:_pickup_chance(self.huntsman.AMMO_MAX, 1)
	self.huntsman.fire_mode_data.fire_rate = 0.12
	self.huntsman.spread.standing = self.r870.spread.standing
	self.huntsman.spread.crouching = self.r870.spread.crouching
	self.huntsman.spread.steelsight = self.r870.spread.steelsight
	self.huntsman.spread.moving_standing = self.r870.spread.moving_standing
	self.huntsman.spread.moving_crouching = self.r870.spread.moving_crouching
	self.huntsman.spread.moving_steelsight = self.r870.spread.moving_steelsight

	self.b92fs.timers = {}
	self.b92fs.timers.reload_not_empty = 1.47
	self.b92fs.timers.reload_empty = 2.12
	self.b92fs.timers.unequip = 0.55
	self.b92fs.timers.equip = 0.55
	self.b92fs.CLIP_AMMO_MAX = 14
	self.b92fs.NR_CLIPS_MAX = math.round(total_damage_secondary / 1 / self.b92fs.CLIP_AMMO_MAX)
	self.b92fs.AMMO_MAX = self.b92fs.CLIP_AMMO_MAX * self.b92fs.NR_CLIPS_MAX
	self.b92fs.AMMO_PICKUP = self:_pickup_chance(self.b92fs.AMMO_MAX, 1)
	self.b92fs.fire_mode_data.fire_rate = 0.09
	self.b92fs.spread.standing = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.crouching = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.steelsight = self.new_m4.spread.steelsight
	self.b92fs.spread.moving_standing = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.moving_crouching = self.new_m4.spread.standing * 0.5
	self.b92fs.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.new_raging_bull.timers = {}
	self.new_raging_bull.timers.reload_not_empty = 2.25
	self.new_raging_bull.timers.reload_empty = 2.25
	self.new_raging_bull.timers.unequip = 0.65
	self.new_raging_bull.timers.equip = 0.65
	self.new_raging_bull.CLIP_AMMO_MAX = 6
	self.new_raging_bull.NR_CLIPS_MAX = math.round(total_damage_secondary / 4.7 / self.new_raging_bull.CLIP_AMMO_MAX)
	self.new_raging_bull.AMMO_MAX = self.new_raging_bull.CLIP_AMMO_MAX * self.new_raging_bull.NR_CLIPS_MAX
	self.new_raging_bull.AMMO_PICKUP = self:_pickup_chance(self.new_raging_bull.AMMO_MAX, 1)
	self.new_raging_bull.fire_mode_data.fire_rate = 0.21
	self.new_raging_bull.spread.standing = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.crouching = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.steelsight = self.new_m4.spread.steelsight
	self.new_raging_bull.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.new_raging_bull.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.saw.timers = {}
	self.saw.timers.reload_not_empty = 3.2
	self.saw.timers.reload_empty = 3.2
	self.saw.timers.unequip = 0.8
	self.saw.timers.equip = 0.8
	self.saw.CLIP_AMMO_MAX = 150
	self.saw.NR_CLIPS_MAX = 2
	self.saw.AMMO_MAX = self.saw.CLIP_AMMO_MAX * self.saw.NR_CLIPS_MAX
	self.saw.AMMO_PICKUP = { 0, 0 }
	self.saw.fire_mode_data.fire_rate = 0.15
	self.saw.spread.standing = 1
	self.saw.spread.crouching = 0.71
	self.saw.spread.steelsight = 0.48
	self.saw.spread.moving_standing = 1.28
	self.saw.spread.moving_crouching = 1.52
	self.saw.spread.moving_steelsight = 0.48
	self.saw.kick.standing = {
		1,
		-1,
		-1,
		1,
	}
	self.saw.kick.crouching = {
		1,
		-1,
		-1,
		1,
	}
	self.saw.kick.steelsight = {
		0.725,
		-0.725,
		-0.725,
		0.725,
	}

	self.usp.timers = {}
	self.usp.timers.reload_not_empty = 1.47
	self.usp.timers.reload_empty = 2.2
	self.usp.timers.unequip = 0.55
	self.usp.timers.equip = 0.55
	self.usp.CLIP_AMMO_MAX = 13
	self.usp.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.15 / self.usp.CLIP_AMMO_MAX)
	self.usp.AMMO_MAX = self.usp.CLIP_AMMO_MAX * self.usp.NR_CLIPS_MAX
	self.usp.AMMO_PICKUP = self:_pickup_chance(self.usp.AMMO_MAX, 1)
	self.usp.fire_mode_data.fire_rate = 0.08
	self.usp.spread.standing = self.new_m4.spread.standing * 0.75
	self.usp.spread.crouching = self.new_m4.spread.standing * 0.75
	self.usp.spread.steelsight = self.new_m4.spread.steelsight
	self.usp.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.usp.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.usp.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.m45.timers = {}
	self.m45.timers.reload_not_empty = 2.85
	self.m45.timers.reload_empty = 3.9
	self.m45.timers.unequip = 0.75
	self.m45.timers.equip = 0.75
	self.m45.CLIP_AMMO_MAX = 40
	self.m45.NR_CLIPS_MAX = math.round(total_damage_secondary / 2.2 / self.m45.CLIP_AMMO_MAX)
	self.m45.AMMO_MAX = self.m45.CLIP_AMMO_MAX * self.m45.NR_CLIPS_MAX
	self.m45.AMMO_PICKUP = self:_pickup_chance(self.m45.AMMO_MAX, 1)
	self.m45.fire_mode_data.fire_rate = 0.1
	self.m45.spread.standing = self.new_m4.spread.standing * 0.75
	self.m45.spread.crouching = self.new_m4.spread.standing * 0.75
	self.m45.spread.steelsight = self.new_m4.spread.steelsight
	self.m45.spread.moving_standing = self.new_m4.spread.standing * 0.75
	self.m45.spread.moving_crouching = self.new_m4.spread.standing * 0.75
	self.m45.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.s552.timers = {}
	self.s552.timers.reload_not_empty = 2.5
	self.s552.timers.reload_empty = 3.45
	self.s552.timers.unequip = 0.9
	self.s552.timers.equip = 0.9
	self.s552.CLIP_AMMO_MAX = 30
	self.s552.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.1 / self.s552.CLIP_AMMO_MAX)
	self.s552.AMMO_MAX = self.s552.CLIP_AMMO_MAX * self.s552.NR_CLIPS_MAX
	self.s552.AMMO_PICKUP = self:_pickup_chance(self.s552.AMMO_MAX, 2)
	self.s552.fire_mode_data.fire_rate = 0.084
	self.s552.spread.standing = self.new_m4.spread.standing * 0.8
	self.s552.spread.crouching = self.new_m4.spread.standing * 0.8
	self.s552.spread.steelsight = self.new_m4.spread.steelsight
	self.s552.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.s552.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.s552.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.ppk.timers = {}
	self.ppk.timers.reload_not_empty = 1.47
	self.ppk.timers.reload_empty = 2.12
	self.ppk.timers.unequip = 0.5
	self.ppk.timers.equip = 0.5
	self.ppk.CLIP_AMMO_MAX = 14
	self.ppk.NR_CLIPS_MAX = math.round(total_damage_secondary / 1 / self.ppk.CLIP_AMMO_MAX)
	self.ppk.AMMO_MAX = self.ppk.CLIP_AMMO_MAX * self.ppk.NR_CLIPS_MAX
	self.ppk.AMMO_PICKUP = self:_pickup_chance(self.ppk.AMMO_MAX, 1)
	self.ppk.fire_mode_data.fire_rate = 0.09
	self.ppk.spread.standing = self.new_m4.spread.standing * 0.5
	self.ppk.spread.crouching = self.new_m4.spread.standing * 0.5
	self.ppk.spread.steelsight = self.new_m4.spread.steelsight
	self.ppk.spread.moving_standing = self.new_m4.spread.standing * 0.5
	self.ppk.spread.moving_crouching = self.new_m4.spread.standing * 0.5
	self.ppk.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.mp7.timers = {}
	self.mp7.timers.reload_not_empty = 1.96
	self.mp7.timers.reload_empty = 2.45
	self.mp7.timers.unequip = 0.75
	self.mp7.timers.equip = 0.75
	self.mp7.CLIP_AMMO_MAX = 20
	self.mp7.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.8 / self.mp7.CLIP_AMMO_MAX)
	self.mp7.AMMO_MAX = self.mp7.CLIP_AMMO_MAX * self.mp7.NR_CLIPS_MAX
	self.mp7.AMMO_PICKUP = self:_pickup_chance(self.mp7.AMMO_MAX, 1)
	self.mp7.fire_mode_data.fire_rate = 0.063
	self.mp7.spread.standing = self.new_m4.spread.standing * 0.8
	self.mp7.spread.crouching = self.new_m4.spread.standing * 0.8
	self.mp7.spread.steelsight = self.new_m4.spread.steelsight
	self.mp7.spread.moving_standing = self.new_m4.spread.standing * 0.8
	self.mp7.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.mp7.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.scar.timers = {}
	self.scar.timers.reload_not_empty = 2.2
	self.scar.timers.reload_empty = 3
	self.scar.timers.unequip = 0.9
	self.scar.timers.equip = 0.9
	self.scar.CLIP_AMMO_MAX = 20
	self.scar.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.7 / self.scar.CLIP_AMMO_MAX)
	self.scar.AMMO_MAX = self.scar.CLIP_AMMO_MAX * self.scar.NR_CLIPS_MAX
	self.scar.AMMO_PICKUP = self:_pickup_chance(self.scar.AMMO_MAX, 2)
	self.scar.fire_mode_data.fire_rate = 0.098
	self.scar.spread.standing = self.new_m4.spread.standing * 0.6
	self.scar.spread.crouching = self.new_m4.spread.standing * 0.7
	self.scar.spread.steelsight = self.new_m4.spread.steelsight
	self.scar.spread.moving_standing = self.new_m4.spread.standing * 0.7
	self.scar.spread.moving_crouching = self.new_m4.spread.standing * 0.8
	self.scar.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.p226.timers = {}
	self.p226.timers.reload_not_empty = 1.47
	self.p226.timers.reload_empty = 2.12
	self.p226.timers.unequip = 0.5
	self.p226.timers.equip = 0.5
	self.p226.CLIP_AMMO_MAX = 12
	self.p226.NR_CLIPS_MAX = math.round(total_damage_secondary / 1.8 / self.p226.CLIP_AMMO_MAX)
	self.p226.AMMO_MAX = self.p226.CLIP_AMMO_MAX * self.p226.NR_CLIPS_MAX
	self.p226.AMMO_PICKUP = self:_pickup_chance(self.p226.AMMO_MAX, 1)
	self.p226.fire_mode_data.fire_rate = 0.09
	self.p226.spread.standing = self.new_m4.spread.standing * 0.3
	self.p226.spread.crouching = self.new_m4.spread.standing * 0.3
	self.p226.spread.steelsight = self.new_m4.spread.steelsight
	self.p226.spread.moving_standing = self.new_m4.spread.standing * 0.3
	self.p226.spread.moving_crouching = self.new_m4.spread.standing * 0.3
	self.p226.spread.moving_steelsight = self.new_m4.spread.moving_steelsight

	self.hk21.timers = {}
	self.hk21.timers.reload_not_empty = 5.6
	self.hk21.timers.reload_empty = 6.7
	self.hk21.timers.unequip = 0.9
	self.hk21.timers.equip = 0.9
	self.hk21.CLIP_AMMO_MAX = 150
	self.hk21.NR_CLIPS_MAX = 2
	self.hk21.AMMO_MAX = self.hk21.CLIP_AMMO_MAX * self.hk21.NR_CLIPS_MAX
	self.hk21.AMMO_PICKUP = self:_pickup_chance(80, 1.5)
	self.hk21.fire_mode_data.fire_rate = 0.083
	self.hk21.spread.standing = 3.8
	self.hk21.spread.crouching = 3.2
	self.hk21.spread.steelsight = 1.5
	self.hk21.spread.moving_standing = 4
	self.hk21.spread.moving_crouching = 3.5
	self.hk21.spread.moving_steelsight = 2
	self.hk21.kick.standing = {
		-0.2,
		0.8,
		-0.8,
		1,
	}
	self.hk21.kick.crouching = self.hk21.kick.standing
	self.hk21.kick.steelsight = self.hk21.kick.standing

	self.m249.timers = {}
	self.m249.timers.reload_not_empty = 5.62
	self.m249.timers.reload_empty = 5.62
	self.m249.timers.unequip = 0.9
	self.m249.timers.equip = 0.9
	self.m249.CLIP_AMMO_MAX = 200
	self.m249.NR_CLIPS_MAX = 2
	self.m249.AMMO_MAX = self.m249.CLIP_AMMO_MAX * self.m249.NR_CLIPS_MAX
	self.m249.AMMO_PICKUP = self:_pickup_chance(90, 1.5)
	self.m249.fire_mode_data.fire_rate = 0.066
	self.m249.spread.standing = 4.3
	self.m249.spread.crouching = 4
	self.m249.spread.steelsight = 1.8
	self.m249.spread.moving_standing = 4.5
	self.m249.spread.moving_crouching = 4
	self.m249.spread.moving_steelsight = 2.5
	self.m249.kick.standing = {
		-0.2,
		0.8,
		-1,
		1.4,
	}
	self.m249.kick.crouching = self.m249.kick.standing
	self.m249.kick.steelsight = self.m249.kick.standing

	self.rpk.timers = {}
	self.rpk.timers.reload_not_empty = 3.4
	self.rpk.timers.reload_empty = 4.56
	self.rpk.timers.unequip = 0.9
	self.rpk.timers.equip = 0.9
	self.rpk.CLIP_AMMO_MAX = 100
	self.rpk.NR_CLIPS_MAX = 3
	self.rpk.AMMO_MAX = self.rpk.CLIP_AMMO_MAX * self.rpk.NR_CLIPS_MAX
	self.rpk.AMMO_PICKUP = self:_pickup_chance(100, 1.5)
	self.rpk.fire_mode_data.fire_rate = 0.08
	self.rpk.spread.standing = 3.3
	self.rpk.spread.crouching = 3
	self.rpk.spread.steelsight = 1.8
	self.rpk.spread.moving_standing = 3.5
	self.rpk.spread.moving_crouching = 3
	self.rpk.spread.moving_steelsight = 2.5
	self.rpk.kick.standing = {
		-0.2,
		0.8,
		-1,
		1.4,
	}
	self.rpk.kick.crouching = self.rpk.kick.standing
	self.rpk.kick.steelsight = self.rpk.kick.standing

	self.akm_gold.use_data.selection_index = 4
	self.g22c.use_data.selection_index = 4
	self.m95.use_data.selection_index = 4
	self.msr.use_data.selection_index = 4
	self.r93.use_data.selection_index = 4
	self.fal.use_data.selection_index = 4
	self.benelli.use_data.selection_index = 4
	self.striker.use_data.selection_index = 4
	self.ksg.use_data.selection_index = 4
	self.gre_m79.use_data.selection_index = 4
	self.g3.use_data.selection_index = 4
	self.galil.use_data.selection_index = 4
	self.famas.use_data.selection_index = 4
	self.scorpion.use_data.selection_index = 4
	self.tec9.use_data.selection_index = 4
	self.uzi.use_data.selection_index = 4
	self.jowi.use_data.selection_index = 4
	self.x_1911.use_data.selection_index = 4
	self.x_b92fs.use_data.selection_index = 4
	self.x_deagle.use_data.selection_index = 4
	self.g26.use_data.selection_index = 4
	self.spas12.use_data.selection_index = 4
	self.mg42.use_data.selection_index = 4
	self.c96.use_data.selection_index = 4
	self.sterling.use_data.selection_index = 4
	self.mosin.use_data.selection_index = 4
	self.m1928.use_data.selection_index = 4
	self.l85a2.use_data.selection_index = 4
	self.vhs.use_data.selection_index = 4
	self.hs2000.use_data.selection_index = 4
	self.m134.use_data.selection_index = 4
	self.rpg7.use_data.selection_index = 4
	self.cobray.use_data.selection_index = 4
	self.b682.use_data.selection_index = 4
	self.x_g22c.use_data.selection_index = 4
	self.x_g17.use_data.selection_index = 4
	self.x_usp.use_data.selection_index = 4
	self.flamethrower_mk2.use_data.selection_index = 4
	self.m32.use_data.selection_index = 4
	self.aa12.use_data.selection_index = 4
	self.peacemaker.use_data.selection_index = 4
	self.winchester1874.use_data.selection_index = 4
	self.sbl.use_data.selection_index = 4
	self.plainsrider.use_data.selection_index = 4
	self.mateba.use_data.selection_index = 4
	self.asval.use_data.selection_index = 4
	self.sub2000.use_data.selection_index = 4
	self.wa2000.use_data.selection_index = 4
	self.polymer.use_data.selection_index = 4
	self.hunter.use_data.selection_index = 4
	self.baka.use_data.selection_index = 4
	self.arblast.use_data.selection_index = 4
	self.frankish.use_data.selection_index = 4
	self.long.use_data.selection_index = 4
	self.par.use_data.selection_index = 4
	self.sparrow.use_data.selection_index = 4
	self.model70.use_data.selection_index = 4
	self.m37.use_data.selection_index = 4
	self.china.use_data.selection_index = 4
	self.sr2.use_data.selection_index = 4
	self.x_sr2.use_data.selection_index = 4
	self.pl14.use_data.selection_index = 4
	self.x_mp5.use_data.selection_index = 4
	self.x_akmsu.use_data.selection_index = 4
	self.tecci.use_data.selection_index = 4
	self.hajk.use_data.selection_index = 4
	self.boot.use_data.selection_index = 4
	self.packrat.use_data.selection_index = 4
	self.schakal.use_data.selection_index = 4
	self.desertfox.use_data.selection_index = 4
	self.x_packrat.use_data.selection_index = 4
	self.rota.use_data.selection_index = 4
	self.arbiter.use_data.selection_index = 4
	self.contraband.use_data.selection_index = 4
	self.contraband_m203.use_data.selection_index = 4
	self.ray.use_data.selection_index = 4
	self.tti.use_data.selection_index = 4
	self.siltstone.use_data.selection_index = 4
	self.flint.use_data.selection_index = 4
	self.coal.use_data.selection_index = 4
	self.lemming.use_data.selection_index = 4
	self.chinchilla.use_data.selection_index = 4
	self.x_chinchilla.use_data.selection_index = 4
	self.model3.use_data.selection_index = 4
	self.x_model3.use_data.selection_index = 4
	self.m1897.use_data.selection_index = 4
	self.shepheard.use_data.selection_index = 4
	self.x_shepheard.use_data.selection_index = 4
	self.breech.use_data.selection_index = 4
	self.ching.use_data.selection_index = 4
	self.erma.use_data.selection_index = 4
	self.ecp.use_data.selection_index = 4
	self.shrew.use_data.selection_index = 4
	self.x_shrew.use_data.selection_index = 4
	self.basset.use_data.selection_index = 4
	self.x_basset.use_data.selection_index = 4
	self.corgi.use_data.selection_index = 4
	self.slap.use_data.selection_index = 4
	self.x_coal.use_data.selection_index = 4
	self.x_baka.use_data.selection_index = 4
	self.x_cobray.use_data.selection_index = 4
	self.x_erma.use_data.selection_index = 4
	self.x_hajk.use_data.selection_index = 4
	self.x_m45.use_data.selection_index = 4
	self.x_m1928.use_data.selection_index = 4
	self.x_mac10.use_data.selection_index = 4
	self.x_mp7.use_data.selection_index = 4
	self.x_mp9.use_data.selection_index = 4
	self.x_olympic.use_data.selection_index = 4
	self.x_p90.use_data.selection_index = 4
	self.x_polymer.use_data.selection_index = 4
	self.x_schakal.use_data.selection_index = 4
	self.x_scorpion.use_data.selection_index = 4
	self.x_sterling.use_data.selection_index = 4
	self.x_tec9.use_data.selection_index = 4
	self.x_uzi.use_data.selection_index = 4
	self.x_2006m.use_data.selection_index = 4
	self.x_breech.use_data.selection_index = 4
	self.x_c96.use_data.selection_index = 4
	self.x_g18c.use_data.selection_index = 4
	self.x_hs2000.use_data.selection_index = 4
	self.x_p226.use_data.selection_index = 4
	self.x_pl14.use_data.selection_index = 4
	self.x_ppk.use_data.selection_index = 4
	self.x_rage.use_data.selection_index = 4
	self.x_sparrow.use_data.selection_index = 4
	self.x_judge.use_data.selection_index = 4
	self.judge.use_data.selection_index = 4
	self.x_rota.use_data.selection_index = 4
	self.shuno.use_data.selection_index = 4
	self.system.use_data.selection_index = 4
	self.komodo.use_data.selection_index = 4
	self.elastic.use_data.selection_index = 4
	self.legacy.use_data.selection_index = 4
	self.x_legacy.use_data.selection_index = 4
	self.coach.use_data.selection_index = 4
	self.beer.use_data.selection_index = 4
	self.x_beer.use_data.selection_index = 4
	self.czech.use_data.selection_index = 4
	self.x_czech.use_data.selection_index = 4
	self.stech.use_data.selection_index = 4
	self.x_stech.use_data.selection_index = 4
	self.holt.use_data.selection_index = 4
	self.x_holt.use_data.selection_index = 4
	self.m60.use_data.selection_index = 4
	self.r700.use_data.selection_index = 4
	self.saw_secondary.use_data.selection_index = 4
	self.groza.use_data.selection_index = 4
	self.groza_underbarrel.use_data.selection_index = 4
	self.m590.use_data.selection_index = 4
	self.qbu88.use_data.selection_index = 4
	self.x_m1911.use_data.selection_index = 4
	self.m1911.use_data.selection_index = 4
	self.x_pm9.use_data.selection_index = 4
	self.pm9.use_data.selection_index = 4
	self.vityaz.use_data.selection_index = 4
	self.x_vityaz.use_data.selection_index = 4
	self.x_type54.use_data.selection_index = 4
	self.type54.use_data.selection_index = 4
	self.rsh12.use_data.selection_index = 4
	self.shak12.use_data.selection_index = 4
	self.ultima.use_data.selection_index = 4
	self.maxim9.use_data.selection_index = 4
	self.x_maxim9.use_data.selection_index = 4
	self.fmg9.use_data.selection_index = 4
	self.hk51b.use_data.selection_index = 4
	self.scout.use_data.selection_index = 4
	self.ms3gl.use_data.selection_index = 4
	self.korth.use_data.selection_index = 4
	self.x_korth.use_data.selection_index = 4
	self.sko12.use_data.selection_index = 4
	self.x_sko12.use_data.selection_index = 4
	self.hailstorm.use_data.selection_index = 4
	self.tkb.use_data.selection_index = 4
	self.contender.use_data.selection_index = 4
	self.hcar.use_data.selection_index = 4
	self.awp.use_data.selection_index = 4
	self.supernova.use_data.selection_index = 4
	self.kacchainsaw.use_data.selection_index = 4
end)

Hooks:PostHook(WeaponTweakData, "_init_stats", "restore_init_stats", function(self)
	self.stats.alert_size = {
		30000,
		20000,
		15000,
		10000,
		7500,
		6000,
		4500,
		4000,
		3500,
		1800,
		1500,
		1200,
		1000,
		850,
		700,
		500,
		350,
		200,
		100,
		0,
	}
	self.stats.suppression = {
		4.5,
		3.9,
		3.6,
		3.3,
		3,
		2.8,
		2.6,
		2.4,
		2.2,
		1.6,
		1.5,
		1.4,
		1.3,
		1.2,
		1.1,
		1,
		0.8,
		0.6,
		0.4,
		0.2,
	}
	self.stats.damage = {
		1,
		1.1,
		1.2,
		1.3,
		1.4,
		1.5,
		1.6,
		1.75,
		2,
		2.25,
		2.5,
		2.75,
		3,
		3.25,
		3.5,
		3.75,
		4,
		4.25,
		4.5,
		4.75,
		5,
		5.5,
		6,
		6.5,
		7,
		7.5,
		8,
		8.5,
		9,
		9.5,
		10,
		10.5,
		11,
		11.5,
		12,
	}
	self.stats.zoom = {
		63,
		60,
		55,
		50,
		45,
		40,
		35,
		30,
		25,
		20,
	}
	self.stats.spread = {
		2,
		1.8,
		1.6,
		1.4,
		1.2,
		1,
		0.8,
		0.6,
		0.4,
		0.2,
	}
	self.stats.spread_moving = {
		3,
		2.7,
		2.4,
		2.2,
		2,
		1.7,
		1.4,
		1.2,
		1,
		0.9,
		0.8,
		0.7,
		0.6,
		0.5,
	}
	self.stats.recoil = {
		3,
		2.7,
		2.4,
		2.2,
		1.75,
		1.5,
		1.25,
		1.1,
		1,
		1,
		0.9,
		0.8,
		0.7,
		0.6,
		0.5,
	}
	self.stats.value = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
	}
	self.stats.concealment = {
		0.3,
		0.4,
		0.5,
		0.6,
		0.65,
		0.7,
		0.75,
		0.8,
		0.825,
		0.85,
		1,
		1.05,
		1.1,
		1.15,
		1.2,
		1.225,
		1.25,
		1.275,
		1.3,
		1.325,
		1.35,
		1.375,
		1.4,
		1.425,
		1.45,
		1.475,
		1.5,
		1.525,
		1.55,
		1.6,
	}
	self.stats.extra_ammo = {}
	for i = -10, 50, 2 do
		table.insert(self.stats.extra_ammo, i)
	end
end)

function WeaponTweakData:_pickup_chance(max_ammo, selection_index)
	local low, high
	low = 0.02
	high = 0.05
	return {
		max_ammo * low,
		max_ammo * high,
	}
end

function WeaponTweakData:_set_easy() end

function WeaponTweakData:_set_normal() end

function WeaponTweakData:_set_hard() end

function WeaponTweakData:_set_overkill() end

function WeaponTweakData:_set_overkill_145() end

function WeaponTweakData:_set_overkill_290() end
