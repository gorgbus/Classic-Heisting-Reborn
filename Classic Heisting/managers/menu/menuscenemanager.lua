if _G.ch_settings.settings.card then
    function MenuSceneManager:set_character_card(peer_id, rank, unit)
        local state = unit:play_redirect(Idstring("idle_menu"))
        if rank and rank > 0 then
            unit:anim_state_machine():set_parameter(state, "husk_card" .. peer_id, 1)
            local card = rank - 1
            local card_unit = World:spawn_unit(Idstring("units/menu/menu_scene/infamy_card"), Vector3(0, 0, 0), Rotation(0, 0, 0))
            card_unit:damage():run_sequence_simple("enable_card_" .. (card < 10 and "0" or "") .. tostring(card))
            unit:link(Idstring("a_weapon_left_front"), card_unit, card_unit:orientation_object():name())
            self:_delete_character_weapon(unit, "secondary")
            self._card_units = self._card_units or {}
            self._card_units[unit:key()] = card_unit
        else
            unit:anim_state_machine():set_parameter(state, "husk" .. peer_id, 1)
        end

    end

    function MenuSceneManager:set_character_equipped_card(unit, card)
        unit = unit or self._character_unit
        local card_unit = World:spawn_unit(Idstring("units/menu/menu_scene/infamy_card"), Vector3(0, 0, 0), Rotation(0, 0, 0))
        card_unit:damage():run_sequence_simple("enable_card_" .. (card < 10 and "0" or "") .. tostring(card - 1))
        unit:link(Idstring("a_weapon_left_front"), card_unit, card_unit:orientation_object():name())
        self:_delete_character_weapon(unit, "secondary")
        self._card_units = self._card_units or {}
        self._card_units[unit:key()] = card_unit
        self:_select_character_pose()
    end

    function MenuSceneManager:_spawn_infamy_card(card)
        self._item_pos = Vector3(0, 0, 0)
        self._item_yaw = 0
        self._item_pitch = 0
        self._item_roll = 0

        mrotation.set_zero(self._item_rot)
        mrotation.set_zero(self._item_rot_mod)

        self._disable_rotate = true
        self._disable_dragging = true
        self._infamy_card_shown = true

        local unit = World:spawn_unit(Idstring("units/menu/menu_scene/infamy_card"), self._item_pos, self._item_rot)
        unit:damage():run_sequence_simple("enable_card_" .. (card < 10 and "0" or "") .. tostring(card))
        unit:damage():run_sequence_simple("card_flip_01")

        local anim_time = 2.666 + unit:anim_length(Idstring("card"))

        self:add_callback(callback(self, self, "_infamy_enable_dragging"), anim_time)
        --self._test_weapon = unit
        self:_set_item_unit(unit)
    end

    function MenuSceneManager:spawn_infamy_card(rank)
        --self:destroy_item_weapon()
        self:add_one_frame_delayed_clbk(callback(self, self, "_spawn_infamy_card", rank - 1))
        return
    end
end