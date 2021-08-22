set_animated_vehicle_base_spawn_original = AnimatedVehicleBase.spawn_module
 
function AnimatedVehicleBase:spawn_module(module_unit_name, ...)
	if type_name(module_unit_name) == "spawn_turret" and not (Global.level_data.level_id == "des" or Global.level_data.level_id == "friend") then
		return set_animated_vehicle_base_spawn_original(self, module_unit_name, ...)
	end
end