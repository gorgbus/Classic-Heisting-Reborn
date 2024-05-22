Hooks:PostHook(CarryData, "on_pickup_SO_administered", "RR_on_pickup_SO_administered", function(self, thief)
	thief:sound():say("l01", true) -- Get the loot!
end)