function HUDManager:set_player_armor(data)
	if data.current == 0 and not data.no_hint then
		managers.hint:show_hint("damage_pad")
	end
	local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD)
	if not hud then
		return
	end
end