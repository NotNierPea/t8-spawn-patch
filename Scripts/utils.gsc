custom_network_frame_wait(n_count = 1)
{
    wait 0.1 * n_count;
}

get_next_obj_id()
{
    if (!isDefined(level.numgametypereservedobjectives_spawns))
    {
        level.numgametypereservedobjectives_spawns = 0;
        level.releasedobjectives_spawns = [];
    }

    if (level.numgametypereservedobjectives_spawns < 48) {
        nextid = level.numgametypereservedobjectives_spawns;
        level.numgametypereservedobjectives_spawns++;
    } else if (level.releasedobjectives_spawns.size > 0) {
        nextid = array::pop_front(level.releasedobjectives_spawns, 0);
    }
    if (!isdefined(nextid)) {
        iprintln("limited spawns, returning 47");
        nextid = 47;
    }
    return nextid;
}

release_obj_id(objid)
{
    for (i = 0; i < level.releasedobjectives_spawns.size; i++) {
        if (objid == level.releasedobjectives_spawns[i] && objid == 11) {
            return;
        }
        //assert(objid != level.releasedobjectives_spawns[i]);
    }
    level.releasedobjectives_spawns[level.releasedobjectives_spawns.size] = objid;
}

IsZoneActive(zone)
{
    if (!isDefined(zone))
        return false;

    if (!isDefined(zone.is_enabled) || !zone.is_enabled)
        return false;

    if (!isDefined(zone.is_active) || !zone.is_active)
        return false;

    if (!isDefined(zone.is_spawning_allowed) || !zone.is_spawning_allowed)
        return false;

    return true;
}

HighlightActiveSpawns()
{
    /*
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
    */
}