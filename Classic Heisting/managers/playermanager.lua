local function make_double_hud_string(a, b)
	return string.format("%01d|%01d", a, b)
end

local function add_hud_item(amount, icon)
	if #amount > 1 then
		managers.hud:add_item_from_string({
			amount_str = make_double_hud_string(amount[1], amount[2]),
			amount = amount,
			icon = icon
		})
	else
		managers.hud:add_item({
			amount = amount[1],
			icon = icon
		})
	end
end

local function set_hud_item_amount(index, amount)
	if #amount > 1 then
		managers.hud:set_item_amount_from_string(index, make_double_hud_string(amount[1], amount[2]), amount)
	else
		managers.hud:set_item_amount(index, amount[1])
	end
end

local function get_as_digested(amount)
	local list = {}

	for i = 1, #amount do
		table.insert(list, Application:digest_value(amount[i], false))
	end

	return list
end

function PlayerManager:_add_equipment(params)
	if self:has_equipment(params.equipment) then
		print("Allready have equipment", params.equipment)

		return
	end

	local equipment = params.equipment
	local tweak_data = tweak_data.equipments[equipment]
	local amount = {}
	local amount_digest = {}
	local quantity = tweak_data.quantity

	for i = 1, #quantity do
		local equipment_name = equipment

		if tweak_data.upgrade_name then
			equipment_name = tweak_data.upgrade_name[i]
		end
        
        amt = (quantity[1] or 0)

        if equipment_name == "trip_mine" then
            upgrades = self._global.upgrades[equipment_name]
            if not upgrades then
            else
                if upgrades["quantity_1"] then
                    amt = amt + 1
                end

                if upgrades["quantity_3"] then
                    amt = amt + 3
                end
            end
        else
            amt = amt + self:equiptment_upgrade_value(equipment_name, "quantity")
        end

		
		amt = managers.modifiers:modify_value("PlayerManager:GetEquipmentMaxAmount", amt, params)

		table.insert(amount, amt)
		table.insert(amount_digest, Application:digest_value(0, true))
	end

	local icon = params.icon or tweak_data and tweak_data.icon
	local use_function_name = params.use_function_name or tweak_data and tweak_data.use_function_name
	local use_function = use_function_name or nil

	if params.slot and params.slot > 1 then
		for i = 1, #quantity do
			amount[i] = math.ceil(amount[i] / 2)
		end
	end

	table.insert(self._equipment.selections, {
		equipment = equipment,
		amount = amount_digest,
		use_function = use_function,
		action_timer = tweak_data.action_timer,
		icon = icon,
		unit = tweak_data.unit,
		on_use_callback = tweak_data.on_use_callback
	})

	self._equipment.selected_index = self._equipment.selected_index or 1

	add_hud_item(amount, icon)

	for i = 1, #amount do
		self:add_equipment_amount(equipment, amount[i], i)
	end
end

function PlayerManager:remove_equipment(equipment_id, slot)
	slot = 1
	local current_equipment = self:selected_equipment()
	local equipment, index = self:equipment_data_by_name(equipment_id)
	local new_amount = Application:digest_value(equipment.amount[slot or 1], false) - 1
	equipment.amount[slot or 1] = Application:digest_value(new_amount, true)

	if current_equipment and current_equipment.equipment == equipment.equipment then
		set_hud_item_amount(index, get_as_digested(equipment.amount))
	end

	if not slot or slot and slot < 2 then
		self:update_deployable_equipment_amount_to_peers(equipment.equipment, new_amount)
	end
end

function PlayerManager:upgrade_value(category, upgrade, default)
	if upgrade == "no_ammo_cost" then
		category = "player"
	end

	if not self._global.upgrades[category] then
		return default or 0
	end

	if not self._global.upgrades[category][upgrade] then
		return default or 0
	end

	local level = self._global.upgrades[category][upgrade]

	if upgrade == "no_ammo_cost" then
		category = "temporary"
	end

	local value = tweak_data.upgrades.values[category][upgrade][level]
	return value
