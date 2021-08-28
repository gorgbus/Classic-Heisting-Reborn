Hooks:PostHook(AssetsTweakData, "_init_assets", "_init_assetsRestore", function(self, tweak_data)
    self.bodybags_bag = {
		name_id = "menu_asset_bodybags_bag",
		texture = "guis/textures/pd2/mission_briefing/assets/generic_assets/bodybags_bag",
		stages = {
			"welcome_to_the_jungle_1",
			"welcome_to_the_jungle_1_night",
			"welcome_to_the_jungle_2",
			"election_day_1",
			"election_day_2",
			"firestarter_2",
			"ukrainian_job",
			"jewelry_store",
			"four_stores",
			"nightclub",
			"arm_for",
			"family",
			"roberts",
			"cage",
			"hox_3",
			"arena",
			"red2",
			"dark",
			"friend",
			"fish",
			"dah",
			"tag",
			"sah",
			"vit"
		},
		visible_if_locked = true,
		unlock_desc_id = "menu_asset_bodybags_bag_desc",
		no_mystery = true,
		money_lock = tweak_data:get_value("money_manager", "mission_asset_cost_small", 4),
		upgrade_lock = {
			upgrade = "special_damage_taken_multiplier",
			category = "weapon"
		}
	}
end)