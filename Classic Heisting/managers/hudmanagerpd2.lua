require("lib/managers/hud/HudStatsScreen")

function HUDManager:safe_house_challenge_popup(id, c_type)
end

function HUDManager:challenge_popup(d)
end

if _G.ch_settings.settings.upper_label then
    Hooks:PostHook(HUDManager, "_add_name_label", "_add_name_label_upper" , function(self, data)
        for _, panels in pairs(self._hud.name_labels) do
            if panels.text:text() == data.name then
                panels.text:set_text(utf8.to_upper(data.name))
            end
        end
    end)

    Hooks:PostHook(HUDManager, "set_teammate_name", "set_teammate_name_upper", function(self, i, teammate_name)
        self._teammate_panels[i]:set_name(utf8.to_upper(teammate_name))
    end)
end

function HUDManager:set_player_armor(data)
    if (math.floor(data.current * 10) / 10) < 0.1 then
        if _G.ch_settings.settings.dmg_pad then
            managers.hint:show_hint("damage_pad")
        end
    end

	self:set_teammate_armor(HUDManager.PLAYER_PANEL, data)
end

--Set total pagers according to skills;
--Even when pager panel has x4 the value self._pagers can be 2 (VoidUI is checking tweakdata for that, which always returns 4, because skill is using two tweakdatas, one for non-skill and one for skill variant)
--Soo here we're correcting it.
Hooks:PostHook(HUDAssaultCorner, 'init', 'update_pagers', function(self, ...)
	if _G.VoidUI and managers.player:has_category_upgrade("player", "corpse_alarm_pager_bluff") then
		self._pagers = 4
	else
		self._pagers = 2
	end
end)

--Make use of total pagers count from Above on panel initialize. 
--Normally it starts with text="x4", we can have x2 or x4, it's not always x4...
Hooks:PostHook(HUDAssaultCorner, 'setup_icons_panel', 'initialize_proper_pagers', function(self, icons_panel)
    if not _G.VoidUI then
        return
    end
    local pagers_count = self._custom_hud_panel:child("icons_panel"):child("pagers_panel"):child("num_pagers")
    pagers_count:set_text("x".. self._pagers)
end)

--To make sure there's no text like "x-1" we're forcing it to be 0.
--I checked the pager's script and these two pagers that can be answered without a pager are 'used' when other players answer the pager.
--Soo even when player never answered a single pager, and two were already answered, if he answer third one, alarm will go off.
Hooks:PreHook(HUDAssaultCorner, 'pager_used', 'initialize_proper_pagers', function(self, ...)
    if not _G.VoidUI then
        return
    end
    if self._pagers == 0 then
        self._pagers = 1
    end
end)
--I had to inlude _G.VoidUI inside each Hook because these scripts are beeing executed before VoidUI, soo script like;
--if _G.VoidUi then
--Hooks:PostHook...
--Will not work at all, because at this stage it's nil, doesn't matter whenever you have it installed or not, it's beeing initialized later.