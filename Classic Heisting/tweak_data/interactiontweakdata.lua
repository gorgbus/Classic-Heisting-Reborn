Hooks:PostHook(InteractionTweakData, "init", "init_restore", function(self)
    self.shaped_sharge.requires_upgrade = {
        category = "player",
        upgrade = "trip_mine_shaped_charge"
    }
    self.hostage_move.requires_upgrade = {
		upgrade = "no_hostage_moving_for_you",
		category = "player"
	}
end)