Hooks:PostHook(PlayerTweakData, "_set_overkill_290", "restore_set_overkill_290", function(self)
	self.suspicion.range_mul = 2
	self.suspicion.buildup_mul = 2
end)

Hooks:PostHook(PlayerTweakData, "init", "restore_init", function(self)
	self.damage.MIN_DAMAGE_INTERVAL = 0.35
	self.alarm_pager = {
		first_call_delay = {
			2,
			4
		},
		call_duration = {
			{
				6,
				6
			},
			{
				6,
				6
			}
		},
		nr_of_calls = {
			2,
			2
		},
		bluff_success_chance = {
			1,
			1,
			0,
			0,
			0
		},
		bluff_success_chance_w_skill = {
			1,
			1,
			1,
			1,
			0
		}
	}

	self.stances.default.standard.head.translation = Vector3(0, 0, 145)
	self.stances.default.standard.head.rotation = Rotation()
	self.stances.default.standard.shakers = {}
	self.stances.default.standard.shakers.breathing = {}
	self.stances.default.standard.shakers.breathing.amplitude = 0.3
	self.stances.default.crouched.shakers = {}
	self.stances.default.crouched.shakers.breathing = {}
	self.stances.default.crouched.shakers.breathing.amplitude = 0.25
	self.stances.default.steelsight.shakers = {}
	self.stances.default.steelsight.shakers.breathing = {}
	self.stances.default.steelsight.shakers.breathing.amplitude = 0.025
	self.stances.default.mask_off = deep_clone(self.stances.default.standard)
	self.stances.default.mask_off.head.translation = Vector3(0, 0, 160)
	self.stances.default.clean = deep_clone(self.stances.default.mask_off)
	local pivot_head_translation = Vector3()
	local pivot_head_rotation = Rotation()
	local pivot_shoulder_translation = Vector3()
	local pivot_shoulder_rotation = Rotation()
	self.stances.default.standard.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.default.standard.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.default.standard.vel_overshot.yaw_neg = 6
	self.stances.default.standard.vel_overshot.yaw_pos = -6
	self.stances.default.standard.vel_overshot.pitch_neg = -10
	self.stances.default.standard.vel_overshot.pitch_pos = 10
	self.stances.default.standard.vel_overshot.pivot = Vector3(0, 0, 0)
	self.stances.default.standard.FOV = 65
	self.stances.default.crouched.head.translation = Vector3(0, 0, 75)
	self.stances.default.crouched.head.rotation = Rotation()
	local pivot_head_translation = Vector3()
	local pivot_head_rotation = Rotation()
	self.stances.default.crouched.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.default.crouched.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.default.crouched.vel_overshot.yaw_neg = 6
	self.stances.default.crouched.vel_overshot.yaw_pos = -6
	self.stances.default.crouched.vel_overshot.pitch_neg = -10
	self.stances.default.crouched.vel_overshot.pitch_pos = 10
	self.stances.default.crouched.vel_overshot.pivot = Vector3(0, 0, 0)
	self.stances.default.crouched.FOV = self.stances.default.standard.FOV
	local pivot_head_translation = Vector3(0, 0, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.default.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.default.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
	self.stances.default.steelsight.vel_overshot.yaw_neg = 4
	self.stances.default.steelsight.vel_overshot.yaw_pos = -4
	self.stances.default.steelsight.vel_overshot.pitch_neg = -2
	self.stances.default.steelsight.vel_overshot.pitch_pos = 2
	self.stances.default.steelsight.vel_overshot.pivot = pivot_shoulder_translation
	self.stances.default.steelsight.zoom_fov = true
	self.stances.default.steelsight.FOV = self.stances.default.standard.FOV
	self:_init_new_stances()
	self.movement_state = {}
	self.movement_state.standard = {}
	self.movement_state.standard.movement = {
		speed = {},
		jump_velocity = {
			xy = {}
		}
	}
	self.movement_state.standard.movement.speed.STANDARD_MAX = 350
	self.movement_state.standard.movement.speed.RUNNING_MAX = 575
	self.movement_state.standard.movement.speed.CROUCHING_MAX = 225
	self.movement_state.standard.movement.speed.STEELSIGHT_MAX = 185
	self.movement_state.standard.movement.speed.INAIR_MAX = 185
	self.movement_state.standard.movement.speed.CLIMBING_MAX = 200
	self.movement_state.standard.movement.jump_velocity.z = 470
	self.movement_state.standard.movement.jump_velocity.xy.run = self.movement_state.standard.movement.speed.RUNNING_MAX * 1
	self.movement_state.standard.movement.jump_velocity.xy.walk = self.movement_state.standard.movement.speed.STANDARD_MAX * 1.2
	self.movement_state.interaction_delay = 1.5
	self.movement_state.stamina = {}
	self.movement_state.stamina.STAMINA_INIT = 20
	self.movement_state.stamina.STAMINA_REGEN_RATE = 3
	self.movement_state.stamina.STAMINA_DRAIN_RATE = 2
	self.movement_state.stamina.REGENERATE_TIME = 1
	self.movement_state.stamina.MIN_STAMINA_THRESHOLD = 4
	self.movement_state.stamina.JUMP_STAMINA_DRAIN = 2
	self.camera = {}
	self.camera.MIN_SENSITIVITY = 0.3
	self.camera.MAX_SENSITIVITY = 1.7
end)
