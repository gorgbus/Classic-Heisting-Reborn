function HUDManager:safe_house_challenge_popup(id, c_type)
end

function HUDManager:challenge_popup(d)
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
        return
    end
end)
--I had to inlude _G.VoidUI inside each Hook because these scripts are beeing executed before VoidUI, soo script like;
--if _G.VoidUi then
--Hooks:PostHook...
--Will not work at all, because at this stage it's nil, doesn't matter whenever you have it installed or not, it's beeing initialized later.
