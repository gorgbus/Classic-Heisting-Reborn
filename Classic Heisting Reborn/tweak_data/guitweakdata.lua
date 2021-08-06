Hooks:PostHook(GuiTweakData, "init", "restore_init", function(self, tweak_data)
	self.crime_net.sidebar = {
		--hide most of sidebar
		{
			visible_callback = "clbk_visible_multiplayer",
			btn_macro = "menu_toggle_filters",
			callback = "clbk_crimenet_filters",
			name_id = "menu_cn_filters_sidebar",
			icon = "sidebar_filters"
		}
	}
	self.crime_net.special_contracts = {
		{
			id = "premium_buy",
			name_id = "menu_cn_premium_buy",
			desc_id = "menu_cn_premium_buy_desc",
			menu_node = "crimenet_contract_special",
			x = 420,
			y = 846,
			icon = "guis/textures/pd2/crimenet_marker_buy"
		},
		{
			id = "contact_info",
			name_id = "menu_cn_contact_info",
			desc_id = "menu_cn_contact_info_desc",
			menu_node = "crimenet_contact_info",
			x = 912,
			y = 905,
			icon = "guis/textures/pd2/crimenet_marker_codex"
		},
		{
			id = "casino",
			name_id = "menu_cn_casino",
			desc_id = "menu_cn_casino_desc",
			menu_node = "crimenet_contract_casino",
			x = 347,
			y = 716,
			icon = "guis/textures/pd2/crimenet_casino",
			unlock = "unlock_level",
			pulse = false,
			pulse_color = Color(204, 255, 209, 32) / 255
		}
	}
	self.buy_weapon_categories = {
		primaries = {
			{
				"assault_rifle"
			},
			{
				"shotgun"
			},
			{
				"lmg"
			},
			{
				"wpn_special"
			}
		},
		secondaries = {
			{
				"pistol"
			},
			{
				"smg"
			},
			{
				"shotgun"
			}
		}
	}
end)