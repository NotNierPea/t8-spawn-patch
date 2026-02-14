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
    //level thread HighlightActiveSpawns();
}