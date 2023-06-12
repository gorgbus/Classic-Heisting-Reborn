function MenuComponentManager:create_skilltree_new_gui(node)
	self:close_skilltree_new_gui()

	self._skilltree_gui = SkillTreeGui:new(self._ws, self._fullscreen_ws, node)
	self._new_skilltree_gui_active = true

	self:enable_skilltree_gui()
end

function MenuComponentManager:close_skilltree_new_gui()
	if self._skilltree_gui and not self._old_skilltree_gui_active then
		self._skilltree_gui:close()

		self._skilltree_gui = nil
		self._new_skilltree_gui_active = nil
	end
end

function MenuComponentManager:on_skill_unlocked(...)
	if self._skilltree_gui then
		self._skilltree_gui:on_skill_unlocked(...)
	end
end

--Update banner remover by Sayori

MenuComponentManager.create_new_heists_gui = function(self, node)
	return
end
--MenuComponentManager.Holo:Post(BLTNotificationsGui) = function(self) return end

BLTNotificationsGui = BLTNotificationsGui or blt_class(MenuGuiComponentGeneric)

local padding = 0 --10

-- Copied from NewHeistsGui
local SPOT_W = 32
local SPOT_H = 8
local BAR_W = 32
local BAR_H = 6
local BAR_X = (SPOT_W - BAR_W) / 2
local BAR_Y = 0
local TIME_PER_PAGE = 3 --6
local CHANGE_TIME = 1.5 --0.5

function MenuComponentManager:create_lobby_code_gui(node)
	self:close_lobby_code_gui()
end
