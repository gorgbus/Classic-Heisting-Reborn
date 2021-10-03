Hooks:PostHook(HUDManager, "update_name_label_by_peer", "update_name_label_by_peer_upper", function(self, peer)
    for _, data in pairs(self._hud.name_labels) do
		if data.peer_id == peer:id() then
			local name = data.character_name

			data.text:set_text(utf8.to_upper(name))
			break
		end
	end
end)