Hooks:PostHook(Drill, "on_sabotage_SO_administered", "RR_on_sabotage_SO_administered", function(self, receiver_unit)
	receiver_unit:sound():say(self.is_drill and "e01" or "e02", true) -- Disable the drill! / Disable the gear!
end)

Hooks:PostHook(Drill, "on_sabotage_SO_completed", "RR_on_sabotage_SO_completed", function(self, saboteur)
	saboteur:sound():say(self.is_drill and "e05" or "e06", true) -- Drill disabled, over / Gear disabled
end)