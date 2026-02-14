#namespace T8SpawnPatch;

autoexec InitSystem() 
{
    compiler::detour();
    system::register("T8SpawnPatch", &Init, &PostInit, undefined);
}

Init()
{
    ShieldLog("^1T8SpawnPatch Loaded!");
}

PostInit() 
{
    // highlight active spawns (debug)
    /#
    level flag::wait_till(#"all_players_spawned");
    level flag::wait_till(#"initial_blackscreen_passed");

    wait 2;
    iPrintLnBold("Highlighting active spawns...");

    while(true)
    {
        zkeys = getarraykeys(level.zones);
        for (z = 0; z < zkeys.size; z++) {
            zone = level.zones[zkeys[z]];

            if (!IsZoneActive(zone))
            {
                foreach (a_locs in zone.a_loc_types) {
                    foreach (loc in a_locs) {
                        if (!isDefined(loc.tokens))
                            continue;
                        
                        foreach (token in loc.tokens) {
                                switch (token) {
                                case #"custom_spawner_entry":
                                case #"spawn_location":
                                case #"riser_location":
                                case #"faller_location":
                                if (isDefined(loc.o_n_obj_id)) {
                                    release_obj_id(loc.o_n_obj_id);
                                    objective_setinvisibletoall(loc.o_n_obj_id);
                                    loc.o_n_obj_id = undefined;
                                }
                                break;

                                default:
                                break;
                            }
                        }
                    }
                }
            }
            else
            {
                foreach (a_locs in zone.a_loc_types) {
                    foreach (loc in a_locs) {
                        if (!isDefined(loc.tokens))
                            continue;
                        
                            foreach (token in loc.tokens) {
                                switch (token) {
                                case #"custom_spawner_entry":
                                case #"spawn_location":
                                case #"riser_location":
                                case #"faller_location":
                                if (!isDefined(loc.o_n_obj_id)) {
                                    loc.o_n_obj_id = get_next_obj_id();

                                    objective_add(loc.o_n_obj_id, "active", loc.origin, #"hash_423a75e2700a53ab");
                                    function_da7940a3(loc.o_n_obj_id, 1);
                                }
                                break;

                                default:
                                break;
                            }
                        }
                    }
                }
            }
        }

        wait 1;
    }
    #/
}