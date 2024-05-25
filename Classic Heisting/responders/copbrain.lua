local math_random = math.random
function CopBrain:on_suppressed(state)
	self._logic_data.is_suppressed = state or nil

	if self._current_logic.on_suppressed_state then
		self._current_logic.on_suppressed_state(self._logic_data)

		if state and self._logic_data.char_tweak.chatter.suppress then
			if managers.groupai:state():chk_assault_active_atm() then
				self._unit:sound():say(math_random() > 0.5 and "hlp" or "lk3a", true)
			else
				self._unit:sound():say("lk3b", true) --calmer lines for when the assault is off
			end
		end
	end
end