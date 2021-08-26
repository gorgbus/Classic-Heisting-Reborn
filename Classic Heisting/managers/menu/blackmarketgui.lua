Hooks:PostHook(BlackMarketGui, "_setup", "restore_setup", function(self, is_start_page, component_data)
	self._stats_shown = {
		{
			round_value = true,
			name = "magazine",
			stat_name = "extra_ammo"
		},
		{
			round_value = true,
			name = "totalammo",
			stat_name = "total_ammo_mod"
		},
		{
			round_value = true,
			name = "fire_rate"
		},
		{
			round_value = true,
			name = "damage"
		},
		{
			round_value = true,
			percent = true,
			name = "spread",
			offset = true,
			revert = true
		},
		{
			round_value = true,
			percent = true,
			name = "recoil",
			offset = true,
			revert = true
		},
		{
			round_value = true,
			index = true,
			name = "concealment"
		},
		{
			round_value = true,
			percent = false,
			name = "suppression",
			offset = true
		}
	}
end)

function BlackMarketGui:purchase_weapon_mod_callback(data)
end