function BlackMarketTweakData:_init_projectiles(tweak_data)
	self.projectiles = {
		frag = {}
	}
	self.projectiles.frag.name_id = "bm_grenade_frag"
	self.projectiles.frag.unit = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade"
	self.projectiles.frag.unit_dummy = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade_husk"
	self.projectiles.frag.sprint_unit = "units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade_sprint"
	self.projectiles.frag.icon = "frag_grenade"
	self.projectiles.frag.dlc = "gage_pack"
	self.projectiles.frag.throwable = true
	self.projectiles.frag.max_amount = 3
	self.projectiles.frag.animation = "throw_grenade"
	self.projectiles.frag.anim_global_param = "projectile_frag"
	self.projectiles.frag.throw_allowed_expire_t = 0.1
	self.projectiles.frag.expire_t = 1.1
	self.projectiles.frag.repeat_expire_t = 1.5
	self.projectiles.frag.is_a_grenade = true
	self.projectiles.frag.is_explosive = true
	self.projectiles.frag_com = {
	}
	self._projectiles_index = {
		"frag"
	}
	local free_dlcs = tweak_data:free_dlc_list()

	for _, data in pairs(self.projectiles) do
		if free_dlcs[data.dlc] then
			data.dlc = nil
		end
	end

	self:_add_desc_from_name_macro(self.projectiles)
end