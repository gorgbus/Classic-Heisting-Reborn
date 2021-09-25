local data = UpgradesTweakData.init
function UpgradesTweakData:init(tweak_data)
	data(self, tweak_data)
	self.values.rep_upgrades.classes = {
		"rep_upgrade"
	}
	self.values.rep_upgrades.values = {2}
	self.values.player.body_armor.armor = {
		0,
		1,
		2,
		3,
		5,
		7,
		15
	}
	self.values.player.body_armor.movement = {
		1.05,
		1.025,
		1,
		0.95,
		0.75,
		0.65,
		0.575
	}
	self.values.player.body_armor.concealment = {
		30,
		26,
		23,
		21,
		18,
		12,
		1
	}
	self.values.player.body_armor.dodge = {
		0.09,
		0.05,
		0.03,
		-0.03,
		-0.1,
		-0.3,
		-0.5
	}
	self.values.player.body_armor.damage_shake = {
		1,
		0.96,
		0.92,
		0.85,
		0.8,
		0.7,
		0.5
	}
	self.values.player.body_armor.stamina = {
		1.025,
		1,
		0.95,
		0.9,
		0.85,
		0.8,
		0.7
	}
	self.values.player.body_armor.skill_ammo_mul = {
		1,
		1.02,
		1.04,
		1.06,
		1.8,
		1.1,
		1.12
	}
	self.values.player.special_enemy_highlight = {true}
	self.values.player.hostage_trade = {true}
	self.values.player.sec_camera_highlight = {true}
	self.values.player.sec_camera_highlight_mask_off = {true}
	self.values.player.special_enemy_highlight_mask_off = {true}
	self.ammo_bag_base = 3
	self.ecm_jammer_base_battery_life = 20
	self.ecm_jammer_base_low_battery_life = 8
	self.ecm_jammer_base_range = 2500
	self.ecm_feedback_min_duration = 15
	self.ecm_feedback_max_duration = 20
	self.ecm_feedback_interval = 1.5
	self.sentry_gun_base_ammo = 150
	self.sentry_gun_base_armor = 10
	self.doctor_bag_base = 2
	self.grenade_crate_base = 3
	self.max_grenade_amount = 3
	self.cop_hurt_alert_radius_whisper = 600
	self.cop_hurt_alert_radius = 400
	self.drill_alert_radius = 2500
	self.taser_malfunction_min = 1
	self.taser_malfunction_max = 3
	self.counter_taser_damage = 0.5
	self.morale_boost_speed_bonus = 1.2
	self.morale_boost_suppression_resistance = 1
	self.morale_boost_time = 10
	self.morale_boost_reload_speed_bonus = 1.2
	self.morale_boost_base_cooldown = 3.5
	self.max_weapon_dmg_mul_stacks = 5
	self.hostage_near_player_radius = 1000
	self.hostage_near_player_check_t = 0.5
	self.hostage_near_player_multiplier = 1.25
	self.weapon_movement_penalty.lmg = 0.8
	self.weapon_movement_penalty.minigun = 1
	self.values.player.crime_net_deal = {0.9, 0.8}
	self.values.player.corpse_alarm_pager_bluff = {true}
	self.values.player.marked_enemy_extra_damage = {true}
	self.values.player.marked_enemy_damage_mul = 1.15
	self.values.cable_tie.interact_speed_multiplier = {0.25}
	self.values.cable_tie.quantity = {4}
	self.values.cable_tie.can_cable_tie_doors = {true}
	self.values.temporary.combat_medic_damage_multiplier = {
		{1.25, 10},
		{1.25, 15}
	}
	self.values.player.revive_health_boost = {1}
	self.revive_health_multiplier = {1.3}
	self.values.player.civ_harmless_bullets = {true}
	self.values.player.civ_harmless_melee = {true}
	self.values.player.civ_calming_alerts = {true}
	self.values.player.civ_intimidation_mul = {1.5}
	self.values.team.pistol.recoil_multiplier = {0.75}
	self.values.team.weapon.recoil_multiplier = {0.5}
	self.values.player.assets_cost_multiplier = {0.5}
	self.values.player.additional_assets = {true}
	self.values.player.stamina_multiplier = {2}
	self.values.team.stamina.multiplier = {1.5}
	self.values.player.intimidate_enemies = {true}
	self.values.player.intimidate_range_mul = {1.5}
	self.values.player.intimidate_aura = {700}
	self.values.player.ene_hostage_lim_1 = {3}
	self.values.player.civilian_reviver = {true}
	self.values.player.civilian_gives_ammo = {true}
	self.values.player.buy_cost_multiplier = {0.9, 0.7}
	self.values.player.sell_cost_multiplier = {1.25}
	self.values.doctor_bag.quantity = {1}
	self.values.doctor_bag.amount_increase = {2}
	self.values.player.convert_enemies = {true}
	self.values.player.convert_enemies_max_minions = {1, 2}
	self.values.player.convert_enemies_health_multiplier = {0.65}
	self.values.player.convert_enemies_damage_multiplier = {1.45}
	self.values.player.xp_multiplier = {1.15}
	self.values.team.xp.multiplier = {1.3}
	self.values.pistol.reload_speed_multiplier = {1.5}
	self.values.pistol.damage_multiplier = {1.5}
	self.values.assault_rifle.reload_speed_multiplier = {1.25}
	self.values.assault_rifle.move_spread_multiplier = {0.5}
	self.values.player.pistol_revive_from_bleed_out = {1, 3}
	self.values.pistol.spread_multiplier = {0.9}
	self.values.pistol.swap_speed_multiplier = {1.5}
	self.values.pistol.fire_rate_multiplier = {2}
	self.values.player.revive_interaction_speed_multiplier = {0.5}
	self.values.player.long_dis_revive = {0.75, 1}
	self.values.doctor_bag.interaction_speed_multiplier = {0.8}
	self.values.team.stamina.passive_multiplier = {1.15, 1.3}
	self.values.player.passive_intimidate_range_mul = {1.25}
	self.values.team.health.passive_multiplier = {1.1}
	self.values.player.passive_convert_enemies_health_multiplier = {0.25}
	self.values.player.passive_convert_enemies_damage_multiplier = {1.15}
	self.values.player.convert_enemies_interaction_speed_multiplier = {0.35}
	self.values.player.empowered_intimidation_mul = {3}
	self.values.player.passive_assets_cost_multiplier = {0.5}
	self.values.player.suppression_multiplier = {1.25, 1.75}
	self.values.carry.movement_speed_multiplier = {1.5}
	self.values.carry.throw_distance_multiplier = {1.5}
	self.values.temporary.no_ammo_cost = {
		{true, 5},
		{true, 10}
	}
	self.values.player.non_special_melee_multiplier = {1.5}
	self.values.player.melee_damage_multiplier = {1.5}
	self.values.player.primary_weapon_when_downed = {true}
	self.values.player.armor_regen_timer_multiplier = {0.85}
	self.values.temporary.dmg_multiplier_outnumbered = {
		{1.15, 7}
	}
	self.values.temporary.dmg_dampener_outnumbered = {
		{0.85, 7}
	}
	self.values.player.extra_ammo_multiplier = {1.25}
	self.values.player.pick_up_ammo_multiplier = {1.75}
	self.values.player.damage_shake_multiplier = {0.5}
	self.values.player.bleed_out_health_multiplier = {1.25}
	self.values.shotgun.recoil_multiplier = {0.75}
	self.values.shotgun.damage_multiplier = {1.35}
	self.values.ammo_bag.quantity = {1}
	self.values.ammo_bag.ammo_increase = {2}
	self.values.shotgun.reload_speed_multiplier = {1.5}
	self.values.shotgun.enter_steelsight_speed_multiplier = {2.25}
	self.values.saw.extra_ammo_multiplier = {1.5}
	self.values.player.flashbang_multiplier = {0.75, 0.25}
	self.values.shotgun.hip_fire_spread_multiplier = {0.8}
	self.values.pistol.hip_fire_spread_multiplier = {0.8}
	self.values.assault_rifle.hip_fire_spread_multiplier = {0.8}
	self.values.smg.hip_fire_spread_multiplier = {0.8}
	self.values.saw.hip_fire_spread_multiplier = {0.8}
	self.values.player.saw_speed_multiplier = {0.95, 0.65}
	self.values.saw.lock_damage_multiplier = {1.2, 1.4}
	self.values.saw.enemy_slicer = {true}
	self.values.player.melee_damage_health_ratio_multiplier = {2.5}
	self.values.player.damage_health_ratio_multiplier = {1}
	self.player_damage_health_ratio_threshold = 0.25
	self.values.player.shield_knock = {true}
	self.values.temporary.overkill_damage_multiplier = {
		{1.75, 5}
	}
	self.values.player.overkill_all_weapons = {true}
	self.values.player.passive_suppression_multiplier = {1.1, 1.2}
	self.values.player.passive_health_multiplier = {
		1.1,
		1.2,
		1.5
	}
	self.values.weapon.passive_damage_multiplier = {1.05}
	self.values.assault_rifle.enter_steelsight_speed_multiplier = {2}
	self.values.assault_rifle.zoom_increase = {2}
	self.values.player.crafting_weapon_multiplier = {0.9}
	self.values.player.crafting_mask_multiplier = {0.9}
	self.values.trip_mine.quantity_1 = {1}
	self.values.trip_mine.can_switch_on_off = {true}
	self.values.player.drill_speed_multiplier = {0.85, 0.7}
	self.values.player.trip_mine_deploy_time_multiplier = {0.8, 0.6}
	self.values.trip_mine.sensor_toggle = {true}
	self.values.player.drill_fix_interaction_speed_multiplier = {0.75}
	self.values.player.drill_autorepair_1 = {0.3}
	self.values.player.sentry_gun_deploy_time_multiplier = {0.5}
	self.values.sentry_gun.armor_multiplier = {2.5}
	self.values.weapon.single_spread_multiplier = {0.8}
	self.values.assault_rifle.recoil_multiplier = {0.75}
	self.values.player.taser_malfunction = {true}
	self.values.player.taser_self_shock = {true}
	self.values.sentry_gun.spread_multiplier = {0.5}
	self.values.sentry_gun.rot_speed_multiplier = {2.5}
	self.values.player.interacting_damage_multiplier = {0.5}
	self.values.player.steelsight_when_downed = {true}
	self.values.player.drill_alert_rad = {900}
	self.values.player.silent_drill = {true}
	self.values.sentry_gun.extra_ammo_multiplier = {1.5, 2.5}
	self.values.sentry_gun.shield = {true}
	self.values.trip_mine.explosion_size_multiplier = {1.25, 2}
	self.values.trip_mine.quantity_3 = {3}
	self.values.player.trip_mine_shaped_charge = {true}
	self.values.sentry_gun.quantity = {1}
	self.values.sentry_gun.damage_multiplier = {4}
	self.values.weapon.clip_ammo_increase = {5, 15}
	self.values.player.armor_multiplier = {1.5}
	self.values.team.armor.regen_time_multiplier = {0.75}
	self.values.player.passive_crafting_weapon_multiplier = {
		0.99,
		0.96,
		0.91
	}
	self.values.player.passive_crafting_mask_multiplier = {
		0.99,
		0.96,
		0.91
	}
	self.values.weapon.passive_recoil_multiplier = {0.95, 0.9}
	self.values.weapon.passive_headshot_damage_multiplier = {1.25}
	self.values.player.passive_armor_multiplier = {1.1, 1.25}
	self.values.team.armor.passive_regen_time_multiplier = {0.9}
	self.values.player.small_loot_multiplier = {1.1, 1.3}
	self.values.player.stamina_regen_timer_multiplier = {0.75}
	self.values.player.stamina_regen_multiplier = {1.25}
	self.values.player.run_dodge_chance = {0.25}
	self.values.player.run_speed_multiplier = {1.25}
	self.values.player.fall_damage_multiplier = {0.25}
	self.values.player.fall_health_damage_multiplier = {0}
	self.values.player.respawn_time_multiplier = {0.5}
	self.values.weapon.special_damage_taken_multiplier = {1.05}
	self.values.player.corpse_dispose = {true}
	self.values.carry.interact_speed_multiplier = {0.75, 0.25}
	self.values.player.suspicion_multiplier = {0.75}
	self.values.player.camouflage_bonus = {0.85}
	self.values.player.walk_speed_multiplier = {1.25}
	self.values.player.crouch_speed_multiplier = {1.1}
	self.values.player.silent_kill = {25}
	self.values.player.melee_knockdown_mul = {1.5}
	self.values.player.damage_dampener = {0.95}
	self.values.player.melee_damage_dampener = {0.5}
	self.values.smg.reload_speed_multiplier = {1.35}
	self.values.smg.fire_rate_multiplier = {1.2}
	self.values.player.additional_lives = {1, 3}
	self.values.player.cheat_death_chance = {0.1}
	self.values.ecm_jammer.can_activate_feedback = {true}
	self.values.ecm_jammer.feedback_duration_boost = {1.25}
	self.values.ecm_jammer.interaction_speed_multiplier = {0}
	self.values.weapon.silencer_damage_multiplier = {1.15, 1.3}
	self.values.weapon.armor_piercing_chance_silencer = {0.15}
	self.values.ecm_jammer.duration_multiplier = {1.25}
	self.values.ecm_jammer.can_open_sec_doors = {true}
	self.values.player.pick_lock_easy = {true}
	self.values.player.pick_lock_easy_speed_multiplier = {0.75, 0.5}
	self.values.player.pick_lock_hard = {true}
	self.values.weapon.silencer_recoil_multiplier = {0.5}
	self.values.weapon.silencer_spread_multiplier = {0.5}
	self.values.weapon.silencer_enter_steelsight_speed_multiplier = {2}
	self.values.player.loot_drop_multiplier = {1.5, 3}
	self.values.ecm_jammer.quantity = {1, 3}
	self.values.ecm_jammer.duration_multiplier_2 = {1.25}
	self.values.ecm_jammer.feedback_duration_boost_2 = {1.25}
	self.values.ecm_jammer.affects_pagers = {true}
	self.values.player.can_strafe_run = {true}
	self.values.player.can_free_run = {true}
	self.values.ecm_jammer.affects_cameras = {true}
	self.values.player.passive_dodge_chance = {0.05, 0.15}
	self.values.weapon.passive_swap_speed_multiplier = {1.2, 2}
	self.values.player.passive_concealment_modifier = {5}
	self.values.player.passive_armor_movement_penalty_multiplier = {0.75}
	self.values.player.passive_loot_drop_multiplier = {1.1}
	self.values.weapon.armor_piercing_chance = {0.15}
	self.values.player.run_and_shoot = {true}
	self.values.player.run_and_reload = {true}
	self.values.player.morale_boost = {true}
	self.values.player.electrocution_resistance_multiplier = {0.25}
	self.values.player.concealment_modifier = {
		5,
		10,
		15
	}
	self.values.sentry_gun.armor_multiplier2 = {1.25}
	self.values.saw.armor_piercing_chance = {1}
	self.values.saw.swap_speed_multiplier = {1.5}
	self.values.saw.reload_speed_multiplier = {1.5}
	self.values.team.health.hostage_multiplier = {1.01}
	self.values.team.stamina.hostage_multiplier = {1.01}
	self.values.player.minion_master_speed_multiplier = {1.05}
	self.values.player.minion_master_health_multiplier = {1.1}
	self.values.player.mark_enemy_time_multiplier = {2}
	self.values.player.critical_hit_chance = {0.25, 0.5}
	self.values.player.melee_kill_snatch_pager_chance = {0.25}
	self.values.player.detection_risk_add_crit_chance = {
		{
			0.005,
			3,
			"below",
			35
		}
	}
	self.values.player.detection_risk_add_dodge_chance = {
		{
			0.01,
			3,
			"below",
			35
		}
	}
	self.values.player.detection_risk_damage_multiplier = {
		{
			0.05,
			7,
			"above",
			40
		}
	}
	self.values.player.overkill_health_to_damage_multiplier = {0.66}
	self.values.player.tased_recover_multiplier = {0.5}
	self.values.player.armor_regen_timer_stand_still_multiplier = {1.1}
	self.values.player.secured_bags_speed_multiplier = {1.02}
	self.values.temporary.no_ammo_cost_buff = {
		{true, 60}
	}
	self.values.player.secured_bags_money_multiplier = {1.02}
	self.values.pistol.stacking_hit_damage_multiplier = {0.1}
	self.values.carry.movement_penalty_nullifier = {true}
	self.values.temporary.berserker_damage_multiplier = {
		{2, 6}
	}
	self.values.player.berserker_invulnerability = {true}
	self.values.player.hostage_health_regen_addend = {0.005}
	self.values.player.carry_sentry_and_trip = {true}
	self.values.player.tier_armor_multiplier = {
		1.1,
		1.25,
		1.5
	}
	self.values.shotgun.hip_fire_damage_multiplier = {1.2}
	self.values.pistol.hip_fire_damage_multiplier = {1.2}
	self.values.assault_rifle.hip_fire_damage_multiplier = {1.2}
	self.values.smg.hip_fire_damage_multiplier = {1.2}
	self.values.saw.hip_fire_damage_multiplier = {1.2}
	self.values.shotgun.consume_no_ammo_chance = {0.01, 0.03}
	self.values.player.add_armor_stat_skill_ammo_mul = {true}
	self.values.saw.melee_knockdown_mul = {1.75}
	self.values.shotgun.melee_knockdown_mul = {1.75}
	self.values.player.assets_cost_multiplier_b = {0.5}
	self.values.player.premium_contract_cost_multiplier = {0.5}
	self.values.player.morale_boost_cooldown_multiplier = {0.5}
	self.values.player.level_interaction_timer_multiplier = {
		{0.01, 10}
	}
	self.values.team.player.clients_buy_assets = {true}
	self.values.player.steelsight_normal_movement_speed = {true}
	self.values.team.weapon.move_spread_multiplier = {1.1}
	self.values.team.player.civ_intimidation_mul = {1.15}
	self.values.sentry_gun.can_revive = {true}
	self.values.sentry_gun.can_reload = {true}
	self.sentry_gun_reload_ratio = 1
	self.values.weapon.modded_damage_multiplier = {1.1}
	self.values.weapon.modded_spread_multiplier = {0.9}
	self.values.weapon.modded_recoil_multiplier = {0.9}
	self.values.sentry_gun.armor_piercing_chance = {0.15}
	self.values.sentry_gun.armor_piercing_chance_2 = {0.05}
	self.values.weapon.armor_piercing_chance_2 = {0.05}
	self.values.player.headshot_regen_armor_bonus = {0.05}
	self.values.player.resist_firing_tased = {true}
	self.values.player.crouch_dodge_chance = {0.1}
	self.values.player.climb_speed_multiplier = {1.33, 1.75}
	self.values.team.xp.stealth_multiplier = {1.5}
	self.values.team.cash.stealth_money_multiplier = {1.5}
	self.values.team.cash.stealth_bags_multiplier = {1.5}
	self.values.player.close_to_hostage_boost = {true}
	local editable_skill_descs = {
		ammo_2x = {
			{"2"},
			{"200%"}
		},
		ammo_reservoir = {
			{"5"},
			{"5"}
		},
		assassin = {
			{"25%", "10%"},
			{"95%"}
		},
		bandoliers = {
			{"25%"},
			{"75%"}
		},
		black_marketeer = {
			{"10%"},
			{"30%", "25%"}
		},
		blast_radius = {
			{"25%"},
			{"75%"}
		},
		cable_guy = {
			{"75%"},
			{"4"}
		},
		carbon_blade = {
			{"20%"},
			{"50%", "20%"}
		},
		cat_burglar = {
			{"75%"},
			{"50%"}
		},
		chameleon = {
			{"25%"},
			{"15%"}
		},
		cleaner = {
			{"5%"},
			{"2"}
		},
		combat_medic = {
			{"25%", "10"},
			{"30%"}
		},
		control_freak = {
			{},
			{"50%"}
		},
		discipline = {
			{"50%"},
			{}
		},
		dominator = {
			{},
			{"50%"}
		},
		drill_expert = {
			{"15%"},
			{"15%"}
		},
		ecm_2x = {
			{"2"},
			{"25%", "25%"}
		},
		ecm_booster = {
			{"25%"},
			{}
		},
		ecm_feedback = {
			{
				"50%-100%",
				"25",
				"1.5",
				"15-20"
			},
			{"25%"}
		},
		enforcer = {
			{"400%"},
			{}
		},
		equilibrium = {
			{"10%", "50%"},
			{"100%"}
		},
		fast_learner = {
			{"15%"},
			{"30%"}
		},
		from_the_hip = {
			{"20%"},
			{"20%"}
		},
		ghost = {
			{"1", "20"},
			{}
		},
		good_luck_charm = {
			{"50%"},
			{"200%"}
		},
		gun_fighter = {
			{"50%"},
			{"50%"}
		},
		hardware_expert = {
			{"25%", "20%"},
			{"30%", "50%"}
		},
		single_shot_ammo_return = {
			{
				"20%",
				"100cm"
			},
			{
				"100%",
				"20%"
			}
		},
		hitman = {
			{"15%"},
			{"15%", "15%"}
		},
		inside_man = {
			{"50%"},
			{}
		},
		inspire = {
			{
				"50%",
				"20%",
				"10"
			},
			{
				"75%",
				"0",
				"9"
			}
		},
		insulation = {
			{},
			{"50%"}
		},
		iron_man = {
			{"50%"},
			{"25%"}
		},
		joker = {
			{},
			{"55%", "45%"}
		},
		juggernaut = {
			{},
			{}
		},
		kilmer = {
			{"25%"},
			{"50%"}
		},
		leadership = {
			{"25%"},
			{"50%"}
		},
		mag_plus = {
			{"5"},
			{"10"}
		},
		magic_touch = {
			{"25%"},
			{"25%"}
		},
		martial_arts = {
			{"50%"},
			{"50%"}
		},
		master_craftsman = {
			{"10%"},
			{"10%"}
		},
		mastermind = {
			{"2"},
			{}
		},
		medic_2x = {
			{"2"},
			{"2"}
		},
		nine_lives = {
			{"1"},
			{"10%"}
		},
		oppressor = {
			{"25%"},
			{"50%"}
		},
		overkill = {
			{"75%", "5"},
			{}
		},
		pack_mule = {
			{"50%"},
			{"50%"}
		},
		pistol_messiah = {
			{"1"},
			{"2"}
		},
		messiah = {
			{
				"1"
			},
			{
				"2"
			}
		},
		portable_saw = {
			{},
			{"1"}
		},
		rifleman = {
			{"100%"},
			{"25%"}
		},
		scavenger = {
			{"10%"},
			{"20%"}
		},
		sentry_2_0 = {
			{"50%"},
			{}
		},
		sentry_gun = {
			{},
			{"150%"}
		},
		sentry_gun_2x = {
			{"2"},
			{"300%"}
		},
		sentry_targeting_package = {
			{"100%"},
			{"150%"}
		},
		shades = {
			{"25%"},
			{"50%"}
		},
		shaped_charge = {
			{"3"},
			{}
		},
		sharpshooter = {
			{"20%"},
			{"25%"}
		},
		shotgun_cqb = {
			{"50%"},
			{"125%"}
		},
		shotgun_impact = {
			{"25%"},
			{"35%"}
		},
		show_of_force = {
			{},
			{"15%"}
		},
		silence = {
			{},
			{}
		},
		silence_expert = {
			{"50%"},
			{"50%", "100%"}
		},
		silent_drilling = {
			{"65%"},
			{}
		},
		smg_master = {
			{"35%"},
			{"20%"}
		},
		smg_training = {
			{},
			{}
		},
		sprinter = {
			{"25%", "25%"},
			{"25%", "25%"}
		},
		steroids = {
			{"50%"},
			{"50%"}
		},
		stockholm_syndrome = {
			{},
			{}
		},
		tactician = {
			{"4", "2"},
			{"15%"}
		},
		target_mark = {
			{},
			{}
		},
		technician = {
			{"2"},
			{}
		},
		tough_guy = {
			{"50%"},
			{"25%"}
		},
		transporter = {
			{"25%"},
			{"50%"}
		},
		triathlete = {
			{"100%"},
			{"50%"}
		},
		trip_mine_expert = {
			{},
			{}
		},
		trip_miner = {
			{"1"},
			{"20%"}
		},
		underdog = {
			{"15%"},
			{"15%"}
		},
		wolverine = {
			{"25%", "250%"},
			{"25%", "100%"}
		},
		stable_shot = {
			{
				"8"
			},
			{
				"16"
			}
		},
		speedy_reload = {
			{
				"15%"
			},
			{
				"100%",
				"4"
			}
		},
		spotter_teamwork = {
			{
				"3",
				"6",
				"1"
			},
			{
				"2",
				"1"
			}
		},
		far_away = {
			{
				"40%"
			},
			{
				"50%"
			}
		},
		close_by = {
			{},
			{
				"35%",
				"15"
			}
		},
		scavenging = {
			{
				"50%"
			},
			{
				"6"
			}
		},
		dire_need = {
			{},
			{
				"6"
			}
		},
		unseen_strike = {
			{
				"4",
				"35%",
				"6"
			},
			{
				"18"
			}
		},
		dance_instructor = {
			{
				"5"
			},
			{
				"50%"
			}
		},
		akimbo_skill = {
			{
				"8"
			},
			{
				"8",
				"50%"
			}
		},
		running_from_death = {
			{
				"100%",
				"10"
			},
			{
				"30%",
				"10"
			}
		},
		up_you_go = {
			{
				"30%",
				"10"
			},
			{
				"40%"
			}
		},
		feign_death = {
			{
				"15%"
			},
			{
				"30%"
			}
		},
		bloodthirst = {
			{
				"100%",
				"1600%"
			},
			{
				"50%",
				"10"
			}
		},
		frenzy = {
			{
				"30%",
				"10%",
				"75%"
			},
			{
				"25%",
				"0%"
			}
		},
		defense_up = {
			{
				"5%"
			},
			{}
		},
		eco_sentry = {
			{
				"5%"
			},
			{
				"150%"
			}
		},
		engineering = {
			{},
			{
				"75%",
				"250%"
			}
		},
		jack_of_all_trades = {
			{
				"100%"
			},
			{
				"50%"
			}
		},
		tower_defense = {
			{
				"1"
			},
			{
				"2"
			}
		},
		steady_grip = {
			{
				"8"
			},
			{
				"16"
			}
		},
		heavy_impact = {
			{
				"5%"
			},
			{
				"20%"
			}
		},
		fire_control = {
			{
				"12"
			},
			{
				"20%"
			}
		},
		shock_and_awe = {
			{},
			{
				"2",
				"100%",
				"1%",
				"20",
				"40%"
			}
		},
		fast_fire = {
			{
				"15"
			},
			{}
		},
		body_expertise = {
			{
				"30%"
			},
			{
				"90%"
			}
		},
		kick_starter = {
			{
				"20%"
			},
			{
				"1",
				"50%"
			}
		},
		expert_handling = {
			{
				"10%",
				"10",
				"4"
			},
			{
				"1",
				"50%"
			}
		},
		optic_illusions = {
			{
				"35%"
			},
			{
				"1",
				"2"
			}
		},
		more_fire_power = {
			{
				"1",
				"4"
			},
			{
				"2",
				"7"
			}
		},
		fire_trap = {
			{
				"10",
				"4"
			},
			{
				"10",
				"50%"
			}
		},
		combat_engineering = {
			{
				"30%"
			},
			{
				"50%"
			}
		},
		hoxton = {
			{
				"4"
			},
			{}
		},
		freedom_call = {
			{
				"20%"
			},
			{
				"15%"
			}
		},
		hidden_blade = {
			{
				"2"
			},
			{
				"95%"
			}
		},
		tea_time = {
			{
				"50%"
			},
			{
				"10%",
				"120"
			}
		},
		awareness = {
			{
				"10%",
				"20%"
			},
			{
				"75%"
			}
		},
		alpha_dog = {
			{
				"5%"
			},
			{
				"10%"
			}
		},
		tea_cookies = {
			{
				"3",
				"7"
			},
			{
				"7",
				"5",
				"3",
				"20"
			}
		},
		cell_mates = {
			{
				"10%"
			},
			{
				"25%"
			}
		},
		thug_life = {
			{
				"1"
			},
			{
				"75%"
			}
		},
		thick_skin = {
			{
				"10",
				"2"
			},
			{
				"20",
				"4"
			}
		},
		backstab = {
			{
				"3%",
				"3",
				"35",
				"30%"
			},
			{
				"3%",
				"1",
				"35",
				"30%"
			}
		},
		drop_soap = {
			{},
			{}
		},
		second_chances = {
			{
				"1",
				"25"
			},
			{
				"2",
				"100%"
			}
		},
		trigger_happy = {
			{
				"10%",
				"2",
				"1",
				"120%"
			},
			{
				"8",
				"4"
			}
		},
		perseverance = {
			{
				"0",
				"3",
				"60%"
			},
			{
				"3"
			}
		},
		jail_workout = {
			{
				"3.5",
				"10",
				"25%"
			},
			{
				"30%"
			}
		},
		akimbo = {
			{
				"-16",
				"8"
			},
			{
				"-8",
				"150%",
				"8",
				"50%"
			}
		},
		jail_diet = {
			{
				"1%",
				"3",
				"35",
				"10%"
			},
			{
				"1%",
				"1",
				"35",
				"10%"
			}
		},
		prison_wife = {
			{
				"15",
				"2",
				"5"
			},
			{
				"30",
				"2",
				"20"
			}
		},
		mastermind_tier1 = {
			{"20%"}
		},
		mastermind_tier2 = {
			{"15%"}
		},
		mastermind_tier3 = {
			{"25%"}
		},
		mastermind_tier4 = {
			{"10%"}
		},
		mastermind_tier5 = {
			{"65%"}
		},
		mastermind_tier6 = {
			{"200%", "50%"}
		},
		enforcer_tier1 = {
			{"10%"}
		},
		enforcer_tier2 = {
			{"10%"}
		},
		enforcer_tier3 = {
			{"10%"}
		},
		enforcer_tier4 = {
			{"10%"}
		},
		enforcer_tier5 = {
			{"5%"}
		},
		enforcer_tier6 = {
			{"30%"}
		},
		technician_tier1 = {
			{"1%"}
		},
		technician_tier2 = {
			{"5%"}
		},
		technician_tier3 = {
			{"3%"}
		},
		technician_tier4 = {
			{"25%"}
		},
		technician_tier5 = {
			{"5%"}
		},
		technician_tier6 = {
			{
				"5%",
				"10%",
				"10%"
			}
		},
		ghost_tier1 = {
			{"5%"}
		},
		ghost_tier2 = {
			{"20%"}
		},
		ghost_tier3 = {
			{"10%"}
		},
		ghost_tier4 = {
			{"+5", "15%"}
		},
		ghost_tier5 = {
			{"80%"}
		},
		ghost_tier6 = {
			{"10%", "15%"}
		},
		hoxton_tier1 = {
			{}
		},
		hoxton_tier2 = {
			{}
		},
		hoxton_tier3 = {
			{}
		},
		hoxton_tier4 = {
			{}
		},
		hoxton_tier5 = {
			{}
		},
		hoxton_tier6 = {
			{}
		}
	}
	self.skill_descs = {}

	for skill_id, skill_desc in pairs(editable_skill_descs) do
		self.skill_descs[skill_id] = {}

		for index, skill_version in ipairs(skill_desc) do
			local version = index == 1 and "multibasic" or "multipro"
			self.skill_descs[skill_id][index] = #skill_version

			for i, desc in ipairs(skill_version) do
				self.skill_descs[skill_id][version .. (i == 1 and "" or tostring(i))] = desc
			end
		end
	end
	
	self.level_tree = {}
	self.level_tree[1] = {
		name_id = "body_armor",
		upgrades = {
			"body_armor2",
			"ak74"
		}
	}
	self.level_tree[2] = {
		name_id = "weapons",
		upgrades = {"colt_1911", "mac10"}
	}
	self.level_tree[4] = {
		name_id = "weapons",
		upgrades = {"new_m4"}
	}
	self.level_tree[6] = {
		name_id = "weapons",
		upgrades = {
			"new_raging_bull",
			"b92fs"
		}
	}
	self.level_tree[7] = {
		name_id = "body_armor",
		upgrades = {
			"body_armor1"
		}
	}
	self.level_tree[8] = {
		name_id = "weapons",
		upgrades = {"r870", "aug"}
	}
	self.level_tree[10] = {
		name_id = "lvl_10",
		upgrades = {
			"rep_upgrade1"
		}
	}
	self.level_tree[12] = {
		name_id = "body_armor3",
		upgrades = {
			"body_armor3"
		}
	}
	self.level_tree[13] = {
		name_id = "weapons",
		upgrades = {"new_mp5", "serbu"}
	}
	self.level_tree[16] = {
		name_id = "weapons",
		upgrades = {"akm", "g36"}
	}
	self.level_tree[19] = {
		name_id = "weapons",
		upgrades = {"olympic", "mp9"}
	}
	self.level_tree[20] = {
		name_id = "lvl_20",
		upgrades = {
			"rep_upgrade2"
		}
	}
	self.level_tree[21] = {
		name_id = "body_armor4",
		upgrades = {
			"body_armor4",
			"kampfmesser"
		}
	}
	self.level_tree[26] = {
		name_id = "weapons",
		upgrades = {"new_m14", "saiga"}
	}
	self.level_tree[29] = {
		name_id = "weapons",
		upgrades = {"akmsu", "glock_18c"}
	}
	self.level_tree[30] = {
		name_id = "lvl_30",
		upgrades = {
			"rep_upgrade3"
		}
	}
	self.level_tree[31] = {
		name_id = "body_armor5",
		upgrades = {
			"body_armor5"
		}
	}
	self.level_tree[33] = {
		name_id = "weapons",
		upgrades = {"ak5"}
	}
	self.level_tree[36] = {
		name_id = "weapons",
		upgrades = {"p90", "deagle"}
	}
	self.level_tree[39] = {
		name_id = "weapons",
		upgrades = {"m16", "huntsman"}
	}
	self.level_tree[40] = {
		name_id = "lvl_40",
		upgrades = {
			"rep_upgrade4"
		}
	}
	self.level_tree[41] = {
		name_id = "weapons",
		upgrades = {"gerber"}
	}
	self.level_tree[45] = {
		name_id = "weapons",
		upgrades = {"m249"}
	}
	self.level_tree[50] = {
		name_id = "lvl_50",
		upgrades = {
			"rep_upgrade5"
		}
	}
	self.level_tree[60] = {
		name_id = "lvl_60",
		upgrades = {
			"rep_upgrade6"
		}
	}
	self.level_tree[61] = {
		name_id = "weapons",
		upgrades = {"rambo"}
	}
	self.level_tree[70] = {
		name_id = "lvl_70",
		upgrades = {
			"rep_upgrade7"
		}
	}
	self.level_tree[75] = {
		name_id = "weapons",
		upgrades = {"hk21"}
	}
	self.level_tree[80] = {
		name_id = "lvl_80",
		upgrades = {
			"rep_upgrade8"
		}
	}
	self.level_tree[90] = {
		name_id = "lvl_90",
		upgrades = {
			"rep_upgrade9"
		}
	}
	self.level_tree[95] = {
		name_id = "menu_es_jobs_available",
		upgrades = {
			"lucky_charm"
		}
	}
	self.level_tree[100] = {
		name_id = "lvl_100",
		upgrades = {
			"rep_upgrade10"
		}
	}
	
	self.values.player.primary_weapon_when_carrying = {true}
	self.values.player.health_multiplier = {1.1}
	self.values.player.passive_xp_multiplier = {1.05}
	self.values.player.dye_pack_chance_multiplier = {0.5}
	self.values.player.dye_pack_cash_loss_multiplier = {0.4}
	self.values.player.toolset = {
		0.95,
		0.9,
		0.85,
		0.8
	}
	self.values.player.uncover_progress_mul = {0.5}
	self.values.player.uncover_progress_decay_mul = {1.5}
	self.values.player.suppressed_multiplier = {0.5}
	self.values.player.intimidate_specials = {true}
	self.values.player.intimidation_multiplier = {1.25}
	self.values.trip_mine.quantity = {
		1,
		2,
		3,
		4,
		5,
		8
	}
	self.values.trip_mine.quantity_2 = {2}
	self.values.trip_mine.quantity_increase = {2}
	self.values.trip_mine.explode_timer_delay = {2}
	self.values.ammo_bag = self.values.ammo_bag or {}
	self.values.ecm_jammer = self.values.ecm_jammer or {}
	self.values.sentry_gun = self.values.sentry_gun or {}
	self.values.doctor_bag = self.values.doctor_bag or {}
	self.values.extra_cable_tie = {}
	self.values.extra_cable_tie.quantity = {
		1,
		2,
		3,
		4
	}

	self.progress = {
		{},
		{},
		{},
		{}
	}
	self.progress[1][49] = "mr_nice_guy"
	self.progress[2][49] = "mr_nice_guy"
	self.progress[3][49] = "mr_nice_guy"
	self.progress[4][49] = "mr_nice_guy"

	self.values.weapon.reload_speed_multiplier = {1}
	self.values.weapon.damage_multiplier = {1}
	self.values.weapon.swap_speed_multiplier = {1.25}
	self.values.weapon.passive_reload_speed_multiplier = {1.1}
	self.values.weapon.auto_spread_multiplier = {1}
	self.values.weapon.spread_multiplier = {0.9}
	self.values.weapon.fire_rate_multiplier = {2}
	self.values.pistol.exit_run_speed_multiplier = {1.25}
	self.values.carry.catch_interaction_speed = {0.6, 0.1}
	self.values.cable_tie.quantity_unlimited = {true}
	self.values.temporary.combat_medic_enter_steelsight_speed_multiplier = {
		{1.2, 15}
	}
	self.values.temporary.wolverine_health_regen = {
		{0.001, 5}
	}
	self.values.temporary.pistol_revive_from_bleed_out = {
		{true, 3}
	}
	self.values.temporary.revive_health_boost = {
		{true, 10}
	}
	self.values.team.weapon.suppression_recoil_multiplier = {0.75}
	self.values.saw.recoil_multiplier = {0.75}
	self.values.saw.fire_rate_multiplier = {1.25, 1.5}

	self.definitions.player_detection_risk_add_crit_chance = {
		category = "feature",
		name_id = "menu_player_detection_risk_add_crit_chance",
		upgrade = {
			category = "player",
			upgrade = "detection_risk_add_crit_chance",
			value = 1
		}
	}
	self.definitions.player_detection_risk_add_dodge_chance = {
		category = "feature",
		name_id = "menu_player_detection_risk_add_dodge_chance",
		upgrade = {
			category = "player",
			upgrade = "detection_risk_add_dodge_chance",
			value = 1
		}
	}
	self.definitions.player_pistol_revive_from_bleed_out_2 = {
		category = "feature",
		name_id = "menu_player_pistol_revive_from_bleed_out",
		upgrade = {
			category = "player",
			upgrade = "pistol_revive_from_bleed_out",
			value = 2
		}
	}
	self.definitions.player_pistol_revive_from_bleed_out_timer = {
		category = "temporary",
		name_id = "menu_player_pistol_revive_from_bleed_out_timer",
		upgrade = {
			category = "temporary",
			upgrade = "pistol_revive_from_bleed_out",
			value = 1
		}
	}
	self.definitions.player_wolverine_health_regen = {
		category = "temporary",
		name_id = "menu_player_wolverine_health_regen",
		upgrade = {
			category = "temporary",
			upgrade = "wolverine_health_regen",
			value = 1
		}
	}	
	self.definitions.player_hostage_health_regen_addend = {
		category = "temporary",
		name_id = "menu_player_hostage_health_regen_addend",
		upgrade = {
			category = "player",
			upgrade = "hostage_health_regen_addend",
			value = 1
		}
	}
	self.definitions.player_camouflage_bonus = {
		category = "feature",
		name_id = "menu_player_camouflage_bonus",
		upgrade = {
			category = "player",
			upgrade = "camouflage_bonus",
			value = 1
		}
	}
	self.definitions.player_berserker_invulnerability = {
		category = "feature",
		name_id = "menu_player_berserker_invulnerability",
		upgrade = {
			category = "player",
			upgrade = "berserker_invulnerability",
			value = 1
		}
	}
	self.definitions.player_suppression_mul_2 = {
		category = "feature",
		name_id = "menu_player_suppression_mul_2",
		upgrade = {
			category = "player",
			upgrade = "suppression_multiplier",
			value = 2
		}
	}
	self.definitions.player_cheat_death_chance = {
		category = "feature",
		name_id = "menu_player_cheat_death_chance",
		upgrade = {
			category = "player",
			upgrade = "cheat_death_chance",
			value = 1
		}
	}
	self.definitions.player_small_loot_multiplier1 = {
		category = "feature",
		name_id = "menu_player_small_loot_multiplier",
		upgrade = {
			category = "player",
			upgrade = "small_loot_multiplier",
			value = 1
		}
	}
	self.definitions.player_small_loot_multiplier2 = {
		category = "feature",
		name_id = "menu_player_small_loot_multiplier",
		upgrade = {
			category = "player",
			upgrade = "small_loot_multiplier",
			value = 2
		}
	}
	self.definitions.player_passive_convert_enemies_health_multiplier = {
		category = "feature",
		name_id = "menu_player_passive_convert_enemies_health_multiplier",
		upgrade = {
			category = "player",
			upgrade = "passive_convert_enemies_health_multiplier",
			value = 1
		}
	}
	self.definitions.player_convert_enemies_damage_multiplier = {
		category = "feature",
		name_id = "menu_player_convert_enemies_damage_multiplier",
		upgrade = {
			category = "player",
			upgrade = "convert_enemies_damage_multiplier",
			value = 1
		}
	}
	self.definitions.player_ene_hostage_lim_1 = {
		category = "feature",
		name_id = "menu_player_intimidate_aura",
		upgrade = {
			category = "player",
			upgrade = "ene_hostage_lim_1",
			value = 1
		}
	}
	self.definitions.player_drill_autorepair_1 = {
		name_id = "menu_player_drill_autorepair",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "drill_autorepair_1",
			category = "player",
			synced = true
		}
	}
	self.definitions.player_long_dis_revive = {
		category = "feature",
		name_id = "menu_player_long_dis_revive",
		upgrade = {
			category = "player",
			upgrade = "long_dis_revive",
			value = 1
		}
	}
	self.definitions.player_pick_lock_easy_speed_multiplier_2 = {
		category = "feature",
		name_id = "menu_player_pick_lock_easy_speed_multiplier",
		upgrade = {
			category = "player",
			upgrade = "pick_lock_easy_speed_multiplier",
			value = 2
		}
	}
	self.definitions.weapon_silencer_armor_piercing_chance = {
		category = "feature",
		name_id = "menu_weapon_silencer_armor_piercing_chance",
		upgrade = {
			category = "weapon",
			upgrade = "armor_piercing_chance_silencer",
			value = 1
		}
	}
	self.definitions.player_headshot_regen_armor_bonus = {
		category = "feature",
		name_id = "menu_player_headshot_regen_armor_bonus",
		upgrade = {
			category = "player",
			upgrade = "headshot_regen_armor_bonus",
			value = 1
		}
	}
	self.definitions.player_crouch_dodge_chance = {
		category = "feature",
		name_id = "menu_player_crouch_dodge_chance",
		upgrade = {
			category = "player",
			upgrade = "crouch_dodge_chance",
			value = 1
		}
	}

	self.definitions.trip_mine = {
		tree = 2,
		step = 4,
		category = "equipment",
		equipment_id = "trip_mine",
		name_id = "debug_trip_mine",
		title_id = "debug_upgrade_new_equipment",
		subtitle_id = "debug_trip_mine",
		icon = "equipment_trip_mine",
		image = "upgrades_tripmines",
		image_slice = "upgrades_tripmines_slice",
		description_text_id = "trip_mine",
		unlock_lvl = 0,
		prio = "high",
		slot = 1
	}
	self.definitions.trip_mine_can_switch_on_off = {
		category = "feature",
		name_id = "menu_trip_mine_can_switch_on_off",
		upgrade = {
			category = "trip_mine",
			upgrade = "can_switch_on_off",
			value = 1
		}
	}
	self.definitions.trip_mine_sensor_toggle = {
		category = "feature",
		name_id = "menu_trip_mine_sensor_toggle",
		upgrade = {
			category = "trip_mine",
			upgrade = "sensor_toggle",
			value = 1
		}
	}
	self.definitions.trip_mine_quantity_increase_1 = {
		category = "feature",
		name_id = "menu_trip_mine_quantity_increase_1",
		upgrade = {
			category = "trip_mine",
			upgrade = "quantity_1",
			value = 1
		}
	}
	self.definitions.trip_mine_quantity_increase_2 = {
		category = "feature",
		name_id = "menu_trip_mine_quantity_increase_1",
		upgrade = {
			category = "trip_mine",
			upgrade = "quantity_2",
			value = 1
		}
	}
	self.definitions.trip_mine_quantity_increase_3 = {
		category = "feature",
		name_id = "menu_trip_mine_quantity_increase_1",
		upgrade = {
			category = "trip_mine",
			upgrade = "quantity_3",
			value = 1
		}
	}
	self.definitions.trip_mine_explosion_size_multiplier_1 = {
		category = "feature",
		incremental = true,
		name_id = "menu_trip_mine_explosion_size_multiplier",
		upgrade = {
			category = "trip_mine",
			upgrade = "explosion_size_multiplier",
			value = 1
		}
	}
	self.definitions.trip_mine_explosion_size_multiplier_2 = {
		category = "feature",
		incremental = true,
		name_id = "menu_trip_mine_explosion_size_multiplier",
		upgrade = {
			category = "trip_mine",
			upgrade = "explosion_size_multiplier",
			value = 2
		}
	}
	self.definitions.trip_mine_explode_timer_delay = {
		category = "feature",
		incremental = true,
		name_id = "menu_trip_mine_explode_timer_delay",
		upgrade = {
			category = "trip_mine",
			upgrade = "explode_timer_delay",
			value = 1
		}
	}

	self.definitions.ecm_jammer = {
		category = "equipment",
		equipment_id = "ecm_jammer",
		name_id = "menu_equipment_ecm_jammer",
		slot = 1
	}
	self.definitions.ecm_jammer_can_activate_feedback = {
		category = "feature",
		name_id = "menu_ecm_jammer_can_activate_feedback",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "can_activate_feedback",
			value = 1
		}
	}
	self.definitions.ecm_jammer_can_open_sec_doors = {
		category = "feature",
		name_id = "menu_ecm_jammer_can_open_sec_doors",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "can_open_sec_doors",
			value = 1
		}
	}
	self.definitions.ecm_jammer_quantity_increase_1 = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_quantity_1",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "quantity",
			value = 1
		}
	}
	self.definitions.ecm_jammer_quantity_increase_2 = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_quantity_2",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "quantity",
			value = 2
		}
	}
	self.definitions.ecm_jammer_duration_multiplier = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_duration_multiplier",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "duration_multiplier",
			value = 1
		}
	}
	self.definitions.ecm_jammer_duration_multiplier_2 = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_duration_multiplier",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "duration_multiplier_2",
			value = 1
		}
	}
	self.definitions.ecm_jammer_affects_cameras = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_affects_cameras",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "affects_cameras",
			value = 1,
			synced = true
		}
	}
	self.definitions.ecm_jammer_affects_pagers = {
		category = "equipment_upgrade",
		name_id = "",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "affects_pagers",
			value = 1,
			synced = true
		}
	}
	self.definitions.ecm_jammer_feedback_duration_boost = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_feedback_duration_boost",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "feedback_duration_boost",
			value = 1,
			synced = true
		}
	}
	self.definitions.ecm_jammer_feedback_duration_boost_2 = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_feedback_duration_boost_2",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "feedback_duration_boost_2",
			value = 1,
			synced = true
		}
	}
	self.definitions.ecm_jammer_interaction_speed_multiplier = {
		category = "equipment_upgrade",
		name_id = "menu_ecm_jammer_interaction_speed_multiplier",
		upgrade = {
			category = "ecm_jammer",
			upgrade = "interaction_speed_multiplier",
			value = 1
		}
	}
	self.definitions.ammo_bag_quantity = {
		category = "equipment_upgrade",
		name_id = "menu_ammo_bag_quantity",
		upgrade = {
			category = "ammo_bag",
			upgrade = "quantity",
			value = 1
		}
	}
	self.definitions.doctor_bag_quantity = {
		category = "equipment_upgrade",
		name_id = "menu_doctor_bag_quantity",
		upgrade = {
			category = "doctor_bag",
			upgrade = "quantity",
			value = 1
		}
	}
	self.definitions.passive_doctor_bag_interaction_speed_multiplier = {
		category = "feature",
		name_id = "menu_passive_doctor_bag_interaction_speed_multiplier",
		upgrade = {
			category = "doctor_bag",
			upgrade = "interaction_speed_multiplier",
			value = 1
		}
	}

	self.definitions.cable_tie = {
		category = "equipment",
		equipment_id = "cable_tie",
		name_id = "debug_equipment_cable_tie",
		title_id = "debug_equipment_cable_tie",
		icon = "equipment_cable_ties",
		image = "upgrades_extracableties",
		image_slice = "upgrades_extracableties_slice",
		unlock_lvl = 0,
		prio = "high"
	}
	self.definitions.cable_tie_quantity = {
		category = "equipment_upgrade",
		name_id = "menu_cable_tie_quantity",
		upgrade = {
			category = "cable_tie",
			upgrade = "quantity",
			value = 1
		}
	}
	self.definitions.cable_tie_interact_speed_multiplier = {
		category = "equipment_upgrade",
		name_id = "menu_cable_tie_interact_speed_multiplier",
		upgrade = {
			category = "cable_tie",
			upgrade = "interact_speed_multiplier",
			value = 1
		}
	}
	self.definitions.cable_tie_can_cable_tie_doors = {
		category = "equipment_upgrade",
		name_id = "menu_cable_tie_can_cable_tie_doors",
		upgrade = {
			category = "cable_tie",
			upgrade = "can_cable_tie_doors",
			value = 1
		}
	}
	self.definitions.cable_tie_quantity_unlimited = {
		category = "equipment_upgrade",
		name_id = "menu_cable_tie_quantity_unlimited",
		upgrade = {
			category = "cable_tie",
			upgrade = "quantity_unlimited",
			value = 1
		}
	}
	self.definitions.sentry_gun_quantity_increase = {
		category = "feature",
		name_id = "menu_sentry_gun_quantity_increase",
		upgrade = {
			category = "sentry_gun",
			upgrade = "quantity",
			value = 1
		}
	}
	self.definitions.weapon_single_spread_multiplier = {
		category = "feature",
		name_id = "menu_weapon_single_spread_multiplier",
		upgrade = {
			category = "weapon",
			upgrade = "single_spread_multiplier",
			value = 1
		}
	}
	self.definitions.weapon_silencer_damage_multiplier_1 = {
		category = "feature",
		name_id = "silencer_damage_multiplier",
		upgrade = {
			category = "weapon",
			upgrade = "silencer_damage_multiplier",
			value = 1
		}
	}
	self.definitions.weapon_silencer_damage_multiplier_2 = {
		category = "feature",
		name_id = "silencer_damage_multiplier",
		upgrade = {
			category = "weapon",
			upgrade = "silencer_damage_multiplier",
			value = 2
		}
	}
	self.definitions.pistol_stacking_hit_damage_multiplier = {
		category = "feature",
		name_id = "menu_pistol_stacking_hit_damage_multiplier",
		upgrade = {
			category = "pistol",
			upgrade = "stacking_hit_damage_multiplier",
			value = 1
		}
	}
	self.definitions.shotgun_damage_multiplier = {
		category = "feature",
		name_id = "menu_shotgun_damage_multiplier",
		upgrade = {
			category = "shotgun",
			upgrade = "damage_multiplier",
			value = 1
		}
	}
	self.definitions.shotgun_reload_speed_multiplier = {
		category = "feature",
		name_id = "menu_shotgun_reload_speed_multiplier",
		upgrade = {
			category = "shotgun",
			upgrade = "reload_speed_multiplier",
			value = 1
		}
	}
	self.definitions.temporary_berserker_damage_multiplier = {
		category = "temporary",
		name_id = "menu_temporary_berserker_damage_multiplier",
		upgrade = {
			category = "temporary",
			upgrade = "berserker_damage_multiplier",
			value = 1
		}
	}
end

function UpgradesTweakData:_melee_weapon_definitions()
	self.definitions.weapon = {
		category = "melee_weapon"
	}
	self.definitions.fists = {
		category = "melee_weapon"
	}
	self.definitions.kabar = {
		dlc = "gage_pack_lmg",
		category = "melee_weapon"
	}
	self.definitions.rambo = {
		dlc = "gage_pack_lmg",
		category = "melee_weapon"
	}
	self.definitions.gerber = {
		dlc = "gage_pack_lmg",
		category = "melee_weapon"
	}
	self.definitions.kampfmesser = {
		dlc = "gage_pack_lmg",
		category = "melee_weapon"
	}
	self.definitions.brass_knuckles = {
		dlc = "pd2_clan",
		category = "melee_weapon"
	}
end