function FeatureManager:announce_feature(feature_id)
    if feature_id == "dlc_gage_pack_jobs" or feature_id == "freed_old_hoxton" then
        return
    end
	if Global.skip_menu_dialogs then
		return
	end

	local announcement = self._global.announcements[feature_id]

	if not announcement then
		return
	end

	if self._global.announced[feature_id] then
		print("[FeatureManager:announce_feature] Feture already announced.", feature_id)

		return
	end

	if type(announcement) ~= "number" then
		self._global.announcements[feature_id] = 0

		return
	end

	if announcement <= 0 then
		return
	end

	local func = self[feature_id]

	if not func or not func() then
		Application:error("[FeatureManager:announce_feature] Failed announcing feature!", feature_id)
	end

	announcement = announcement - 1
	self._global.announcements[feature_id] = announcement
	self._global.announced[feature_id] = true
end