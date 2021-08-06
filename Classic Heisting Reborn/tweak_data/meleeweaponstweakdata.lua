Hooks:PostHook(BlackMarketTweakData, "_init_melee_weapons", "restore_init_melee_weapons", function(self, tweak_data)
	self.melee_weapons = {}
	self.melee_weapons.weapon = {}
	self.melee_weapons.weapon.name_id = "bm_melee_weapon"
	self.melee_weapons.weapon.type = "weapon"
	self.melee_weapons.weapon.unit = nil
	self.melee_weapons.weapon.animation = nil
	self.melee_weapons.weapon.instant = true
	self.melee_weapons.weapon.free = true
	self.melee_weapons.weapon.stats = {}
	self.melee_weapons.weapon.stats.min_damage = 1.5
	self.melee_weapons.weapon.stats.max_damage = 1.5
	self.melee_weapons.weapon.stats.min_damage_effect = 1.75
	self.melee_weapons.weapon.stats.max_damage_effect = 1.75
	self.melee_weapons.weapon.stats.charge_time = 0
	self.melee_weapons.weapon.stats.range = 150
	self.melee_weapons.weapon.stats.weapon_type = "blunt"
	self.melee_weapons.weapon.expire_t = 0.6
	self.melee_weapons.weapon.repeat_expire_t = 0.6
	self.melee_weapons.weapon.sounds = {}
	self.melee_weapons.weapon.sounds.hit_body = "melee_hit_body"
	self.melee_weapons.weapon.sounds.hit_gen = "melee_hit_gen"
	self.melee_weapons.fists = {}
	self.melee_weapons.fists.name_id = "bm_melee_fists"
	self.melee_weapons.fists.type = "fists"
	self.melee_weapons.fists.unit = nil
	self.melee_weapons.fists.animation = nil
	self.melee_weapons.fists.free = true
	self.melee_weapons.fists.stats = {}
	self.melee_weapons.fists.stats.min_damage = 1
	self.melee_weapons.fists.stats.max_damage = 3
	self.melee_weapons.fists.stats.min_damage_effect = 2
	self.melee_weapons.fists.stats.max_damage_effect = 4
	self.melee_weapons.fists.stats.charge_time = 1
	self.melee_weapons.fists.stats.range = 150
	self.melee_weapons.fists.stats.remove_weapon_movement_penalty = true
	self.melee_weapons.fists.stats.weapon_type = "blunt"
	self.melee_weapons.fists.anim_global_param = "melee_fist"
	self.melee_weapons.fists.anim_attack_vars = {
		"var1",
		"var2",
		"var3",
		"var4"
	}
	self.melee_weapons.fists.expire_t = 1
	self.melee_weapons.fists.repeat_expire_t = 0.55
	self.melee_weapons.fists.melee_damage_delay = 0.2
	self.melee_weapons.fists.melee_charge_shaker = "player_melee_charge_fist"
	self.melee_weapons.fists.sounds = {}
	self.melee_weapons.fists.sounds.equip = "fist_equip"
	self.melee_weapons.fists.sounds.hit_air = "fist_hit_air"
	self.melee_weapons.fists.sounds.hit_gen = "fist_hit_gen"
	self.melee_weapons.fists.sounds.hit_body = "fist_hit_body"
	self.melee_weapons.fists.sounds.charge = "fist_charge"
	self.melee_weapons.kabar = {}
	self.melee_weapons.kabar.name_id = "bm_melee_kabar"
	self.melee_weapons.kabar.type = "knife"
	self.melee_weapons.kabar.unit = "units/pd2_dlc_gage_lmg/weapons/wpn_fps_mel_kabar/wpn_fps_mel_kabar"
	self.melee_weapons.kabar.third_unit = "units/pd2_dlc_gage_lmg/weapons/wpn_third_mel_kabar/wpn_third_mel_kabar"
	self.melee_weapons.kabar.animation = nil
	self.melee_weapons.kabar.dlc = "gage_pack_lmg"
	self.melee_weapons.kabar.texture_bundle_folder = "gage_pack_lmg"
	self.melee_weapons.kabar.stats = {}
	self.melee_weapons.kabar.stats.min_damage = 1.5
	self.melee_weapons.kabar.stats.max_damage = 7
	self.melee_weapons.kabar.stats.min_damage_effect = 0.7
	self.melee_weapons.kabar.stats.max_damage_effect = 0.75
	self.melee_weapons.kabar.stats.charge_time = 1.8
	self.melee_weapons.kabar.stats.range = 150
	self.melee_weapons.kabar.stats.remove_weapon_movement_penalty = true
	self.melee_weapons.kabar.stats.weapon_type = "sharp"
	self.melee_weapons.kabar.anim_global_param = "melee_knife"
	self.melee_weapons.kabar.anim_attack_vars = {
		"var1",
		"var2",
		"var3",
		"var4"
	}
	self.melee_weapons.kabar.repeat_expire_t = 0.6
	self.melee_weapons.kabar.expire_t = 1.1
	self.melee_weapons.kabar.melee_damage_delay = 0.1
	self.melee_weapons.kabar.sounds = {}
	self.melee_weapons.kabar.sounds.equip = "knife_equip"
	self.melee_weapons.kabar.sounds.hit_air = "knife_hit_air"
	self.melee_weapons.kabar.sounds.hit_gen = "knife_hit_gen"
	self.melee_weapons.kabar.sounds.hit_body = "knife_hit_body"
	self.melee_weapons.kabar.sounds.charge = "knife_charge"
	self.melee_weapons.rambo = deep_clone(self.melee_weapons.kabar)
	self.melee_weapons.rambo.name_id = "bm_melee_rambo"
	self.melee_weapons.rambo.type = "knife"
	self.melee_weapons.rambo.unit = "units/pd2_dlc_gage_lmg/weapons/wpn_fps_mel_rambo/wpn_fps_mel_rambo"
	self.melee_weapons.rambo.third_unit = "units/pd2_dlc_gage_lmg/weapons/wpn_third_mel_rambo/wpn_third_mel_rambo"
	self.melee_weapons.rambo.stats.min_damage = 2.2
	self.melee_weapons.rambo.stats.max_damage = 10
	self.melee_weapons.rambo.stats.min_damage_effect = 0.7
	self.melee_weapons.rambo.stats.max_damage_effect = 0.75
	self.melee_weapons.rambo.stats.charge_time = 2
	self.melee_weapons.rambo.stats.range = 185
	self.melee_weapons.gerber = deep_clone(self.melee_weapons.kabar)
	self.melee_weapons.gerber.name_id = "bm_melee_gerber"
	self.melee_weapons.gerber.type = "knife"
	self.melee_weapons.gerber.unit = "units/pd2_dlc_gage_lmg/weapons/wpn_fps_mel_dmf/wpn_fps_mel_dmf"
	self.melee_weapons.gerber.third_unit = "units/pd2_dlc_gage_lmg/weapons/wpn_third_mel_dmf/wpn_third_mel_dmf"
	self.melee_weapons.gerber.stats.min_damage = 2
	self.melee_weapons.gerber.stats.max_damage = 5.2
	self.melee_weapons.gerber.stats.min_damage_effect = 1
	self.melee_weapons.gerber.stats.max_damage_effect = 1.15
	self.melee_weapons.gerber.stats.charge_time = 1.3
	self.melee_weapons.gerber.stats.range = 125
	self.melee_weapons.kampfmesser = deep_clone(self.melee_weapons.kabar)
	self.melee_weapons.kampfmesser.name_id = "bm_melee_kampfmesser"
	self.melee_weapons.kampfmesser.type = "knife"
	self.melee_weapons.kampfmesser.unit = "units/pd2_dlc_gage_lmg/weapons/wpn_fps_mel_km2000/wpn_fps_mel_km2000"
	self.melee_weapons.kampfmesser.third_unit = "units/pd2_dlc_gage_lmg/weapons/wpn_third_mel_km2000/wpn_third_mel_km2000"
	self.melee_weapons.kampfmesser.stats.min_damage = 1.5
	self.melee_weapons.kampfmesser.stats.max_damage = 7.5
	self.melee_weapons.kampfmesser.stats.min_damage_effect = 1
	self.melee_weapons.kampfmesser.stats.max_damage_effect = 1.15
	self.melee_weapons.kampfmesser.stats.charge_time = 1.5
	self.melee_weapons.kampfmesser.stats.range = 150
	self.melee_weapons.brass_knuckles = deep_clone(self.melee_weapons.fists)
	self.melee_weapons.brass_knuckles.name_id = "bm_melee_brass_knuckles"
	self.melee_weapons.brass_knuckles.free = nil
	self.melee_weapons.brass_knuckles.type = "fists"
	self.melee_weapons.brass_knuckles.dlc = "pd2_clan"
	self.melee_weapons.brass_knuckles.align_objects = {
		"a_weapon_left",
		"a_weapon_right"
	}
	self.melee_weapons.brass_knuckles.unit = "units/payday2/weapons/wpn_fps_mel_brassknuckle/wpn_fps_mel_brassknuckle"
	self.melee_weapons.brass_knuckles.third_unit = "units/payday2/weapons/wpn_fps_mel_brassknuckle/wpn_third_mel_brassknuckle"
	self.melee_weapons.brass_knuckles.stats.min_damage = 1.5
	self.melee_weapons.brass_knuckles.stats.max_damage = 3.5
	self.melee_weapons.brass_knuckles.stats.min_damage_effect = 2
	self.melee_weapons.brass_knuckles.stats.max_damage_effect = 4
	self.melee_weapons.brass_knuckles.stats.charge_time = 1.3
	self.melee_weapons.brass_knuckles.stats.range = 150
	self.melee_weapons.brass_knuckles.sounds.hit_gen = "knuckles_hit_gen"
	self.melee_weapons.brass_knuckles.sounds.hit_body = "knuckles_hit_body"
end)