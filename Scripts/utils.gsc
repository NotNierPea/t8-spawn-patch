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