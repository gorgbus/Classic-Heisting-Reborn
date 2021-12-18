function QuickFlashGrenade:init(unit)
	self._unit = unit
	self._unit:set_visible(false)
	self._state = 0
	self._armed = false

	for i, state in ipairs(QuickFlashGrenade.States) do
		if state[2] == nil then
			QuickFlashGrenade.States[i][2] = tweak_data.group_ai.flash_grenade.timer
		end
	end

	if Network:is_client() then
		self:activate(self._unit:position(), tweak_data.group_ai.flash_grenade_lifetime)
	end
end

function QuickFlashGrenade:update(unit, t, dt)
	if self._destroyed_t then
		self._destroyed_t = self._destroyed_t - dt

		if self._destroyed_t <= 0 then
			self:destroy_unit()
		end
	end

	if self._destroyed or not self._armed then
		return
	end

	if self._timer then
		self._timer = self._timer - dt

		if self._timer <= 0 then
			self._state = self._state + 1
			local state = QuickFlashGrenade.States[self._state]

			if state then
				self[state[1]](self)

				self._timer = state[2]
			else
				self._timer = nil
			end
		end
	end
end

function QuickFlashGrenade:_state_bounced()
	self._unit:damage():run_sequence_simple("activate")

	local bounce_point = Vector3()

	mvector3.lerp(bounce_point, self._shoot_position, self._unit:position(), 0.65)

    local sound_source = SoundDevice:create_source("grenade_bounce_source")

	sound_source:set_position(bounce_point)
	sound_source:post_event("flashbang_bounce", callback(self, self, "sound_playback_complete_clbk"), sound_source, "end_of_event")
end

function QuickFlashGrenade:_state_detonated()
	local detonate_pos = self._unit:position()

	self:make_flash(detonate_pos, tweak_data.group_ai.flash_grenade.range)
	managers.groupai:state():propagate_alert({
		"aggression",
		detonate_pos,
		10000,
		managers.groupai:state():get_unit_type_filter("civilians_enemies")
	})
end

function QuickFlashGrenade:_beep()
end

function QuickFlashGrenade:destroy()
end
function QuickFlashGrenade:preemptive_kill()
end

function QuickFlashGrenade:destroy_unit()
end

function QuickFlashGrenade:on_flashbang_destroyed(prevent_network)
end