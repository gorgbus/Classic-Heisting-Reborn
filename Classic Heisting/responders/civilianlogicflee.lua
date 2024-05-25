Hooks:PostHook(CivilianLogicFlee, "on_rescue_SO_administered", "RR_on_rescue_SO_administered", function(ignore_this, data, receiver_unit)
	receiver_unit:sound():say("civ", true) -- Get the hostages!
end)