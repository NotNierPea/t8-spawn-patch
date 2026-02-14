// fix co-op spawning
detour zm_round_logic<scripts\zm_common\zm_round_logic.gsc>::round_spawning() {
    if (level.zm_loc_types[#"zombie_location"].size < 1) {
        //assertmsg("<dev string:x38>");
        return;
    }
    level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), level.round_number);
    //profilestart();
    level endon(#"intermission", #"end_of_round", #"restart_round");
    if (level.intermission) {
        //profilestop();
        return;
    }
    if (zm::cheat_enabled(2)) {
        //profilestop();
        return;
    }
    if (zm_round_spawning::function_191ae5ec()) {
        //profilestop();
        return;
    }
    //profilestop();
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].zombification_time = 0;
    }
    if (!(isdefined(level.kill_counter_hud) && level.zombie_total > 0)) {
        level.zombie_total = zm_round_logic::get_zombie_count_for_round(level.round_number, level.players.size);
        level.var_38b15968 = level.zombie_total;
        level.var_9427911d = level.zombie_total;
        level.var_412516cb = level.var_2125984b;
        level.zombie_respawns = level.var_2125984b;
        level.zombie_total += level.var_2125984b;
        level notify(#"zombie_total_set");
        //waittillframeend();
        waittillframeend;
    }
    var_8dd554ee = zm_round_logic::function_1687c93(level.round_number, level.players.size);
    if (isdefined(level.zombie_total_set_func)) {
        level thread [[ level.zombie_total_set_func ]]();
    }
    level thread [[ level.var_d8d02d0e ]]();
    zm_round_spawning::function_b2dabfc();
    old_spawn = undefined;
    while (true) {
        var_404e4288 = zombie_utility::get_current_zombie_count();
        var_3cafeff5 = 0;
        while (var_404e4288 >= level.zombie_ai_limit || level.zombie_total <= 0 && !level flag::get(#"infinite_round_spawning")) {
            wait 0.1;
            zm_quick_spawning::function_367e3573();
            var_404e4288 = zombie_utility::get_current_zombie_count();
            continue;
        }
        while (zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
            zombie_utility::clear_all_corpses();
            wait 0.1;
        }
        if (flag::exists("world_is_paused")) {
            level flag::wait_till_clear("world_is_paused");
        }
        level flag::wait_till("spawn_zombies");
        while (level.zm_loc_types[#"zombie_location"].size <= 0) {
            wait 0.1;
        }
        zm_round_logic::run_custom_ai_spawn_checks();
        if (isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
            //util::wait_network_frame();
            custom_network_frame_wait();
            continue;
        }
        if (isdefined(level.var_78afc69) && [[ level.var_78afc69 ]](var_404e4288, var_8dd554ee)) {
            //util::wait_network_frame();
            custom_network_frame_wait();
            var_3cafeff5 = 1;
        } else if (isdefined(level.fn_custom_round_ai_spawn) && [[ level.fn_custom_round_ai_spawn ]]()) {
            //util::wait_network_frame();
            custom_network_frame_wait();
            var_3cafeff5 = 1;
        } else if (zm_round_spawning::function_4990741c()) {
            //util::wait_network_frame();
            custom_network_frame_wait();
            var_3cafeff5 = 1;
        } else if (isdefined(level.zombie_spawners)) {
            var_6095c0b6 = zm_round_logic::function_4e8157cd(var_404e4288, var_8dd554ee);
            var_3cafeff5 = var_6095c0b6.var_3cafeff5;
        }    
        if (var_3cafeff5) {
            wait isdefined(zombie_utility::get_zombie_var(#"zombie_spawn_delay")) ? zombie_utility::get_zombie_var(#"zombie_spawn_delay") : zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
            continue;
        }
        //util::wait_network_frame();
        custom_network_frame_wait();
    }
}