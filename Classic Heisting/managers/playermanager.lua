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
                    amount = amount + 1
                end

                if upgrades["quantity_3"] then
                    amount = amount + 3
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