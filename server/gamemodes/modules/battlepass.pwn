// =====================================================================
//  Havana PASS - Battle Pass Season System
//  30 days season, 5 daily quests, points, 25 free + 25 VIP rewards
//  VIP track price: 20 BC (u_donate). Client UI: [!BP_UI] overlay.
//  (Devin-injected, self-contained module, CP1256)
// =====================================================================

#if defined _battlepass_included
    #endinput
#endif
#define _battlepass_included

#define BP_DAYS            30
#define BP_QPD             5
#define BP_TIERS           25
#define BP_TIER_STEP       140
#define BP_VIP_PRICE       20
#define BP_DLG             30811
#define BP_SEASON_LEN      (BP_DAYS * 86400)

// quest types
#define BPQ_KILL           1
#define BPQ_TIME           2
#define BPQ_DRIVE          3
#define BPQ_WALK           4
#define BPQ_VISIT          5

// reward types
#define BPR_MONEY          1
#define BPR_CAR            2
#define BPR_ITEM           3
#define BPR_WEAPON         4
#define BPR_XP             5
#define BPR_SKILLS         6
#define BPR_VIPDAYS        7
#define BPR_BC             8
#define BPR_SKIN           9

// ---- season state ----
new g_bp_season       = 1 ;
new g_bp_start        = 0 ;
new g_bp_season_ok    = 0 ;

// ---- player state ----
new g_bp_loaded     [ MAX_PLAYERS ] ;
new g_bp_pts        [ MAX_PLAYERS ] ;
new g_bp_vip        [ MAX_PLAYERS ] ;
new g_bp_cfree      [ MAX_PLAYERS ] ;      // claimed free rewards bitmask (25 bits)
new g_bp_cvip       [ MAX_PLAYERS ] ;      // claimed vip rewards bitmask
new g_bp_qday       [ MAX_PLAYERS ] ;
new g_bp_qprog      [ MAX_PLAYERS ] [ BP_QPD ] ;
new g_bp_qdone      [ MAX_PLAYERS ] ;      // 5-bit mask for today's quests
new g_bp_timesec    [ MAX_PLAYERS ] ;      // seconds toward the TIME quest minute
new g_bp_lastkill   [ MAX_PLAYERS ] ;      // last victim uid (anti farm)
new g_bp_lastkill_t [ MAX_PLAYERS ] ;
new Float:g_bp_lastpos [ MAX_PLAYERS ] [ 3 ] ;
new g_bp_haspos     [ MAX_PLAYERS ] ;

new const g_bp_qtype [ BP_DAYS ] [ BP_QPD ] =
{
    { 4, 1, 2, 5, 3 },
    { 2, 5, 3, 4, 1 },
    { 4, 5, 3, 1, 2 },
    { 2, 1, 5, 4, 3 },
    { 5, 2, 3, 4, 1 },
    { 2, 4, 5, 3, 1 },
    { 5, 4, 3, 1, 2 },
    { 2, 4, 5, 3, 1 },
    { 4, 2, 5, 1, 3 },
    { 3, 4, 5, 2, 1 },
    { 4, 3, 2, 1, 5 },
    { 3, 1, 4, 2, 5 },
    { 1, 2, 3, 4, 5 },
    { 5, 2, 3, 4, 1 },
    { 4, 5, 3, 1, 2 },
    { 3, 5, 4, 2, 1 },
    { 2, 4, 1, 5, 3 },
    { 1, 4, 2, 5, 3 },
    { 5, 3, 2, 4, 1 },
    { 3, 1, 4, 2, 5 },
    { 2, 5, 3, 4, 1 },
    { 3, 5, 4, 2, 1 },
    { 2, 4, 5, 3, 1 },
    { 4, 3, 2, 1, 5 },
    { 4, 5, 1, 3, 2 },
    { 2, 3, 1, 4, 5 },
    { 1, 4, 2, 3, 5 },
    { 1, 4, 3, 2, 5 },
    { 5, 1, 2, 3, 4 },
    { 4, 5, 3, 2, 1 }
} ;

