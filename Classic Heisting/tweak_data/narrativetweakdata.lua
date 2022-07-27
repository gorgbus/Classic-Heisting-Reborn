_G.ch_settings = {}
_G.ch_settings.path = SavePath .. "ch_settings.json"
_G.ch_settings.mod_path = ModPath
_G.ch_settings.settings = {
    flash_off = false,
    u24_progress = false,
	dmg_pad = true,
	card = true,
	upper_label = true,
	tab_screen = true,
    old_char = false
}

function json_decode(path)
	local file = io.open(path, "r")
	if file then
		local results = json.decode(file:read("*all") or {})
		if results.settings then
			for i, result in pairs(results.settings) do
				_G.ch_settings.settings[i] = result
			end
		end
		file:close()
	end
end

json_decode(_G.ch_settings.path)

local data = NarrativeTweakData.init
function NarrativeTweakData:init(tweak_data)
	data(self, tweak_data)



	self.jobs.firestarter_prof = deep_clone(self.jobs.firestarter)
	self.jobs.firestarter_prof.jc = 70
	self.jobs.firestarter_prof.professional = true
	self.jobs.firestarter_prof.region = "professional"
	self.jobs.firestarter_prof.payout = {
		80000,
		110000,
		160000,
		250000,
		300000,
		300000,
		300000
	}
	self.jobs.firestarter_prof.heat = {this_job = -25, other_jobs = 30}

	self.jobs.alex_prof = deep_clone(self.jobs.alex)
	self.jobs.alex_prof.jc = 70
	self.jobs.alex_prof.professional = true
	self.jobs.alex_prof.region = "professional"
	self.jobs.alex_prof.payout = {
		10000,
		15000,
		30000,
		40000,
		80000,
		80000,
		80000
	}
	self.jobs.alex_prof.contract_cost = {
		131000,
		188000,
		264000,
		530000,
		700000,
		700000,
		700000
	}
	self.jobs.alex_prof.heat = {this_job = -35, other_jobs = 10}
	
	self.jobs.welcome_to_the_jungle_wrapper_prof.professional = true

	self.jobs.framing_frame_prof = deep_clone(self.jobs.framing_frame)
	self.jobs.framing_frame_prof.jc = 70
	self.jobs.framing_frame_prof.professional = true
	self.jobs.framing_frame_prof.region = "professional"
	self.jobs.framing_frame_prof.payout = {
		80000,
		100000,
		150000,
		200000,
		300000,
		300000,
		300000
	}
	self.jobs.framing_frame_prof.heat = {this_job = -25, other_jobs = 30}

	self.jobs.watchdogs_wrapper_prof = deep_clone(self.jobs.watchdogs_wrapper)
	self.jobs.watchdogs_wrapper_prof.jc = 70
	self.jobs.watchdogs_wrapper_prof.professional = true
	self.jobs.watchdogs_wrapper_prof.region = "professional"
	self.jobs.watchdogs_wrapper_prof.payout = {
		75000,
		85000,
		150000,
		200000,
		290000,
		290000,
		290000
	}
	self.jobs.watchdogs_wrapper_prof.heat = {this_job = -25, other_jobs = 20}

	self.jobs.ukrainian_job_prof.jc = 30
	self.jobs.ukrainian_job_prof.professional = true
	self.jobs.ukrainian_job_prof.payout = {
		20000,
		21000,
		23000,
		25000,
		30000
	}

	self.jobs.branchbank_prof.jc = 70
	self.jobs.branchbank_prof.professional = true
	
	self.jobs.branchbank_gold_prof.professional = true
	
	self.jobs.election_day_prof = deep_clone(self.jobs.election_day)
	self.jobs.election_day_prof.jc = 50
	self.jobs.election_day_prof.professional = true
	self.jobs.election_day_prof.region = "professional"
	self.jobs.election_day_prof.payout = {
		25000,
		35000,
		50000,
		65000,
		100000,
		100000,
		100000
	}
	self.jobs.election_day_prof.contract_cost = {
		31000,
		62000,
		155000,
		310000,
		400000,
		400000,
		400000
	}

	self.jobs.mia_prof = deep_clone(self.jobs.mia)
	self.jobs.mia_prof.jc = 70
	self.jobs.mia_prof.professional = true
	self.jobs.mia_prof.region = "professional"
	self.jobs.mia_prof.payout = {
		25000,
		35000,
		50000,
		65000,
		100000,
		100000,
		100000
	}
	self.jobs.mia_prof.contract_cost = {
		62000,
		124000,
		310000,
		620000,
		800000,
		800000,
		800000
	}
	self.jobs.mia_prof.experience_mul = {
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5
	}	

	self.jobs.hox_prof = deep_clone(self.jobs.hox)
	self.jobs.hox_prof.jc = 70
	self.jobs.hox_prof.professional = true
	self.jobs.hox_prof.region = "professional"
	self.jobs.hox_prof.payout = {
		290000,
		580000,
		1450000,
		2900000,
		3800000,
		3800000,
		3800000
	}
	self.jobs.hox_prof.experience_mul = {
		2,
		2,
		2,
		2,
		2,
		2,
		2
	}
	self.jobs.hox_prof.contract_cost = {
		62000,
		124000,
		310000,
		620000,
		800000,
		800000,
		800000
	}

	self.jobs.peta_prof = deep_clone(self.jobs.peta)
	self.jobs.peta_prof.jc = 70
	self.jobs.peta_prof.professional = true
	self.jobs.peta_prof.region = "professional"
	self.jobs.peta_prof.contract_cost = {
		62000,
		124000,
		310000,
		620000,
		800000,
		800000,
		800000
	}
	self.jobs.peta_prof.payout = {
		290000,
		580000,
		1450000,
		2900000,
		3800000,
		3800000,
		3800000
	}
	
	self.jobs.born_pro = deep_clone(self.jobs.born)
	self.jobs.born_pro.jc = 70
	self.jobs.born_pro.professional = true
	self.jobs.born_pro.region = "professional"
	self.jobs.born_pro.contract_cost = {
		62000,
		124000,
		310000,
		620000,
		800000,
		800000,
		800000
	}
	self.jobs.born_pro.payout = {
		175000,
		357000,
		900307,
		1750000,
		2370000,
		2370000,
		2370000
	}
	self.jobs.born_pro.experience_mul = {
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5
	}	

	if not _G.ch_settings.settings.u24_progress then
		self.jobs.man.professional = true
		self.jobs.man.region = "professional"

		self.jobs.run.professional = true
		self.jobs.run.region = "professional"

		self.jobs.glace.professional = true
		self.jobs.glace.region = "professional"

		self.jobs.nmh.professional = true
		self.jobs.nmh.region = "professional"

		self.jobs.vit.professional = true
		self.jobs.vit.region = "professional"
		self.jobs.vit.payout = {
			90000,
			225000,
			350000,
			650000,
			800000,
			700000,
			700000
		}
		self.jobs.vit.contract_cost = {
			34000,
			58000,
			220000,
			340000,
			400000,
			300000,
			300000
		}

		self.jobs.pbr.heat = {this_job = -25, other_jobs = 20}
		self.jobs.pbr.jc = 50
		self.jobs.pbr.professional = true
		self.jobs.pbr.region = "professional"
		self.jobs.pbr.payout = {
			85000,
			74000,
			125000,
			185000,
			260000,
			260000,
			260000
		}
		self.jobs.pbr.contract_cost = {
			37200,
			97000,
			200000,
			415000,
			520000,
			520000,
			520000
		}
	else
		self.jobs.family.payout = {
			37000,
			43000,
			60000,
			70000,
			81000
		}

		self.jobs.roberts.payout = {
			26000,
			37000,
			81000,
			101000,
			202000
		}

		self.jobs.jewelry_store.payout = {
			37000,
			43000,
			60000,
			70000,
			80000
		}

		self.jobs.run.payout = {
			13000,
			27500,
			68000,
			100000,
			158000
		}

		self.jobs.red2.payout = {
			12500,
			25000,
			62500,
			125000,
			162500
		}

		self.jobs.glace.payout = {
			14000,
			28000,
			69000,
			143000,
			158000
		}

		self.jobs.dah.payout = {
			12500,
			32500,
			62500,
			105000,
			135000
		}

		self.jobs.pal.payout = {
			14000,
			28000,
			50000,
			95000,
			120500
		}

		self.jobs.flat.payout = {
			15000,
			29000,
			65000,
			127500,
			150000
		}

		self.jobs.dinner.payout = {
			12000,
			20000,
			45000,
			90000,
			125000
		}

		self.jobs.man.payout = {
			11250,
			22000,
			50000,
			70000,
			100000
		}

		self.jobs.nmh.payout = {
			30000,
			37000,
			62500,
			92500,
			130000
		}

		self.jobs.framing_frame.payout = {
			60000,
			75000,
			125000,
			185000,
			270000
		}

		self.jobs.welcome_to_the_jungle_wrapper_prof.payout = {
			20000,
			36000,
			50000,
			90000,
			150000
		}

		self.jobs.four_stores.payout = {
			15000,
			25000,
			40000,
			60000,
			72000
		}

		self.jobs.mallcrasher.payout = {
			35000,
			40000,
			50000,
			60000,
			70000
		}

		self.jobs.nightclub.payout = {
			20000,
			22500,
			40000,
			60000,
			80000
		}
	end
	
	if not _G.ch_settings.settings.u24_progress then
		self._jobs_index = {
			"jewelry_store",
			"four_stores",
			"nightclub",
			"mallcrasher",
			"ukrainian_job_prof",
			"branchbank_deposit",
			"branchbank_cash",
			"branchbank_prof",
			"branchbank_gold_prof",
			"firestarter",
			"firestarter_prof",
			"alex",
			"alex_prof",
			"watchdogs_wrapper",
			"watchdogs_wrapper_prof",
			"watchdogs_night",
			"watchdogs",
			"framing_frame",
			"framing_frame_prof",
			"welcome_to_the_jungle_wrapper_prof",
			"welcome_to_the_jungle_prof",
			"welcome_to_the_jungle_night_prof",
			"family",
			"election_day",
			"election_day_prof",
			"kosugi",
			"arm_fac",
			"arm_par",
			"arm_hcm",
			"arm_und",
			"arm_cro",
			"arm_for",
			"big",
			"mia",
			"mia_prof",
			"gallery",
			"hox",
			"hox_prof",
			"hox_3",
			"pines",
			"cage",
			"mus",
			"crojob1",
			"crojob_wrapper",
			"crojob2",
			"crojob2_night",
			"rat",
			"shoutout_raid",
			"arena",
			"kenaz",
			"jolly",
			"red2",
			"dinner",
			"nail",
			"cane",
			"pbr",
			"pbr2",
			"peta",
			"peta_prof",
			"pal",
			"man",
			"mad",
			"dark",
			"born",
			"born_pro",
			"chill",
			"chill_combat",
			"friend",
			"flat",
			"help",
			"haunted",
			"spa",
			"fish",
			"moon",
			"run",
			"glace",
			"dah",
			"rvd",
			"crime_spree",
			"hvh",
			"wwh",
			"brb",
			"tag",
			"des",
			"nmh",
			"sah",
			"skm_mus",
			"skm_red2",
			"skm_run",
			"skm_watchdogs_stage2",
			"skm_cas",
			"skm_big2",
			"skm_mallcrasher",
			"skm_arena",
			"skm_bex",
			"vit",
			"bph",
			"mex",
			"mex_cooking",
			"bex",
			"pex",
			"fex",
			"chas",
			"sand",
			"roberts",
			"chca",
			"pent",
            "ranc"
		}
	else
		self._jobs_index = {
			"welcome_to_the_jungle_wrapper_prof",
			"welcome_to_the_jungle_prof",
			"welcome_to_the_jungle_night_prof",
			"framing_frame",
			"framing_frame_prof",
			"watchdogs_wrapper",
			"watchdogs_wrapper_prof",
			"watchdogs_night",
			"watchdogs",
			"alex",
			"alex_prof",
			"firestarter",
			"firestarter_prof",
			"ukrainian_job_prof",
			"jewelry_store",
			"four_stores",
			"nightclub",
			"mallcrasher",
			"branchbank_deposit",
			"branchbank_cash",
			"branchbank_gold_prof",
			"branchbank_prof",
			"family",
			"roberts",
			"arm_fac",
			"arm_par",
			"arm_hcm",
			"arm_und",
			"arm_cro",
			"pal",
			"dah",
			"red2",
			"glace",
			"run",
			"nmh",
			"flat",
			"dinner",
			"man"
		}
	end
end