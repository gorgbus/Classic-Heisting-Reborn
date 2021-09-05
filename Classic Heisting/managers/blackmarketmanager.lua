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