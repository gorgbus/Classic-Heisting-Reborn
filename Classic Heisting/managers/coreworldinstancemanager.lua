local standard_spawngroups = {
	["standard"] = {
		"CS_shields",
		"CS_defend_c",
		"FBI_stealth_a",
		"FBI_defend_a",
		"CS_cops",
		"CS_tazers",
		"FBI_stealth_b",
		"CS_defend_b",
		"FBI_shields",
		"CS_tanks",
		"FBI_defend_d",
		"CS_defend_a",
		"CS_swats",
		"FBI_defend_c",
		"CS_stealth_a",
		"FBI_swats",
		"FBI_heavys",
		"FBI_tanks",
		"FBI_spoocs",
		"CS_heavys",
		"FBI_defend_b"
	},
	["standard_with_single_spooc"] = {
		"single_spooc",
		"CS_shields",
		"CS_defend_c",
		"FBI_stealth_a",
		"FBI_defend_a",
		"CS_cops",
		"CS_tazers",
		"FBI_stealth_b",
		"CS_defend_b",
		"CS_defend_a",
		"FBI_shields",
		"CS_tanks",
		"FBI_defend_d",
		"CS_swats",
		"FBI_defend_c",
		"CS_stealth_a",
		"FBI_heavys",
		"FBI_tanks",
		"FBI_spoocs",
		"CS_heavys",
		"FBI_defend_b",
		"FBI_swats"
	},
	["proprietary_pbr"] = {
		"single_spooc",
		"CS_defend_c",
		"FBI_stealth_a",
		"FBI_defend_a",
		"FBI_stealth_b",
		"CS_tazers",
		"CS_defend_b",
		"FBI_defend_d",
		"CS_defend_a",
		"FBI_defend_c",
		"CS_swats",
		"CS_stealth_a",
		"CS_heavys",
		"FBI_defend_b",
		"FBI_spoocs",
		"Phalanx",
		"FBI_heavys",
		"FBI_swats"
	}
}

