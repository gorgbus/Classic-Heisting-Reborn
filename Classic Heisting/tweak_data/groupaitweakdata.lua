Hooks:PostHook(GroupAITweakData, "init", "restore_init", function(self, tweak_data)
    self.ai_tick_rate = 0.00833333333
end)

function GroupAITweakData:_init_enemy_spawn_groups_level(tweak_data, difficulty_index)
end

Hooks:PostHook(GroupAITweakData, "_init_unit_categories", "restore_init_unit_categories",
    function(self, difficulty_index)
        local access_type_walk_only = {
            walk = true
        }
        local access_type_all = {
            acrobatic = true,
            walk = true
        }

        if difficulty_index <= 2 then
            self.special_unit_spawn_limits = {
                tank = 1,
                taser = 1,
                spooc = 0,
                shield = 2
            }
        elseif difficulty_index == 3 then
            self.special_unit_spawn_limits = {
                tank = 1,
                taser = 2,
                spooc = 1,
                shield = 4
            }
        elseif difficulty_index == 4 then
            self.special_unit_spawn_limits = {
                tank = 3,
                taser = 4,
                spooc = 2,
                shield = 5
            }
        elseif difficulty_index == 5 then
            self.special_unit_spawn_limits = {
                tank = 3,
                taser = 4,
                spooc = 3,
                shield = 5
            }
        else
            self.special_unit_spawn_limits = {
                tank = 3,
                taser = 4,
                spooc = 4,
                shield = 5
            }
        end

        self.unit_categories.CS_cop_C45_R870 = {
            unit_types = {
                america = {
                    Idstring("units/payday2/characters/ene_cop_1/ene_cop_1"),
                    Idstring("units/payday2/characters/ene_cop_2/ene_cop_2"),
                    Idstring("units/payday2/characters/ene_cop_4/ene_cop_4")
                },
                russia = {
                    Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_r870/ene_akan_cs_cop_r870")
                },
                zombie = {
                    Idstring("units/pd2_dlc_hvh/characters/ene_cop_hvh_1/ene_cop_hvh_1"),
                    Idstring("units/pd2_dlc_hvh/characters/ene_cop_hvh_2/ene_cop_hvh_2"),
                    Idstring("units/pd2_dlc_hvh/characters/ene_cop_hvh_4/ene_cop_hvh_4")
                },
                murkywater = {
                    Idstring("units/payday2/characters/ene_cop_1/ene_cop_1"),
                    Idstring("units/payday2/characters/ene_cop_2/ene_cop_2"),
                    Idstring("units/payday2/characters/ene_cop_4/ene_cop_4")
                },
                federales = {
                    Idstring("units/payday2/characters/ene_cop_1/ene_cop_1"),
                    Idstring("units/payday2/characters/ene_cop_2/ene_cop_2"),
                    Idstring("units/payday2/characters/ene_cop_4/ene_cop_4")
                }
            },
            access = access_type_walk_only
        }

        self.unit_categories.CS_cop_stealth_MP5 = {
            unit_types = {
                america = {
                    Idstring("units/payday2/characters/ene_cop_3/ene_cop_3")
                },
                russia = {
                    Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_akmsu_smg/ene_akan_cs_cop_akmsu_smg")
                },
                zombie = {
                    Idstring("units/pd2_dlc_hvh/characters/ene_cop_hvh_3/ene_cop_hvh_3")
                },
                murkywater = {
                    Idstring("units/payday2/characters/ene_cop_3/ene_cop_3")
                },
                federales = {
                    Idstring("units/payday2/characters/ene_cop_3/ene_cop_3")
                }
            },
            access = access_type_walk_only
        }

        ----murky/federales crash fix provided by MY NAME IS JAMES
        self.unit_categories.FBI_suit_C45_M4.unit_types.murkywater = {
            Idstring("units/payday2/characters/ene_fbi_1/ene_fbi_1"),
            Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2")
        }

        self.unit_categories.FBI_suit_C45_M4.unit_types.federales = {
            Idstring("units/payday2/characters/ene_fbi_1/ene_fbi_1"),
            Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2")
        }

        self.unit_categories.FBI_suit_M4_MP5.unit_types.murkywater = {
            Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2"),
            Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
        }

        self.unit_categories.FBI_suit_M4_MP5.unit_types.federales = {
            Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2"),
            Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
        }
        ----

        if difficulty_index < 6 then
            self.unit_categories.FBI_swat_R870 = {
                unit_types = {
                    america = {
                        Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2")
                    },
                    russia = {
                        Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_r870/ene_akan_fbi_swat_r870")
                    },
                    zombie = {
                        Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_2/ene_fbi_swat_hvh_2")
                    },
                    murkywater = {
                        Idstring("units/pd2_dlc_bph/characters/ene_murkywater_light_r870/ene_murkywater_light_r870")
                    },
                    federales = {
                        Idstring(
                        "units/pd2_dlc_bex/characters/ene_swat_policia_federale_r870/ene_swat_policia_federale_r870")
                    }
                },
                access = access_type_all
            }
        else
            self.unit_categories.FBI_swat_R870 = {
                unit_types = {
                    america = {
                        Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2"),
                        Idstring("units/payday2/characters/ene_city_swat_3/ene_city_swat_3")
                    },
                    russia = {
                        Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_r870/ene_akan_fbi_swat_dw_r870")
                    },
                    zombie = {
                        Idstring("units/pd2_dlc_hvh/characters/ene_fbi_swat_hvh_2/ene_fbi_swat_hvh_2")
                    },
                    murkywater = {
                        Idstring(
                        "units/pd2_dlc_bph/characters/ene_murkywater_light_city_r870/ene_murkywater_light_city_r870")
                    },
                    federales = {
                        Idstring(
                        "units/pd2_dlc_bex/characters/ene_swat_policia_federale_city_r870/ene_swat_policia_federale_city_r870")
                    }
                },
                access = access_type_all
            }
        end

        self.unit_categories.FBI_heavy_G36 = {
            unit_types = {
                america = {
                    Idstring("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1")
                },
                russia = {
                    Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36")
                },
                zombie = {
                    Idstring("units/pd2_dlc_hvh/characters/ene_fbi_heavy_hvh_1/ene_fbi_heavy_hvh_1")
                },
                murkywater = {
                    Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy_g36/ene_murkywater_heavy_g36")
                },
                federales = {
                    Idstring(
                    "units/pd2_dlc_bex/characters/ene_swat_heavy_policia_federale_fbi_g36/ene_swat_heavy_policia_federale_fbi_g36")
                }
            },
            access = access_type_all
        }

        if difficulty_index < 6 then
            self.unit_categories.FBI_tank = {
                special_type = "tank",
                unit_types = {
                    america = {
                        Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"),
                        Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2")
                    },
                    russia = {
                        Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870")
                    },
                    zombie = {
                        Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_1/ene_bulldozer_hvh_1")
                    },
                    murkywater = {
                        Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_2/ene_murkywater_bulldozer_2")
                    },
                    federales = {
                        Idstring(
                        "units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_saiga/ene_swat_dozer_policia_federale_saiga")
                    }
                },
                access = access_type_all
            }
        else
            self.unit_categories.FBI_tank = {
                special_type = "tank",
                unit_types = {
                    america = {
                        Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"),
                        Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3")
                    },
                    russia = {
                        Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"),
                        Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870")
                    },
                    zombie = {
                        Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_1/ene_bulldozer_hvh_1"),
                        Idstring("units/pd2_dlc_hvh/characters/ene_bulldozer_hvh_2/ene_bulldozer_hvh_2")
                    },
                    murkywater = {
                        Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_2/ene_murkywater_bulldozer_2"),
                        Idstring("units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_3/ene_murkywater_bulldozer_3")
                    },
                    federales = {
                        Idstring(
                        "units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_saiga/ene_swat_dozer_policia_federale_saiga"),
                        Idstring(
                        "units/pd2_dlc_bex/characters/ene_swat_dozer_policia_federale_r870/ene_swat_dozer_policia_federale_r870")
                    }
                },
                access = access_type_all
            }
        end
    end)

