#if defined _family_wars_compat_included
    #endinput
#endif
#define _family_wars_compat_included

#define FWS_IDLE    (0)
#define FWS_PENDING (1)
#define FWS_ACTIVE  (2)

#if !defined FAM_WAR_MIN_ONLINE
    #define FAM_WAR_MIN_ONLINE (1)
#endif
#if !defined FAM_WAR_DURATION
    #define FAM_WAR_DURATION (1800)
#endif

#define g_fw_season_pts g_fam_war_points
#define g_fw_joined g_fam_war_joined
#define FAM_IS_LEADER(%0,%1) Family_IsLeader ( %0, %1 )

stock Family_IsLeader ( playerid, family_id )
{
    if ( family_id < 0 || family_id >= MAX_FAMILY ) return 0 ;
    if ( p_info [ playerid ] [ family ] != family_id + 1 ) return 0 ;
    if ( p_info [ playerid ] [ family_rang ] < 1 || p_info [ playerid ] [ family_rang ] > 7 ) return 0 ;
    if ( p_info [ playerid ] [ family_rang ] == 7 ) return 1 ;
    return !strcmp ( p_info [ playerid ] [ name ], family_info [ family_id ] [ fam_creator ], true ) ;
}

new g_fw_wins [ MAX_FAMILY ] ;
new g_fw_losses [ MAX_FAMILY ] ;
new g_fw_state = FWS_IDLE ;
new g_fw_famA = -1 ;
new g_fw_famB = -1 ;
new g_fw_pending_expire ;
new g_fw_endtime ;
new g_fw_ptsA ;
new g_fw_ptsB ;
new g_fw_bet ;

stock Family_SaveBank ( family_id )
{
    new query [ 144 ] ;
    format ( query, sizeof query,
        "UPDATE `family` SET `fam_bank`='%d' WHERE `fam_id`='%d' LIMIT 1",
        family_info [ family_id ] [ fam_bank ], family_id + 1 ) ;
    mysql_tquery ( sql_connection, query ) ;
    return 1 ;
}

stock Family_WarChallenge ( playerid, bet, const family_name [ ] )
{
    #pragma unused playerid
    #pragma unused bet
    #pragma unused family_name
    return 1 ;
}

stock Family_WarAccept ( playerid )
{
    #pragma unused playerid
    return 1 ;
}

stock Family_WarDecline ( playerid )
{
    #pragma unused playerid
    return 1 ;
}

stock Family_WarOnKill ( killerid, playerid )
{
    #pragma unused killerid
    #pragma unused playerid
    return 1 ;
}
