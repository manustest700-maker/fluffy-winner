/*
================================================================================
    HavanaRp â€” Fisherman Job (gamemode module)
    -----------------------------------------------------------------------------
    Standalone fishing-job module intended to be `#include`d from the main
    gamemode (arabonline.pwn).  All server callbacks are exposed as regular
    functions prefixed with `Fisherman_` and must be invoked from the matching
    gamemode public callbacks.
================================================================================
*/
#if defined _fisherman_included
    #endinput
#endif
#define _fisherman_included

// --------------------------------------------------------------------------
//  CONFIG
// --------------------------------------------------------------------------

#define FISH_NPC_X              581.246704
#define FISH_NPC_Y              -2091.282470
#define FISH_NPC_Z              6.391632
#define FISH_NPC_A              56.06
#define FISH_NPC_SKIN           136

#define BOAT_NPC_X              505.574829
#define BOAT_NPC_Y              -2087.931640
#define BOAT_NPC_Z              7.540138
#define BOAT_NPC_A              246.15
#define BOAT_NPC_SKIN           171

#define BOAT_SPAWN_X            492.241943
#define BOAT_SPAWN_Y            -2090.020507
#define BOAT_SPAWN_Z            -0.383024
#define BOAT_SPAWN_A            103.52
#define BOAT_MODEL              473

#define FISH_ZONE_CX            626.229736
#define FISH_ZONE_CY            -2566.131591
#define FISH_ZONE_HALF          250.0
#define FISH_ZONE_COLOR         0xFF000099
#define FISH_ZONE_COLOR_FLASH   0xFF0000CC

#define WORKER_SKIN             171

#define PRICE_BAIT              10
#define PRICE_ROD               500
#define PRICE_BOAT              250
#define PRICE_LIC_30            10000
#define PRICE_LIC_60            18000
#define PRICE_LIC_90            25000

#define MAX_BAG_FISH            40
// No cap on per-purchase bait quantity anymore (was 20). Kept for
// backward compatibility but unused.
#define MAX_BAIT_PURCHASE       999999

// Coordinates of the decorative "pickup" markers that appear directly
// in front of each NPC (taken from the player position feedback the
// user sent -- these are the tiles the player was standing on when
// interacting with each NPC).
#define FISH_PICKUP_X           580.599426
#define FISH_PICKUP_Y           -2090.743896
#define FISH_PICKUP_Z           6.391632

#define BOAT_PICKUP_X           506.863952
#define BOAT_PICKUP_Y           -2087.901367
#define BOAT_PICKUP_Z           7.540138

// Audio IDs (SA-MP sound IDs used for various fisherman events).
#define SND_CAST                1139    // rope swing / whoosh
#define SND_CATCH               1054    // collect coin -> "got a fish"
#define SND_MISS                1055    // deny / nothing bit
#define SND_BUY                 1052    // cash register
#define SND_BOAT                1133    // boat horn
#define SND_END                 1184    // bling / finish

#define ROD_OBJECT_MODEL        18632
#define ROD_SLOT                3

#define DLG_FISH_SHOP           31401
#define DLG_FISH_LIC            31402
#define DLG_FISH_BAIT           31403
#define DLG_FISH_ROD            31404
#define DLG_FISH_BOAT_RENT      31406
#define DLG_FISH_CAST           31407
#define DLG_FISH_RESULT         31408
#define DLG_FISH_STATS          31409
#define DLG_FISH_MSG            31411
#define DLG_FISH_HUD            31412
#define DLG_FISH_CLOSE          31413

#define CAST_MIN_MS             1500
#define CAST_MAX_MS             6000
#define CAST_TIMEOUT_MS         30000   // forces a miss if the player never reels

// Radius (m) around the rented boat within which the CAST HUD works.
#define FISH_BOAT_NEAR_R        10.0

// --------------------------------------------------------------------------
//  FISH SPECIES TABLE
// --------------------------------------------------------------------------

enum e_fish_species_t
{
    fs_name[32],
    fs_min_dg,
    fs_max_dg,
    fs_chance,
    fs_price_kg,
    fs_is_rare
}

// Weights are stored in decigrams (10 dg = 1 kg).
// Regular catches are clamped to 100-3000$ via CAP_COMMON_PRICE;
// rare catches (is_rare OR weight >= 1.0kg) pay PRICE_RARE once.
static const g_fish_species[][e_fish_species_t] = {
    // name               min  max chance $/kg  rare
    { "ط³ط±ط¯ظٹظ†",          2,   6,    28,    350,  0 },
    { "ط¥ط³ظ‚ظ…ط±ظٹ",         3,   8,    22,    500,  0 },
    { "ظ‚ط§ط±ظˆطµ",          3,   8,    16,    750,  0 },
    { "ظ†ط¬ظٹظ„ ط£ط­ظ…ط±",      3,   7,    12,   1100,  0 },
    { "طھظˆظ†ط©",             4,   9,    10,   1300,  0 },
    { "ط³ظ„ظ…ظˆظ†",           4,   9,     7,   1700,  0 },
    { "ظ‡ط§ظ…ظˆط±",           4,   8,     4,   2400,  0 },
    { "ط£ط¨ظˆ ط³ظٹظپ",         5,  10,     3,   3000,  0 },
    { "ظ…ط§ط±ظ„ظٹظ†",          8,  14,     1,   3500,  1 },
    { "طھظˆظ†ط© ط°ظ‡ط¨ظٹط©",     10,  16,     1,   4000,  1 }
};

#define PRICE_RARE          25000
#define CAP_COMMON_PRICE    3000
#define CAP_COMMON_MIN      100
#define CATCH_SUCCESS_PCT   45

enum e_fish_player_t
{
    bool:fp_has_license,
    fp_license_expire,
    fp_bait,
    bool:fp_has_rod,
    bool:fp_is_working,
    bool:fp_has_boat,
    fp_boat_vehicle,
    fp_orig_skin,
    bool:fp_casting,
    fp_cast_tick,     // GetTickCount() when the line was thrown (reel timing)
    fp_bag_count,
    fp_bag_species [MAX_BAG_FISH],
    Float:fp_bag_weight[MAX_BAG_FISH],
    fp_bag_price  [MAX_BAG_FISH],
    fp_total_money,
    fp_streak,        // consecutive successful catches (resets on a miss)
    fp_best_streak,   // best streak reached this trip (for the summary)
    bool:fp_in_zone,
    fp_cur_dialog     // last fishing screen pushed to the WebView (drives /fishact)
}

static g_fp[MAX_PLAYERS][e_fish_player_t];
static bool:g_fp_loaded[MAX_PLAYERS] = { false, ... };
static g_FishCP         = -1;
static g_BoatCP         = -1;
static g_FishNPC        = -1;
static g_BoatNPC        = -1;
static g_FishZoneGZ     = -1;
static g_FishDecorObj   = -1; // rotating job-start marker above NPC
static g_BoatDecorObj   = -1; // rotating boat-rent marker above NPC
static bool:g_ZoneFlash = false;

forward Fisherman_ZoneFlash_Tick();
forward Fisherman_SetSkin(playerid, skin);
forward Fisherman_CastResolve(playerid);
forward Fisherman_CastTimeout(playerid);
forward Fisherman_CheckZone(playerid);
forward Fisherman_StartPost(playerid);
forward Fisherman_CloseUI_(playerid);
forward Fisherman_OnLoadCache(playerid);
forward Fisherman_LoadDB(playerid);
forward Fisherman_CamRestore(playerid);
forward Fisherman_CamRestoreEnd(playerid);

// --------------------------------------------------------------------------
//  HELPERS
// --------------------------------------------------------------------------

