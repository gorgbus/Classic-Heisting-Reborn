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