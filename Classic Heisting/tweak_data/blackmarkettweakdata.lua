function BlackMarketTweakData:_init_deployables(tweak_data)
	self.deployables = {
		doctor_bag = {}
	}
	self.deployables.doctor_bag.name_id = "bm_equipment_doctor_bag"
	self.deployables.ammo_bag = {
		name_id = "bm_equipment_ammo_bag"
	}
	self.deployables.ecm_jammer = {
		name_id = "bm_equipment_ecm_jammer"
	}
	self.deployables.sentry_gun = {
		name_id = "bm_equipment_sentry_gun"
	}
	self.deployables.trip_mine = {
		name_id = "bm_equipment_trip_mine"
	}

	self:_add_desc_from_name_macro(self.deployables)
end