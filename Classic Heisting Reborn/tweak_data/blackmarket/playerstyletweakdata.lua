Hooks:PostHook(BlackMarketTweakData, "_init_player_styles", "hide_outfits", function(self)
    self.player_styles.general = nil
    self.player_styles.gangstercoat = nil
    self.player_styles.leather = nil
    self.player_styles.t800 = nil
    self.player_styles.baron = nil
end)