function NetworkPeer:send(func_name, ...)
    if self:is_host() and func_name == "take_confidential_folder_event" then
        managers.job:set_next_interupt_stage("arm_for")
    end

	if not self._ip_verified then
		debug_pause("[NetworkPeer:send] ip unverified:", func_name, ...)

		return
	end

	local rpc = self._rpc

	rpc[func_name](rpc, ...)

	local send_resume = Network:get_connection_send_status(rpc)

	if type(send_resume) == "table" then
		local nr_queued_packets = 0

		for delivery_type, amount in pairs(send_resume) do
			nr_queued_packets = nr_queued_packets + amount

			if nr_queued_packets > 100 and send_resume.unreliable then
				print("[NetworkPeer:send] dropping unreliable packets", send_resume.unreliable)
				Network:drop_unreliable_packets_for_connection(rpc)

				break
			end
		end
	end
end