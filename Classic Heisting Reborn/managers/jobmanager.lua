function JobManager:get_min_jc_for_player()
	local data = tweak_data.narrative.STARS[math.clamp(managers.experience:level_to_stars(), 1, 10)]
	if not data then
		return
	end
	local jcs = data.jcs
	if not jcs then
		return
	end
	local min_jc = 100
	for _, jc in ipairs(jcs) do
		min_jc = math.min(min_jc, jc)
	end
	return min_jc
end

function JobManager:get_max_jc_for_player()
	local data = tweak_data.narrative.STARS[math.clamp(managers.experience:level_to_stars(), 1, 10)]
	if not data then
		return
	end
	local jcs = data.jcs
	if not jcs then
		return
	end
	local max_jc = 0
	for _, jc in ipairs(jcs) do
		max_jc = math.max(max_jc, jc)
	end
	return max_jc
end