local spawnpoint_delays = {
	["levels/instances/unique/are_elevator/world/world"] = {
		[100013] = {
			interval = 20, -- same as modern
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		}
	},
	["levels/instances/unique/are_ps_double_doors/world/world"] = {
		[100013] = {
			interval = 10, -- same as modern
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		}
	},
	["levels/instances/unique/cane/cane_group_spawner/world/world"] = {
		[100008] = {
			interval = 0,
			preferred_spawn_groups = {
				"CS_defend_c",
				"FBI_stealth_a",
				"FBI_defend_a",
				"FBI_stealth_b",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_defend_a",
				"CS_swats",
				"FBI_defend_c",
				"CS_stealth_a",
				"FBI_swats",
				"FBI_heavys",
				"FBI_defend_b"
			}
		},
		[100033] = {
			interval = 0,
			preferred_spawn_groups = {
				"CS_defend_c",
				"FBI_stealth_a",
				"FBI_defend_a",
				"FBI_stealth_b",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_defend_a",
				"CS_swats",
				"FBI_defend_c",
				"CS_stealth_a",
				"FBI_swats",
				"FBI_heavys",
				"FBI_defend_b",
				"CS_heavys"
			}
		},
	},
	["levels/instances/unique/chew/chew_heli_dropoff/world/world"] = {
		[100011] = {
			interval = 8,
			preferred_spawn_groups = {
				"CS_shields",
				"CS_defend_c",
				"FBI_stealth_a",
				"FBI_defend_a",
				"CS_tazers",
				"CS_cops",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_defend_a",
				"CS_swats",
				"FBI_defend_c",
				"CS_stealth_a",
				"CS_heavys",
				"FBI_defend_b",
				"FBI_spoocs",
				"FBI_heavys",
				"FBI_tanks",
				"CS_tanks",
			}
		}
	},
	["levels/instances/unique/chew/chew_tall_train/world/world"] = {
		[100088] = {
			interval = 5,
			preferred_spawn_groups = {
				"CS_defend_c",
				"FBI_stealth_a",
				"FBI_defend_a",
				"CS_cops",
				"FBI_stealth_b",
				"FBI_defend_c",
				"CS_stealth_a",
				"CS_swats",
				"CS_defend_a",
				"FBI_defend_d",
				"CS_tanks",
				"CS_defend_b",
				"FBI_swats",
				"FBI_heavys",
				"FBI_spoocs",
				"FBI_defend_b",
				"CS_heavys"
			}
		},
		[100098] = {
			interval = 50,
			preferred_spawn_groups = {
				"CS_defend_c",
				"FBI_stealth_a",
				"FBI_defend_a",
				"CS_cops",
				"FBI_stealth_b",
				"FBI_defend_c",
				"CS_stealth_a",
				"CS_swats",
				"CS_defend_a",
				"FBI_defend_d",
				"CS_tanks",
				"CS_defend_b",
				"FBI_swats",
				"FBI_heavys",
				"FBI_spoocs",
				"FBI_defend_b",
				"CS_heavys"
			}
		}
	},
	["levels/instances/unique/chew/chew_train_car/world/world"] = {
		[100598] = {
			interval = 7,
			preferred_spawn_groups = standard_spawngroups["standard"]
		},
		[100599] = {
			interval = 7,
			preferred_spawn_groups = standard_spawngroups["standard"]
		},
		[100600] = {
			interval = 7,
			preferred_spawn_groups = standard_spawngroups["standard"]
		}
	},
	["levels/instances/unique/hlm_smoke_suprise/world/world"] = {
		[100013] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard"]
		},
		[100014] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		},
		[100015] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard"]
		},
		[100016] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		},
		[100017] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		},
		[100018] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard"]
		}
	},
	["levels/instances/unique/holly_2/group_force_spawn/world/world"] = {
		[100008] = {
			interval = 0,
			preferred_spawn_groups = {
				"CS_defend_c",
				"FBI_stealth_a",
				"FBI_defend_a",
				"FBI_stealth_b",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_defend_a",
				"CS_swats",
				"FBI_defend_c",
				"CS_stealth_a",
				"FBI_swats",
				"FBI_heavys",
				"FBI_defend_b"
			}
		},
		[100033] = {
			interval = 0,
			preferred_spawn_groups = {
				"CS_defend_c",
				"FBI_stealth_a",
				"FBI_defend_a",
				"FBI_stealth_b",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_defend_a",
				"CS_swats",
				"FBI_defend_c",
				"CS_stealth_a",
				"FBI_swats",
				"FBI_heavys",
				"FBI_defend_b",
				"CS_heavys"
			}
		}
	},
	["levels/instances/unique/hox_breakout_elevator001/world/world"] = {
		[100013] = {
			interval = 45,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		}
	},
	["levels/instances/unique/hox_estate_heli_spawn/world/world"] = {
		[100012] = {
			interval = 15,
			preferred_spawn_groups = standard_spawngroups["standard"]
		}
	},
	["levels/instances/unique/hox_fbi_ceiling_breach/world/world"] = {
		[100012] = {
			interval = 15,
			preferred_spawn_groups = {
				"FBI_stealth_a",
				"FBI_defend_a",
				"CS_tazers",
				"FBI_stealth_b",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_defend_a",
				"CS_swats",
				"FBI_defend_c",
				"FBI_swats",
				"CS_stealth_a",
				"FBI_heavys",
				"FBI_spoocs",
				"FBI_defend_b",
				"CS_heavys",
				"CS_defend_c",
				"CS_tanks",
				"FBI_tanks"
			}
		}
	},
	["levels/instances/unique/kenaz/control_room/world/world"] = {
		[100605] = {
			interval = 0,
			preferred_spawn_groups = {
				"FBI_stealth_a",
				"CS_defend_c",
				"CS_tazers",
				"FBI_stealth_b",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_swats",
				"FBI_defend_c",
				"FBI_swats",
				"FBI_defend_b"
			}
		}
	},
	["levels/instances/unique/kenaz/elevator_openable/world/world"] = {
		[100013] = {
			interval = 2,
			preferred_spawn_groups = {
				"FBI_stealth_a",
				"CS_tazers",
				"CS_swats",
				"CS_defend_b",
				"FBI_stealth_b",
				"FBI_defend_d",
				"CS_defend_a",
				"FBI_swats",
				"FBI_defend_b",
				"FBI_defend_c",
				"CS_defend_c"
			}
		}
	},
	["levels/instances/unique/kenaz/security_room/world/world"] = {
		[100062] = {
			interval = 0,
			preferred_spawn_groups = {
				"CS_defend_c",
				"FBI_stealth_a",
				"CS_tazers",
				"FBI_stealth_b",
				"CS_defend_b",
				"FBI_defend_d",
				"CS_swats",
				"FBI_defend_c",
				"FBI_swats",
				"FBI_defend_b"
			}
		}
	},
	["levels/instances/unique/pbr/pbr_mountain_surface/world/world"] = {
		[101411] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		},
		[101412] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["proprietary_pbr"]
		},
		[101413] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		},
		[101414] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["proprietary_pbr"]
		},
		[101415] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["proprietary_pbr"]
		},
		[101418] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		},
		[101504] = {
			interval = 0,
			preferred_spawn_groups = standard_spawngroups["standard_with_single_spooc"]
		}
	}
}

-- If you restore old spawngroups, but add new groups. You will likely need to update your method of adding your custom groups in order to preserve the spawngroup selections restored by this mod
local _get_instance_mission_data_orig = CoreWorldInstanceManager._get_instance_mission_data
function CoreWorldInstanceManager:_get_instance_mission_data(path)
	local result = _get_instance_mission_data_orig(self, path)
	local elements = spawnpoint_delays[path]
	if elements then
		for _, element in ipairs(result.default.elements) do
			if elements[element.id] then
				local has_old_spawngroups = true
				for _, spawngroup in pairs(standard_spawngroups["standard_with_single_spooc"]) do -- unless there's a table function to check for presence of all keys
					if not tweak_data.group_ai.enemy_spawn_groups[spawngroup] then
						has_old_spawngroups = false
						break
					end
				end
			
				element.values.interval = elements[element.id].interval
				
				if has_old_spawngroups then
					element.values.preferred_spawn_groups = elements[element.id].preferred_spawn_groups
				end
			end
		end
	end

	return result
end