new const g_bp_qparam [ BP_DAYS ] [ BP_QPD ] =
{
    { 1500, 8, 25, 0, 8 },
    { 25, 1, 12, 1000, 3 },
    { 2500, 2, 6, 4, 30 },
    { 30, 3, 3, 3000, 6 },
    { 4, 25, 10, 2000, 5 },
    { 20, 1500, 5, 10, 3 },
    { 6, 1000, 10, 4, 20 },
    { 20, 1500, 7, 8, 4 },
    { 3000, 30, 8, 3, 4 },
    { 4, 3000, 9, 20, 3 },
    { 3000, 6, 30, 4, 0 },
    { 8, 10, 1000, 30, 1 },
    { 10, 20, 10, 2500, 2 },
    { 3, 20, 10, 2000, 10 },
    { 1000, 4, 6, 4, 25 },
    { 8, 5, 1000, 25, 10 },
    { 30, 1000, 3, 6, 4 },
    { 10, 1000, 30, 7, 10 },
    { 8, 10, 20, 2500, 3 },
    { 10, 3, 1000, 30, 9 },
    { 25, 0, 8, 1500, 5 },
    { 8, 1, 3000, 25, 6 },
    { 30, 2000, 2, 4, 5 },
    { 3000, 12, 25, 8, 3 },
    { 3000, 4, 3, 6, 20 },
    { 25, 6, 8, 1000, 5 },
    { 6, 2000, 30, 4, 6 },
    { 4, 2500, 8, 25, 7 },
    { 8, 3, 25, 10, 2500 },
    { 1500, 9, 4, 30, 4 }
} ;

new const g_bp_qpts [ BP_DAYS ] [ BP_QPD ] =
{
    { 25, 40, 15, 15, 25 },
    { 15, 15, 25, 25, 40 },
    { 25, 15, 25, 40, 15 },
    { 15, 40, 15, 25, 25 },
    { 15, 15, 25, 25, 40 },
    { 15, 25, 15, 25, 40 },
    { 15, 25, 25, 40, 15 },
    { 15, 25, 15, 25, 40 },
    { 25, 15, 15, 40, 25 },
    { 25, 25, 15, 15, 40 },
    { 25, 25, 15, 40, 15 },
    { 25, 40, 25, 15, 15 },
    { 40, 15, 25, 25, 15 },
    { 15, 15, 25, 25, 40 },
    { 25, 15, 25, 40, 15 },
    { 25, 15, 25, 15, 40 },
    { 15, 25, 40, 15, 25 },
    { 40, 25, 15, 15, 25 },
    { 15, 25, 15, 25, 40 },
    { 25, 40, 25, 15, 15 },
    { 15, 15, 25, 25, 40 },
    { 25, 15, 25, 15, 40 },
    { 15, 25, 15, 25, 40 },
    { 25, 25, 15, 40, 15 },
    { 25, 15, 40, 25, 15 },
    { 15, 25, 40, 25, 15 },
    { 40, 25, 15, 25, 15 },
    { 40, 25, 25, 15, 15 },
    { 15, 40, 15, 25, 25 },
    { 25, 15, 25, 15, 40 }
} ;



// visit locations (index used by BPQ_VISIT param); client mirrors the names
new const Float:g_bp_loc [ 10 ] [ 3 ] =
{
    { 1554.44, -1675.63, 16.19 },   // LSPD
    { 1172.94, -1323.35, 15.40 },   // All Saints Hospital
    { 2036.94, -1412.34, 17.16 },   // Unity Station
    { 1310.62, -1367.58, 13.55 },   // Downtown LS
    { 2495.36, -1687.53, 13.51 },   // Grove Street
    { 1642.61, -2334.44, 13.55 },   // LS Airport
    { 369.95, -2010.19, 7.83 },     // Santa Maria Beach
    { 1038.02, -1340.11, 13.74 },   // Burger Shot Temple
    { 2244.49, -1665.32, 15.47 },   // Idlewood
    { 811.19, -1616.16, 13.54 }     // Marina
} ;

// ---- rewards: free track ----
new const g_bp_rf_type [ BP_TIERS ] = { 1, 5, 3, 1, 3, 1, 3, 5, 1, 2, 1, 3, 5, 9, 3, 1, 3, 2, 1, 5, 9, 3, 1, 3, 2 } ;
new const g_bp_rf_val  [ BP_TIERS ] = { 25000, 4, 11858, 40000, 4548, 60000, 11867, 8, 80000, 439, 100000, 11804, 12, 15548, 11862, 150000, 11806, 560, 200000, 16, 15613, 11877, 300000, 15065, 516 } ;
new const g_bp_rf_val2 [ BP_TIERS ] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } ;

// ---- rewards: vip track ----
new const g_bp_rv_type [ BP_TIERS ] = { 1, 8, 2, 5, 1, 6, 3, 8, 9, 2, 5, 1, 3, 8, 2, 1, 7, 5, 1, 3, 8, 9, 3, 1, 2 } ;
new const g_bp_rv_val  [ BP_TIERS ] = { 100000, 2, 415, 12, 200000, 0, 11808, 3, 15733, 445, 20, 400000, 11871, 5, 602, 500000, 7, 30, 650000, 15067, 5, 15749, 11868, 1000000, 506 } ;
new const g_bp_rv_val2 [ BP_TIERS ] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } ;

forward BP_Tick ( ) ;
forward BP_OnSeasonLoad ( ) ;
forward BP_OnPlayerLoad ( playerid ) ;
forward BP_OpenDeferred ( playerid ) ;