// Persistent money helper: mirrors the gamemode's give_money() behaviour.
// The main gamemode tracks every player's cash in p_info[playerid][money]
// and periodically flushes that value to the `u_money` SQL column.
// GivePlayerMoney() alone would only update the client-side HUD, so any
// fishing earnings would get wiped on reconnect.  This helper keeps both
// in sync and writes the new balance to the DB immediately.
static stock Fisherman_AddMoney(playerid, delta)
{
    p_info[playerid][money] += delta;
    GivePlayerMoney(playerid, delta);
    update_int_sql(playerid, "u_money", p_info[playerid][money]);
}

static stock Fisherman_FmtMoney(value, dest[], len)
{
    new tmp[32], i, j = 0, n = value, neg = 0;
    if (n < 0) { neg = 1; n = -n; }
    if (n == 0) { dest[0] = '$'; dest[1] = '0'; dest[2] = 0; return 1; }
    while (n > 0 && j < 30) { tmp[j++] = (n % 10) + '0'; n /= 10; }
    new out[32], k = 0;
    if (neg) out[k++] = '-';
    out[k++] = '$';
    for (i = j - 1; i >= 0; --i)
    {
        out[k++] = tmp[i];
        if (i > 0 && (i % 3) == 0) out[k++] = ',';
    }
    out[k] = 0;
    strmid(dest, out, 0, k, len);
    return 1;
}

static stock Fisherman_InZone(Float:x, Float:y)
{
    if (floatabs(x - FISH_ZONE_CX) > FISH_ZONE_HALF) return 0;
    if (floatabs(y - FISH_ZONE_CY) > FISH_ZONE_HALF) return 0;
    return 1;
}

static stock Fisherman_RandWeighted()
{
    new total = 0, i;
    for (i = 0; i < sizeof(g_fish_species); ++i)
        total += g_fish_species[i][fs_chance];
    new r = random(total) + 1;
    for (i = 0; i < sizeof(g_fish_species); ++i)
    {
        r -= g_fish_species[i][fs_chance];
        if (r <= 0) return i;
    }
    return 0;
}

static stock Fisherman_Reset(playerid)
{
    g_fp[playerid][fp_has_license]   = false;
    g_fp[playerid][fp_license_expire]= 0;
    g_fp[playerid][fp_bait]          = 0;
    g_fp[playerid][fp_has_rod]       = false;
    g_fp[playerid][fp_is_working]    = false;
    g_fp[playerid][fp_has_boat]      = false;
    g_fp[playerid][fp_boat_vehicle]  = 0;
    g_fp[playerid][fp_orig_skin]     = 0;
    g_fp[playerid][fp_casting]       = false;
    g_fp[playerid][fp_bag_count]     = 0;
    g_fp[playerid][fp_total_money]   = 0;
    g_fp[playerid][fp_streak]        = 0;
    g_fp[playerid][fp_best_streak]   = 0;
    g_fp[playerid][fp_in_zone]       = false;
    g_fp[playerid][fp_cur_dialog]    = 0;
    g_fp_loaded[playerid]            = false;
}

// --------------------------------------------------------------------------
//  DB PERSISTENCE  ( table: users, key: u_id )
//    u_fish_lic       TINYINT(1) -- legacy 0/1 flag
//    u_fish_lic_days  INT        -- days remaining on license
//    u_fish_bait      INT        -- number of bait in inventory
//    u_fish_rod       TINYINT(1) -- 1 if a rod is owned
// --------------------------------------------------------------------------

static stock Fisherman_SaveDB(playerid)
{
    if (!IsPlayerConnected(playerid))    return 0;
    if (!g_fp_loaded[playerid])          return 0;
    if (p_info[playerid][id] <= 0)       return 0;
    new days = 0;
    if (g_fp[playerid][fp_has_license])
    {
        new rem = g_fp[playerid][fp_license_expire] - gettime();
        if (rem > 0) days = rem / 86400 + 1;
    }
    new q[256];
    format(q, sizeof(q),
        "UPDATE `users` SET `u_fish_lic`='%d',`u_fish_lic_days`='%d',\
`u_fish_bait`='%d',`u_fish_rod`='%d' WHERE `u_id`='%d' LIMIT 1",
        g_fp[playerid][fp_has_license] ? 1 : 0,
        days,
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_has_rod] ? 1 : 0,
        p_info[playerid][id]);
    mysql_tquery(sql_connection, q, "", "");
    return 1;
}

public Fisherman_OnLoadCache(playerid)
{
    if (!IsPlayerConnected(playerid)) return 1;
    if (cache_get_row_count(sql_connection) < 1)
    {
        g_fp_loaded[playerid] = true;
        return 1;
    }
    new lic  = cache_get_field_content_int(0, "u_fish_lic",      sql_connection);
    new days = cache_get_field_content_int(0, "u_fish_lic_days", sql_connection);
    new bait = cache_get_field_content_int(0, "u_fish_bait",     sql_connection);
    new rod  = cache_get_field_content_int(0, "u_fish_rod",      sql_connection);
    if (days > 0)
    {
        g_fp[playerid][fp_has_license]    = true;
        g_fp[playerid][fp_license_expire] = gettime() + days * 86400;
    }
    else if (lic > 0)
    {
        // legacy license flag without stored days -- grant 30 days as a
        // grace period so existing players don't lose access.
        g_fp[playerid][fp_has_license]    = true;
        g_fp[playerid][fp_license_expire] = gettime() + 30 * 86400;
    }
    g_fp[playerid][fp_bait]    = bait;
    g_fp[playerid][fp_has_rod] = (rod > 0);
    g_fp_loaded[playerid]      = true;
    return 1;
}

public Fisherman_LoadDB(playerid)
{
    if (!IsPlayerConnected(playerid))  return 1;
    if (p_info[playerid][id] <= 0)     return 1;
    if (g_fp_loaded[playerid])         return 1;
    new q[160];
    format(q, sizeof(q),
        "SELECT `u_fish_lic`,`u_fish_lic_days`,`u_fish_bait`,`u_fish_rod` \
FROM `users` WHERE `u_id`='%d' LIMIT 1", p_info[playerid][id]);
    mysql_tquery(sql_connection, q, "Fisherman_OnLoadCache", "i", playerid);
    return 1;
}

static stock Fisherman_RemoveRod(playerid)
{
    if (IsPlayerAttachedObjectSlotUsed(playerid, ROD_SLOT))
        RemovePlayerAttachedObject(playerid, ROD_SLOT);
}

static stock Fisherman_AttachRod(playerid)
{
    Fisherman_RemoveRod(playerid);
    SetPlayerAttachedObject(playerid, ROD_SLOT, ROD_OBJECT_MODEL, 6,
        0.093, 0.026, -0.015, 80.0, 55.0, 4.0, 1.0, 1.0, 1.0);
}

static stock Fisherman_CleanupBoat(playerid)
{
    if (g_fp[playerid][fp_has_boat] && g_fp[playerid][fp_boat_vehicle] > 0)
    {
        if (IsPlayerInVehicle(playerid, g_fp[playerid][fp_boat_vehicle]))
            RemovePlayerFromVehicle(playerid);
        DestroyVehicle(g_fp[playerid][fp_boat_vehicle]);
    }
    g_fp[playerid][fp_has_boat]     = false;
    g_fp[playerid][fp_boat_vehicle] = 0;
}

// Forward-declared (used before their definitions below)
forward Fisherman_ShowShop_(playerid);
forward Fisherman_ShowLic_(playerid);
forward Fisherman_ShowBait_(playerid);
forward Fisherman_ShowRod_(playerid);
forward Fisherman_ShowBoat_(playerid);
forward Fisherman_ShowCast_(playerid);
forward Fisherman_ShowHud_(playerid);
forward Fisherman_ShowMsg_(playerid, msg[]);
forward Fisherman_ShowStats_(playerid);