end

function PlayerManager:activate_temporary_upgrade(category, upgrade)
	local upgrade_value = self:upgrade_value(category, upgrade)

	if upgrade_value == 0 then
		return
	end

	local time = upgrade_value[2]
	self._temporary_upgrades[category] = self._temporary_upgrades[category] or {}
	self._temporary_upgrades[category][upgrade] = {
		expire_time = Application:time() + time
	}

	if self:is_upgrade_synced(category, upgrade) then
		managers.network:session():send_to_peers("sync_temporary_upgrade_activated", self:temporary_upgrade_index(category, upgrade))
	end
end

function PlayerManager:_internal_load()
	local player = self:player_unit()

	if not player then
		return
	end

	local default_weapon_selection = 1
	local secondary = managers.blackmarket:equipped_secondary()
	local secondary_slot = managers.blackmarket:equipped_weapon_slot("secondaries")
	local texture_switches = managers.blackmarket:get_weapon_texture_switches("secondaries", secondary_slot, secondary)

	player:inventory():add_unit_by_factory_name(secondary.factory_id, default_weapon_selection == 1, false, secondary.blueprint, secondary.cosmetics, texture_switches)

	local primary = managers.blackmarket:equipped_primary()

	if primary then
		local primary_slot = managers.blackmarket:equipped_weapon_slot("primaries")
		local texture_switches = managers.blackmarket:get_weapon_texture_switches("primaries", primary_slot, primary)

		player:inventory():add_unit_by_factory_name(primary.factory_id, default_weapon_selection == 2, false, primary.blueprint, primary.cosmetics, texture_switches)
	end

	player:inventory():set_melee_weapon(managers.blackmarket:equipped_melee_weapon())

	local peer_id = managers.network:session():local_peer():id()
	local grenade, amount = managers.blackmarket:equipped_grenade()

	if self:has_grenade(peer_id) then
		amount = self:get_grenade_amount(peer_id) or amount
	end

	amount = managers.modifiers:modify_value("PlayerManager:GetThrowablesMaxAmount", amount)

	self:_set_grenade({
		grenade = grenade,
		amount = math.min(amount, self:get_max_grenades())
	})

	if self:has_category_upgrade("player", "extra_corpse_dispose_amount") then
		self:_set_body_bags_amount(2)
	else
		self:_set_body_bags_amount(managers.blackmarket:forced_body_bags() or self._local_player_body_bags or self:total_body_bags())
	end

	

	if not self._respawn then
		self:_add_level_equipment(player)

		for i, name in ipairs(self._global.default_kit.special_equipment_slots) do
			local ok_name = self._global.equipment[name] and name

			if ok_name then
				local upgrade = tweak_data.upgrades.definitions[ok_name]

				if upgrade and (upgrade.slot and upgrade.slot < 2 or not upgrade.slot) then
					self:add_equipment({
						silent = true,
						equipment = upgrade.equipment_id
					})
				end
			end
		end

		local slot = 2

		if self:has_category_upgrade("player", "second_deployable") then
			slot = 3
		else
			self:set_equipment_in_slot(nil, 2)
		end

		local equipment_list = self:equipment_slots()

		for i, name in ipairs(equipment_list) do
			local ok_name = self._global.equipment[name] and name or self:equipment_in_slot(i)

			if ok_name then
				local upgrade = tweak_data.upgrades.definitions[ok_name]

				if upgrade and (upgrade.slot and upgrade.slot < slot or not upgrade.slot) then
					self:add_equipment({
						silent = true,
						equipment = upgrade.equipment_id,
						slot = i
					})
				end
			end
		end

		self:update_deployable_selection_to_peers()
	end

	if self:has_category_upgrade("player", "cocaine_stacking") then
		self:update_synced_cocaine_stacks_to_peers(0, self:upgrade_value("player", "sync_cocaine_upgrade_level", 1), self:upgrade_level("player", "cocaine_stack_absorption_multiplier", 0))
		managers.hud:set_info_meter(nil, {
			icon = "guis/dlcs/coco/textures/pd2/hud_absorb_stack_icon_01",
			max = 1,
			current = self:get_local_cocaine_damage_absorption_ratio(),
			total = self:get_local_cocaine_damage_absorption_max_ratio()
		})
	end

	self:update_cocaine_hud()

	local equipment = self:selected_equipment()

	if equipment then
		add_hud_item(get_as_digested(equipment.amount), equipment.icon)
	end

	if self:has_equipment("armor_kit") then
		managers.mission:call_global_event("player_regenerate_armor", true)
	end
