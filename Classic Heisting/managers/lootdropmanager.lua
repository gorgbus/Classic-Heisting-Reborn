Hooks:PostHook(LootDropManager, "add_qlvl_to_weapon_mods", "add_qlvl_to_weapon_modsPost", function(self)
    local whitelist = {
        --commando 553
        "bm_wp_ass_s552_b_long",
        "bm_wp_ass_s552_s_standard_green", 
        "bm_wp_ass_s552_fg_standard_green", 
        "bm_wp_ass_s552_g_standard_green",
        "bm_wp_ass_s552_fg_railed", 
        "bm_wp_ass_s552_body_standard_black",
        --eagle heavy
        "bm_wp_scar_b_short",
        "bm_wp_scar_b_long",
        "bm_wp_scar_fg_railext",
        "bm_wp_scar_s_sniper",
        --grip
        "bm_wp_upg_m4_g_mgrip",
        "bm_wp_m4_g_sniper",
        "bm_wp_m4_g_ergo",
        "bm_wp_upg_m4_g_hgrip",
        "bm_wp_hk21_g_ergo",
        "bm_wp_smg_m45_g_bling",
        "bm_wp_smg_m45_g_ergo",
        "bm_wp_pis_ppk_g_laser",
        "bm_wp_p226_g_ergo",
        "bm_wp_1911_g_ergo",
        "bm_wp_1911_g_bling",
        "bm_wp_beretta_g_ergo",
        "bm_wp_rage_g_ergo",
        "bm_wp_g18c_g_ergo",
        "bm_wp_deagle_g_ergo",
        "bm_wp_deagle_g_bling",
        --foregrip
        "bm_wp_ak_fg_combo2",
        "bm_wp_ak_fg_combo3",
        "bm_wp_m4_uupg_fg_lr300",
        "bm_wp_aug_fg_a3",
        "bm_wp_g36_fg_c",
        "bm_wp_g36_fg_ksk",
        "bm_wp_ak5_fg_ak5c",
        "bm_wp_ak5_fg_fnc",
        "bm_wp_m16_fg_railed",
        "bm_wp_m16_fg_vietnam",
        "bm_wp_r870_fg_wood",
        "bm_wp_saiga_fg_lowerrail",
        "bm_wp_rpk_fg_standard",
        "bm_wp_m249_fg_mk46",
        "bm_wp_hk21_fg_short",
        "bm_wp_mp5_fg_m5k",
        "bm_wp_mp5_fg_mp5a5",
        "bm_wp_mp5_fg_mp5sd",
        "bm_wp_olympic_fg_railed",
        "bm_wp_akmsu_fg_rail",
        --stock
        "bm_wp_m4_s_standard",
        "bm_wp_m4_s_pts",
        "bm_wp_ak_s_folding",
        "bm_wp_ak_s_psl",
        "bm_wp_m4_uupg_s_fold",
        "bm_wp_ak_s_skfoldable",
        "bm_wp_g36_s_kv",
        "bm_wp_g36_s_sl8",
        "bm_wp_m14_body_ebr",
        "bm_wp_m14_body_jae",
        "bm_wp_ak5_s_ak5b",
        "bm_wp_ak5_s_ak5c",
        "bm_wp_r870_s_nostock_single",
        "bm_wp_r870_s_nostock",
        "bm_wp_r870_s_nostock_big",
        "bm_wp_r870_s_solid_single",
        "bm_wp_r870_s_solid",
        "bm_wp_serbu_s_solid_short",
        "bm_wp_serbu_s_nostock_short",
        "bm_wp_r870_s_folding",
        "bm_wp_huntsman_s_short",
        "bm_wp_rpk_s_standard",
        "bm_wp_m249_s_solid",
        "bm_wp_smg_m45_s_folded",
        "bm_wp_mp7_s_long",
        "bm_wp_mac10_s_skel",
        "bm_wp_mp5_s_adjust",
        "bm_wp_mp5_s_ring",
        "bm_wp_mp9_s_skel",
        "bm_wp_olympic_s_short",
        "bm_wp_g18c_s_stock",
        --barrel
        "bm_wp_m4_uupg_b_long",
        "bm_wp_m4_uupg_b_short",
        "bm_wp_m4_uupg_b_sd",
        "bm_wp_aug_b_short",
        "bm_wp_aug_b_long",
        "bm_wp_huntsman_b_short",
        "bm_wp_m249_b_long",
        "bm_wp_hk21_b_long",
        "bm_wp_smg_m45_b_small",
        "bm_wp_smg_m45_b_green",
        "bm_wp_m4_uupg_b_medium",
        "bm_wp_p90_b_long",
        --mag
        "bm_wp_m4_m_pmag",
        "bm_wp_m4_m_straight",
        "bm_wp_m4_uupg_m_std",
        "bm_wp_r870_m_extended",
        "bm_wp_shorty_m_extended_short",
        "bm_wp_mp7_m_extended",
        "bm_wp_mac10_m_extended",
        "bm_wp_mp9_m_extended",
        "bm_wp_pis_usp_m_extended",
        "bm_wp_p226_m_extended",
        "bm_wp_1911_m_extended",
        "bm_wp_beretta_m_extended",
        "bm_wp_g18c_m_mag_33rnd",
        "bm_wp_deagle_m_extended",
        --receiver
        "bm_wp_m4_upper_reciever_edge",
        "bm_wp_r870_body_rack",
        "bm_wp_smg_m45_body_green",
        "bm_wp_rage_body_smooth",
        --gadget
        "bm_wp_upg_fl_ass_smg_sho_surefire",
        "bm_wp_upg_fl_ass_smg_sho_peqbox",
        "bm_wp_upg_fl_pis_tlr1",
        "bm_wp_upg_fl_pis_laser",
        --custom
        "bm_wp_upg_i_singlefire",
        "bm_wp_upg_i_autofire",
        --barrel ext
        "bm_wp_upg_ns_ass_smg_medium",
        "bm_wp_upg_ns_ass_smg_small",
        "bm_wp_upg_ns_ass_smg_stubby",
        "bm_wp_upg_ns_ass_smg_tank",
        "bm_wp_upg_ns_ass_smg_firepig",
        "bm_wp_upg_ns_ass_smg_large",
        "bm_wp_upg_ns_shot_shark",
        "bm_wp_upg_ns_shot_thick",
        "bm_wp_usp_co_comp_1",
        "bm_wp_usp_co_comp_2",
        "bm_wp_upg_ns_pis_medium",
        "bm_wp_upg_ns_pis_small",
        "bm_wp_upg_ns_pis_large",
        "bm_wp_1911_co_2",
        "bm_wp_1911_co_1",
        "bm_wp_beretta_co_co2",
        "bm_wp_beretta_co_co1",
        "bm_wp_g18c_co_1",
        "bm_wp_g18c_co_2",
        "bm_wp_deagle_co_short",
        "bm_wp_deagle_co_long",
        --sight
        "bm_wp_upg_o_eotech",
        "bm_wp_upg_o_t1micro",
        "bm_wp_upg_o_docter",
        "bm_wp_upg_o_acog",
        "bm_wp_upg_o_aimpoint",
        "bm_wp_upg_o_specter",
        "bm_wp_upg_o_cmore",
        "bm_wp_upg_o_marksmansight_rear",
        --slide
        "bm_wp_pis_usp_b_expert",
        "bm_wp_pis_usp_b_match",
        "bm_wp_pis_ppk_b_long",
        "bm_wp_p226_b_equinox",
        "bm_wp_p226_b_long",
        "bm_wp_1911_b_long",
        "bm_wp_1911_b_vented",
        "bm_wp_beretta_sl_brigadier",
        "bm_wp_rage_b_comp1",
        "bm_wp_rage_b_short",
        "bm_wp_rage_b_comp2",
        "bm_wp_rage_b_long",
    }

    for item, item_tweak in pairs(tweak_data.blackmarket.weapon_mods) do
        if not table.contains(whitelist, item_tweak.name_id) then
            tweak_data.blackmarket.weapon_mods[item].qlvl = 101
        end
    end
end)
if _G.ch_settings.settings.u24_progress then
    Hooks:PostHook(LootDropManager, "_setup", "remove_masks", function(self)
        local masks = {
            "bm_msk_character_locked",
            "bm_msk_skull",
            "bm_msk_wolf_clean",
            "bm_msk_hoxton_clean",
            "bm_msk_dallas_clean",
            "bm_msk_chains_clean",
            "bm_msk_dallas",
            "bm_msk_hoxton",
            "bm_msk_chains",
            "bm_msk_wolf",
            "bm_msk_cthulhu",
            "bm_msk_grin",
            "bm_msk_anonymous",
            "bm_msk_dillinger_death_mask",
            "bm_msk_alienware",
            "bm_msk_greek_tragedy",
            "bm_msk_jaw",
            "bm_msk_hockey",
            "bm_msk_bear",
            "bm_msk_troll",
            "bm_msk_gagball",
            "bm_msk_tounge",
            "bm_msk_zipper",
            "bm_msk_biglips",
            "bm_msk_clowncry",
            "bm_msk_mr_sinister",
            "bm_msk_clown_56",
            "bm_msk_buha",
            "bm_msk_dripper",
            "bm_msk_shogun",
            "bm_msk_oni",
            "bm_msk_monkeybiss",
            "bm_msk_babyrhino",
            "bm_msk_hog",
            "bm_msk_outlandish_a",
            "bm_msk_outlandish_b",
            "bm_msk_outlandish_c",
            "bm_msk_bullet",
            "bm_msk_shrunken",
            "bm_msk_brainiack",
            "bm_msk_zombie",
            "bm_msk_scarecrow",
            "bm_msk_mummy",
            "bm_msk_vampire",
            "bm_msk_day_of_the_dead",
            "bm_msk_dawn_of_the_dead",
            "bm_msk_demon",
            "bm_msk_stonekisses",
            "bm_msk_demonictender",
            "bm_msk_kawaii",
            "bm_msk_irondoom",
            "bm_msk_rubber_male",
            "bm_msk_rubber_female",
            "bm_msk_heat",
            "bm_msk_clinton",
            "bm_msk_bush",
            "bm_msk_obama",
            "bm_msk_nixon",
            "bm_msk_goat",
            "bm_msk_panda",
            "bm_msk_pitbull",
            "bm_msk_eagle",
            "bm_msk_santa_happy",
            "bm_msk_santa_mad",
            "bm_msk_santa_drunk",
            "bm_msk_santa_surprise",
            "bm_msk_aviator",
            "bm_msk_ghost",
            "bm_msk_welder",
            "bm_msk_plague",
            "bm_msk_smoker",
            "bm_msk_cloth_commander",
            "bm_msk_gage_blade",
            "bm_msk_rambo",
            "bm_msk_deltaforce",
            "bm_msk_skullhard",
            "bm_msk_skullveryhard",
            "bm_msk_skulloverkill",
            "bm_msk_skulloverkillplus",
            "bm_msk_sms_01",
            "bm_msk_sms_02",
            "bm_msk_sms_03",
            "bm_msk_sms_04"
        }

        for item, item_tweak in pairs(tweak_data.blackmarket.masks) do
            if not table.contains(masks, item_tweak.name_id) then
                tweak_data.blackmarket.masks[item].qlvl = 101
            end
        end

        local allowed_dlc = {
			"armored_transport",
			"preorder",
			"gage_pack",
			"gage_pack_lmg"
		}

        for item, item_tweak in pairs(tweak_data.blackmarket.materials) do
            if item_tweak.global_value == "halloween" then
                tweak_data.blackmarket.materials[item].qlvl = 101
            end

            if item_tweak.dlc and not table.contains(allowed_dlc, item_tweak.dlc) then
                tweak_data.blackmarket.materials[item].qlvl = 101
            end
        end

        for item, item_tweak in pairs(tweak_data.blackmarket.textures) do
            if item_tweak.global_value == "halloween" then
                tweak_data.blackmarket.textures[item].qlvl = 101
            end

            if item_tweak.dlc and not table.contains(allowed_dlc, item_tweak.dlc) then
                tweak_data.blackmarket.textures[item].qlvl = 101
            end
        end
    end)
end