static stock Fisherman_Finish(playerid, bool:payout)
{
    // Make absolutely sure the camera is back in normal 3rd-person mode
    // before we tear the fishing job down, otherwise a player who ends the
    // job mid-cast could be left with a stuck underwater camera.
    SetCameraBehindPlayer(playerid);

    if (g_fp[playerid][fp_orig_skin] > 0)
        SetPlayerSkin(playerid, g_fp[playerid][fp_orig_skin]);

    Fisherman_RemoveRod(playerid);
    Fisherman_CleanupBoat(playerid);
    if (g_FishZoneGZ >= 0)
        GangZoneHideForPlayer(playerid, g_FishZoneGZ);

    new total_money = g_fp[playerid][fp_total_money];
    new total_fish  = g_fp[playerid][fp_bag_count];

    if (payout && total_fish > 0)
    {
        // 1) Credit the player's cash balance AND persist it to SQL via
        //    the gamemode's p_info[money] path (plain GivePlayerMoney
        //    would get overwritten on the next u_money flush).
        Fisherman_AddMoney(playerid, total_money);

        // 2) Big on-screen GameText for 5 seconds summarising the haul.
        new gt[144];
        format(gt, sizeof(gt),
            "~y~ط®ظ„طµطھ ط±ط­ظ„ط© ط§ظ„طµظٹط¯~n~~w~~h~%d ط³ظ…ظƒط©~n~~g~+$%d",
            total_fish, total_money);
        GameTextForPlayer(playerid, gt, 5000, 3);

        // 3) Chat message (stays in log for reference).
        new cm[160];
        format(cm, sizeof(cm),
            "[طµظٹط¯] ط®ظ„طµطھ ط§ظ„ظٹظˆظ… ط¨ظ€ %d ط³ظ…ظƒط© ظˆط­ظˆظ‘ط´طھ $%d. طµظٹط¯ ظ…ظ…طھط§ط²!",
            total_fish, total_money);
        SendClientMessage(playerid, 0x33E48CFF, cm);

        // 4) Finish sound.
        PlayerPlaySound(playerid, SND_END, 0.0, 0.0, 0.0);

        // 5) Detailed stats dialog (per-fish breakdown).
        Fisherman_ShowStats_(playerid);
    }
    else
    {
        SendClientMessage(playerid, 0x9AA0A6FF,
            "[طµظٹط¯] ط®ظ„طµ ط§ظ„ط´ط؛ظ„. ظ…ط§ ط·ظ„ط¹ ط´ظٹ ط¨ظ‡ط§ظ„ط¬ظ„ط³ط©.");
        Fisherman_CloseUI_(playerid);
    }

    g_fp[playerid][fp_has_rod]    = false;
    g_fp[playerid][fp_is_working] = false;
    g_fp[playerid][fp_casting]    = false;
    g_fp[playerid][fp_bag_count]  = 0;
    g_fp[playerid][fp_total_money]= 0;
    Fisherman_SaveDB(playerid);
}

// --------------------------------------------------------------------------
//  DIALOGS
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
//  SAMP-mobile-safe UI push.
//  Follow-up ShowPlayerDialog() calls issued from inside OnDialogResponse are
//  silently dropped by the SAMP-mobile (Havana) client, so the launcher CEF
//  fishing UI never receives the next screen and every button looks dead.
//  We keep the ShowPlayerDialog() call (it sets the server-side pending dialog
//  so the SendDialogResponse reply still routes correctly) and ALSO push the
//  screen through a SendClientMessage sentinel -- the exact channel the casino
//  uses, which IS delivered reliably on mobile.
//    ~FISHUI~<dialogid>~<TAG>~<part>~<total>~<chunk>
//  (long bodies such as STATS are split into <=FISHUI_CHUNK byte chunks and
//   re-assembled launcher-side; cp1256 is single-byte so chunking is safe.)
// --------------------------------------------------------------------------
#if !defined FISHUI_CHUNK
    #define FISHUI_CHUNK (90)
#endif
stock Fisherman_PushUI(playerid, dialogid, const tag[], const body[])
{
    // Remember which screen the WebView is now showing so the reliable
    // /fishact reply channel can be dispatched against it server-side
    // (SA-MP mobile drops SendDialogResponse for these WebView dialogs).
    g_fp[playerid][fp_cur_dialog] = dialogid;
    new len = strlen(body);
    new total = (len + FISHUI_CHUNK - 1) / FISHUI_CHUNK;
    if (total < 1) total = 1;
    new buf[160];
    new chunk[FISHUI_CHUNK + 4];
    for (new part = 1; part <= total; ++part)
    {
        new s = (part - 1) * FISHUI_CHUNK;
        new e = s + FISHUI_CHUNK;
        if (e > len) e = len;
        chunk[0] = EOS;
        strmid(chunk, body, s, e, sizeof(chunk));
        format(buf, sizeof(buf), "~FISHUI~%d~%s~%d~%d~%s",
            dialogid, tag, part, total, chunk);
        SendClientMessage(playerid, -1, buf);
    }
    return 1;
}

public Fisherman_ShowShop_(playerid)
{
    new days_left = 0;
    if (g_fp[playerid][fp_has_license])
    {
        new rem = g_fp[playerid][fp_license_expire] - gettime();
        if (rem > 0) days_left = rem / 86400 + 1;
        else { g_fp[playerid][fp_has_license] = false; days_left = 0; }
    }
    new body[512];
    format(body, sizeof(body),
        "%d|%d|%d|%d|%d|%d",
        g_fp[playerid][fp_has_license] ? 1 : 0,
        days_left,
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_has_rod] ? 1 : 0,
        g_fp[playerid][fp_is_working] ? 1 : 0,
        GetPlayerMoney(playerid));
    ShowPlayerDialog(playerid, DLG_FISH_SHOP, DIALOG_STYLE_LIST,
        "HAVANA_FISH_SHOP", body, "ط§ط®طھط±", "ط®ط±ظˆط¬");
    Fisherman_PushUI(playerid, DLG_FISH_SHOP, "SHOP", body);
    return 1;
}

public Fisherman_ShowLic_(playerid)
{
    new body[256];
    format(body, sizeof(body),
        "30|%d\n60|%d\n90|%d",
        PRICE_LIC_30, PRICE_LIC_60, PRICE_LIC_90);
    ShowPlayerDialog(playerid, DLG_FISH_LIC, DIALOG_STYLE_LIST,
        "HAVANA_FISH_LIC", body, "ط´ط±ط§ط،", "ط±ط¬ظˆط¹");
    Fisherman_PushUI(playerid, DLG_FISH_LIC, "LIC", body);
    return 1;
}

public Fisherman_ShowBait_(playerid)
{
    // First param = unit price, second = 0 (0 means "no upper limit")
    // which the overlay interprets as unlimited bait purchase.
    ShowPlayerDialog(playerid, DLG_FISH_BAIT, DIALOG_STYLE_INPUT,
        "HAVANA_FISH_BAIT",
        "10|0",
        "ط´ط±ط§ط،", "ط±ط¬ظˆط¹");
    Fisherman_PushUI(playerid, DLG_FISH_BAIT, "BAIT", "10|0");
    return 1;
}