// ---------------------------------------------------------------------
stock BP_Init ( )
{
    SetTimer ( "BP_Tick", 5000, true ) ;
    return 1 ;
}

stock BP_EnsureTables ( )
{
    mysql_tquery ( sql_connection, "CREATE TABLE IF NOT EXISTS `havana_bp_season` (`id` INT NOT NULL, `season` INT NOT NULL DEFAULT 1, `start` INT NOT NULL DEFAULT 0, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8", "", "" ) ;
    mysql_tquery ( sql_connection, "CREATE TABLE IF NOT EXISTS `havana_bp` (`uid` INT NOT NULL, `season` INT NOT NULL DEFAULT 1, `pts` INT NOT NULL DEFAULT 0, `vip` TINYINT NOT NULL DEFAULT 0, `cfree` INT NOT NULL DEFAULT 0, `cvip` INT NOT NULL DEFAULT 0, `qday` INT NOT NULL DEFAULT 0, `qdone` INT NOT NULL DEFAULT 0, `qp0` INT NOT NULL DEFAULT 0, `qp1` INT NOT NULL DEFAULT 0, `qp2` INT NOT NULL DEFAULT 0, `qp3` INT NOT NULL DEFAULT 0, `qp4` INT NOT NULL DEFAULT 0, PRIMARY KEY (`uid`)) ENGINE=InnoDB DEFAULT CHARSET=utf8", "", "" ) ;
    mysql_tquery ( sql_connection, "SELECT `season`,`start` FROM `havana_bp_season` WHERE `id`='1' LIMIT 1", "BP_OnSeasonLoad", "" ) ;
    return 1 ;
}

public BP_OnSeasonLoad ( )
{
    new q [ 160 ] ;
    if ( ! cache_num_rows ( ) )
    {
        g_bp_season = 1 ;
        g_bp_start  = gettime ( ) ;
        format ( q, sizeof q, "INSERT INTO `havana_bp_season` (`id`,`season`,`start`) VALUES ('1','%d','%d')", g_bp_season, g_bp_start ) ;
        mysql_tquery ( sql_connection, q, "", "" ) ;
    }
    else
    {
        g_bp_season = cache_get_field_content_int ( 0, "season", sql_connection ) ;
        g_bp_start  = cache_get_field_content_int ( 0, "start",  sql_connection ) ;
    }
    g_bp_season_ok = 1 ;
    BP_CheckSeason ( ) ;
    return 1 ;
}

stock BP_CheckSeason ( )
{
    if ( ! g_bp_season_ok ) return 0 ;
    new changed = 0 ;
    while ( gettime ( ) >= g_bp_start + BP_SEASON_LEN )
    {
        g_bp_season ++ ;
        g_bp_start += BP_SEASON_LEN ;
        changed = 1 ;
    }
    if ( changed )
    {
        new q [ 160 ] ;
        format ( q, sizeof q, "UPDATE `havana_bp_season` SET `season`='%d', `start`='%d' WHERE `id`='1' LIMIT 1", g_bp_season, g_bp_start ) ;
        mysql_tquery ( sql_connection, q, "", "" ) ;
        // reset in-memory progress of online players; DB rows reset lazily
        foreach(new i : logged_players)
        {
            if ( g_bp_loaded [ i ] ) BP_ResetPlayer ( i ), BP_Save ( i ) ;
        }
    }
    return 1 ;
}

stock BP_CurDay ( )
{
    if ( ! g_bp_season_ok ) return 1 ;
    new day = ( gettime ( ) - g_bp_start ) / 86400 + 1 ;
    if ( day < 1 ) day = 1 ;
    if ( day > BP_DAYS ) day = BP_DAYS ;
    return day ;
}

stock BP_DaysLeft ( )
{
    if ( ! g_bp_season_ok ) return BP_DAYS ;
    new left = ( g_bp_start + BP_SEASON_LEN - gettime ( ) ) / 86400 + 1 ;
    if ( left < 0 ) left = 0 ;
    if ( left > BP_DAYS ) left = BP_DAYS ;
    return left ;
}

stock BP_ResetPlayer ( playerid )
{
    g_bp_pts   [ playerid ] = 0 ;
    g_bp_vip   [ playerid ] = 0 ;
    g_bp_cfree [ playerid ] = 0 ;
    g_bp_cvip  [ playerid ] = 0 ;
    g_bp_qday  [ playerid ] = BP_CurDay ( ) ;
    g_bp_qdone [ playerid ] = 0 ;
    for ( new s = 0 ; s < BP_QPD ; s ++ ) g_bp_qprog [ playerid ] [ s ] = 0 ;
    g_bp_timesec [ playerid ] = 0 ;
    return 1 ;
}

