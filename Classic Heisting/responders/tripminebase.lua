Hooks:PostHook(TripMineBase, "init", "RR_init", function(self)
	self.is_tripmine = true -- used in vanilla code too but isn't actually set (as far as i can tell at least)
end)