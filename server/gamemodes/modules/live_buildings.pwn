#if defined _live_buildings_included
    #endinput
#endif
#define _live_buildings_included

new bool:g_live_buildings_spawned = false ;

LiveBuildings_Spawn ( )
{
    // Live Russia map data removed - stock Los Santos map restored.
    if ( g_live_buildings_spawned ) return 1 ;
    g_live_buildings_spawned = true ;
    return 1 ;
}

LiveBuildings_Teleport ( playerid, preview )
{
    SetPlayerVirtualWorld ( playerid, 0 ) ;
    switch ( preview )
    {
        case 1:
        {
            SetPlayerInterior ( playerid, 2 ) ;
            SetPlayerPos ( playerid, 535.00000, 334.00000, 1201.00000 ) ;
        }
        case 2:
        {
            SetPlayerInterior ( playerid, 2 ) ;
            SetPlayerPos ( playerid, 1295.58716, -202.07288, 1203.94287 ) ;
        }
        case 3:
        {
            SetPlayerInterior ( playerid, 2 ) ;
            SetPlayerPos ( playerid, -910.93542, -2036.97803, 27.63353 ) ;
        }
        case 4:
        {
            SetPlayerInterior ( playerid, 2 ) ;
            SetPlayerPos ( playerid, 689.21564, -22.15234, 1201.47400 ) ;
        }
        case 5:
        {
            SetPlayerInterior ( playerid, 2 ) ;
            SetPlayerPos ( playerid, -981.62866, 19.26401, 1205.24121 ) ;
        }
        default: return 0 ;
    }
    return 1 ;
}
