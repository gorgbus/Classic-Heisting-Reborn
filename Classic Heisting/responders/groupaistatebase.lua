local _process_recurring_grp_SO_orig = GroupAIStateBase._process_recurring_grp_SO
function GroupAIStateBase:_process_recurring_grp_SO(...)
	if _process_recurring_grp_SO_orig(self, ...) then
		managers.hud:post_event("cloaker_spawn")
		managers.network:session():send_to_peers_synched("group_ai_event", self:get_sync_event_id("cloaker_spawned"), 0)
		return true
	end
end