local line_translation_map = {
	["l1n_x01a_any_3p"] = "l1n_x02a_any_3p",
	["l1n_x02a_any_3p"] = "l1n_x01a_any_3p",

	["l2n_x01a_any_3p"] = "l2n_x02a_any_3p",
	["l2n_x02a_any_3p"] = "l2n_x01a_any_3p",

	["l3n_x01a_any_3p"] = "l3n_x02a_any_3p",
	["l3n_x02a_any_3p"] = "l3n_x01a_any_3p",
	
	["l4n_x01a_any_3p"] = "l1n_x02a_any_3p",
	["l4n_x02a_any_3p"] = "l4n_x01a_any_3p",

	["l1d_a05"] = "l1d_clr",
	["l1d_a06"] = "l1d_clr",

	["l2d_a05"] = "l2d_clr",
	["l2d_a06"] = "l2d_clr",
	["l2d_x02a_any_3p"] = "l1d_x02a_any_3p",

	["l3d_a05"] = "l3d_clr",
	["l3d_a06"] = "l3d_clr",
	["l3d_burnhurt"] = "l1d_burnhurt",
	["l3d_burndeath"] = "l1d_burndeath",

	["l4d_a05"] = "l4d_clr",
	["l4d_a06"] = "l4d_clr",

	["l5d_a05"] = "l5d_clr",
	["l5d_a06"] = "l5d_clr",
	["l5d_att"] = "l5d_g90",
	["l5d_c01"] = "l5d_g90",
	["l5d_h01"] = "l5d_h10",
	["l5d_rrl"] = "l5d_pus",
	["l5d_t01"] = "l5d_prm",
}

local say_orig = CopSound.say
function CopSound:say(sound_name, sync, skip_prefix, ...)
	local full_sound = skip_prefix and sound_name or self._prefix .. sound_name
	full_sound = line_translation_map[full_sound] or full_sound

	return say_orig(self, full_sound, sync, true, ...)
end