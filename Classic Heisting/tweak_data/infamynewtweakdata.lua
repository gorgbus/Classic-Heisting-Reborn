local data = InfamyTweakData.init
function InfamyTweakData:init(tweak_data)
    local digest = function(value)
		return Application:digest_value(value, true)
	end

	self.ranks = 5

	self.offshore_cost = {
		digest(200000000),
		digest(200000000),
		digest(200000000),
		digest(200000000),
		digest(200000000),
		digest(0)
	}
	
	self.statistics_rank_steps = {}

	for i = 0, 100 do
		table.insert(self.statistics_rank_steps, 1, i)
	end

	for i = 150, self.ranks, 50 do
		table.insert(self.statistics_rank_steps, 1, i)
	end

	self.join_stingers = 35
	self.free_join_stingers = {
		0,
		18
	}
	self.icon_rank_step = 100

	self.infamy_icons = {
		{
			hud_icon = "infamy_icon_1",
			color = Color("000000")
		},
		{
			hud_icon = "infamy_icon_2",
			color = Color("B8000A")
		},
		{
			hud_icon = "infamy_icon_3",
			color = Color("000000")
		},
		{
			hud_icon = "infamy_icon_4",
			color = Color("B8000A")
		},
		{
			hud_icon = "infamy_icon_5",
			color = Color("FFD700")
		}
	}

	self.tree = {
		"infamy_root",
		"infamy_mastermind",
		"infamy_enforcer",
		"infamy_technician",
		"infamy_ghost"
	}
	self.cost = {
		root = digest(1),
		tier1 = digest(1)
	}
	self.items = {}
	local skilltree_multiplier = 0.9
	local skillcost_multiplier = 0.75
	local skilltree_readable_multiplier = "10%"
	local skillcost_readable_multiplier = "25%"
	local infamous_lootdrop_multiplier = 2
	local infamous_xp_multiplier = 1.05
	local infamous_readable_multiplier = "100%"
	local infamous_readable_xp_multiplier = "5%"
	self.items.infamy_root = {
		name_id = "menu_infamy_name_root",
		add_tier = false,
		desc_id = "menu_infamy_desc_root",
		desc_params = {cashcost = skillcost_readable_multiplier, xpboost = infamous_readable_xp_multiplier},
		icon_xy = {0, 0},
		cost = self.cost.root,
		upgrades = {
			{
				nil,
				"masks",
				"aviator"
			},
			infamous_lootdrop = infamous_lootdrop_multiplier,
			infamous_xp = infamous_xp_multiplier,
			skillcost = {multiplier = skillcost_multiplier}
		}
	}
	self.items.infamy_mastermind = {
		name_id = "menu_infamy_name_mastermind",
		add_tier = true,
		desc_id = "menu_infamy_desc_mastermind",
		desc_params = {multibasic = skilltree_readable_multiplier, xpboost = infamous_readable_xp_multiplier},
		icon_xy = {2, 0},
		cost = self.cost.tier1,
		upgrades = {
			{
				nil,
				"masks",
				"plague"
			},
			{
				nil,
				"textures",
				"imperial"
			},
			{
				nil,
				"materials",
				"dark_leather"
			},
			infamous_xp = infamous_xp_multiplier,
			skilltree = {
				trees = {"mastermind", "hoxton"},
				multiplier = skilltree_multiplier
			}
		}
	}
	self.items.infamy_enforcer = {
		name_id = "menu_infamy_name_enforcer",
		add_tier = true,
		desc_id = "menu_infamy_desc_enforcer",
		desc_params = {multibasic = skilltree_readable_multiplier, xpboost = infamous_readable_xp_multiplier},
		icon_xy = {3, 0},
		cost = self.cost.tier1,
		upgrades = {
			{
				nil,
				"masks",
				"welder"
			},
			{
				nil,
				"textures",
				"fatman"
			},
			{
				nil,
				"materials",
				"copper"
			},
			infamous_xp = infamous_xp_multiplier,
			skilltree = {
				trees = {"enforcer", "hoxton"},
				multiplier = skilltree_multiplier
			}
		}
	}
	self.items.infamy_technician = {
		name_id = "menu_infamy_name_technician",
		add_tier = true,
		desc_id = "menu_infamy_desc_technician",
		desc_params = {multibasic = skilltree_readable_multiplier, xpboost = infamous_readable_xp_multiplier},
		icon_xy = {1, 0},
		cost = self.cost.tier1,
		upgrades = {
			{
				nil,
				"masks",
				"smoker"
			},
			{
				nil,
				"textures",
				"toto"
			},
			{
				nil,
				"materials",
				"electric"
			},
			infamous_xp = infamous_xp_multiplier,
			skilltree = {
				trees = {"technician", "hoxton"},
				multiplier = skilltree_multiplier
			}
		}
	}
	self.items.infamy_ghost = {
		name_id = "menu_infamy_name_ghost",
		add_tier = true,
		desc_id = "menu_infamy_desc_ghost",
		desc_params = {multibasic = skilltree_readable_multiplier, xpboost = infamous_readable_xp_multiplier},
		icon_xy = {0, 1},
		cost = self.cost.tier1,
		upgrades = {
			{
				nil,
				"masks",
				"ghost"
			},
			{
				nil,
				"textures",
				"ribcage"
			},
			{
				nil,
				"materials",
				"sinister"
			},
			infamous_xp = infamous_xp_multiplier,
			skilltree = {
				trees = {"ghost", "hoxton"},
				multiplier = skilltree_multiplier
			}
		}
	}
	self.items.infamy_secret_9 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_8 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_7 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_6 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_5 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_4 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_3 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_2 = {
		icon_xy = {1, 3}
	}
	self.items.infamy_secret_1 = {
		icon_xy = {1, 3}
	}
end