function GroupAITweakData:_init_enemy_spawn_groups(difficulty_index)
    self._tactics = {
        CS_cop = {
            "provide_coverfire",
            "provide_support",
            "ranged_fire"
        },
        CS_cop_stealth = {
            "flank",
            "provide_coverfire",
            "provide_support"
        },
        CS_swat_rifle = {
            "smoke_grenade",
            "charge",
            "provide_coverfire",
            "provide_support",
            "ranged_fire",
            "deathguard"
        },
        CS_swat_shotgun = {
            "smoke_grenade",
            "charge",
            "provide_coverfire",
            "provide_support",
            "shield_cover"
        },
        CS_swat_heavy = {
            "smoke_grenade",
            "charge",
            "flash_grenade",
            "provide_coverfire",
            "provide_support"
        },
        CS_shield = {
            "charge",
            "provide_coverfire",
            "provide_support",
            "shield",
            "deathguard"
        },
        CS_swat_rifle_flank = {
            "flank",
            "flash_grenade",
            "smoke_grenade",
            "charge",
            "provide_coverfire",
            "provide_support"
        },
        CS_swat_shotgun_flank = {
            "flank",
            "flash_grenade",
            "smoke_grenade",
            "charge",
            "provide_coverfire",
            "provide_support"
        },
        CS_swat_heavy_flank = {
            "flank",
            "flash_grenade",
            "smoke_grenade",
            "charge",
            "provide_coverfire",
            "provide_support",
            "shield_cover"
        },
        CS_shield_flank = {
            "flank",
            "charge",
            "flash_grenade",
            "provide_coverfire",
            "provide_support",
            "shield"
        },
        CS_tazer = {
            "flank",
            "charge",
            "flash_grenade",
            "shield_cover",
            "murder"
        },
        CS_sniper = {
            "ranged_fire",
            "provide_coverfire",
            "provide_support"
        },
        FBI_suit = {
            "flank",
            "ranged_fire",
            "flash_grenade"
        },
        FBI_suit_stealth = {
            "provide_coverfire",
            "provide_support",
            "flash_grenade",
            "flank"
        },
        FBI_swat_rifle = {
            "smoke_grenade",
            "flash_grenade",
            "provide_coverfire",
            "charge",
            "provide_support",
            "ranged_fire"
        },
        FBI_swat_shotgun = {
            "smoke_grenade",
            "flash_grenade",
            "charge",
            "provide_coverfire",
            "provide_support"
        },
        FBI_heavy = {
            "smoke_grenade",
            "flash_grenade",
            "charge",
            "provide_coverfire",
            "provide_support",
            "shield_cover",
            "deathguard"
        },
        FBI_shield = {
            "smoke_grenade",
            "charge",
            "provide_coverfire",
            "provide_support",
            "shield",
            "deathguard"
        },
        FBI_swat_rifle_flank = {
            "flank",
            "smoke_grenade",
            "flash_grenade",
            "charge",
            "provide_coverfire",
            "provide_support"
        },
        FBI_swat_shotgun_flank = {
            "flank",
            "smoke_grenade",
            "flash_grenade",
            "charge",
            "provide_coverfire",
            "provide_support"
        },
        FBI_heavy_flank = {
            "flank",
            "smoke_grenade",
            "flash_grenade",
            "charge",
            "provide_coverfire",
            "provide_support",
            "shield_cover"
        },
        FBI_shield_flank = {
            "flank",
            "smoke_grenade",
            "flash_grenade",
            "charge",
            "provide_coverfire",
            "provide_support",
            "shield"
        },
        FBI_tank = {
            "charge",
            "deathguard",
            "shield_cover",
            "smoke_grenade"
        },
        spooc = {
            "charge",
            "shield_cover",
            "smoke_grenade",
            "flash_grenade"
        }
    }
    self.enemy_spawn_groups = {}
    self.enemy_spawn_groups.CS_defend_a = {
        amount = { 3, 4 },
        spawn = {
            {
                unit = "CS_cop_C45_R870",
                freq = 1,
                tactics = self._tactics.CS_cop,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.CS_defend_b = {
        amount = { 3, 4 },
        spawn = {
            {
                unit = "CS_swat_MP5",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.CS_cop,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.CS_defend_c = {
        amount = { 3, 4 },
        spawn = {
            {
                unit = "CS_heavy_M4",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.CS_cop,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.CS_cops = {
        amount = { 3, 4 },
        spawn = {
            {
                unit = "CS_cop_C45_R870",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.CS_cop,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.CS_stealth_a = {
        amount = { 2, 3 },
        spawn = {
            {
                unit = "CS_cop_stealth_MP5",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.CS_cop_stealth,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.CS_swats = {
        amount = { 3, 4 },
        spawn = {
            {
                unit = "CS_swat_MP5",
                freq = 1,
                tactics = self._tactics.CS_swat_rifle,
                rank = 2
            },
            {
                unit = "CS_swat_R870",
                freq = 0.5,
                amount_max = 2,
                tactics = self._tactics.CS_swat_shotgun,
                rank = 1
            },
            {
                unit = "CS_swat_MP5",
                freq = 0.33,
                tactics = self._tactics.CS_swat_rifle_flank,
                rank = 3
            }
        }
    }
    self.enemy_spawn_groups.CS_heavys = {
        amount = { 3, 4 },
        spawn = {
            {
                unit = "CS_heavy_M4",
                freq = 1,
                tactics = self._tactics.CS_swat_rifle,
                rank = 2
            },
            {
                unit = "CS_heavy_M4",
                freq = 0.35,
                tactics = self._tactics.CS_swat_rifle_flank,
                rank = 3
            }
        }
    }
    self.enemy_spawn_groups.CS_shields = {
        amount = { 3, 4 },
        spawn = {
            {
                unit = "CS_shield",
                freq = 1,
                amount_min = 1,
                amount_max = 2,
                tactics = self._tactics.CS_shield,
                rank = 3
            },
            {
                unit = "CS_cop_C45_R870",
                freq = 0.5,
                amount_max = 1,
                tactics = self._tactics.CS_cop_stealth,
                rank = 1
            },
            {
                unit = "CS_heavy_M4_w",
                freq = 0.75,
                amount_max = 1,
                tactics = self._tactics.CS_swat_heavy,
                rank = 2
            }
        }
    }
    if difficulty_index < 6 then
        self.enemy_spawn_groups.CS_tazers = {
            amount = { 1, 3 },
            spawn = {
                {
                    unit = "CS_tazer",
                    freq = 1,
                    amount_min = 1,
                    amount_max = 1,
                    tactics = self._tactics.CS_tazer,
                    rank = 2
                },
                {
                    unit = "CS_swat_MP5",
                    freq = 1,
                    amount_max = 2,
                    tactics = self._tactics.CS_cop_stealth,
                    rank = 1
                }
            }
        }
    else
        self.enemy_spawn_groups.CS_tazers = {
            amount = { 4, 4 },
            spawn = {
                {
                    unit = "CS_tazer",
                    freq = 1,
                    amount_min = 3,
                    tactics_ = self._tactics.CS_tazer,
                    rank = 1
                },
                {
                    unit = "FBI_shield",
                    freq = 1,
                    amount_min = 2,
                    amount_max = 3,
                    tactics = self._tactics.FBI_shield,
                    rank = 3
                },
                {
                    unit = "FBI_heavy_G36",
                    freq = 1,
                    amount_max = 2,
                    tactics = self._tactics.FBI_swat_rifle,
                    rank = 1
                }
            }
        }
    end
    self.enemy_spawn_groups.CS_tanks = {
        amount = { 1, 2 },
        spawn = {
            {
                unit = "FBI_tank",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.FBI_tank,
                rank = 2
            },
            {
                unit = "CS_tazer",
                freq = 0.5,
                amount_max = 1,
                tactics = self._tactics.CS_tazer,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.FBI_defend_a = {
        amount = { 3, 3 },
        spawn = {
            {
                unit = "FBI_suit_C45_M4",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.FBI_suit,
                rank = 2
            },
            {
                unit = "CS_cop_C45_R870",
                freq = 1,
                tactics = self._tactics.FBI_suit,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.FBI_defend_b = {
        amount = { 3, 3 },
        spawn = {
            {
                unit = "FBI_suit_M4_MP5",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.FBI_suit,
                rank = 2
            },
            {
                unit = "FBI_swat_M4",
                freq = 1,
                tactics = self._tactics.FBI_suit,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.FBI_defend_c = {
        amount = { 3, 3 },
        spawn = {
            {
                unit = "FBI_swat_M4",
                freq = 1,
                tactics = self._tactics.FBI_suit,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.FBI_defend_d = {
        amount = { 2, 3 },
        spawn = {
            {
                unit = "FBI_heavy_G36",
                freq = 1,
                tactics = self._tactics.FBI_suit,
                rank = 1
            }
        }
    }
    if difficulty_index < 6 then
        self.enemy_spawn_groups.FBI_stealth_a = {
            amount = { 2, 3 },
            spawn = {
                {
                    unit = "FBI_suit_stealth_MP5",
                    freq = 1,
                    amount_min = 1,
                    tactics = self._tactics.FBI_suit_stealth,
                    rank = 1
                },
                {
                    unit = "CS_tazer",
                    freq = 1,
                    amount_max = 2,
                    tactics = self._tactics.CS_tazer,
                    rank = 2
                }
            }
        }
    else
        self.enemy_spawn_groups.FBI_stealth_a = {
            amount = { 3, 4 },
            spawn = {
                {
                    unit = "FBI_suit_stealth_MP5",
                    freq = 1,
                    amount_min = 1,
                    tactics = self._tactics.FBI_suit_stealth,
                    rank = 2
                },
                {
                    unit = "CS_tazer",
                    freq = 1,
                    amount_max = 2,
                    tactics = self._tactics.CS_tazer,
                    rank = 1
                }
            }
        }
    end
    if difficulty_index < 6 then
        self.enemy_spawn_groups.FBI_stealth_b = {
            amount = { 2, 3 },
            spawn = {
                {
                    unit = "FBI_suit_stealth_MP5",
                    freq = 1,
                    amount_min = 1,
                    tactics = self._tactics.FBI_suit_stealth,
                    rank = 1
                },
                {
                    unit = "FBI_suit_M4_MP5",
                    freq = 0.75,
                    tactics = self._tactics.FBI_suit,
                    rank = 2
                }
            }
        }
    else
        self.enemy_spawn_groups.FBI_stealth_b = {
            amount = { 4, 4 },
            spawn = {
                {
                    unit = "FBI_suit_stealth_MP5",
                    freq = 1,
                    amount_min = 1,
                    tactics = self._tactics.FBI_suit_stealth,
                    rank = 1
                },
                {
                    unit = "FBI_suit_M4_MP5",
                    freq = 0.75,
                    tactics = self._tactics.FBI_suit_stealth,
                    rank = 2
                }
            }
        }
    end
    if difficulty_index < 6 then
        self.enemy_spawn_groups.FBI_swats = {
            amount = { 3, 4 },
            spawn = {
                {
                    unit = "FBI_swat_M4",
                    freq = 1,
                    amount_min = 1,
                    tactics = self._tactics.FBI_swat_rifle,
                    rank = 2
                },
                {
                    unit = "FBI_swat_M4",
                    freq = 0.75,
                    tactics = self._tactics.FBI_swat_rifle_flank,
                    rank = 3
                },
                {
                    unit = "FBI_swat_R870",
                    freq = 0.5,
                    amount_max = 2,
                    tactics = self._tactics.FBI_swat_shotgun,
                    rank = 1
                },
                {
                    unit = "spooc",
                    freq = 0.15,
                    amount_max = 2,
                    tactics = self._tactics.spooc,
                    rank = 1
                }
            }
        }
    else
        self.enemy_spawn_groups.FBI_swats = {
            amount = { 3, 4 },
            spawn = {
                {
                    unit = "FBI_swat_M4",
                    freq = 1,
                    amount_min = 3,
                    tactics = self._tactics.FBI_swat_rifle,
                    rank = 1
                },
                {
                    unit = "FBI_suit_M4_MP5",
                    freq = 1,
                    tactics = self._tactics.FBI_swat_rifle_flank,
                    rank = 2
                },
                {
                    unit = "FBI_swat_R870",
                    amount_min = 2,
                    freq = 1,
                    tactics = self._tactics.FBI_swat_shotgun,
                    rank = 3
                }
            }
        }
    end
    if difficulty_index < 6 then
        self.enemy_spawn_groups.FBI_heavys = {
            amount = { 2, 3 },
            spawn = {
                {
                    unit = "FBI_heavy_G36",
                    freq = 1,
                    tactics = self._tactics.FBI_swat_rifle,
                    rank = 1
                },
                {
                    unit = "FBI_heavy_G36",
                    freq = 0.75,
                    tactics = self._tactics.FBI_swat_rifle_flank,
                    rank = 2
                },
                {
                    unit = "CS_tazer",
                    freq = 0.25,
                    amount_max = 1,
                    tactics = self._tactics.CS_tazer,
                    rank = 3
                }
            }
        }
    else
        self.enemy_spawn_groups.FBI_heavys = {
            amount = { 3, 4 },
            spawn = {
                {
                    unit = "FBI_heavy_G36_w",
                    freq = 1,
                    amount_min = 4,
                    tactics = self._tactics.FBI_swat_rifle,
                    rank = 1
                },
                {
                    unit = "FBI_swat_M4",
                    freq = 1,
                    amount_min = 3,
                    tactics = self._tactics.FBI_heavy_flank,
                    rank = 2
                }
            }
        }
    end
    if difficulty_index < 6 then
        self.enemy_spawn_groups.FBI_shields = {
            amount = { 3, 4 },
            spawn = {
                {
                    unit = "FBI_shield",
                    freq = 1,
                    amount_min = 1,
                    amount_max = 2,
                    tactics = self._tactics.FBI_shield_flank,
                    rank = 3
                },
                {
                    unit = "CS_tazer",
                    freq = 0.75,
                    amount_max = 1,
                    tactics = self._tactics.CS_tazer,
                    rank = 2
                },
                {
                    unit = "FBI_heavy_G36",
                    freq = 0.5,
                    amount_max = 1,
                    tactics = self._tactics.FBI_swat_rifle_flank,
                    rank = 1
                }
            }
        }
    else
        self.enemy_spawn_groups.FBI_shields = {
            amount = { 3, 4 },
            spawn = {
                {
                    unit = "FBI_shield",
                    freq = 1,
                    amount_min = 3,
                    amount_max = 4,
                    tactics = self._tactics.FBI_shield,
                    rank = 3
                },
                {
                    unit = "FBI_suit_stealth_MP5",
                    freq = 1,
                    amount_min = 1,
                    tactics = self._tactics.FBI_suit_stealth,
                    rank = 1
                },
                {
                    unit = "spooc",
                    freq = 0.15,
                    amount_max = 2,
                    tactics = self._tactics.spooc,
                    rank = 1
                },
                {
                    unit = "CS_tazer",
                    freq = 0.75,
                    amount_min = 2,
                    tactics = self._tactics.CS_swat_heavy,
                    rank = 2
                }
            }
        }
    end
    if difficulty_index < 6 then
        self.enemy_spawn_groups.FBI_tanks = {
            amount = { 3, 4 },
            spawn = {
                {
                    unit = "FBI_tank",
                    freq = 1,
                    amount_max = 1,
                    tactics = self._tactics.FBI_tank,
                    rank = 1
                },
                {
                    unit = "FBI_shield",
                    freq = 0.5,
                    amount_min = 1,
                    amount_max = 2,
                    tactics = self._tactics.FBI_shield_flank,
                    rank = 3
                },
                {
                    unit = "FBI_heavy_G36_w",
                    freq = 0.75,
                    amount_min = 1,
                    tactics = self._tactics.FBI_heavy_flank,
                    rank = 1
                }
            }
        }
    else
        self.enemy_spawn_groups.FBI_tanks = {
            amount = { 4, 4 },
            spawn = {
                {
                    unit = "FBI_tank",
                    freq = 1,
                    amount_min = 2,
                    tactics = self._tactics.FBI_tank,
                    rank = 3
                },
                {
                    unit = "FBI_shield",
                    freq = 1,
                    amount_min = 1,
                    amount_max = 2,
                    tactics = self._tactics.FBI_shield,
                    rank = 3
                },
                {
                    unit = "CS_tazer",
                    freq = 0.75,
                    amount_min = 1,
                    tactics = self._tactics.FBI_swat_rifle,
                    rank = 2
                }
            }
        }
    end
    self.enemy_spawn_groups.single_spooc = {
        amount = { 1, 1 },
        spawn = {
            {
                unit = "spooc",
                freq = 1,
                amount_min = 1,
                tactics = self._tactics.spooc,
                rank = 1
            }
        }
    }
    self.enemy_spawn_groups.FBI_spoocs = self.enemy_spawn_groups.single_spooc
end

Hooks:PostHook(GroupAITweakData, "_init_task_data", "restore_init_task_data",
    function(self, difficulty_index, difficulty)
        if difficulty_index < 6 then
            self.smoke_grenade_lifetime = 7.5
        else
            self.smoke_grenade_lifetime = 12
        end

        if difficulty_index >= 6 then
            self.besiege.recurring_group_SO = {
                recurring_cloaker_spawn = {
                    interval = { 20, 40 },
                    retire_delay = 30
                },
                recurring_spawn_1 = {
                    interval = { 30, 60 }
                }
            }
        end

        self.besiege.assault.sustain_duration_min = {
            0,
            80,
            120
        }
        self.besiege.assault.sustain_duration_max = {
            0,
            80,
            120
        }

        if difficulty_index <= 2 then
            self.besiege.assault.delay = {
                80,
                70,
                30
            }
        elseif difficulty_index == 3 then
            self.besiege.assault.delay = {
                45,
                35,
                20
            }
        elseif difficulty_index == 4 then
            self.besiege.assault.delay = {
                40,
                30,
                20
            }
        elseif difficulty_index == 5 then
            self.besiege.assault.delay = {
                30,
                20,
                15
            }
        else
            self.besiege.assault.delay = {
                20,
                15,
                10
            }
        end

        self.besiege.assault.force = {
            0,
            5,
            7
        }
        self.besiege.assault.force_pool = {
            0,
            20,
            50
        }

        if difficulty_index <= 2 then
            self.besiege.assault.force_balance_mul = {
                0.9,
                1.5,
                2,
                2.25
            }
            self.besiege.assault.force_pool_balance_mul = {
                1,
                1.5,
                2,
                3
            }
        elseif difficulty_index == 3 then
            self.besiege.assault.force_balance_mul = {
                1,
                1.4,
                1.6,
                1.9
            }
            self.besiege.assault.force_pool_balance_mul = {
                1.2,
                1.4,
                1.6,
                1.9
            }
        elseif difficulty_index == 4 then
            self.besiege.assault.force_balance_mul = {
                1.4,
                1.8,
                2,
                2.4
            }
            self.besiege.assault.force_pool_balance_mul = {
                1.7,
                2,
                2.2,
                2.5
            }
        elseif difficulty_index == 5 then
            self.besiege.assault.force_balance_mul = {
                2,
                2.5,
                2.9,
                3.2
            }
            self.besiege.assault.force_pool_balance_mul = {
                2.2,
                2.4,
                2.6,
                3
            }
        else
            self.besiege.assault.force_balance_mul = {
                4,
                4.2,
                4.5,
                4.9
            }
            self.besiege.assault.force_pool_balance_mul = {
                3,
                5,
                7,
                9
            }
        end

        if difficulty_index <= 2 then
            self.besiege.assault.groups = {
                CS_swats = {
                    0,
                    1,
                    0.7
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        elseif difficulty_index == 3 then
            self.besiege.assault.groups = {
                CS_swats = {
                    0,
                    1,
                    0
                },
                CS_heavys = {
                    0,
                    0.2,
                    0.7
                },
                CS_shields = {
                    0,
                    0.02,
                    0.2
                },
                CS_tazers = {
                    0,
                    0.05,
                    0.15
                },
                CS_tanks = {
                    0,
                    0.01,
                    0.05
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        elseif difficulty_index == 4 then
            self.besiege.assault.groups = {
                FBI_swats = {
                    0.1,
                    1,
                    1
                },
                FBI_heavys = {
                    0.05,
                    0.25,
                    0.5
                },
                FBI_shields = {
                    0.1,
                    0.2,
                    0.2
                },
                FBI_tanks = {
                    0,
                    0.1,
                    0.15
                },
                FBI_spoocs = {
                    0,
                    0.1,
                    0.2
                },
                CS_tazers = {
                    0.05,
                    0.15,
                    0.2
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        elseif difficulty_index == 5 then
            self.besiege.assault.groups = {
                FBI_swats = {
                    0.2,
                    1,
                    1
                },
                FBI_heavys = {
                    0.1,
                    0.5,
                    0.75
                },
                FBI_shields = {
                    0.1,
                    0.3,
                    0.4
                },
                FBI_tanks = {
                    0,
                    0.25,
                    0.3
                },
                CS_tazers = {
                    0.1,
                    0.25,
                    0.25
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        else
            self.besiege.assault.groups = {
                FBI_swats = {
                    0.2,
                    0.8,
                    0.8
                },
                FBI_heavys = {
                    0.1,
                    0.3,
                    0.4
                },
                FBI_shields = {
                    0.1,
                    0.5,
                    0.4
                },
                FBI_tanks = {
                    0.1,
                    0.5,
                    0.5
                },
                CS_tazers = {
                    0.1,
                    0.5,
                    0.45
                },
                FBI_spoocs = {
                    0,
                    0.45,
                    0.45
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        end

        self.besiege.assault.groups.single_spooc = {
            0,
            0,
            0
        }
        self.besiege.assault.groups.Phalanx = {
            0,
            0,
            0
        }

        if difficulty_index <= 2 then
            self.besiege.reenforce.groups = {
                CS_defend_a = {
                    1,
                    0.2,
                    0
                },
                CS_defend_b = {
                    0,
                    1,
                    1
                }
            }
        elseif difficulty_index == 3 then
            self.besiege.reenforce.groups = {
                CS_defend_a = {
                    1,
                    0,
                    0
                },
                CS_defend_b = {
                    2,
                    1,
                    0
                },
                CS_defend_c = {
                    0,
                    0,
                    1
                }
            }
        elseif difficulty_index == 4 then
            self.besiege.reenforce.groups = {
                CS_defend_a = {
                    1,
                    0,
                    0
                },
                CS_defend_b = {
                    2,
                    1,
                    0
                },
                CS_defend_c = {
                    0,
                    0,
                    1
                },
                FBI_defend_a = {
                    0,
                    1,
                    0
                },
                FBI_defend_b = {
                    0,
                    0,
                    1
                }
            }
        elseif difficulty_index == 5 then
            self.besiege.reenforce.groups = {
                CS_defend_a = {
                    0.1,
                    0,
                    0
                },
                FBI_defend_b = {
                    1,
                    1,
                    0
                },
                FBI_defend_c = {
                    0,
                    1,
                    0
                },
                FBI_defend_d = {
                    0,
                    0,
                    1
                }
            }
        else
            self.besiege.reenforce.groups = {
                CS_defend_a = {
                    0.1,
                    0,
                    0
                },
                FBI_defend_b = {
                    1,
                    1,
                    0
                },
                FBI_defend_c = {
                    0,
                    1,
                    0
                },
                FBI_defend_d = {
                    0,
                    0,
                    1
                }
            }
        end

        if difficulty_index <= 2 then
            self.besiege.recon.groups = {
                CS_stealth_a = {
                    1,
                    1,
                    0
                },
                CS_swats = {
                    0,
                    1,
                    1
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        elseif difficulty_index == 3 then
            self.besiege.recon.groups = {
                CS_stealth_a = {
                    1,
                    0,
                    0
                },
                CS_swats = {
                    0,
                    1,
                    1
                },
                CS_tazers = {
                    0,
                    0.1,
                    0.15
                },
                FBI_stealth_b = {
                    0,
                    0,
                    0.1
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        elseif difficulty_index == 4 then
            self.besiege.recon.groups = {
                FBI_stealth_a = {
                    1,
                    0.5,
                    0
                },
                FBI_stealth_b = {
                    0,
                    0,
                    1
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        elseif difficulty_index == 5 then
            self.besiege.recon.groups = {
                FBI_stealth_a = {
                    0.5,
                    1,
                    1
                },
                FBI_stealth_b = {
                    0.25,
                    0.5,
                    1
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        else
            self.besiege.recon.groups = {
                FBI_stealth_a = {
                    0.5,
                    1,
                    1
                },
                FBI_stealth_b = {
                    0.25,
                    0.5,
                    1
                },
                single_spooc = {
                    0,
                    0,
                    0
                }
            }
        end

        self.besiege.recon.groups.single_spooc = {
            0,
            0,
            0
        }
        self.besiege.recon.groups.Phalanx = {
            0,
            0,
            0
        }

        self.besiege.cloaker.groups = {
            single_spooc = {
                1,
                1,
                1
            }
        }

        self.phalanx.spawn_chance = {
            decrease = 0,
            start = 0,
            respawn_delay = 120,
            increase = 0,
            max = 0
        }

        self.street = deep_clone(self.besiege)
        self.safehouse = deep_clone(self.besiege)
    end)
