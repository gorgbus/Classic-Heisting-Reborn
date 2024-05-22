Hooks:PreHook(CopDamage, "_on_damage_received", "RR_on_damage_received", function(self, damage_info)
	local attacker_unit = damage_info and damage_info.attacker_unit
	if Network:is_server() and damage_info.result.type == "death" and alive(attacker_unit) and attacker_unit:base() then -- if this gets run on clients, don't do anything
		local weapon_unit = attacker_unit.inventory and attacker_unit:inventory() and attacker_unit:inventory():equipped_unit()
		if weapon_unit and weapon_unit:base():is_category("saw") then
			managers.groupai:state():_voice_saw(self._unit)
		elseif attacker_unit:base().sentry_gun then
			managers.groupai:state():_voice_sentry(self._unit)
		elseif attacker_unit:base().is_tripmine then -- might not work since the tripmine might've been destroyed by now
			managers.groupai:state():_voice_trip_mine(self._unit)
		end
	end
end)