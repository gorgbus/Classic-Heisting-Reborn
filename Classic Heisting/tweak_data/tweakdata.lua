tweak_data.difficulties = {
	"easy",
	"normal",
	"hard",
	"overkill",
	"overkill_145",
	"overkill_290",
	"sm_wish",
	"sm_wish"
}
tweak_data.difficulty_level_locks = {
	0,
	0,
	0,
	0,
	0,
	80,
	69420,
	69420
}

tweak_data.experience_manager.stage_completion = {
	200,
	250,
	300,
	350,
	425,
	475,
	550
}
tweak_data.experience_manager.job_completion = {
	750,
	1000,
	1500,
	2000,
	2500,
	3000,
	4000
}
tweak_data.experience_manager.difficulty_multiplier = {
	2,
	5,
	10,
	13,
	13,
	13
}

tweak_data.experience_manager.day_multiplier = {
	1,
	2,
	3,
	4,
	5,
	6,
	7
}
tweak_data.experience_manager.pro_day_multiplier = {
	1,
	2.5,
	5,
	5.5,
	7,
	8.5,
	10
}

tweak_data.projectiles.frag.damage = 30

if _G.ch_settings.settings.u24_progress then
	tweak_data.criminals = {
		characters = {
			{
				name = "russian",
				order = 1,
				static_data = {
					voice = "rb4",
					ai_mask_id = "dallas",
					ai_character_id = "ai_dallas",
					ssuffix = "a"
				},
				body_g_object = Idstring("g_body")
			},
			{
				name = "german",
				order = 2,
				static_data = {
					voice = "rb3",
					ai_mask_id = "wolf",
					ai_character_id = "ai_wolf",
					ssuffix = "c"
				},
				body_g_object = Idstring("g_body")
			},
			{
				name = "spanish",
				order = 3,
				static_data = {
					voice = "rb1",
					ai_mask_id = "chains",
					ai_character_id = "ai_chains",
					ssuffix = "b"
				},
				body_g_object = Idstring("g_body")
			},
			{
				name = "american",
				order = 4,
				static_data = {
					voice = "rb2",
					ai_mask_id = "hoxton",
					ai_character_id = "ai_hoxton",
					ssuffix = "d"
				},
				body_g_object = Idstring("g_body")
			}
		},
		character_names = {}
	}

	table.sort(tweak_data.criminals.characters, function (a, b)
		return a.order < b.order
	end)

	for _, character in ipairs(tweak_data.criminals.characters) do
		table.insert(tweak_data.criminals.character_names, character.name)
	end
end