stock BP_OnConnect ( playerid )
{
    g_bp_loaded [ playerid ] = 0 ;
    g_bp_haspos [ playerid ] = 0 ;
    g_bp_lastkill [ playerid ] = 0 ;
    g_bp_lastkill_t [ playerid ] = 0 ;
    BP_ResetPlayer ( playerid ) ;
    return 1 ;
}

stock BP_OnDisconnect ( playerid )
{
    if ( g_bp_loaded [ playerid ] && p_info [ playerid ] [ id ] > 0 ) BP_Save ( playerid ) ;
    g_bp_loaded [ playerid ] = 0 ;
    return 1 ;
}

stock BP_LoadProgress ( playerid )
{
    if ( p_info [ playerid ] [ id ] <= 0 ) return 0 ;
    new q [ 200 ] ;
    format ( q, sizeof q, "SELECT * FROM `havana_bp` WHERE `uid`='%d' LIMIT 1", p_info [ playerid ] [ id ] ) ;
    mysql_tquery ( sql_connection, q, "BP_OnPlayerLoad", "i", playerid ) ;
    return 1 ;
}

public BP_OnPlayerLoad ( playerid )
{
    if ( ! IsPlayerConnected ( playerid ) ) return 0 ;
    BP_CheckSeason ( ) ;
    if ( ! cache_num_rows ( ) )
    {
        BP_ResetPlayer ( playerid ) ;
        g_bp_loaded [ playerid ] = 1 ;
        BP_Save ( playerid ) ;
        return 1 ;
    }
    new row_season = cache_get_field_content_int ( 0, "season", sql_connection ) ;
    if ( row_season != g_bp_season )
    {
        BP_ResetPlayer ( playerid ) ;
        g_bp_loaded [ playerid ] = 1 ;
        BP_Save ( playerid ) ;
        return 1 ;
    }
    g_bp_pts   [ playerid ] = cache_get_field_content_int ( 0, "pts",   sql_connection ) ;
    g_bp_vip   [ playerid ] = cache_get_field_content_int ( 0, "vip",   sql_connection ) ;
    g_bp_cfree [ playerid ] = cache_get_field_content_int ( 0, "cfree", sql_connection ) ;
    g_bp_cvip  [ playerid ] = cache_get_field_content_int ( 0, "cvip",  sql_connection ) ;
    g_bp_qday  [ playerid ] = cache_get_field_content_int ( 0, "qday",  sql_connection ) ;
    g_bp_qdone [ playerid ] = cache_get_field_content_int ( 0, "qdone", sql_connection ) ;
    g_bp_qprog [ playerid ] [ 0 ] = cache_get_field_content_int ( 0, "qp0", sql_connection ) ;
    g_bp_qprog [ playerid ] [ 1 ] = cache_get_field_content_int ( 0, "qp1", sql_connection ) ;
    g_bp_qprog [ playerid ] [ 2 ] = cache_get_field_content_int ( 0, "qp2", sql_connection ) ;
    g_bp_qprog [ playerid ] [ 3 ] = cache_get_field_content_int ( 0, "qp3", sql_connection ) ;
    g_bp_qprog [ playerid ] [ 4 ] = cache_get_field_content_int ( 0, "qp4", sql_connection ) ;
    g_bp_loaded [ playerid ] = 1 ;
    BP_DayCheck ( playerid ) ;
    return 1 ;
}

stock BP_Save ( playerid )
{
    if ( p_info [ playerid ] [ id ] <= 0 ) return 0 ;
    new q [ 420 ] ;
    format ( q, sizeof q, "REPLACE INTO `havana_bp` (`uid`,`season`,`pts`,`vip`,`cfree`,`cvip`,`qday`,`qdone`,`qp0`,`qp1`,`qp2`,`qp3`,`qp4`) VALUES ('%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d','%d')",
        p_info [ playerid ] [ id ], g_bp_season, g_bp_pts [ playerid ], g_bp_vip [ playerid ],
        g_bp_cfree [ playerid ], g_bp_cvip [ playerid ], g_bp_qday [ playerid ], g_bp_qdone [ playerid ],
        g_bp_qprog [ playerid ] [ 0 ], g_bp_qprog [ playerid ] [ 1 ], g_bp_qprog [ playerid ] [ 2 ],
        g_bp_qprog [ playerid ] [ 3 ], g_bp_qprog [ playerid ] [ 4 ] ) ;
    mysql_tquery ( sql_connection, q, "", "" ) ;
    return 1 ;
}

