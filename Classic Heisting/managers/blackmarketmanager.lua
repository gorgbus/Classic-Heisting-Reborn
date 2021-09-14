function BlackMarketManager:outfit_string()
    local s = ""
	s = s .. self:_outfit_string_mask()
	local armor_id = tostring(self:equipped_armor(false))
	local current_armor_id = tostring(self:equipped_armor(true))
	local current_state_armor_id = tostring(self:equipped_armor(true, true))
	s = s .. " " .. armor_id .. "-" .. current_armor_id .. "-" .. current_state_armor_id
	s = s .. "-" .. tostring(self:equipped_armor_skin())
	s = s .. "-" .. tostring(self:equipped_player_style()) .. "-" .. tostring(self:get_suit_variation())
	s = s .. "-" .. tostring(self:equipped_glove_id())

	for character_id, data in pairs(tweak_data.blackmarket.characters) do
		if Global.blackmarket_manager.characters[character_id].equipped then
			s = s .. " " .. character_id
		end
	end

	local equipped_primary = self:equipped_primary()

	if equipped_primary then
		local primary_string = managers.weapon_factory:blueprint_to_string(equipped_primary.factory_id, equipped_primary.blueprint)
		primary_string = string.gsub(primary_string, " ", "_")
		s = s .. " " .. equipped_primary.factory_id .. " " .. primary_string
	else
		s = s .. " " .. "nil" .. " " .. "0"
	end

	local equipped_secondary = self:equipped_secondary()

	if equipped_secondary then
		local secondary_string = managers.weapon_factory:blueprint_to_string(equipped_secondary.factory_id, equipped_secondary.blueprint)
		secondary_string = string.gsub(secondary_string, " ", "_")
		s = s .. " " .. equipped_secondary.factory_id .. " " .. secondary_string
	else
		s = s .. " " .. "nil" .. " " .. "0"
	end

	local equipped_deployable = self:equipped_deployable()

	if equipped_deployable then
		s = s .. " " .. tostring(equipped_deployable)
		local deployable_tweak_data = tweak_data.equipments[equipped_deployable]

		if equipped_deployable == "sentry_gun_silent" then
			equipped_deployable = "sentry_gun"
		end
        
        amount = (deployable_tweak_data.quantity[1] or 0)

        if equipped_deployable == "trip_mine" then
            upgrades = Global.player_manager.upgrades[equipped_deployable]
            if not upgrades then
            else
                if upgrades["quantity_1"] then
                    amount = amount + 1
                end

                if upgrades["quantity_3"] then
                    amount = amount + 3
                end
            end
        else
            amount = (deployable_tweak_data.quantity[1] or 0) + managers.player:equiptment_upgrade_value(equipped_deployable, "quantity")
        end

		s = s .. " " .. tostring(amount)
	else
		s = s .. " " .. "nil" .. " " .. "0"
	end

	local secondary_deployable = self:equipped_deployable(2)

	if secondary_deployable then
		s = s .. " " .. tostring(secondary_deployable)
		local deployable_tweak_data = tweak_data.equipments[secondary_deployable]

		if secondary_deployable == "sentry_gun_silent" then
			secondary_deployable = "sentry_gun"
		end

		local amount = (deployable_tweak_data.quantity[1] or 0) + managers.player:equiptment_upgrade_value(secondary_deployable, "quantity")
		s = s .. " " .. tostring(amount)
	else
		s = s .. " " .. "nil" .. " " .. "0"
	end

	local concealment_modifier = -self:visibility_modifiers() or 0
	s = s .. " " .. tostring(concealment_modifier)
	local equipped_melee_weapon = self:equipped_melee_weapon()
	s = s .. " " .. tostring(equipped_melee_weapon)
	local equipped_grenade = self:equipped_grenade()
	s = s .. " " .. tostring(equipped_grenade)
	s = s .. " " .. tostring(managers.skilltree:pack_to_string())
	s = s .. " " .. self:outfit_string_from_cosmetics(equipped_primary and equipped_primary.cosmetics)
	s = s .. " " .. self:outfit_string_from_cosmetics(equipped_secondary and equipped_secondary.cosmetics)

	return s
end

function BlackMarketManager:accuracy_multiplier(name, categories, silencer, current_state, spread_moving, fire_mode, blueprint, is_single_shot)
	local multiplier = 1
	for _, category in ipairs(categories) do
		multiplier = multiplier + 1 - managers.player:upgrade_value(category, "spread_multiplier", 1)
	end

	if silencer then
		multiplier = multiplier + 1 - managers.player:upgrade_value("weapon", "silencer_spread_multiplier", 1)

		for _, category in ipairs(categories) do
			multiplier = multiplier + 1 - managers.player:upgrade_value(category, "silencer_spread_multiplier", 1)
		end
	end

	if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
		multiplier = multiplier + 1 - managers.player:upgrade_value("weapon", "modded_spread_multiplier", 1)
	end

	return self:_convert_add_to_mul(multiplier)
end

function BlackMarketManager:set_equipped_player_style(player_style, loading)
	Global.blackmarket_manager.equipped_player_style = player_style

	if not loading then
		if managers.menu_scene then
			managers.menu_scene:set_character_player_style(player_style, self:get_suit_variation(player_style))
		end

		MenuCallbackHandler:_update_outfit_information()

		if SystemInfo:distribution() == Idstring("STEAM") then
			managers.statistics:publish_equipped_to_steam()
		end
	end

	return true
end

function BlackMarketManager:set_suit_variation(player_style, material_variation, loading)
	player_style = player_style or self:equipped_player_style()

	Global.blackmarket_manager.player_styles[player_style].equipped_material_variation = material_variation
	
	if not loading and (player_style == self:equipped_player_style() or player_style == (managers.menu_scene and managers.menu_scene:get_player_style())) then
		if managers.menu_scene then
			managers.menu_scene:set_character_player_style(player_style, material_variation)
		end
		MenuCallbackHandler:_update_outfit_information()
		if SystemInfo:distribution() == Idstring("STEAM") then
			managers.statistics:publish_equipped_to_steam()
		end
	end

	return true
end

function BlackMarketManager:set_equipped_glove_id(glove_id, loading)
	Global.blackmarket_manager.equipped_glove_id = glove_id
	
	if not loading then
		if managers.menu_scene then
			managers.menu_scene:set_character_gloves(glove_id)
		end
		MenuCallbackHandler:_update_outfit_information()
		if SystemInfo:distribution() == Idstring("STEAM") then
			managers.statistics:publish_equipped_to_steam()
		end
	end

	return true
end