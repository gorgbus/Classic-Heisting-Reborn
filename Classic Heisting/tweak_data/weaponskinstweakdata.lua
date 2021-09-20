Hooks:PostHook(BlackMarketTweakData, "_init_weapon_skins", "remove_skin_parts_and_boosts", function(self, tweak_data)
	for _, skin in pairs(self.weapon_skins) do
		skin.default_blueprint = nil
        skin.bonus = nil
	end
end)