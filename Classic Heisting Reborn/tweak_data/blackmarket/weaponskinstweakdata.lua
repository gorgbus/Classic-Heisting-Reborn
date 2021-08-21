function BlackMarketTweakData:create_new_color_skin(name, data, color_skin_data)
	data.name_id = "bm_wskn_" .. name
	data.rarity = "common"
	data.weapon_ids = {
		"akm_gold"
	}

	table.insert(data.weapon_ids, "money")

	data.use_blacklist = true
	data.is_a_unlockable = true
	data.is_a_color_skin = true
	data.group_id = data.global_value_category or data.global_value or data.dlc or "normal"
	data.color_skin_data = color_skin_data

	if not table.contains(self.weapon_color_groups, data.group_id) then
		table.insert(self.weapon_color_groups, data.group_id)
	end

	self.weapon_skins[name] = data

    local blacklist = {
        "color_anv_02",
        "color_anv_03",
        "color_anv_04",
        "color_anv_05",
        "color_red_crust",
        "color_purple_song",
        "color_pink_cat",
        "color_orange_mellow",
        "color_green_mellow",
        "color_green_deluxe",
        "color_blue_teal",
        "color_blue_ice",
        "color_blue_deluxe",
        "color_blue_deep",
        "color_inf_01",
        "color_inf_02",
        "color_inf_03",
        "color_inf_04",
        "color_inf_05",
        "color_inf_06",
        "color_inf_07",
        "color_inf_08",
        "color_inf_09",
        "color_inf_10",
        "color_inf_11",
        "color_inf_12",
        "color_inf_13",
        "color_inf_14",
        "color_inf_15",
        "color_inf_16",
        "color_in31_01",
        "color_in31_02",
        "color_in31_03",
        "color_in31_04",
        "color_in31_05",
        "color_in31_06",
        "color_in31_07",
        "color_in31_08",
        "color_in32_01",
        "color_in32_02",
        "color_in32_03",
        "color_in32_04",
        "color_in32_05",
        "color_in32_06",
        "color_in32_07",
        "color_in32_08",
        "color_in32_09",
    }

    local function has_id(tab, val)
        for index, value in ipairs(tab) do
            if value == val then
                return true
            end
        end

        return false
    end

    if not has_id(blacklist, name) then
        table.insert(self.weapon_colors, name)
    end
end