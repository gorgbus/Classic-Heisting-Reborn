Hooks:PostHook(PrePlanningTweakData, "init", "init_restore", function(self)
    self.types.spycam.upgrade_lock = {
        upgrade = "additional_assets",
		category = "player"
    }
    self.types.spotter.upgrade_lock = {
        upgrade = "additional_assets",
		category = "player"
    }
    self.types.bodybags_bag.upgrade_lock = {
        upgrade = "special_damage_taken_multiplier",
		category = "weapon"
    }
    self.types.bodybags_bag.total = 1
    self.types.ammo_bag.total = 1
    self.types.grenade_crate.total = 1
    self.types.health_bag .total = 1

end)