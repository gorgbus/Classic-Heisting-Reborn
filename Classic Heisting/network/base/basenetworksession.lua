function BaseNetworkSession:check_peer_preferred_character(preferred_character)
	local free_characters = clone(CriminalsManager.character_names())

    if _G.ch_settings.settings.old_char then
        free_characters =  {"russian", "german", "spanish", "american"}
    end

	for _, peer in pairs(self._peers_all) do
		local character = peer:character()

		table.delete(free_characters, character)
	end

	local preferreds = string.split(preferred_character, " ")

	for _, preferred in ipairs(preferreds) do
		if table.contains(free_characters, preferred) then
			return preferred
		end
	end

	local character = free_characters[math.random(#free_characters)]

	return character
end