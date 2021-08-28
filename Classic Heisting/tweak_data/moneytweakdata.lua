Hooks:PostHook(MoneyTweakData, "init", "restore_init", function(self)
	self.bag_values.default = 900
	self.bag_values.money = 750
	self.bag_values.gold = 1000
	self.bag_values.diamonds = 500
	self.bag_values.coke = 900
	self.bag_values.meth = 1000
	self.bag_values.meth_half = 500
	self.bag_values.weapon = 950
	self.bag_values.weapons = 950
	self.bag_values.painting = 700
	self.bag_values.samurai_suit = 2000
	self.bag_values.artifact_statue = 2000
	self.bag_values.mus_artifact_bag = 700
	self.bag_values.circuit = 1000
	self.bag_values.sandwich = 3000
	self.bag_values.cro_loot = 5000
	self.bag_values.hope_diamond = 10000
	self.bag_values.evidence_bag = 1500
	self.bag_values.vehicle_falcogini = 2000
	self.bag_values.warhead = 2300
	self.bag_values.unknown = 2500
	self.bag_values.safe = 2300
	self.bag_values.prototype = 5000
	self.bag_values.faberge_egg = 1500
	self.bag_values.treasure = 1600
	self.bag_values.counterfeit_money = 600
	self.bag_values.box_unknown = 5000
	self.bag_values.black_tablet = 5000
	self.bag_values.masterpiece_painting = 5000
	self.bag_values.master_server = 5000
	self.bag_values.lost_artifact = 5000
	self.bag_values.present = 1000
	self.bag_values.mad_master_server_value_1 = 2500
	self.bag_values.mad_master_server_value_2 = 5000
	self.bag_values.mad_master_server_value_3 = 7500
	self.bag_values.mad_master_server_value_4 = 10000
	self.bag_values.weapon_glock = 1000
	self.bag_values.weapon_scar = 1000
	self.bag_values.drk_bomb_part = 4500
	self.bag_values.drone_control_helmet = 9000
	self.bag_values.toothbrush = 9000
	self.bag_values.cloaker_gold = 1000
	self.bag_values.cloaker_money  = 750
	self.bag_values.cloaker_cocaine = 900
	self.bag_values.diamond_necklace = 1500
	self.bag_values.vr_headset = 1500
	self.bag_values.women_shoes = 1500
	self.bag_values.expensive_vine = 1500
	self.bag_values.ordinary_wine = 1500
	self.bag_values.robot_toy = 1500
	self.bag_values.rubies = 750
	self.bag_values.red_diamond = 5000
	self.bag_values.old_wine = 1000
	self.bag_values.shells = 2100
	self.bag_values.turret = 10000
	self.buy_premium_multiplier = {
		easy = 0.5,
		normal = 0.75,
		hard = 1.25,
		overkill = 1.5,
		overkill_145 = 2,
		easy_wish = 2,
		overkill_290 = 2.5,
		sm_wish = 2.5
	}
	self.buy_premium_static_fee = {
		easy = 100000,
		normal = 100000,
		hard = 150000,
		overkill = 200000,
		overkill_145 = 300000,
		easy_wish = 300000,
		overkill_290 = 360000,
		sm_wish = 360000
	}
	self.difficulty_multiplier = {
		4,
		9,
		12,
		20,
		40,
		0,
		0
	}
	local smallest_cashout = (self.stage_completion[1] + self.job_completion[1]) * self.offshore_rate
	local biggest_mask_cost = self.biggest_cashout * 40
	local biggest_mask_cost_deinfamous = math.round(biggest_mask_cost / self.global_value_multipliers.infamous)
	local biggest_mask_part_cost = math.round(smallest_cashout * 20)
	local smallest_mask_part_cost = math.round(smallest_cashout * 1.9)
	local biggest_weapon_cost = math.round(self.biggest_cashout * 1.15)
	local smallest_weapon_cost = math.round(smallest_cashout * 3)
	local biggest_weapon_mod_cost = math.round(self.biggest_cashout * 0.5)
	local smallest_weapon_mod_cost = math.round(smallest_cashout * 3)
	self.weapon_cost = self._create_value_table(smallest_weapon_cost, biggest_weapon_cost, 40, true, 1.1)
	self.modify_weapon_cost = self._create_value_table(smallest_weapon_mod_cost, biggest_weapon_mod_cost, 10, true, 1.2)
	self.remove_weapon_mod_cost_multiplier = self._create_value_table(1, 1, 10, true, 1)
	self.masks.mask_value = self._create_value_table(smallest_mask_part_cost, smallest_mask_part_cost * 2, 10, true, 2)
	self.masks.material_value = self._create_value_table(smallest_mask_part_cost * 0.5, biggest_mask_part_cost, 10, true, 1.2)
	self.masks.pattern_value = self._create_value_table(smallest_mask_part_cost * 0.4, biggest_mask_part_cost, 10, true, 1.1)
	self.masks.color_value = self._create_value_table(smallest_mask_part_cost * 0.3, biggest_mask_part_cost, 10, true, 1)
end)