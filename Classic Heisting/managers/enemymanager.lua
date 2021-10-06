--[[function EnemyManager:_update_queued_tasks(t)
	local i_asap_task, asp_task_t
	
	for i_task, task_data in ipairs(self._queued_tasks) do
		if not task_data.t or t > task_data.t then
			self:_execute_queued_task(i_task)
			break
		elseif task_data.asap and (not asp_task_t or asp_task_t > task_data.t) then
			i_asap_task = i_task
			asp_task_t = task_data.t
		end
	end

	if i_asap_task and not self._queued_task_executed then
		self:_execute_queued_task(i_asap_task)
	end
	local all_clbks = self._delayed_clbks
	if all_clbks[1] and t > all_clbks[1][2] then
		local clbk = table.remove(all_clbks, 1)[3]
		clbk()
	end
end]]--