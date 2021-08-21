function BlackMarketTweakData:_init_characters(tweak_data)
	self.characters = {
		locked = {}
	}
	self.characters.locked.fps_unit = "units/payday2/characters/fps_mover/fps_mover"
	self.characters.locked.npc_unit = "units/payday2/characters/npc_criminals_suit_1/npc_criminals_suit_1"
	self.characters.locked.menu_unit = "units/payday2/characters/npc_criminals_suit_1/npc_criminals_suit_1_menu"
	self.characters.locked.sequence = "var_material_01"
	self.characters.locked.name_id = "bm_character_locked"
	self.characters.locked.dallas = {
		sequence = "var_mtr_dallas",
		installed = true,
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_dallas",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_dallas"
		}
	}
	self.characters.locked.wolf = {
		sequence = "var_mtr_wolf",
		installed = true,
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_wolf",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_wolf"
		}
	}
	self.characters.locked.hoxton = {
		sequence = "var_mtr_hoxton",
		installed = true,
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_hoxton",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_hoxton"
		}
	}
	self.characters.locked.chains = {
		sequence = "var_mtr_chains",
		installed = true,
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_chains",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_chains"
		}
	}
	self.characters.locked.jowi = {
		sequence = "var_mtr_john_wick",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_john_wick",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_john_wick"
		}
	}
	self.characters.locked.old_hoxton = {
		sequence = "var_mtr_old_hoxton",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_old_hoxton",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_old_hoxton"
		}
	}
	self.characters.locked.dragan = {
		texture_bundle_folder = "character_pack_dragan",
		sequence = "var_mtr_dragan",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_dragan",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_dragan"
		}
	}
	self.characters.locked.jacket = {
		texture_bundle_folder = "hlm2",
		sequence = "var_mtr_jacket",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_jacket",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_jacket"
		}
	}
	self.characters.locked.sokol = {
		texture_bundle_folder = "character_pack_sokol",
		mask_on_sequence = "mask_on_sokol",
		mask_off_sequence = "mask_off_sokol",
		sequence = "var_mtr_sokol",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_sokol",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_sokol"
		}
	}
	self.characters.locked.dragon = {
		texture_bundle_folder = "dragon",
		sequence = "var_mtr_jiro",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_jiro",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_jiro"
		}
	}
	self.characters.locked.bodhi = {
		texture_bundle_folder = "rip",
		sequence = "var_mtr_bodhi",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_bodhi",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_bodhi"
		}
	}
	self.characters.locked.jimmy = {
		texture_bundle_folder = "coco",
		mask_on_sequence = "mask_on_jimmy",
		mask_off_sequence = "mask_off_jimmy",
		sequence = "var_mtr_jimmy",
		dlc = "fockoff",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_jimmy",
			npc = "units/payday2/characters/npc_criminals_suit_1/mtr_jimmy"
		}
	}
	self.characters.female_1 = {
		fps_unit = "units/payday2/characters/fps_mover/fps_female_1_mover",
		npc_unit = "units/payday2/characters/npc_criminal_female_1/npc_criminal_female_1",
		menu_unit = "units/payday2/characters/npc_criminal_female_1/npc_criminal_female_1_menu",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_fem1",
			npc = "units/payday2/characters/npc_criminal_female_1/mtr_fem1"
		},
		texture_bundle_folder = "character_pack_clover",
		sequence = "var_mtr_fem1",
		mask_on_sequence = "mask_on",
		mask_off_sequence = "mask_off",
		dlc = "fockoff"
	}
	self.characters.bonnie = {
		fps_unit = "units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/fps_bonnie_mover",
		npc_unit = "units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/npc_criminal_bonnie",
		menu_unit = "units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/npc_criminal_bonnie_menu",
		material_config = {
			fps = "units/payday2/characters/fps_criminals_suit_1/mtr_bonnie",
			npc = "units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/mtr_bonnie"
		},
		texture_bundle_folder = "character_pack_bonnie",
		sequence = "var_mtr_bonnie",
		mask_on_sequence = "bonnie_mask_on",
		mask_off_sequence = "bonnie_mask_off",
		dlc = "fockoff"
	}
	self.characters.ai_hoxton = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/hoxton/npc_criminal_suit_hoxton",
		sequence = "var_mtr_hoxton"
	}
	self.characters.ai_chains = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/chains/npc_criminal_suit_chains",
		sequence = "var_mtr_chains"
	}
	self.characters.ai_dallas = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/dallas/npc_criminal_suit_dallas",
		sequence = "var_mtr_dallas"
	}
	self.characters.ai_wolf = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/wolf/npc_criminal_suit_wolf",
		sequence = "var_mtr_wolf",
	}
	self.characters.ai_jowi = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/jowi/npc_criminal_suit_jowi",
		sequence = "var_mtr_john_wick",
		dlc = "fockoff"
	}
	self.characters.ai_old_hoxton = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/old_hoxton/npc_criminal_suit_old_hoxton",
		sequence = "var_mtr_old_hoxton",
		dlc = "fockoff"
	}
	self.characters.ai_female_1 = {
		npc_unit = "units/payday2/characters/npc_criminal_female_1/fem1/npc_criminal_female_fem1",
		sequence = "var_mtr_fem1",
		mask_on_sequence = "mask_on",
		mask_off_sequence = "mask_off",
		dlc = "fockoff"
	}
	self.characters.ai_dragan = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/dragan/npc_criminal_suit_dragan",
		sequence = "var_mtr_dragan",
		dlc = "fockoff"
	}
	self.characters.ai_jacket = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/jacket/npc_criminal_suit_jacket",
		sequence = "var_mtr_jacket",
		dlc = "fockoff"
	}
	self.characters.ai_bonnie = {
		npc_unit = "units/pd2_dlc_bonnie/characters/npc_criminal_bonnie/fem1/npc_criminal_female_bonnie_1",
		sequence = "var_mtr_bonnie",
		mask_on_sequence = "bonnie_mask_on",
		mask_off_sequence = "bonnie_mask_off",
		dlc = "fockoff"
	}
	self.characters.ai_sokol = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/sokol/npc_criminal_suit_sokol",
		sequence = "var_mtr_sokol",
		mask_on_sequence = "mask_on_sokol",
		mask_off_sequence = "mask_off_sokol",
		dlc = "fockoff"
	}
	self.characters.ai_dragon = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/dragon/npc_criminal_suit_dragon",
		sequence = "var_mtr_jiro",
		dlc = "fockoff"
	}
	self.characters.ai_bodhi = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/bodhi/npc_criminal_suit_bodhi",
		sequence = "var_mtr_bodhi",
		dlc = "fockoff"
	}
	self.characters.ai_jimmy = {
		npc_unit = "units/payday2/characters/npc_criminals_suit_1/jimmy/npc_criminal_suit_jimmy",
		sequence = "var_mtr_jimmy",
		dlc = "fockoff"
	}
	self.characters.sydney = {
		fps_unit = "units/pd2_dlc_opera/characters/npc_criminals_fem_3/fps_sydney_mover",
		npc_unit = "units/pd2_dlc_opera/characters/npc_criminals_fem_3/npc_criminal_sydney",
		menu_unit = "units/pd2_dlc_opera/characters/npc_criminals_fem_3/npc_criminal_sydney_menu",
		material_config = {
			fps = "units/pd2_dlc_opera/characters/fps_criminals_fem_3/mtr_sydney",
			npc = "units/pd2_dlc_opera/characters/npc_criminals_fem_3/mtr_criminal_sydney"
		},
		texture_bundle_folder = "opera",
		sequence = "var_mtr_sydney",
		mask_on_sequence = "mask_on",
		mask_off_sequence = "mask_off",
		dlc = "fockoff"
	}
	self.characters.ai_sydney = {
		npc_unit = "units/pd2_dlc_opera/characters/npc_criminals_fem_3/fem3/npc_criminal_female_3",
		sequence = "var_mtr_sydney",
		mask_on_sequence = "mask_on",
		mask_off_sequence = "mask_off",
		dlc = "fockoff"
	}
	self.characters.wild = {
		fps_unit = "units/pd2_dlc_wild/characters/npc_criminals_wild_1/fps_wild_mover",
		npc_unit = "units/pd2_dlc_wild/characters/npc_criminals_wild_1/npc_criminal_wild_1",
		menu_unit = "units/pd2_dlc_wild/characters/npc_criminals_wild_1/npc_criminal_wild_1_menu",
		material_config = {
			fps = "units/pd2_dlc_wild/characters/fps_criminals_wild_1/mtr_wild",
			npc = "units/pd2_dlc_wild/characters/npc_criminals_wild_1/mtr_criminal_wild_1"
		},
		texture_bundle_folder = "wild",
		sequence = "var_mtr_wild",
		dlc = "fockoff"
	}
	self.characters.ai_wild = {
		npc_unit = "units/pd2_dlc_wild/characters/npc_criminals_wild_1/wild_1/npc_criminal_wild_1",
		sequence = "var_mtr_wild",
		dlc = "fockoff"
	}
	self.characters.chico = {
		fps_unit = "units/pd2_dlc_chico/characters/npc_criminals_terry/fps_terry_mover",
		npc_unit = "units/pd2_dlc_chico/characters/npc_criminals_terry/npc_criminal_terry",
		menu_unit = "units/pd2_dlc_chico/characters/npc_criminals_terry/npc_criminal_terry_menu",
		material_config = {
			fps = "units/pd2_dlc_chico/characters/fps_criminals_terry/mtr_terry",
			npc = "units/pd2_dlc_chico/characters/npc_criminals_terry/mtr_criminal_terry"
		},
		texture_bundle_folder = "chico",
		sequence = "var_mtr_terry",
		dlc = "fockoff"
	}
	self.characters.ai_chico = {
		npc_unit = "units/pd2_dlc_chico/characters/npc_criminals_terry/terry/npc_criminal_terry",
		sequence = "var_mtr_terry",
		dlc = "fockoff"
	}
	self.characters.max = {
		fps_unit = "units/pd2_dlc_max/characters/npc_criminals_max/fps_max_mover",
		npc_unit = "units/pd2_dlc_max/characters/npc_criminals_max/npc_criminal_max",
		menu_unit = "units/pd2_dlc_max/characters/npc_criminals_max/npc_criminal_max_menu",
		texture_bundle_folder = "max",
		sequence = "var_mtr_max",
		dlc = "fockoff",
		material_config = {
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_shirt_01"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_shirt_02"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_shirt_03"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_shirt_04"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_shirt_05"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_shirt_06"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				chance = 200,
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_taco"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				chance = 50,
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_snakeskin"
			},
			{
				fps = "units/pd2_dlc_max/characters/fps_criminals_max/mtr_max",
				chance = 50,
				npc = "units/pd2_dlc_max/characters/npc_criminals_max/mtr_criminal_max_pink"
			}
		}
	}
	self.characters.ai_max = {
		npc_unit = "units/pd2_dlc_max/characters/npc_criminals_max/max/npc_criminal_max",
		sequence = "var_mtr_max",
		dlc = "fockoff"
	}
	self.characters.joy = {
		fps_unit = "units/pd2_dlc_joy/characters/npc_criminals_joy_1/fps_joy_mover",
		npc_unit = "units/pd2_dlc_joy/characters/npc_criminals_joy_1/npc_criminal_joy_1",
		menu_unit = "units/pd2_dlc_joy/characters/npc_criminals_joy_1/npc_criminal_joy_1_menu",
		material_config = {
			fps = "units/pd2_dlc_joy/characters/fps_criminals_joy_1/mtr_joy",
			npc = "units/pd2_dlc_joy/characters/npc_criminals_joy_1/mtr_criminal_joy_1"
		},
		texture_bundle_folder = "joy",
		sequence = "var_mtr_joy",
		mask_on_sequence = "mask_on_joy",
		mask_off_sequence = "mask_off_joy",
		dlc = "fockoff"
	}
	self.characters.ai_joy = {
		npc_unit = "units/pd2_dlc_joy/characters/npc_criminals_joy_1/joy_1/npc_criminal_joy_1",
		sequence = "var_mtr_joy",
		mask_on_sequence = "mask_on_joy",
		mask_off_sequence = "mask_off_joy",
		dlc = "fockoff"
	}
	self.characters.myh = {
		fps_unit = "units/pd2_dlc_myh/characters/npc_criminals_myh/fps_myh_mover",
		npc_unit = "units/pd2_dlc_myh/characters/npc_criminals_myh/npc_criminal_myh",
		menu_unit = "units/pd2_dlc_myh/characters/npc_criminals_myh/npc_criminal_myh_menu",
		material_config = {
			fps = "units/pd2_dlc_myh/characters/fps_criminals_myh/mtr_myh",
			npc = "units/pd2_dlc_myh/characters/npc_criminals_myh/mtr_criminal_myh"
		},
		texture_bundle_folder = "myh",
		sequence = "var_mtr_myh",
		dlc = "fockoff"
	}
	self.characters.ai_myh = {
		npc_unit = "units/pd2_dlc_myh/characters/npc_criminals_myh/myh/npc_criminal_myh",
		sequence = "var_mtr_myh",
		dlc = "fockoff"
	}
	self.characters.ecp_female = {
		fps_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_female/fps_ecp_female_mover",
		npc_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_female/npc_criminal_ecp_female",
		menu_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_female/npc_criminal_ecp_female_menu",
		material_config = {
			fps = "units/pd2_dlc_ecp/characters/fps_criminals_ecp_female/mtr_ecp_female",
			npc = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_female/mtr_criminal_ecp_female"
		},
		texture_bundle_folder = "ecp",
		sequence = "var_mtr_ecp_female",
		mask_on_sequence = "mask_on_ecp_female",
		mask_off_sequence = "mask_off_ecp_female",
		dlc = "fockoff"
	}
	self.characters.ecp_male = {
		fps_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_male/fps_ecp_male_mover",
		npc_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_male/npc_criminal_ecp_male",
		menu_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_male/npc_criminal_ecp_male_menu",
		material_config = {
			fps = "units/pd2_dlc_ecp/characters/fps_criminals_ecp_male/mtr_ecp_male",
			npc = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_male/mtr_criminal_ecp_male"
		},
		texture_bundle_folder = "ecp",
		sequence = "var_mtr_ecp_male",
		mask_on_sequence = "mask_on_ecp_male",
		mask_off_sequence = "mask_off_ecp_male",
		dlc = "fockoff"
	}
	self.characters.ai_ecp_female = {
		npc_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_female/ecp_female/npc_criminal_ecp_female",
		sequence = "var_mtr_ecp_female",
		mask_on_sequence = "mask_on_ecp_female",
		mask_off_sequence = "mask_off_ecp_female",
		dlc = "fockoff"
	}
	self.characters.ai_ecp_male = {
		npc_unit = "units/pd2_dlc_ecp/characters/npc_criminals_ecp_male/ecp_male/npc_criminal_ecp_male",
		sequence = "var_mtr_ecp_male",
		mask_on_sequence = "mask_on_ecp_male",
		mask_off_sequence = "mask_off_ecp_male",
		dlc = "fockoff"
	}
	local free_dlcs = tweak_data:free_dlc_list()

	for _, data in pairs(self.characters) do
		if free_dlcs[data.dlc] then
			data.dlc = nil
		end
	end

	for _, data in pairs(self.characters.locked) do
		if free_dlcs[data.dlc] then
			data.dlc = nil
		end
	end
end

function BlackMarketTweakData:_init_deployables(tweak_data)
	self.deployables = {
		doctor_bag = {}
	}
	self.deployables.doctor_bag.name_id = "bm_equipment_doctor_bag"
	self.deployables.ammo_bag = {
		name_id = "bm_equipment_ammo_bag"
	}
	self.deployables.ecm_jammer = {
		name_id = "bm_equipment_ecm_jammer"
	}
	self.deployables.sentry_gun = {
		name_id = "bm_equipment_sentry_gun"
	}
	self.deployables.trip_mine = {
		name_id = "bm_equipment_trip_mine"
	}

	self:_add_desc_from_name_macro(self.deployables)
end