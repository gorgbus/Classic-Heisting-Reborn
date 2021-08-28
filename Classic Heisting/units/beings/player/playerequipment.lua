function PlayerEquipment:use_ammo_bag()
	local ray = self:valid_shape_placement("ammo_bag")
	if ray then
		local pos = ray.position
		local rot = self._unit:movement():m_head_rot()
		rot = Rotation(rot:yaw(), 0, 0)
		PlayerStandard.say_line(self, "s01x_plu")
		managers.statistics:use_ammo_bag()
		local ammo_upgrade_lvl = managers.player:upgrade_level("ammo_bag", "ammo_increase")
		if Network:is_client() then
			managers.network:session():send_to_host("place_deployable_bag", "AmmoBagBase", pos, rot, ammo_upgrade_lvl)
		else
			local unit = AmmoBagBase.spawn(pos, rot, ammo_upgrade_lvl, managers.network:session():local_peer():id())
		end

		if managers.player:has_category_upgrade("player", "no_ammo_cost") then
			managers.player:activate_temporary_upgrade("temporary", "no_ammo_cost")
		end

		return true
	end

	return false
end