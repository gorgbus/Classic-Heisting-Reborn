Hooks:PostHook(HUDTeammate, "init", "init_upper", function(self, i)
    local names = {
		"WWWWWWWWWWWWQWWW",
		"AI Teammate",
		"FutureCatCar",
		"WWWWWWWWWWWWQWWW"
	}

    self._panel:child("name"):set_text(" " .. utf8.to_upper(names[i]))
end)

Hooks:PostHook(HUDTeammate, "set_name", "set_name_upper", function(self, teammate_name)
    local teammate_panel = self._panel
	local name = teammate_panel:child("name")

    name:set_text(utf8.to_upper(" " .. teammate_name))
end)