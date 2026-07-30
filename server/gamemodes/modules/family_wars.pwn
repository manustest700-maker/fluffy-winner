// Family War System - San Fierro zone
#if defined _family_wars_included
    #endinput
#endif
#define _family_wars_included

forward Family_WarUpdate();

#define FAM_WAR_UPDATE_MS               30000
#define FAM_WAR_POINTS_PER_INTERVAL     5
#define FAM_WAR_ZONE_MIN_X              -1794.9
#define FAM_WAR_ZONE_MIN_Y              -730.1
#define FAM_WAR_ZONE_MAX_X              -1213.9
#define FAM_WAR_ZONE_MAX_Y              -50.0

new g_fam_war_zone = -1;
new g_fam_war_points[MAX_FAMILY];
new g_fam_war_players_in_zone;
new bool:g_fam_war_active = true;
new bool:g_fam_war_joined[MAX_PLAYERS];

stock Family_WarInit()
{
    g_fam_war_zone = GangZoneCreate(FAM_WAR_ZONE_MIN_X, FAM_WAR_ZONE_MIN_Y, FAM_WAR_ZONE_MAX_X, FAM_WAR_ZONE_MAX_Y);
    if (g_fam_war_zone != -1) GangZoneShowForAll(g_fam_war_zone, 0xFFFFFF99);
    for (new i = 0; i < MAX_PLAYERS; i++) g_fam_war_joined[i] = false;
    for (new i = 0; i < MAX_FAMILY; i++) g_fam_war_points[i] = 0;
    g_fam_war_players_in_zone = 0;
    g_fam_war_active = true;
    SetTimer("Family_WarUpdate", FAM_WAR_UPDATE_MS, true);
}

public Family_WarUpdate()
{
    g_fam_war_players_in_zone = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
        if (!g_fam_war_joined[i]) continue;
        new Float:x, Float:y, Float:z;
        GetPlayerPos(i, x, y, z);
        if (x >= FAM_WAR_ZONE_MIN_X && x <= FAM_WAR_ZONE_MAX_X && y >= FAM_WAR_ZONE_MIN_Y && y <= FAM_WAR_ZONE_MAX_Y)
        {
            g_fam_war_players_in_zone++;
            new fid = p_info[i][family] - 1;
            if (fid >= 0) g_fam_war_points[fid] += FAM_WAR_POINTS_PER_INTERVAL;
        }
    }
}

stock Family_WarJoin(playerid)
{
    if (p_info[playerid][family] < 1)
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}أنت لست في عائلة.");
    g_fam_war_joined[playerid] = true;
    SendClientMessage(playerid, col_green, "* {FFFFFF}لقد انضممت إلى حرب العائلات.");
    return 1;
}

stock Family_WarLeave(playerid)
{
    g_fam_war_joined[playerid] = false;
    SendClientMessage(playerid, col_gray, "* {FFFFFF}لقد غادرت حرب العائلات.");
    return 1;
}

stock bool:Family_IsPlayerJoined(playerid)
{
    return g_fam_war_joined[playerid];
}

stock Family_GetJoinedCount()
{
    return g_fam_war_players_in_zone;
}

stock Family_WarPlayerConnect(playerid)
{
    g_fam_war_joined[playerid] = false;
    if (g_fam_war_zone != -1) GangZoneShowForPlayer(playerid, g_fam_war_zone, 0xFFFFFF99);
    return 1;
}

stock Family_WarPlayerDisconnect(playerid)
{
    g_fam_war_joined[playerid] = false;
    return 1;
}

stock Family_GetTopInfo(top, out_name[], namelen, &out_members, &out_score, out_leader[], leaderlen)
{
    new top1 = -1, top2 = -1;
    for (new f = 0; f < family_count; f++)
    {
        if (family_info[f][fam_id] <= 0) continue;
        if (top1 == -1 || g_fam_war_points[f] > g_fam_war_points[top1])
        {
            top2 = top1;
            top1 = f;
        }
        else if (top2 == -1 || g_fam_war_points[f] > g_fam_war_points[top2])
        {
            top2 = f;
        }
    }
    new fid = (top == 1) ? top1 : top2;
    if (fid == -1)
    {
        out_name[0] = EOS;
        out_members = 0;
        out_score = 0;
        out_leader[0] = EOS;
        return;
    }
    format(out_name, namelen, "%s", family_info[fid][fam_name]);
    out_members = family_info[fid][fam_members];
    out_score = g_fam_war_points[fid];
    format(out_leader, leaderlen, "%s", family_info[fid][fam_creator]);
}
