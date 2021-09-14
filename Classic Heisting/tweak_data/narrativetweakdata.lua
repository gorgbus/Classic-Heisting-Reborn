

Hooks:PostHook(NarrativeTweakData, "init", "init_pro_jobs", function(self)
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
	self.jobs.framing_frame_prof.jc = 60
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
	self.jobs.watchdogs_wrapper_prof.jc = 60
	self.jobs.watchdogs_wrapper_prof.professional = true
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

	self.jobs.branchbank_prof.jc = 50
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
		45000,
		55000,
		70000,
		85000,
		200000,
		200000,
		200000
	}
	self.jobs.mia_prof.contract_cost = {
		62000,
		124000,
		310000,
		620000,
		900000,
		900000,
		900000
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

	local _pro_jobs = {
		"born_pro",
		"peta_prof",
		"hox_prof",
		"mia_prof",
		"election_day_prof",
		"branchbank_gold_prof",
		"branchbank_prof",
		"watchdogs_wrapper_prof",
		"framing_frame_prof",
		"alex_prof",
		"firestarter_prof"
	}

	for _, id in pairs(_pro_jobs) do
		table.insert(self._jobs_index, id)
	end
end)