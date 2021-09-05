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

function BlackMarketManager:fire_rate_multiplier(name, category, silencer, detection_risk, current_state, blueprint)
	local multiplier = managers.player:upgrade_value(category, "fire_rate_multiplier", 1)
	multiplier = multiplier * managers.player:upgrade_value(name, "fire_rate_multiplier", 1)
	return multiplier
end

function BlackMarketManager:damage_multiplier(name, category, silencer, detection_risk, current_state, blueprint)
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "damage_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(name, "damage_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "passive_damage_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "passive_damage_multiplier", 1))
	if silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_damage_multiplier", 1))
	end

	local detection_risk_damage_multiplier = managers.player:upgrade_value("player", "detection_risk_damage_multiplier")
	multiplier = multiplier - managers.player:get_value_from_risk_upgrade(detection_risk_damage_multiplier, detection_risk)
	if managers.player:has_category_upgrade("player", "overkill_health_to_damage_multiplier") then
		local damage_ratio = managers.player:upgrade_value("player", "overkill_health_to_damage_multiplier", 1) - 1
		multiplier = multiplier + damage_ratio
	end

	if not current_state or current_state:in_steelsight() then
	else
		multiplier = multiplier + (1 - managers.player:upgrade_value(category, "hip_fire_damage_multiplier", 1))
	end

	if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "modded_damage_multiplier", 1))
	end

	return self:_convert_add_to_mul(multiplier)
end

function BlackMarketManager:recoil_multiplier(name, category, silencer, blueprint)
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "passive_recoil_multiplier", 1))
	if managers.player:player_unit() and managers.player:player_unit():character_damage():is_suppressed() then
		if managers.player:has_team_category_upgrade(category, "suppression_recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value(category, "suppression_recoil_multiplier", 1))
		end
		if managers.player:has_team_category_upgrade("weapon", "suppression_recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "suppression_recoil_multiplier", 1))
		end
	else
		if managers.player:has_team_category_upgrade(category, "recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value(category, "recoil_multiplier", 1))
		end
		if managers.player:has_team_category_upgrade("weapon", "recoil_multiplier") then
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "recoil_multiplier", 1))
		end
	end
	multiplier = multiplier + (1 - managers.player:upgrade_value(name, "recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "passive_recoil_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("player", "recoil_multiplier", 1))
	if silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_recoil_multiplier", 1))
		multiplier = multiplier + (1 - managers.player:upgrade_value(category, "silencer_recoil_multiplier", 1))
	end
	if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "modded_recoil_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end

function BlackMarketManager:recoil_addend(name, category, silencer, blueprint)
	local addend = 0
	return addend
end

function BlackMarketManager:damage_addend(name, category, silencer, detection_risk, current_state, blueprint)
	local value = 0

	if tweak_data.weapon[name] and tweak_data.weapon[name].ignore_damage_upgrades then
		return value
	end

	value = value + managers.player:upgrade_value("player", "damage_addend", 0)
	value = value + managers.player:upgrade_value("weapon", "damage_addend", 0)
	value = value + managers.player:upgrade_value(name, "damage_addend", 0)

	value = value + managers.player:upgrade_value(category, "damage_addend", 0)

	return value
end

function BlackMarketManager:accuracy_multiplier(name, category, silencer, current_state, fire_mode, blueprint)
	local multiplier = 1
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(category, "spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", fire_mode .. "_spread_multiplier", 1))
	multiplier = multiplier + (1 - managers.player:upgrade_value(name, "spread_multiplier", 1))
	if silencer then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "silencer_spread_multiplier", 1))
		multiplier = multiplier + (1 - managers.player:upgrade_value(category, "silencer_spread_multiplier", 1))
	end
	if current_state then
		if current_state._moving then
			multiplier = multiplier + (1 - managers.player:upgrade_value(category, "move_spread_multiplier", 1))
			multiplier = multiplier + (1 - managers.player:team_upgrade_value("weapon", "move_spread_multiplier", 1))
			multiplier = multiplier + (1 - (self._spread_moving or 1))
		end
		if current_state:in_steelsight() then
			multiplier = multiplier + (1 - tweak_data.weapon[name].spread[current_state._moving and "moving_steelsight" or "steelsight"])
		else
			multiplier = multiplier + (1 - managers.player:upgrade_value(category, "hip_fire_spread_multiplier", 1))
			if current_state._state_data.ducking then
				multiplier = multiplier + (1 - tweak_data.weapon[name].spread[current_state._moving and "moving_crouching" or "crouching"])
			else
				multiplier = multiplier + (1 - tweak_data.weapon[name].spread[current_state._moving and "moving_standing" or "standing"])
			end
		end
	end
	if blueprint and self:is_weapon_modified(managers.weapon_factory:get_factory_id_by_weapon_id(name), blueprint) then
		multiplier = multiplier + (1 - managers.player:upgrade_value("weapon", "modded_spread_multiplier", 1))
	end
	return self:_convert_add_to_mul(multiplier)
end