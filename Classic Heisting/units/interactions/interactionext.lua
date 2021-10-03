function BaseInteractionExt:_has_required_deployable()
	if self._tweak_data.required_deployable then
		return managers.player:has_deployable_left(self._tweak_data.required_deployable, 1)
	end

	return true
end

function BaseInteractionExt:interact(player)
	self._tweak_data_at_interact_start = nil

	local level = Global.level_data and Global.level_data.level_id or ''
	local allowed_levels = {'arm_fac', 'arm_par', 'arm_hcm', 'arm_und', 'arm_cro'}
	if table.contains(allowed_levels, level) then
		if self.tweak_data == "take_confidential_folder_event" then
			if Network:is_server() then
				managers.job:set_next_interupt_stage("arm_for")
			else
				managers.network:session():server_peer():send("take_confidential_folder_event")
			end
		end
	end

	self:_post_event(player, "sound_done")
end