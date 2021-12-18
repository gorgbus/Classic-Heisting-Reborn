if _G.ch_settings.settings.upper_label then
	Hooks:PostHook(HUDManager, "update_name_label_by_peer", "update_name_label_by_peer_upper", function(self, peer)
		for _, data in pairs(self._hud.name_labels) do
			if data.peer_id == peer:id() then
				local name = data.character_name

				if peer:level() then
					local color_range_offset = utf8.len(name) + 2
					local experience, color_ranges = managers.experience:gui_string(peer:level(), peer:rank(), color_range_offset)
					data.name_color_ranges = color_ranges
					name = name .. " (" .. experience .. ")"
				end

				data.text:set_text(utf8.to_upper(name))
				break
			end
		end
	end)
end