stock BP_DayCheck ( playerid )
{
    BP_CheckSeason ( ) ;
    new cur = BP_CurDay ( ) ;
    if ( g_bp_qday [ playerid ] != cur )
    {
        g_bp_qday  [ playerid ] = cur ;
        g_bp_qdone [ playerid ] = 0 ;
        for ( new s = 0 ; s < BP_QPD ; s ++ ) g_bp_qprog [ playerid ] [ s ] = 0 ;
        g_bp_timesec [ playerid ] = 0 ;
        if ( g_bp_loaded [ playerid ] ) BP_Save ( playerid ) ;
    }
    return 1 ;
}

// target value of a quest (in progress units)
stock BP_QTarget ( day, slot )
{
    new t = g_bp_qtype [ day - 1 ] [ slot ] ;
    new p = g_bp_qparam [ day - 1 ] [ slot ] ;
    switch ( t )
    {
        case BPQ_KILL:  return p ;
        case BPQ_TIME:  return p ;          // minutes
        case BPQ_DRIVE: return p * 1000 ;   // km -> meters
        case BPQ_WALK:  return p ;          // meters
        case BPQ_VISIT: return 1 ;
    }
    return 1 ;
}

stock BP_AddProgress ( playerid, slot, amount )
{
    if ( ! g_bp_loaded [ playerid ] ) return 0 ;
    if ( g_bp_qdone [ playerid ] & ( 1 << slot ) ) return 0 ;
    new day = g_bp_qday [ playerid ] ;
    if ( day < 1 || day > BP_DAYS ) return 0 ;
    g_bp_qprog [ playerid ] [ slot ] += amount ;
    new target = BP_QTarget ( day, slot ) ;
    if ( g_bp_qprog [ playerid ] [ slot ] >= target )
    {
        g_bp_qprog [ playerid ] [ slot ] = target ;
        g_bp_qdone [ playerid ] |= ( 1 << slot ) ;
        new pts = g_bp_qpts [ day - 1 ] [ slot ] ;
        g_bp_pts [ playerid ] += pts ;
        new msg [ 180 ] ;
        format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}أنجزت مهمة يومية! {00FF7F}+%d نقطة {FFFFFF}(المجموع: %d)", pts, g_bp_pts [ playerid ] ) ;
        SendClientMessage ( playerid, 0xFFFFFFFF, msg ) ;
        PlayerPlaySound ( playerid, 1058, 0.0, 0.0, 0.0 ) ;
        BP_Save ( playerid ) ;
    }
    return 1 ;
}

// find today's quest slot of a given type (-1 = none)
stock BP_SlotOfType ( playerid, qt )
{
    new day = g_bp_qday [ playerid ] ;
    if ( day < 1 || day > BP_DAYS ) return -1 ;
    for ( new s = 0 ; s < BP_QPD ; s ++ )
        if ( g_bp_qtype [ day - 1 ] [ s ] == qt ) return s ;
    return -1 ;
}

public BP_Tick ( )
{
    BP_CheckSeason ( ) ;
    foreach(new i : logged_players)
    {
        if ( ! g_bp_loaded [ i ] ) continue ;
        BP_DayCheck ( i ) ;
        new day = g_bp_qday [ i ] ;
        if ( day < 1 || day > BP_DAYS ) continue ;

        // TIME quest: accumulate played seconds
        new st = BP_SlotOfType ( i, BPQ_TIME ) ;
        if ( st != -1 && ! ( g_bp_qdone [ i ] & ( 1 << st ) ) )
        {
            g_bp_timesec [ i ] += 5 ;
            while ( g_bp_timesec [ i ] >= 60 )
            {
                g_bp_timesec [ i ] -= 60 ;
                BP_AddProgress ( i, st, 1 ) ;
            }
        }

        // movement quests
        new Float:px, Float:py, Float:pz ;
        GetPlayerPos ( i, px, py, pz ) ;
        if ( g_bp_haspos [ i ] )
        {
            new Float:dist = floatsqroot (
                ( px - g_bp_lastpos [ i ] [ 0 ] ) * ( px - g_bp_lastpos [ i ] [ 0 ] ) +
                ( py - g_bp_lastpos [ i ] [ 1 ] ) * ( py - g_bp_lastpos [ i ] [ 1 ] ) ) ;
            if ( dist < 300.0 )  // ignore teleports
            {
                new pstate = GetPlayerState ( i ) ;
                if ( pstate == PLAYER_STATE_DRIVER )
                {
                    new sd = BP_SlotOfType ( i, BPQ_DRIVE ) ;
                    if ( sd != -1 ) BP_AddProgress ( i, sd, floatround ( dist ) ) ;
                }
                else if ( pstate == PLAYER_STATE_ONFOOT )
                {
                    new sw = BP_SlotOfType ( i, BPQ_WALK ) ;
                    if ( sw != -1 ) BP_AddProgress ( i, sw, floatround ( dist ) ) ;
                }
            }
        }
        g_bp_lastpos [ i ] [ 0 ] = px ;
        g_bp_lastpos [ i ] [ 1 ] = py ;
        g_bp_lastpos [ i ] [ 2 ] = pz ;
        g_bp_haspos [ i ] = 1 ;

        // visit quest
        new sv = BP_SlotOfType ( i, BPQ_VISIT ) ;
        if ( sv != -1 && ! ( g_bp_qdone [ i ] & ( 1 << sv ) ) )
        {
            new loc = g_bp_qparam [ day - 1 ] [ sv ] ;
            if ( loc >= 0 && loc < 10 &&
                 IsPlayerInRangeOfPoint ( i, 25.0, g_bp_loc [ loc ] [ 0 ], g_bp_loc [ loc ] [ 1 ], g_bp_loc [ loc ] [ 2 ] ) )
                BP_AddProgress ( i, sv, 1 ) ;
        }
    }
    return 1 ;
}

