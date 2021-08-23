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

Hooks:PostHook(TweakData, "init", "initBlockCharacters", function(self)
	self.criminals = {
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
					ssuffix = "l"
				},
				body_g_object = Idstring("g_body")
			}
	}
end)