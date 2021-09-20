local data = HUDManager.init

function HUDManager:add_mugshot_by_unit(unit)
	if unit:base().is_local_player then
		return
	end

	local character_name = unit:base():nick_name()
	local name_label_id = managers.hud:_add_name_label({
		name = character_name,
		unit = unit
	})
	unit:unit_data().name_label_id = name_label_id
	local is_husk_player = unit:base().is_husk_player
	local character_name_id = managers.criminals:character_name_by_unit(unit)

	for i, data in ipairs(self._hud.mugshots) do
		if data.character_name_id == character_name_id then
			if is_husk_player and not data.peer_id then
				self:_remove_mugshot(data.id)

				break
			else
				unit:unit_data().mugshot_id = data.id

				managers.hud:set_mugshot_normal(unit:unit_data().mugshot_id)
				managers.hud:set_mugshot_armor(unit:unit_data().mugshot_id, 1)
				managers.hud:set_mugshot_health(unit:unit_data().mugshot_id, 1)

				return
			end
		end
	end

	local peer, peer_id = nil

	if is_husk_player then
		peer = unit:network():peer()
		peer_id = peer:id()
	end

	local use_lifebar = is_husk_player and true or false
	local mugshot_id = managers.hud:add_mugshot({
		name = utf8.to_upper(character_name),	--name = character_name, --no upper
		use_lifebar = use_lifebar,
		peer_id = peer_id,
		character_name_id = character_name_id
	})
	unit:unit_data().mugshot_id = mugshot_id

	if peer and peer:is_cheater() then
		self:mark_cheater(peer_id)
	end

	return mugshot_id
end

function HUDManager:add_mugshot_without_unit(char_name, ai, peer_id, name)
	local character_name = name
	local character_name_id = char_name

	if not ai then
		-- Nothing
	end

	local use_lifebar = not ai
	local mugshot_id = managers.hud:add_mugshot({
		name = utf8.to_upper(character_name),	--name = character_name, --no upper
		use_lifebar = use_lifebar,
		peer_id = peer_id,
		character_name_id = character_name_id
	})

	return mugshot_id
end

function HUDManager:update_name_label_by_peer(peer)
	for _, data in pairs(self._hud.name_labels) do
		if data.peer_id == peer:id() then
			local name = data.character_name

			if peer:level() then
				local experience = (peer:rank() > 0 and managers.experience:rank_string(peer:rank()) .. "-" or "") .. peer:level()
				name = name .. " (" .. experience .. ")"
			end

			data.text:set_text(utf8.to_upper(name))		--data.text:set_text(name) --no upper
			self:align_teammate_name_label(data.panel, data.interact)

			break
		end
	end
end