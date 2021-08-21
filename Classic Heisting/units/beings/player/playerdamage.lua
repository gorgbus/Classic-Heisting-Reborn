local _hit_direction_actual = PlayerDamage._hit_direction
function PlayerDamage:_hit_direction(position_vector, ...)
	if position_vector then
		local dir = (self._unit:camera():position() - position_vector):normalized()
		local infront = math.dot(self._unit:camera():forward(), dir)
		if infront < -0.9 then
			managers.environment_controller:hit_feedback_front()
		elseif infront > 0.9 then
			managers.environment_controller:hit_feedback_back()
		else
			local polar = self._unit:camera():forward():to_polar_with_reference(-dir, Vector3(0, 0, 1))
			local direction = Vector3(polar.spin, polar.pitch, 0):normalized()
			if math.abs(direction.x) > math.abs(direction.y) then
				if 0 > direction.x then
					managers.environment_controller:hit_feedback_left()
				else
					managers.environment_controller:hit_feedback_right()
				end
			elseif 0 > direction.y then
				managers.environment_controller:hit_feedback_up()
			else
				managers.environment_controller:hit_feedback_down()
			end
		end
	end
	return _hit_direction_actual(self, position_vector, ...)
end