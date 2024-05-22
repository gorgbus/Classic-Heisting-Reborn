local init_orig = CopActionHurt.init
function CopActionHurt:init(action_desc, ...)
	if init_orig(self, action_desc, ...) then -- need to ensure the action actually started successfully
		if not self._unit:base().nick_name then
			local action_type = action_desc.hurt_type
			if action_type == "counter_tased" or action_type == "taser_tased" then
				if not self._unit:base():has_tag("taser") then
					self._unit:sound():say("x01a_any_3p", true) -- should be fine to immediately play this after
				end
			elseif action_type == "hurt_sick" then
				if self._unit:base():has_tag("law") and not self._unit:base():has_tag("special") or self._unit:base():has_tag("shield") then
					self._unit:sound():say("ch3", true) --make cops scream in pain when affected ECM feedback
				elseif self._unit:base():has_tag("medic")then
					self._unit:sound():say("burndeath", true) --same for the medic with a similar sound, since they lack one
				elseif self._unit:base():has_tag("taser") then
					self._unit:sound():say("tasered", true) --same as his tased lines felt they fit best
				end
			end
		end
		
		return true
	end
end