end

function PlayerManager:add_special(params)
	local name = params.equipment or params.name

	if not tweak_data.equipments.specials[name] then
		Application:error("Special equipment " .. name .. " doesn't exist!")

		return
	end

	local unit = self:player_unit()
	local respawn = params.amount and true or false
	local equipment = tweak_data.equipments.specials[name]
	local special_equipment = self._equipment.specials[name]
	local amount = params.amount or equipment.quantity
	local extra = self:_equipped_upgrade_value(equipment) + self:upgrade_value(name, "quantity")

	if name == "cable_tie" then
		extra = self:upgrade_value(name, "quantity")
	end

	if special_equipment then
		if equipment.max_quantity or equipment.quantity or params.transfer and equipment.transfer_quantity then
			local dedigested_amount = special_equipment.amount and Application:digest_value(special_equipment.amount, false) or 1
			local new_amount = self:has_category_upgrade(name, "quantity_unlimited") and -1 or math.min(dedigested_amount + amount, (params.transfer and equipment.transfer_quantity or equipment.max_quantity or equipment.quantity) + extra)
			special_equipment.amount = Application:digest_value(new_amount, true)

			if special_equipment.is_cable_tie then
				managers.hud:set_cable_ties_amount(HUDManager.PLAYER_PANEL, new_amount)
				self:update_synced_cable_ties_to_peers(new_amount)
			else
				managers.hud:set_special_equipment_amount(name, new_amount)
				self:update_equipment_possession_to_peers(name, new_amount)
			end
		end

		return
	end

	local icon = equipment.icon
	local action_message = equipment.action_message

	if not params.silent then
		local text = managers.localization:text(equipment.text_id)
		local title = managers.localization:text("present_obtained_mission_equipment_title")

		managers.hud:present_mid_text({
			time = 4,
			text = text,
			title = title,
			icon = icon
		})

		if action_message and alive(unit) then
			managers.network:session():send_to_peers_synched("sync_show_action_message", unit, action_message)
		end
	end

	local is_cable_tie = name == "cable_tie"
	local quantity = nil

	if is_cable_tie or not params.transfer then
		quantity = self:has_category_upgrade(name, "quantity_unlimited") and -1 or equipment.quantity and (respawn and math.min(params.amount, (equipment.max_quantity or equipment.quantity or 1) + extra) or equipment.quantity and math.min(amount + extra, (equipment.max_quantity or equipment.quantity or 1) + extra))
	else
		quantity = params.amount
	end

	if is_cable_tie then
		managers.hud:set_cable_tie(HUDManager.PLAYER_PANEL, {
			icon = icon,
			amount = quantity or nil
		})
		self:update_synced_cable_ties_to_peers(quantity)
	else
		managers.hud:add_special_equipment({
			id = name,
			icon = icon,
			amount = quantity or equipment.transfer_quantity and 1 or nil
		})
		self:update_equipment_possession_to_peers(name, quantity)
	end

	self._equipment.specials[name] = {
		amount = quantity and Application:digest_value(quantity, true) or nil,
		is_cable_tie = is_cable_tie
	}

	if equipment.player_rule then
		self:set_player_rule(equipment.player_rule, true)
	end
end