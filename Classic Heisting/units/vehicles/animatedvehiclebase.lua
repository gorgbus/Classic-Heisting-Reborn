set_animated_vehicle_base_spawn_original = AnimatedVehicleBase.spawn_module
 
function AnimatedVehicleBase:spawn_module(module_unit_name, ...)
	local level = Global.level_data and Global.level_data.level_id or ''
	if type_name(module_unit_name) == "spawn_turret" and level ~= "des" and level ~= "friend" then
		return set_animated_vehicle_base_spawn_original(self, module_unit_name, ...)
	end
	
end