public Fisherman_ShowRod_(playerid)
{
    new body[128];
    format(body, sizeof(body), "%d", PRICE_ROD);
    ShowPlayerDialog(playerid, DLG_FISH_ROD, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_ROD", body, "ط´ط±ط§ط،", "ط±ط¬ظˆط¹");
    Fisherman_PushUI(playerid, DLG_FISH_ROD, "ROD", body);
    return 1;
}

public Fisherman_ShowBoat_(playerid)
{
    new body[128];
    format(body, sizeof(body), "%d", PRICE_BOAT);
    ShowPlayerDialog(playerid, DLG_FISH_BOAT_RENT, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_BOAT", body, "ط¥ظٹط¬ط§ط±", "ط±ط¬ظˆط¹");
    Fisherman_PushUI(playerid, DLG_FISH_BOAT_RENT, "BOAT", body);
    return 1;
}

// Returns 1 if the player is close enough to their rented boat to use
// the fishing HUD (i.e. they are either seated on the boat, or within
// FISH_BOAT_NEAR_R metres of it).
static stock Fisherman_NearBoat(playerid)
{
    if (!g_fp[playerid][fp_has_boat])            return 0;
    if (g_fp[playerid][fp_boat_vehicle] <= 0)    return 0;
    if (IsPlayerInVehicle(playerid,
            g_fp[playerid][fp_boat_vehicle])) return 1;
    new Float:vx, Float:vy, Float:vz;
    GetVehiclePos(g_fp[playerid][fp_boat_vehicle], vx, vy, vz);
    if (IsPlayerInRangeOfPoint(playerid, FISH_BOAT_NEAR_R, vx, vy, vz))
        return 1;
    return 0;
}

public Fisherman_ShowCast_(playerid)
{
    new body[256];
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new in_zone = Fisherman_InZone(x, y);
    new on_boat = Fisherman_NearBoat(playerid);
    format(body, sizeof(body),
        "%d|%d|%d|%d|%d|%d|%d",
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_bag_count],
        g_fp[playerid][fp_total_money],
        in_zone,
        on_boat,
        g_fp[playerid][fp_casting] ? 1 : 0,
        g_fp[playerid][fp_streak]);
    ShowPlayerDialog(playerid, DLG_FISH_CAST, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_CAST", body, "ط§ط³ط­ط¨", "ط¥ظ†ظ‡ط§ط،");
    Fisherman_PushUI(playerid, DLG_FISH_CAST, "CAST", body);
    return 1;
}

public Fisherman_ShowHud_(playerid)
{
    new body[128];
    format(body, sizeof(body), "%d|%d|%d|%d",
        g_fp[playerid][fp_bait],
        g_fp[playerid][fp_bag_count],
        g_fp[playerid][fp_total_money],
        g_fp[playerid][fp_streak]);
    ShowPlayerDialog(playerid, DLG_FISH_HUD, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_HUD", body, "ط±ظ…ظٹ", "ط¥ظ†ظ‡ط§ط،");
    Fisherman_PushUI(playerid, DLG_FISH_HUD, "HUD", body);
    return 1;
}

public Fisherman_ShowMsg_(playerid, msg[])
{
    ShowPlayerDialog(playerid, DLG_FISH_MSG, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_MSG", msg, "طھظ…ط§ظ…", "");
    Fisherman_PushUI(playerid, DLG_FISH_MSG, "MSG", msg);
    return 1;
}

// Tell the launcher CEF fishing UI to close (atm_id route -> Hide()).
// Used at the genuine terminal points of the fishing flow so the WebView
// never stays open with no live dialog behind it.
public Fisherman_CloseUI_(playerid)
{
    ShowPlayerDialog(playerid, DLG_FISH_CLOSE, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_CLOSE", " ", " ", "");
    Fisherman_PushUI(playerid, DLG_FISH_CLOSE, "CLOSE", "");
    return 1;
}

public Fisherman_ShowStats_(playerid)
{
    new body[2048], line[128];
    new n = g_fp[playerid][fp_bag_count];
    new total_price = g_fp[playerid][fp_total_money];
    new total_count = n;
    new Float:total_weight = 0.0;

    for (new i = 0; i < n; ++i)
        total_weight += g_fp[playerid][fp_bag_weight][i];

    format(body, sizeof(body), "TOTALS|%d|%d|%.1f|%d\n",
        total_count, total_price, total_weight,
        g_fp[playerid][fp_best_streak]);

    for (new i = 0; i < n; ++i)
    {
        new idx = g_fp[playerid][fp_bag_species][i];
        new is_rare = (g_fish_species[idx][fs_is_rare] != 0
                      || g_fp[playerid][fp_bag_weight][i] >= 1.0) ? 1 : 0;
        format(line, sizeof(line), "%s|%.1f|%d|%d\n",
            g_fish_species[idx][fs_name],
            g_fp[playerid][fp_bag_weight][i],
            g_fp[playerid][fp_bag_price][i],
            is_rare);
        strcat(body, line, sizeof(body));
    }

    ShowPlayerDialog(playerid, DLG_FISH_STATS, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_STATS", body, "طھظ…ط§ظ…", "");
    Fisherman_PushUI(playerid, DLG_FISH_STATS, "STATS", body);
    return 1;
}

// --------------------------------------------------------------------------
//  HOOKS
// --------------------------------------------------------------------------

stock Fisherman_OnGameModeInit()
{
    print("[Fisherman] HavanaRp fishing job â€” loading...");

    g_FishNPC = CreateDynamicActor(FISH_NPC_SKIN,
        FISH_NPC_X, FISH_NPC_Y, FISH_NPC_Z, FISH_NPC_A);
    SetDynamicActorInvulnerable(g_FishNPC, true);

    new Float:rad = FISH_NPC_A * 3.14159265 / 180.0;
    new Float:cpx = FISH_NPC_X + floatsin(-rad, radian) * 1.5;
    new Float:cpy = FISH_NPC_Y + floatcos(-rad, radian) * 1.5;
    g_FishCP = CreateDynamicCP(cpx, cpy, FISH_NPC_Z - 1.0, 2.0, -1, -1, -1, 60.0);

    // "Start work" pickup placed directly in front of the fisherman NPC
    // (clothesp model 1275).  Pickup type 1 = constant hover + rotation.
    g_FishDecorObj = CreateDynamicPickup(1275, 1,
        FISH_PICKUP_X, FISH_PICKUP_Y, FISH_PICKUP_Z,
        -1, -1, -1, 350.0);

    g_BoatNPC = CreateDynamicActor(BOAT_NPC_SKIN,
        BOAT_NPC_X, BOAT_NPC_Y, BOAT_NPC_Z, BOAT_NPC_A);
    SetDynamicActorInvulnerable(g_BoatNPC, true);

    new Float:brad = BOAT_NPC_A * 3.14159265 / 180.0;
    new Float:bcpx = BOAT_NPC_X + floatsin(-brad, radian) * 1.5;
    new Float:bcpy = BOAT_NPC_Y + floatcos(-brad, radian) * 1.5;
    g_BoatCP = CreateDynamicCP(bcpx, bcpy, BOAT_NPC_Z - 1.0, 2.0, -1, -1, -1, 60.0);

    // "Rent boat" pickup placed directly in front of the boat-rental NPC
    // (ArrowType2 model 19131).
    g_BoatDecorObj = CreateDynamicPickup(19131, 1,
        BOAT_PICKUP_X, BOAT_PICKUP_Y, BOAT_PICKUP_Z,
        -1, -1, -1, 350.0);

    g_FishZoneGZ = GangZoneCreate(
        FISH_ZONE_CX - FISH_ZONE_HALF, FISH_ZONE_CY - FISH_ZONE_HALF,
        FISH_ZONE_CX + FISH_ZONE_HALF, FISH_ZONE_CY + FISH_ZONE_HALF);

    SetTimer("Fisherman_ZoneFlash_Tick", 900, true);
    print("[Fisherman] loaded.");
    return 1;
}

// Called from gamemode's OnPlayerSpawn to (a) load the player's saved
// fisherman state from the DB the first time they spawn after login, and
// (b) refresh the local "Boat Yard" map icon for them.  MAPICON_LOCAL
// only renders while the player is close to the marker (~300 m), which
// matches the "~350 m show-when-near" behaviour requested by the user.
stock Fisherman_OnPlayerSpawn(playerid)
{
    // Icon 42 = "Boat Yard" (SA-MP boatyard radar sprite).  LOCAL mode
    // auto-hides the icon when the player is far from the marker, so
    // the map stays clean and only reveals the fishing job when the
    // player approaches the marina.
    SetPlayerMapIcon(playerid, 46,
        BOAT_NPC_X, BOAT_NPC_Y, BOAT_NPC_Z,
        42, 0, MAPICON_LOCAL);
    // Lazy-load fisherman state from DB (only once per session).
    if (!g_fp_loaded[playerid] && p_info[playerid][id] > 0)
        Fisherman_LoadDB(playerid);
    return 1;
}

public Fisherman_ZoneFlash_Tick()
{
    g_ZoneFlash = !g_ZoneFlash;
    new col = g_ZoneFlash ? FISH_ZONE_COLOR : FISH_ZONE_COLOR_FLASH;
    for (new i = 0; i < MAX_PLAYERS; ++i)
    {
        if (!IsPlayerConnected(i)) continue;
        if (g_fp[i][fp_is_working])
        {
            GangZoneStopFlashForPlayer(i, g_FishZoneGZ);
            GangZoneShowForPlayer(i, g_FishZoneGZ, col);
        }
    }
    return 1;
}

stock Fisherman_OnPlayerConnect(playerid)
{
    Fisherman_Reset(playerid);
    // Preload the SWORD animation library so the first ApplyAnimation call
    // during a cast does not freeze the client while it streams in.
    ApplyAnimation(playerid, "SWORD", "sword_block", 4.1, 0, 0, 0, 0, 1, 1);
    ClearAnimations(playerid);
    return 1;
}

stock Fisherman_OnPlayerDisconnect(playerid, reason)
{
    #pragma unused reason
    // Persist the player's fishing state to the DB before cleanup.
    Fisherman_SaveDB(playerid);
    Fisherman_CleanupBoat(playerid);
    Fisherman_RemoveRod(playerid);
    if (g_FishZoneGZ >= 0)
        GangZoneHideForPlayer(playerid, g_FishZoneGZ);
    Fisherman_Reset(playerid);
    return 1;
}

// Returns 1 if handled
stock Fisherman_OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if (checkpointid == g_FishCP)
    {
        Fisherman_ShowShop_(playerid);
        return 1;
    }
    if (checkpointid == g_BoatCP)
    {
        if (!g_fp[playerid][fp_is_working])
        {
            Fisherman_ShowMsg_(playerid,
                "ظ„ط§ط²ظ… طھط¨ط¯ط£ ط´ط؛ظ„ ط§ظ„طµظٹط¯ ط¹ظ†ط¯ ط§ظ„طµظٹظ‘ط§ط¯ ط£ظˆظ„.");
            return 1;
        }
        if (!g_fp[playerid][fp_has_rod])
        {
            Fisherman_ShowMsg_(playerid, "ط§ط´طھط±ظٹ ط³ظ†ط§ط±ط© طµظٹط¯ ط£ظˆظ„.");
            return 1;
        }
        if (g_fp[playerid][fp_bait] <= 0)
        {
            Fisherman_ShowMsg_(playerid, "ط§ط´طھط±ظٹ ط·ط¹ظ… ط£ظˆظ„.");
            return 1;
        }
        if (g_fp[playerid][fp_has_boat])
        {
            Fisherman_ShowMsg_(playerid, "ظ‚ط§ط±ط¨ظƒ ظ…ظˆط¬ظˆط¯ ط¨ط§ظ„ظ…ط§ط±ظٹظ†ط§ ط¨ط§ظ„ظپط¹ظ„.");
            return 1;
        }
        Fisherman_ShowBoat_(playerid);
        return 1;
    }
    return 0;
}

stock Fisherman_OnPlayerStateChange(playerid, newstate, oldstate)
{
    #pragma unused oldstate
    if (g_fp[playerid][fp_is_working] && newstate == PLAYER_STATE_DRIVER
        && g_fp[playerid][fp_has_boat])
    {
        SetTimerEx("Fisherman_CheckZone", 400, false, "i", playerid);
    }
    return 1;
}

public Fisherman_CheckZone(playerid)
{
    if (!IsPlayerConnected(playerid))          return 1;
    if (!g_fp[playerid][fp_is_working])        return 1;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if (Fisherman_InZone(x, y))
    {
        if (!g_fp[playerid][fp_in_zone])
        {
            g_fp[playerid][fp_in_zone] = true;
            SendClientMessage(playerid, 0x00FF00FF,
                "[طµظٹط¯] ط¯ط®ظ„طھ ظ…ظ†ط·ظ‚ط© ط§ظ„طµظٹط¯. ط§ط¶ط؛ط· (ط±ظ…ظٹ ط§ظ„ط³ظ†ط§ط±ط©) ط¹ط´ط§ظ† طھطµظٹط¯.");
            if (g_fp[playerid][fp_bait] > 0 && !g_fp[playerid][fp_casting])
                Fisherman_ShowHud_(playerid);
        }
    }
    else
    {
        if (g_fp[playerid][fp_in_zone])
        {
            g_fp[playerid][fp_in_zone] = false;
            SendClientMessage(playerid, 0xFFCC00FF,
                "[طµظٹط¯] ط·ظ„ط¹طھ ظ…ظ† ظ…ظ†ط·ظ‚ط© ط§ظ„طµظٹط¯.");
        }
    }
    SetTimerEx("Fisherman_CheckZone", 800, false, "i", playerid);
    return 1;
}

public Fisherman_SetSkin(playerid, skin)
{
    SetPlayerSkin(playerid, skin);
    Fisherman_AttachRod(playerid);
    return 1;
}

public Fisherman_StartPost(playerid)
{
    if (!IsPlayerConnected(playerid))   return 1;
    if (!g_fp[playerid][fp_is_working]) return 1;
    // Only show the red fishing gang-zone on the map -- no waypoint
    // marker at the zone centre (removed per user request).
    GangZoneShowForPlayer(playerid, g_FishZoneGZ, FISH_ZONE_COLOR);
    return 1;
}

// --------------------------------------------------------------------------
//  CINEMATIC CAMERA  (flymod-style dive when casting, smooth rise when reeling)
// --------------------------------------------------------------------------
//
//   Fisherman_CamDive        -- called right after the cast animation; the
//                               camera glides down from the player's
//                               shoulder view into a low underwater view,
//                               pointing at the hook/float.  1.8 s.
//
//   Fisherman_CamSurface     -- called when a bite resolves (catch or
//                               miss); the camera rises back to the
//                               player's boat in 1.5 s, then
//                               SetCameraBehindPlayer to return full
//                               gameplay control.
//
//   Fisherman_CamRestore     -- timer target that fires when the surface
//                               interpolation finishes, used to snap the
//                               camera behind the player cleanly.
//
static stock Fisherman_CamDive(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    // Facing angle -> unit forward vector (for "where the player is
    // looking"), so the hook sits ~5 m ahead of the player.
    new Float:a = 0.0;
    GetPlayerFacingAngle(playerid, a);
    new Float:rad = a * 3.14159265 / 180.0;
    new Float:fx = -floatsin(rad, radian);
    new Float:fy =  floatcos(rad, radian);

    // Start: slightly above+behind the player's shoulder (chase cam).
    new Float:sx = x - fx * 3.0,
        Float:sy = y - fy * 3.0,
        Float:sz = z + 2.5;
    new Float:slx = x + fx * 2.0,
        Float:sly = y + fy * 2.0,
        Float:slz = z + 0.4;

    // End: underwater, about 5 m ahead of the boat and 4 m below surface.
    new Float:ex = x + fx * 5.0,
        Float:ey = y + fy * 5.0,
        Float:ez = z - 4.0;
    new Float:elx = x + fx * 9.0,
        Float:ely = y + fy * 9.0,
        Float:elz = z - 6.5;

    // Kick off the dive â€” instant snap to the start frame then 1.8 s
    // interpolation into the underwater shot.
    SetPlayerCameraPos(playerid, sx, sy, sz);
    SetPlayerCameraLookAt(playerid, slx, sly, slz, CAMERA_CUT);
    InterpolateCameraPos(playerid, sx, sy, sz, ex, ey, ez, 1800, CAMERA_MOVE);
    InterpolateCameraLookAt(playerid,
        slx, sly, slz, elx, ely, elz, 1800, CAMERA_MOVE);
    return 1;
}

static stock Fisherman_CamSurface(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new Float:a = 0.0;
    GetPlayerFacingAngle(playerid, a);
    new Float:rad = a * 3.14159265 / 180.0;
    new Float:fx = -floatsin(rad, radian);
    new Float:fy =  floatcos(rad, radian);

    // Current underwater shot -> chase cam behind the player.
    new Float:sx = x + fx * 5.0,
        Float:sy = y + fy * 5.0,
        Float:sz = z - 4.0;
    new Float:slx = x + fx * 9.0,
        Float:sly = y + fy * 9.0,
        Float:slz = z - 6.5;

    new Float:ex = x - fx * 3.0,
        Float:ey = y - fy * 3.0,
        Float:ez = z + 2.5;
    new Float:elx = x + fx * 2.0,
        Float:ely = y + fy * 2.0,
        Float:elz = z + 0.4;

    SetPlayerCameraPos(playerid, sx, sy, sz);
    SetPlayerCameraLookAt(playerid, slx, sly, slz, CAMERA_CUT);
    InterpolateCameraPos(playerid, sx, sy, sz, ex, ey, ez, 1500, CAMERA_MOVE);
    InterpolateCameraLookAt(playerid,
        slx, sly, slz, elx, ely, elz, 1500, CAMERA_MOVE);

    // After the rise finishes, snap back to normal 3rd-person cam.
    SetTimerEx("Fisherman_CamRestore", 1600, false, "i", playerid);
    return 1;
}

public Fisherman_CamRestore(playerid)
{
    if (!IsPlayerConnected(playerid)) return 1;
    SetCameraBehindPlayer(playerid);
    return 1;
}

public Fisherman_CamRestoreEnd(playerid)
{
    if (!IsPlayerConnected(playerid)) return 1;
    SetCameraBehindPlayer(playerid);
    return 1;
}

public Fisherman_CastResolve(playerid)
{
    if (!IsPlayerConnected(playerid))    return 1;
    if (!g_fp[playerid][fp_casting])     return 1;
    g_fp[playerid][fp_casting] = false;
    // Rise back to the surface before showing the result dialog.
    Fisherman_CamSurface(playerid);

    new roll = random(100);
    new bool:caught = (roll < CATCH_SUCCESS_PCT);

    new body[256];
    if (!caught)
    {
        // A miss breaks the catch streak.
        g_fp[playerid][fp_streak] = 0;
        PlayerPlaySound(playerid, SND_MISS, 0.0, 0.0, 0.0);
        format(body, sizeof(body), "MISS|%d|%d|0|0",
            g_fp[playerid][fp_bait], g_fp[playerid][fp_bag_count]);
        ShowPlayerDialog(playerid, DLG_FISH_RESULT, DIALOG_STYLE_MSGBOX,
            "HAVANA_FISH_RESULT", body, "ظ…طھط§ط¨ط¹ط©", "ط¥ظ†ظ‡ط§ط،");
        Fisherman_PushUI(playerid, DLG_FISH_RESULT, "RESULT", body);
        return 1;
    }

    new idx = Fisherman_RandWeighted();
    new dg = g_fish_species[idx][fs_min_dg]
        + random(g_fish_species[idx][fs_max_dg]
               - g_fish_species[idx][fs_min_dg] + 1);
    new Float:weight = float(dg) / 10.0;

    new price;
    new bool:is_rare_catch = (weight >= 1.0 || g_fish_species[idx][fs_is_rare] != 0);
    if (is_rare_catch)
    {
        price = PRICE_RARE;
    }
    else
    {
        price = floatround(weight * float(g_fish_species[idx][fs_price_kg]));
        if (price < CAP_COMMON_MIN) price = CAP_COMMON_MIN;
        if (price > CAP_COMMON_PRICE) price = CAP_COMMON_PRICE;
    }

    // ---- Catch streak / combo bonus -------------------------------------
    // Each consecutive catch (no miss in between) adds +10% of the base
    // value, capped at +50% (streak level 6 and up).  This rewards staying
    // in the rhythm of casting without making the job grindy or unbalanced.
    g_fp[playerid][fp_streak] += 1;
    new streak = g_fp[playerid][fp_streak];
    if (streak > g_fp[playerid][fp_best_streak])
        g_fp[playerid][fp_best_streak] = streak;

    new lvl = streak - 1;            // 0 on the first catch of a streak
    if (lvl > 5) lvl = 5;            // cap the multiplier at +50%
    new bonus = (price * lvl) / 10;  // +10% per streak level
    new pay   = price + bonus;

    new n = g_fp[playerid][fp_bag_count];
    if (n < MAX_BAG_FISH)
    {
        g_fp[playerid][fp_bag_species][n] = idx;
        g_fp[playerid][fp_bag_weight ][n] = weight;
        g_fp[playerid][fp_bag_price  ][n] = pay;
        g_fp[playerid][fp_bag_count]      = n + 1;
        g_fp[playerid][fp_total_money]   += pay;
    }

    new rare = is_rare_catch ? 1 : 0;
    PlayerPlaySound(playerid, SND_CATCH, 0.0, 0.0, 0.0);
    // CATCH|name|weight|price|rare|bait|bag|streak|bonus
    format(body, sizeof(body), "CATCH|%s|%.1f|%d|%d|%d|%d|%d|%d",
        g_fish_species[idx][fs_name], weight, pay, rare,
        g_fp[playerid][fp_bait], g_fp[playerid][fp_bag_count],
        streak, bonus);
    ShowPlayerDialog(playerid, DLG_FISH_RESULT, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_RESULT", body, "ظ…طھط§ط¨ط¹ط©", "ط¥ظ†ظ‡ط§ط،");
    Fisherman_PushUI(playerid, DLG_FISH_RESULT, "RESULT", body);
    return 1;
}

// Safety net: if the player throws the line but never finishes reeling, this
// timer forces a miss after CAST_TIMEOUT_MS so the cast state can't soft-lock.
// A normal catch is resolved earlier by Fisherman_CastResolve when the WebView
// reports the reel is full, which clears fp_casting and makes this a no-op.
public Fisherman_CastTimeout(playerid)
{
    if (!IsPlayerConnected(playerid))    return 1;
    if (!g_fp[playerid][fp_casting])     return 1;
    g_fp[playerid][fp_casting] = false;
    g_fp[playerid][fp_streak]  = 0;
    Fisherman_CamSurface(playerid);
    PlayerPlaySound(playerid, SND_MISS, 0.0, 0.0, 0.0);
    new body[64];
    format(body, sizeof(body), "MISS|%d|%d|0|0",
        g_fp[playerid][fp_bait], g_fp[playerid][fp_bag_count]);
    ShowPlayerDialog(playerid, DLG_FISH_RESULT, DIALOG_STYLE_MSGBOX,
        "HAVANA_FISH_RESULT", body, "ظ…طھط§ط¨ط¹ط©", "ط¥ظ†ظ‡ط§ط،");
    Fisherman_PushUI(playerid, DLG_FISH_RESULT, "RESULT", body);
    return 1;
}

// Returns 1 if handled (so gamemode should `return 1` early).
stock Fisherman_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch (dialogid)
    {
        case DLG_FISH_SHOP:
        {
            if (!response) { Fisherman_CloseUI_(playerid); return 1; }
            switch (listitem)
            {
                case 0: { Fisherman_ShowLic_(playerid); return 1; }
                case 1:
                {
                    if (!g_fp[playerid][fp_has_license])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "طھط­طھط§ط¬ ط±ط®طµط© طµظٹط¯ ط£ظˆظ„.");
                        return 1;
                    }
                    Fisherman_ShowBait_(playerid);
                    return 1;
                }
                case 2:
                {
                    if (!g_fp[playerid][fp_has_license])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "طھط­طھط§ط¬ ط±ط®طµط© طµظٹط¯ ط£ظˆظ„.");
                        return 1;
                    }
                    Fisherman_ShowRod_(playerid);
                    return 1;
                }
                case 3:
                {
                    if (g_fp[playerid][fp_is_working])
                    {
                        Fisherman_Finish(playerid, true);
                        return 1;
                    }
                    if (!g_fp[playerid][fp_has_license])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "طھط­طھط§ط¬ ط±ط®طµط© طµظٹط¯ ط¹ط´ط§ظ† طھط¨ط¯ط£.");
                        return 1;
                    }
                    if (!g_fp[playerid][fp_has_rod])
                    {
                        Fisherman_ShowMsg_(playerid,
                            "ط§ط´طھط±ظٹ ط³ظ†ط§ط±ط© طµظٹط¯ ط£ظˆظ„.");
                        return 1;
                    }
                    if (g_fp[playerid][fp_bait] <= 0)
                    {
                        Fisherman_ShowMsg_(playerid,
                            "ط§ط´طھط±ظٹ ط·ط¹ظ… ظˆط§ط­ط¯ ط¹ظ„ظ‰ ط§ظ„ط£ظ‚ظ„ ط£ظˆظ„.");
                        return 1;
                    }
                    // Set the working flag + payload before any heavy ops so
                    // that the client sees the dialog close immediately.
                    g_fp[playerid][fp_orig_skin]  = GetPlayerSkin(playerid);
                    g_fp[playerid][fp_is_working] = true;
                    g_fp[playerid][fp_bag_count]  = 0;
                    g_fp[playerid][fp_total_money]= 0;
                    g_fp[playerid][fp_streak]     = 0;
                    g_fp[playerid][fp_best_streak]= 0;
                    SendClientMessage(playerid, 0x00C8FFFF,
                        "[طµظٹط¯] ط£ط¬ظ‘ط± ظ‚ط§ط±ط¨ ظ…ظ† ط§ظ„ظ…ط§ط±ظٹظ†ط§ ظˆط±ظˆط­ ظ„ظ„ظ…ظ†ط·ظ‚ط© ط§ظ„ط­ظ…ط±ط§ط،.");
                    // Defer skin/rod/gangzone/mapicon so the dialog closes
                    // without a frame-long freeze on slower devices.  The
                    // SWORD anim lib is preloaded in OnPlayerConnect.
                    SetTimerEx("Fisherman_SetSkin", 150, false, "ii",
                        playerid, WORKER_SKIN);
                    SetTimerEx("Fisherman_StartPost", 260, false, "i", playerid);
                    Fisherman_CloseUI_(playerid);
                    return 1;
                }
            }
            return 1;
        }
        case DLG_FISH_LIC:
        {
            if (!response)
            {
                Fisherman_ShowShop_(playerid);
                return 1;
            }
            new days = 30, price = PRICE_LIC_30;
            switch (listitem)
            {
                case 1: { days = 60; price = PRICE_LIC_60; }
                case 2: { days = 90; price = PRICE_LIC_90; }
            }
            if (GetPlayerMoney(playerid) < price)
            {
                Fisherman_ShowMsg_(playerid, "ظپظ„ظˆط³ظƒ ظ…ط§ طھظƒظپظٹ.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -price);
            PlayerPlaySound(playerid, SND_BUY, 0.0, 0.0, 0.0);
            g_fp[playerid][fp_has_license]   = true;
            g_fp[playerid][fp_license_expire]= gettime() + days * 86400;
            Fisherman_SaveDB(playerid);
            new msg[128];
            format(msg, sizeof(msg),
                "طھظ… ط´ط±ط§ط، ط±ط®طµط© ط§ظ„طµظٹط¯ ظ„ظ…ط¯ط© %d ظٹظˆظ….", days);
            Fisherman_ShowMsg_(playerid, msg);
            return 1;
        }
        case DLG_FISH_BAIT:
        {
            if (!response)
            {
                Fisherman_ShowShop_(playerid);
                return 1;
            }
            new qty = 0;
            if (sscanf(inputtext, "i", qty) || qty <= 0)
            {
                Fisherman_ShowMsg_(playerid, "ط§ظ„ط¹ط¯ط¯ ط؛ظٹط± طµط­ظٹط­.");
                return 1;
            }
            // Unlimited bait purchase (qty capped only by int32).
            new price = qty * PRICE_BAIT;
            if (price <= 0)
            {
                // integer overflow guard
                Fisherman_ShowMsg_(playerid, "ط§ظ„ط¹ط¯ط¯ ط؛ظٹط± طµط­ظٹط­.");
                return 1;
            }
            if (GetPlayerMoney(playerid) < price)
            {
                Fisherman_ShowMsg_(playerid, "ظپظ„ظˆط³ظƒ ظ…ط§ طھظƒظپظٹ.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -price);
            PlayerPlaySound(playerid, SND_BUY, 0.0, 0.0, 0.0);
            g_fp[playerid][fp_bait] += qty;
            Fisherman_SaveDB(playerid);
            new msg[128];
            format(msg, sizeof(msg),
                "ط§ط´طھط±ظٹطھ %d ط·ط¹ظ…. طµط§ط± ط¹ظ†ط¯ظƒ %d.",
                qty, g_fp[playerid][fp_bait]);
            Fisherman_ShowMsg_(playerid, msg);
            return 1;
        }
        case DLG_FISH_ROD:
        {
            if (!response)
            {
                Fisherman_ShowShop_(playerid);
                return 1;
            }
            if (g_fp[playerid][fp_has_rod])
            {
                Fisherman_ShowMsg_(playerid, "ط¹ظ†ط¯ظƒ ط³ظ†ط§ط±ط© ط¨ط§ظ„ظپط¹ظ„.");
                return 1;
            }
            if (GetPlayerMoney(playerid) < PRICE_ROD)
            {
                Fisherman_ShowMsg_(playerid, "ظپظ„ظˆط³ظƒ ظ…ط§ طھظƒظپظٹ.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -PRICE_ROD);
            PlayerPlaySound(playerid, SND_BUY, 0.0, 0.0, 0.0);
            g_fp[playerid][fp_has_rod] = true;
            Fisherman_SaveDB(playerid);
            Fisherman_ShowMsg_(playerid, "طھظ… ط´ط±ط§ط، ط³ظ†ط§ط±ط© ط§ظ„طµظٹط¯.");
            return 1;
        }
        case DLG_FISH_BOAT_RENT:
        {
            if (!response) { Fisherman_CloseUI_(playerid); return 1; }
            if (GetPlayerMoney(playerid) < PRICE_BOAT)
            {
                Fisherman_ShowMsg_(playerid, "ظپظ„ظˆط³ظƒ ظ…ط§ طھظƒظپظٹ.");
                return 1;
            }
            Fisherman_AddMoney(playerid, -PRICE_BOAT);
            new veh = CreateVehicle(BOAT_MODEL,
                BOAT_SPAWN_X, BOAT_SPAWN_Y, BOAT_SPAWN_Z, BOAT_SPAWN_A,
                -1, -1, -1);
            g_fp[playerid][fp_has_boat]     = true;
            g_fp[playerid][fp_boat_vehicle] = veh;
            // Full fuel + full engine health so the boat is ready to go.
            if (veh > 0)
            {
                veh_info[veh - 1][v_fuel] = 100.0;
                SetVehicleHealth(veh, 1000.0);
            }
            PutPlayerInVehicle(playerid, veh, 0);
            PlayerPlaySound(playerid, SND_BOAT, 0.0, 0.0, 0.0);
            SendClientMessage(playerid, 0x00C8FFFF,
                "[طµظٹط¯] طھظ… ط§ط³طھط¦ط¬ط§ط± ط§ظ„ظ‚ط§ط±ط¨ (ط§ظ„ط®ط²ط§ظ† ظƒط§ظ…ظ„). طھظˆط¬ظ‡ ظ„ظ„ظ…ظ†ط·ظ‚ط© ط§ظ„ط­ظ…ط±ط§ط،.");
            Fisherman_CloseUI_(playerid);
            return 1;
        }
        case DLG_FISH_HUD, DLG_FISH_CAST:
        {
            if (!response)
            {
                if (g_fp[playerid][fp_bag_count] > 0)
                    Fisherman_Finish(playerid, true);
                else
                    Fisherman_Finish(playerid, false);
                return 1;
            }
            // CAST dialog fired with response=1 while already casting -> the
            // player completed the reel (filled the line in the WebView).  The
            // launcher only sends this once the reel bar is 100% full, so we
            // resolve the catch now instead of on a blind timer.  We still
            // enforce a minimum "bite" delay so the fish can't be reeled in
            // instantly: if the reel-complete arrives too early we just re-show
            // the waiting scene and wait for a proper bite.
            if (dialogid == DLG_FISH_CAST && g_fp[playerid][fp_casting])
            {
                new elapsed = GetTickCount() - g_fp[playerid][fp_cast_tick];
                if (elapsed < CAST_MIN_MS)
                {
                    Fisherman_ShowCast_(playerid);
                    return 1;
                }
                Fisherman_CastResolve(playerid);
                return 1;
            }
            if (g_fp[playerid][fp_bait] <= 0)
            {
                Fisherman_ShowMsg_(playerid, "ط®ظ„طµ ط§ظ„ط·ط¹ظ….");
                return 1;
            }
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            if (!Fisherman_InZone(x, y))
            {
                Fisherman_ShowMsg_(playerid,
                    "ظ„ط§ط²ظ… طھظƒظˆظ† ط¯ط§ط®ظ„ ظ…ظ†ط·ظ‚ط© ط§ظ„طµظٹط¯ ط§ظ„ط­ظ…ط±ط§ط،.");
                return 1;
            }
            if (!Fisherman_NearBoat(playerid))
            {
                Fisherman_ShowMsg_(playerid,
                    "ظ„ط§ط²ظ… طھظƒظˆظ† ط¹ظ„ظ‰ ط§ظ„ظ‚ط§ط±ط¨ ط§ظ„ظ„ظٹ ظ…ط£ط¬ظ‘ط±ظ‡ (ط£ظˆ ط¹ظ„ظ‰ ط¨ط¹ط¯ 10 ط£ظ…طھط§ط± ظ…ظ†ظ‡).");
                return 1;
            }
            g_fp[playerid][fp_casting] = true;
            g_fp[playerid][fp_cast_tick] = GetTickCount();
            g_fp[playerid][fp_bait] -= 1;
            Fisherman_SaveDB(playerid);
            PlayerPlaySound(playerid, SND_CAST, 0.0, 0.0, 0.0);
            ApplyAnimation(playerid, "SWORD", "sword_block", 4.1, 0, 0, 0, 0, 0, 1);
            Fisherman_CamDive(playerid);
            Fisherman_ShowCast_(playerid);
            // The catch is resolved when the player finishes reeling (the
            // WebView sends a second "ok" once the line is fully reeled in).
            // This safety timer only fires if the player never reels: it
            // forces a miss so the trip can never soft-lock in the cast state.
            SetTimerEx("Fisherman_CastTimeout", CAST_TIMEOUT_MS, false, "i", playerid);
            return 1;
        }
        case DLG_FISH_RESULT:
        {
            g_fp[playerid][fp_casting] = false;
            ClearAnimations(playerid);
            if (!response)
            {
                Fisherman_Finish(playerid, true);
                return 1;
            }
            if (g_fp[playerid][fp_bait] <= 0)
            {
                Fisherman_ShowMsg_(playerid,
                    "ط®ظ„طµ ط§ظ„ط·ط¹ظ…. ط§ط±ط¬ط¹ ظ„ظ„طµظٹظ‘ط§ط¯ ط¹ط´ط§ظ† طھط®ظ„ظ‘طµ.");
                return 1;
            }
            Fisherman_ShowHud_(playerid);
            return 1;
        }
        case DLG_FISH_STATS:
        {
            Fisherman_CloseUI_(playerid);
            return 1;
        }
        case DLG_FISH_MSG:
        {
            if (g_fp[playerid][fp_is_working])
                Fisherman_ShowHud_(playerid);
            else
                Fisherman_ShowShop_(playerid);
            return 1;
        }
    }
    return 0;
}

// Reliable reply channel for the CEF fishing UI.  The launcher sends
//   /fishact <code> <val>
// when the player taps a button, because SA-MP mobile silently drops
// SendDialogResponse for these WebView-only dialogs (confirmed on-device).
// We dispatch the tap against the screen the server last pushed
// (fp_cur_dialog), so no client-side dialog-id tracking is needed.
//   code 0 = pick(listitem=val) | 1 = ok | 2 = cancel | 3 = input(qty=val)
CMD:fishact(playerid, params[])
{
    new code, val = 0;
    if (sscanf(params, "iI(0)", code, val)) return 1;
    new dlg = g_fp[playerid][fp_cur_dialog];
    if (dlg <= 0) return 1;
    // code 4 = "back": close the fishing UI and drop back to the in-zone HUD
    // (the native rod button) WITHOUT ending the trip.  Any in-progress cast is
    // cancelled cleanly so the next throw starts fresh.  We do NOT push a
    // WebView here â€” the launcher shows the native rod button on its side.
    if (code == 4)
    {
        if (g_fp[playerid][fp_casting])
        {
            g_fp[playerid][fp_casting] = false;
            ClearAnimations(playerid);
            Fisherman_CamSurface(playerid);
        }
        g_fp[playerid][fp_cur_dialog] = DLG_FISH_HUD;
        return 1;
    }
    new resp = 1, item = 0, inp[16];
    inp[0] = EOS;
    switch (code)
    {
        case 0: { resp = 1; item = val; }                                    // pick
        case 1: { resp = 1; item = 0;   }                                    // ok
        case 2: { resp = 0; item = 0;   }                                    // cancel
        case 3: { resp = 1; item = 0; format(inp, sizeof(inp), "%d", val); }  // input(qty)
        default: return 1;
    }
    Fisherman_OnDialogResponse(playerid, dlg, resp, item, inp);
    return 1;
}
