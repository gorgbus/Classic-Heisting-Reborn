Hooks:PostHook(AssetsTweakData, "_init_assets", "_init_assetsRestore", function(self, tweak_data)
    self.bodybags_bag.upgrade_lock = {
		upgrade = "special_damage_taken_multiplier",
		category = "weapon"
	}
	self.spotter.upgrade_lock = {
        upgrade = "additional_assets",
		category = "player"
    }
end)

function AssetsTweakData:_init_gage_assets(tweak_data)
end