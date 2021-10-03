if _G.ch_settings.settings.u24_progress then
	function MoneyManager:get_money_by_job(job_id, difficulty)
		if not job_id or not tweak_data.narrative.jobs[job_id] then
			Application:error("Error: Missing Job =", job_id)
			return 0, 0, 0
		end
		local tweak_job = tweak_data.narrative:job_data(job_id)
		if tweak_job.payout and tweak_job.payout[difficulty] then
			local payout = tweak_job.payout[difficulty] or 0
			local base_payout = tweak_job.payout[1] or 0
			local risk_payout = payout - base_payout
			return payout, base_payout, risk_payout
		else
			local payout = 0
			local base_payout = 0
			local risk_payout = 0
			local job_chain = tweak_data.narrative:job_chain(job_id)
			for _, level in pairs(job_chain) do
				if tweak_data.narrative[level.level_id] and tweak_data.narrative[level.level_id].payout and tweak_data.narrative[level.level_id].payout[difficulty] then
					local cash = tweak_data.narrative[level.level_id].payout[difficulty] or 0
					local base_cash = tweak_data.narrative[level.level_id].payout[1] or 0
					payout = payout + cash
					base_payout = base_payout + base_cash
					risk_payout = risk_payout + (cash - base_cash)
				end
			end
			return payout, base_payout, risk_payout
		end
	end
end

function MoneyManager:get_cost_of_premium_contract(job_id, difficulty_id)
	local job_data = tweak_data.narrative:job_data(job_id)

	if not job_data then
		return 0
	end

	local stars = job_data.jc / 10
	local total_payout, base_payout, risk_payout = self:get_contract_money_by_stars(stars, difficulty_id - 2, #tweak_data.narrative:job_chain(job_id), job_id)
	local diffs = {
		"easy",
		"normal",
		"hard",
		"overkill",
		"overkill_145",
		"overkill_290"
	}

	local function has_id(tab, val)
        for index, value in ipairs(tab) do
            if value == val then
                return true
            end
        end

        return false
    end

	local jobs = {
		"welcome_to_the_jungle_prof",
		"peta_prof",
		"hox_prof",
		"hox",
		"peta",
		"welcome_to_the_jungle"
	}

	local value = total_payout * self:get_tweak_value("money_manager", "buy_premium_multiplier", diffs[difficulty_id]) + self:get_tweak_value("money_manager", "buy_premium_static_fee", diffs[difficulty_id])
	
	if has_id(jobs, job_id) and diffs[difficulty_id] == "overkill_290" then
		value = total_payout * 1.5 + self:get_tweak_value("money_manager", "buy_premium_static_fee", diffs[difficulty_id])
	end
	
	local total_value = value
	local multiplier = 1 * managers.player:upgrade_value("player", "buy_cost_multiplier", 1) * managers.player:upgrade_value("player", "crime_net_deal", 1) * managers.player:upgrade_value("player", "premium_contract_cost_multiplier", 1)
	total_value = total_value + (job_data.contract_cost and job_data.contract_cost[difficulty_id - 1] / self:get_tweak_value("money_manager", "offshore_rate") or 0)
	total_value = total_value * multiplier

	return total_value
end