stock BP_OnDeath ( playerid, killerid )
{
    if ( killerid == INVALID_PLAYER_ID || killerid == playerid ) return 0 ;
    if ( ! IsPlayerConnected ( killerid ) || ! g_bp_loaded [ killerid ] ) return 0 ;
    if ( p_info [ playerid ] [ id ] <= 0 ) return 0 ;
    // anti farm: same victim only counts once every 120 seconds
    if ( g_bp_lastkill [ killerid ] == p_info [ playerid ] [ id ] &&
         gettime ( ) - g_bp_lastkill_t [ killerid ] < 120 ) return 0 ;
    g_bp_lastkill   [ killerid ] = p_info [ playerid ] [ id ] ;
    g_bp_lastkill_t [ killerid ] = gettime ( ) ;
    new sk = BP_SlotOfType ( killerid, BPQ_KILL ) ;
    if ( sk != -1 ) BP_AddProgress ( killerid, sk, 1 ) ;
    return 1 ;
}

// ---------------------------------------------------------------------
//  UI open / responses  ([!BP_UI] ASCII payload; client owns Arabic text)
// ---------------------------------------------------------------------
stock BP_Open ( playerid )
{
    if ( ! g_bp_loaded [ playerid ] )
    {
        SendClientMessage ( playerid, 0xFFFFFFFF, "{FFD700}[Havana PASS] {FFFFFF}لم يكتمل تحميل بياناتك بعد، حاول بعد لحظات." ) ;
        return 0 ;
    }
    BP_DayCheck ( playerid ) ;

    // BC balance for the VIP purchase button
    new bc = 0 ;
    new q [ 128 ] ;
    format ( q, sizeof q, "SELECT `u_donate` FROM `users` WHERE `u_id`='%d' LIMIT 1", p_info [ playerid ] [ id ] ) ;
    new Cache:r = mysql_query ( sql_connection, q ) ;
    if ( cache_num_rows ( ) ) bc = cache_get_field_content_int ( 0, "u_donate", sql_connection ) ;
    cache_delete ( r ) ;

    new day = g_bp_qday [ playerid ] ;
    new payload [ 512 ] ;
    format ( payload, sizeof payload, "S|%d|%d|%d|%d|%d|%d|%d",
        g_bp_season, day, BP_DaysLeft ( ), g_bp_pts [ playerid ], g_bp_vip [ playerid ], bc, BP_VIP_PRICE ) ;
    for ( new s = 0 ; s < BP_QPD ; s ++ )
    {
        format ( payload, sizeof payload, "%s\nQ|%d|%d|%d|%d",
            payload,
            g_bp_qtype [ day - 1 ] [ s ], g_bp_qparam [ day - 1 ] [ s ],
            g_bp_qprog [ playerid ] [ s ], ( g_bp_qdone [ playerid ] >> s ) & 1 ) ;
    }
    format ( payload, sizeof payload, "%s\nC|%d|%d", payload, g_bp_cfree [ playerid ], g_bp_cvip [ playerid ] ) ;
    ShowPlayerDialog ( playerid, BP_DLG, DIALOG_STYLE_MSGBOX, "[!BP_UI]", payload, "", "" ) ;
    return 1 ;
}

