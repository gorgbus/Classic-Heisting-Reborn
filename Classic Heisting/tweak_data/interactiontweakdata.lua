Hooks:PostHook(InteractionTweakData, "init", "init_restore", function(self)
    self.shaped_sharge.requires_upgrade = {
            category = "player",
            upgrade = "trip_mine_shaped_charge"
    }
end)