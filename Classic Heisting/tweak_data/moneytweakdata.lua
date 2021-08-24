Hooks:PostHook(MoneyTweakData, "init", "restore_init", function(self)
	self.bag_values.default = 1000
	self.bag_values.money = 1500
	self.bag_values.gold = 2875
	self.bag_values.diamonds = 1000
	self.bag_values.coke = 2000
	self.bag_values.meth = 13000
	self.bag_values.meth_half = 6500
	self.bag_values.weapon = 3000
	self.bag_values.weapons = 3000
	self.bag_values.painting = 3000
	self.bag_values.samurai_suit = 5000
	self.bag_values.artifact_statue = 5000
	self.bag_values.mus_artifact_bag = 1000
	self.bag_values.circuit = 1000
	self.bag_values.sandwich = 10000
	self.bag_values.cro_loot = 10000
	self.bag_values.hope_diamond = 30000
	self.bag_values.evidence_bag = 3000
	self.bag_values.vehicle_falcogini = 4000
	self.bag_values.warhead = 4600
	self.bag_values.unknown = 5000
	self.bag_values.safe = 4600
	self.bag_values.prototype = 5000
	self.bag_values.faberge_egg = 3000
	self.bag_values.treasure = 3200
	self.bag_values.counterfeit_money = 1100
	self.bag_values.box_unknown = 5000
	self.bag_values.black_tablet = 5000
	self.bag_values.masterpiece_painting = 10000
	self.bag_values.master_server = 10000
	self.bag_values.lost_artifact = 10000
	self.bag_values.present = 2049
	self.bag_values.mad_master_server_value_1 = 5000
	self.bag_values.mad_master_server_value_2 = 10000
	self.bag_values.mad_master_server_value_3 = 15000
	self.bag_values.mad_master_server_value_4 = 20000
	self.bag_values.weapon_glock = 2000
	self.bag_values.weapon_scar = 2000
	self.bag_values.drk_bomb_part = 9000
	self.bag_values.drone_control_helmet = 9000
	self.bag_values.toothbrush = 9000
	self.bag_values.cloaker_gold = 3000
	self.bag_values.cloaker_money  = 2250
	self.bag_values.cloaker_cocaine = 2700
	self.bag_values.diamond_necklace = 1500
	self.bag_values.vr_headset = 3000
	self.bag_values.women_shoes = 3000
	self.bag_values.expensive_vine = 3000
	self.bag_values.ordinary_wine = 3000
	self.bag_values.robot_toy = 3000
	self.bag_values.rubies = 1500
	self.bag_values.red_diamond = 10000
	self.bag_values.old_wine = 2000
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