stock BP_GiveReward ( playerid, bool:vip_track, tier )
{
    new rtype = vip_track ? g_bp_rv_type [ tier ] : g_bp_rf_type [ tier ] ;
    new rval  = vip_track ? g_bp_rv_val  [ tier ] : g_bp_rf_val  [ tier ] ;
    new rval2 = vip_track ? g_bp_rv_val2 [ tier ] : g_bp_rf_val2 [ tier ] ;
    new msg [ 200 ] ;
    switch ( rtype )
    {
        case BPR_MONEY:
        {
            give_money ( playerid, rval ) ;
            insert_money_log ( playerid, INVALID_PLAYER_ID, rval, "battlepass" ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت {00FF7F}%d${FFFFFF} من الباتل باس!", rval ) ;
        }
        case BPR_CAR:
        {
            Casino_GiveCar ( playerid, rval ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت سيارة من الباتل باس! تجدها عند أقرب معرض." ) ;
        }
        case BPR_ITEM:
        {
            new aslot = -1 ;
            for ( new j = 0 ; j < 8 ; j ++ )
            {
                if ( p_info [ playerid ] [ accessories ] [ j ] == 0 ) { aslot = j ; break ; }
            }
            if ( aslot == -1 )
            {
                SendClientMessage ( playerid, 0xFFFFFFFF, "{FFD700}[Havana PASS] {FFFFFF}خانات الإكسسوارات ممتلئة (8/8)، فرّغ خانة ثم استلم الجائزة." ) ;
                return 0 ;
            }
            p_info [ playerid ] [ accessories      ] [ aslot ] = rval ;
            p_info [ playerid ] [ accessories_used ] [ aslot ] = 0 ;
            new aq [ 200 ] ;
            format ( aq, sizeof aq,
                "UPDATE `users` SET `u_accessories`='%d|%d|%d|%d|%d|%d|%d|%d' WHERE `u_id`='%d'",
                p_info [ playerid ] [ accessories ] [ 0 ], p_info [ playerid ] [ accessories ] [ 1 ],
                p_info [ playerid ] [ accessories ] [ 2 ], p_info [ playerid ] [ accessories ] [ 3 ],
                p_info [ playerid ] [ accessories ] [ 4 ], p_info [ playerid ] [ accessories ] [ 5 ],
                p_info [ playerid ] [ accessories ] [ 6 ], p_info [ playerid ] [ accessories ] [ 7 ],
                p_info [ playerid ] [ id ] ) ;
            mysql_tquery ( sql_connection, aq, "", "" ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت اكسسوار مميز! تجده في قائمة الإكسسوارات." ) ;
        }
        case BPR_WEAPON:
        {
            give_weapon ( playerid, rval, rval2 ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت سلاح مع ذخيرة من الباتل باس!" ) ;
        }
        case BPR_XP:
        {
            p_info [ playerid ] [ exp ] += rval ;
            update_int_sql ( playerid, "u_exp", p_info [ playerid ] [ exp ] ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت {00FF7F}%d XP{FFFFFF} من الباتل باس!", rval ) ;
        }
        case BPR_SKILLS:
        {
            for ( new sk = 0 ; sk < 7 ; sk ++ ) p_info [ playerid ] [ gun_skills ] [ sk ] = 100 ;
            SetPlayerSkills ( playerid ) ;
            new qs [ 200 ] ;
            format ( qs, sizeof qs, "UPDATE `users` SET `u_skills`='100|100|100|100|100|100|100' WHERE `u_id`='%d' LIMIT 1", p_info [ playerid ] [ id ] ) ;
            mysql_tquery ( sql_connection, qs, "", "" ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}تمت ترقية جميع مهاراتك للحد الأقصى!" ) ;
        }
        case BPR_VIPDAYS:
        {
            p_info [ playerid ] [ vip ] = 1 ;
            p_info [ playerid ] [ vip_time ] += rval ;
            new qv [ 200 ] ;
            format ( qv, sizeof qv, "UPDATE `users` SET `u_vip`='1', `u_vip_time`=`u_vip_time`+'%d' WHERE `u_id`='%d' LIMIT 1", rval, p_info [ playerid ] [ id ] ) ;
            mysql_tquery ( sql_connection, qv, "", "" ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت عضوية VIP لمدة {00FF7F}%d يوم{FFFFFF}!", rval ) ;
        }
        case BPR_SKIN:
        {
            set_skin ( playerid, rval ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت سكن مميز من متجر الملابس!" ) ;
        }
        case BPR_BC:
        {
            new qb [ 160 ] ;
            format ( qb, sizeof qb, "UPDATE `users` SET `u_donate`=`u_donate`+'%d' WHERE `u_id`='%d' LIMIT 1", rval, p_info [ playerid ] [ id ] ) ;
            mysql_tquery ( sql_connection, qb, "", "" ) ;
            format ( msg, sizeof msg, "{FFD700}[Havana PASS] {FFFFFF}استلمت {00FF7F}%d BC{FFFFFF} من الباتل باس!", rval ) ;
        }
        default: return 0 ;
    }
    SendClientMessage ( playerid, 0xFFFFFFFF, msg ) ;
    PlayerPlaySound ( playerid, 1057, 0.0, 0.0, 0.0 ) ;
    return 1 ;
}

stock BP_Claim ( playerid, bool:vip_track, tier )
{
    if ( tier < 0 || tier >= BP_TIERS ) return 0 ;
    if ( ! g_bp_loaded [ playerid ] ) return 0 ;
    if ( g_bp_pts [ playerid ] < BP_TIER_STEP * ( tier + 1 ) )
    {
        SendClientMessage ( playerid, 0xFFFFFFFF, "{FFD700}[Havana PASS] {FF5555}لم تجمع نقاط كافية لهذه الجائزة بعد." ) ;
        return 0 ;
    }
    if ( vip_track )
    {
        if ( ! g_bp_vip [ playerid ] )
        {
            SendClientMessage ( playerid, 0xFFFFFFFF, "{FFD700}[Havana PASS] {FF5555}هذه الجائزة لمشتركي الباتل باس VIP فقط." ) ;
            return 0 ;
        }
        if ( g_bp_cvip [ playerid ] & ( 1 << tier ) ) return 0 ;
        g_bp_cvip [ playerid ] |= ( 1 << tier ) ;
    }
    else
    {
        if ( g_bp_cfree [ playerid ] & ( 1 << tier ) ) return 0 ;
        g_bp_cfree [ playerid ] |= ( 1 << tier ) ;
    }
    if ( ! BP_GiveReward ( playerid, vip_track, tier ) )
    {
        // delivery failed (e.g. accessory slots full) - roll back so it can be claimed later
        if ( vip_track ) g_bp_cvip  [ playerid ] &= ~( 1 << tier ) ;
        else             g_bp_cfree [ playerid ] &= ~( 1 << tier ) ;
        return 0 ;
    }
    BP_Save ( playerid ) ;
    return 1 ;
}

stock BP_BuyVip ( playerid )
{
    if ( ! g_bp_loaded [ playerid ] ) return 0 ;
    if ( g_bp_vip [ playerid ] )
    {
        SendClientMessage ( playerid, 0xFFFFFFFF, "{FFD700}[Havana PASS] {FFFFFF}أنت مشترك VIP بالفعل هذا الموسم." ) ;
        return 0 ;
    }
    new q [ 180 ] ;
    format ( q, sizeof q, "UPDATE `users` SET `u_donate`=`u_donate`-'%d' WHERE `u_id`='%d' AND `u_donate`>='%d' LIMIT 1", BP_VIP_PRICE, p_info [ playerid ] [ id ], BP_VIP_PRICE ) ;
    new Cache:r = mysql_query ( sql_connection, q ) ;
    new rows = cache_affected_rows ( sql_connection ) ;
    cache_delete ( r ) ;
    if ( rows < 1 )
    {
        SendClientMessage ( playerid, 0xFFFFFFFF, "{FFD700}[Havana PASS] {FF5555}تحتاج 20 BC لشراء الباتل باس VIP." ) ;
        return 0 ;
    }
    g_bp_vip [ playerid ] = 1 ;
    BP_Save ( playerid ) ;
    SendClientMessage ( playerid, 0xFFFFFFFF, "{FFD700}[Havana PASS] {00FF7F}تم شراء الباتل باس VIP! جوائز المسار الذهبي صارت متاحة لك." ) ;
    return 1 ;
}

stock BP_OnResponse ( playerid, response, inputtext [ ] )
{
    if ( ! response ) return 1 ;
    if ( inputtext [ 0 ] == EOS ) return 1 ;
    if ( ! strcmp ( inputtext, "close", true ) ) return 1 ;
    if ( ! strcmp ( inputtext, "REFRESH", true ) )
    {
        BP_Open ( playerid ) ;
        return 1 ;
    }
    if ( ! strcmp ( inputtext, "BUYVIP", true ) )
    {
        BP_BuyVip ( playerid ) ;
        BP_Open ( playerid ) ;
        return 1 ;
    }
    if ( ! strcmp ( inputtext, "CLAIM ", true, 6 ) )
    {
        new track [ 8 ], tier ;
        if ( sscanf ( inputtext [ 6 ], "s[8]d", track, tier ) ) return 1 ;
        BP_Claim ( playerid, ( track [ 0 ] == 'V' || track [ 0 ] == 'v' ), tier ) ;
        BP_Open ( playerid ) ;
        return 1 ;
    }
    return 1 ;
}

public BP_OpenDeferred ( playerid )
{
    if ( ! IsPlayerConnected ( playerid ) ) return 0 ;
    BP_Open ( playerid ) ;
    return 1 ;
}

CMD:bpass ( playerid, params [ ] )
{
    return BP_Open ( playerid ) ;
}

CMD:battlepass ( playerid, params [ ] )
{
    return BP_Open ( playerid ) ;
}

CMD:phone_bpass ( playerid, params [ ] )
{
    // opened from the phone Havana PASS app; give the phone a moment to hide
    SetTimerEx ( "BP_OpenDeferred", 250, false, "d", playerid ) ;
    return 1 ;
}
