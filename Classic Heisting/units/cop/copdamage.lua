Hooks:PreHook(CopDamage, "die", "messiah_pistol_rev", function(self, attack_data)
    local bleed_out = attack_data.attacker_unit and (attack_data.attacker_unit:character_damage().bleed_out and attack_data.attacker_unit:character_damage():bleed_out() or false) or false

	if bleed_out and not self:is_civilian(self._unit:base()._tweak_table) then
        local messiah_revive = false
        if managers.player:has_category_upgrade("player", "pistol_revive_from_bleed_out") and attack_data.weapon_unit:base():weapon_tweak_data().category == "pistol" and attack_data.attacker_unit:character_damage():consume_messiah_charge() then
            messiah_revive = true
        end
		
        if messiah_revive then
            attack_data.attacker_unit:character_damage():revive(true)
        end
	end
end)