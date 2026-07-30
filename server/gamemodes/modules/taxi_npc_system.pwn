/*
 *  Taxi NPC Job Module
 *  ====================
 *  A complete taxi NPC passenger system using FCNPC.
 *  Players with the taxi job can accept randomly generated
 *  passenger orders, pick up NPCs, and deliver them across
 *  the GTA San Andreas map for money.
 *
 *  Dependencies: FCNPC, Streamer, Pawn.CMD
 *  Source encoding: Windows-1256.
 */

// ============================================================================
//  SECTION 1 - Constants and configuration
// ============================================================================

#if !defined MAX_TAXI_NPC_ORDERS
    #define MAX_TAXI_NPC_ORDERS         10
#endif

#define MAX_TAXI_NPC_LOCATIONS          14
#define MAX_TAXI_NPC_FIRST_NAMES        20
#define MAX_TAXI_NPC_LAST_NAMES         20
#define MAX_TAXI_NPC_NAME_LEN           32
#define MAX_TAXI_NPC_LOC_NAME_LEN       40

#define TAXI_NPC_STAGE_NONE             0
#define TAXI_NPC_STAGE_GOING_PICKUP     1
#define TAXI_NPC_STAGE_ARRIVED_PICKUP   2
#define TAXI_NPC_STAGE_DRIVING_DEST     3
#define TAXI_NPC_STAGE_ARRIVED_DEST     4

#define TAXI_NPC_MAX_LEVEL              20
#define TAXI_NPC_TRIPS_PER_LEVEL        5

// Base price per distance unit (scaled by 100-200 per 100 units)
#define TAXI_NPC_BASE_PRICE_MIN         1.0
#define TAXI_NPC_BASE_PRICE_MAX         2.0

// Camera sequence timing (milliseconds)
#define TAXI_NPC_CAM_STAGE_DURATION     2500
#define TAXI_NPC_CAM_WALK_DURATION      3000
#define TAXI_NPC_CAM_BOARD_DELAY        1500
#define TAXI_NPC_CAM_EXIT_DURATION      3000

// Checkpoint size
#define TAXI_NPC_CP_SIZE                7.0
#define TAXI_NPC_ARRIVAL_RADIUS         9.0
#define TAXI_NPC_PROXIMITY_INTERVAL     500
#define TAXI_NPC_BOARD_RETRY_DELAY      450
#define TAXI_NPC_MAX_BOARD_ATTEMPTS     6

// NPC walk speed
#define TAXI_NPC_WALK_SPEED             0.0050

// NPC skin range (civilian male skins)
new const TaxiNPC_Skins[] = {
    1, 2, 3, 4, 5, 6, 7, 14, 15, 17,
    19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
    29, 30, 33, 34, 35, 36, 37, 43, 44, 46
};

// ============================================================================
//  SECTION 2 - Location data
// ============================================================================

enum E_TAXI_NPC_LOCATION {
    Float:tnl_x,
    Float:tnl_y,
    Float:tnl_z,
    tnl_name[MAX_TAXI_NPC_LOC_NAME_LEN]
};

// Exterior road, parking and forecourt positions with direct vehicle access.
new const TaxiNPC_Locations[MAX_TAXI_NPC_LOCATIONS][E_TAXI_NPC_LOCATION] = {
    {1804.2081, -1926.4210, 13.3894, "محطة يونيتي"},
    {1685.7011, -2335.3750, 13.5468, "مطار لوس سانتوس"},
    {2493.6000, -1670.0000, 13.3000, "غروف ستريت"},
    {2170.0200, -1745.2200, 13.8200, "إيدلوود"},
    {1425.6357, -1874.3829, 13.5153, "كومرس"},
    {749.2318,  -1764.0657, 12.5949, "شاطئ سانتا ماريا"},
    {1038.1800, -1339.8800, 13.7270, "ماركت"},
    {1177.6900, -1323.5500, 14.1000, "مستشفى أول ساينتس"},
    {1940.5700, -1773.1600, 13.3900, "محطة وقود إيدلوود"},
    {2421.6500, -1221.1100, 25.3000, "شرق لوس سانتوس"},
    {2231.0200, -1159.7600, 25.8900, "جيفرسون"},
    {2864.7300, -1439.1500, 10.9600, "إيست بيتش"},
    {2455.7800, -2623.9800, 13.6500, "ميناء لوس سانتوس"},
    {660.0300,   -573.5900, 16.3400, "ديليمور"}
};

// ============================================================================
//  SECTION 3 - NPC name data
// ============================================================================

new const TaxiNPC_FirstNames[MAX_TAXI_NPC_FIRST_NAMES][16] = {
    "Jackson",  "Michael",   "David",    "James",
    "Robert",   "William",   "Richard",  "Joseph",
    "Thomas",   "Christopher","Daniel",  "Anthony",
    "Marcus",   "Kevin",     "Brian",    "Steven",
    "Edward",   "Patrick",   "George",   "Samuel"
};

new const TaxiNPC_LastNames[MAX_TAXI_NPC_LAST_NAMES][16] = {
    "Henderson","Williams",  "Johnson",  "Brown",
    "Davis",    "Wilson",    "Anderson", "Taylor",
    "Thomas",   "Moore",     "Martin",   "Jackson",
    "White",    "Harris",    "Clark",    "Lewis",
    "Robinson", "Walker",    "Young",    "Hall"
};

// ============================================================================
//  SECTION 4 - Per-player state variables
// ============================================================================

new bool:TaxiNPC_Active[MAX_PLAYERS];
new TaxiNPC_OrderID[MAX_PLAYERS];
new TaxiNPC_NpcId[MAX_PLAYERS];
new TaxiNPC_Stage[MAX_PLAYERS];
new TaxiNPC_CP[MAX_PLAYERS];
new TaxiNPC_Price[MAX_PLAYERS];
new TaxiNPC_TotalEarnings[MAX_PLAYERS];
new TaxiNPC_TotalTrips[MAX_PLAYERS];
new TaxiNPC_Level[MAX_PLAYERS];
new TaxiNPC_CamTimer[MAX_PLAYERS];
new TaxiNPC_MapIcon[MAX_PLAYERS];
new TaxiNPC_ProximityTimer[MAX_PLAYERS];
new TaxiNPC_BoardAttempts[MAX_PLAYERS];
new TaxiNPC_PassengerSeat[MAX_PLAYERS];
new TaxiNPC_NpcSerial;

// Pickup and destination indices for current order
new TaxiNPC_PickupIdx[MAX_PLAYERS];
new TaxiNPC_DestIdx[MAX_PLAYERS];

// Camera sequence sub-stage tracker
new TaxiNPC_CamStage[MAX_PLAYERS];

// ============================================================================
//  SECTION 5 - Order pool structure
// ============================================================================

enum E_TAXI_NPC_ORDER {
    tno_npc_name[MAX_TAXI_NPC_NAME_LEN],
    tno_pickup,         // index into TaxiNPC_Locations
    tno_dest,           // index into TaxiNPC_Locations
    Float:tno_distance,
    tno_price
};

// Per-player order pool (each player gets their own randomized list)
new TaxiNPC_Orders[MAX_PLAYERS][MAX_TAXI_NPC_ORDERS][E_TAXI_NPC_ORDER];

// ============================================================================
//  SECTION 6 - Utility / helper functions
// ============================================================================

/**
 * Calculate 3D distance between two points.
 */
stock Float:TaxiNPC_GetDistance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return floatsqroot(
        (x2 - x1) * (x2 - x1) +
        (y2 - y1) * (y2 - y1) +
        (z2 - z1) * (z2 - z1)
    );
}

/**
 * Generate a random NPC name in "First_Last" format.
 */
stock TaxiNPC_RandomName(dest[], maxlen = MAX_TAXI_NPC_NAME_LEN)
{
    new first = random(MAX_TAXI_NPC_FIRST_NAMES);
    new last  = random(MAX_TAXI_NPC_LAST_NAMES);
    format(dest, maxlen, "%s_%s", TaxiNPC_FirstNames[first], TaxiNPC_LastNames[last]);
}

/**
 * Calculate a price for a given distance.
 * Roughly $100-200 per 100 distance units, with slight randomness.
 */
stock TaxiNPC_CalcPrice(Float:distance, taxi_level)
{
    new Float:rate = TAXI_NPC_BASE_PRICE_MIN +
        (float(random(100)) / 100.0) * (TAXI_NPC_BASE_PRICE_MAX - TAXI_NPC_BASE_PRICE_MIN);
    new Float:base_price = distance * rate;
    new Float:bonus = 1.0 + (float(taxi_level) * 0.05);
    new price = floatround(base_price * bonus, floatround_round);

    // Clamp minimum price
    if (price < 50) price = 50;
    return price;
}

/**
 * Get the player's current taxi level based on completed trips.
 */
stock TaxiNPC_GetLevel(playerid)
{
    new lvl = TaxiNPC_TotalTrips[playerid] / TAXI_NPC_TRIPS_PER_LEVEL;
    if (lvl > TAXI_NPC_MAX_LEVEL) lvl = TAXI_NPC_MAX_LEVEL;
    return lvl;
}

/**
 * Get the bonus multiplier string for display.
 */
stock Float:TaxiNPC_GetBonus(playerid)
{
    return 1.0 + (float(TaxiNPC_Level[playerid]) * 0.05);
}

/**
 * Pick a random civilian skin for the NPC.
 */
stock TaxiNPC_RandomSkin()
{
    return TaxiNPC_Skins[random(sizeof(TaxiNPC_Skins))];
}

/**
 * Check if a player is in a valid taxi vehicle (rental car with taxi job type).
 */
stock bool:TaxiNPC_IsInTaxiVehicle(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (vehicleid == 0) return false;
    if (GetPlayerVehicleSeat(playerid) != 0) return false;

    // Must be the player's rented car
    if (player_rentcar[playerid] == INVALID_VEHICLE_ID) return false;
    if (player_rentcar[playerid] != vehicleid) return false;

    // Vehicle must be a job-type taxi (index is vehicleid - 1)
    new idx = player_rentcar[playerid] - 1;
    if (idx < 0 || idx >= MAX_VEHICLES) return false;
    if (veh_info[idx][v_type] != vehicle_type_job) return false;
    if (veh_info[idx][v_owner] != job_taxi) return false;

    return true;
}

stock TaxiNPC_StopProximityTimer(playerid)
{
    if (TaxiNPC_ProximityTimer[playerid] != -1)
    {
        KillTimer(TaxiNPC_ProximityTimer[playerid]);
        TaxiNPC_ProximityTimer[playerid] = -1;
    }
}

stock TaxiNPC_FindFreePassengerSeat(vehicleid)
{
    for (new seat = 1; seat <= 3; seat++)
    {
        new bool:occupied = false;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (!IsPlayerConnected(i)) continue;
            if (GetPlayerVehicleID(i) != vehicleid) continue;
            if (GetPlayerVehicleSeat(i) != seat) continue;

            occupied = true;
            break;
        }
        if (!occupied) return seat;
    }
    return -1;
}

stock bool:TaxiNPC_PutPassengerInVehicle(npcid, vehicleid, seatid)
{
    FCNPC_PutInVehicle(npcid, vehicleid, seatid);

    if (GetPlayerVehicleID(npcid) != vehicleid ||
        GetPlayerVehicleSeat(npcid) != seatid)
    {
        orig_PutPlayerInVehicle(npcid, vehicleid, seatid);
    }

    return GetPlayerVehicleID(npcid) == vehicleid &&
        GetPlayerVehicleSeat(npcid) == seatid;
}

// ============================================================================
//  SECTION 7 - Core logic functions
// ============================================================================

/**
 * Initialize/reset all taxi NPC state for a player.
 */
stock TaxiNPC_ResetPlayer(playerid)
{
    TaxiNPC_Active[playerid]        = false;
    TaxiNPC_OrderID[playerid]       = -1;
    TaxiNPC_NpcId[playerid]         = INVALID_PLAYER_ID;
    TaxiNPC_Stage[playerid]         = TAXI_NPC_STAGE_NONE;
    TaxiNPC_CP[playerid]            = -1;
    TaxiNPC_Price[playerid]         = 0;
    TaxiNPC_TotalEarnings[playerid] = 0;
    TaxiNPC_TotalTrips[playerid]    = 0;
    TaxiNPC_Level[playerid]         = 0;
    TaxiNPC_CamTimer[playerid]      = -1;
    TaxiNPC_MapIcon[playerid]       = -1;
    TaxiNPC_ProximityTimer[playerid] = -1;
    TaxiNPC_BoardAttempts[playerid] = 0;
    TaxiNPC_PassengerSeat[playerid] = -1;
    TaxiNPC_PickupIdx[playerid]     = -1;
    TaxiNPC_DestIdx[playerid]       = -1;
    TaxiNPC_CamStage[playerid]      = 0;
}

/**
 * Generate a fresh set of random orders for the player.
 */
stock TaxiNPC_GenerateOrders(playerid)
{
    for (new i = 0; i < MAX_TAXI_NPC_ORDERS; i++)
    {
        // Random NPC name
        TaxiNPC_RandomName(TaxiNPC_Orders[playerid][i][tno_npc_name]);

        // Random pickup and destination (must be different)
        new pickup = random(MAX_TAXI_NPC_LOCATIONS);
        new dest   = random(MAX_TAXI_NPC_LOCATIONS);
        while (dest == pickup)
        {
            dest = random(MAX_TAXI_NPC_LOCATIONS);
        }

        TaxiNPC_Orders[playerid][i][tno_pickup] = pickup;
        TaxiNPC_Orders[playerid][i][tno_dest]   = dest;

        // Calculate distance
        new Float:dist = TaxiNPC_GetDistance(
            TaxiNPC_Locations[pickup][tnl_x], TaxiNPC_Locations[pickup][tnl_y], TaxiNPC_Locations[pickup][tnl_z],
            TaxiNPC_Locations[dest][tnl_x],   TaxiNPC_Locations[dest][tnl_y],   TaxiNPC_Locations[dest][tnl_z]
        );
        TaxiNPC_Orders[playerid][i][tno_distance] = dist;

        // Calculate price with player's current level bonus
        TaxiNPC_Orders[playerid][i][tno_price] = TaxiNPC_CalcPrice(dist, TaxiNPC_Level[playerid]);
    }
}

/**
 * Accept an order: set up checkpoint at pickup location.
 */
stock TaxiNPC_AcceptOrder(playerid, orderidx)
{
    if (orderidx < 0 || orderidx >= MAX_TAXI_NPC_ORDERS) return 0;
    if (GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0)
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}[تاكسي] {"#cWH"}اخرج إلى الشارع أولاً قبل قبول الطلب."
        );
        return 0;
    }

    new pickup = TaxiNPC_Orders[playerid][orderidx][tno_pickup];
    new dest   = TaxiNPC_Orders[playerid][orderidx][tno_dest];

    TaxiNPC_OrderID[playerid]   = orderidx;
    TaxiNPC_PickupIdx[playerid] = pickup;
    TaxiNPC_DestIdx[playerid]   = dest;
    TaxiNPC_Price[playerid]     = TaxiNPC_Orders[playerid][orderidx][tno_price];
    TaxiNPC_Stage[playerid]     = TAXI_NPC_STAGE_GOING_PICKUP;
    TaxiNPC_Active[playerid]    = true;
    TaxiNPC_BoardAttempts[playerid] = 0;
    TaxiNPC_PassengerSeat[playerid] = -1;

    TaxiNPC_StopProximityTimer(playerid);
    TaxiNPC_ProximityTimer[playerid] = SetTimerEx(
        "TaxiNPC_ProximityCheck",
        TAXI_NPC_PROXIMITY_INTERVAL,
        true,
        "i",
        playerid
    );

    // Set race checkpoint at pickup location (type 0 = normal, arrow)
    SetPlayerRaceCheckpoint(playerid, 0,
        TaxiNPC_Locations[pickup][tnl_x], TaxiNPC_Locations[pickup][tnl_y], TaxiNPC_Locations[pickup][tnl_z],
        TaxiNPC_Locations[dest][tnl_x],   TaxiNPC_Locations[dest][tnl_y],   TaxiNPC_Locations[dest][tnl_z],
        TAXI_NPC_CP_SIZE
    );

    // Create minimap icon at pickup
    TaxiNPC_MapIcon[playerid] = CreateDynamicMapIcon(
        TaxiNPC_Locations[pickup][tnl_x], TaxiNPC_Locations[pickup][tnl_y], TaxiNPC_Locations[pickup][tnl_z],
        56, 0, .playerid = playerid, .style = 1
    );

    // Notify player
    format(global_string, 4096,
        "{"#cGR"}[Taxi] {"#cWH"}قبلت طلب الراكب {"#cBL"}%s {"#cWH"}المنتظر في {"#cGR"}%s{"#cWH"}. توجّه لنقطة الاستلام!",
        TaxiNPC_Orders[playerid][orderidx][tno_npc_name],
        TaxiNPC_Locations[pickup][tnl_name]
    );
    SendClientMessage(playerid, col_green, global_string);

    format(global_string, 4096,
        "{"#cGR"}[Taxi] {"#cWH"}الوجهة: {"#cGR"}%s {"#cWH"}| الأجرة: {"#cGR"}$%d",
        TaxiNPC_Locations[dest][tnl_name],
        TaxiNPC_Price[playerid]
    );
    SendClientMessage(playerid, col_green, global_string);

    return 1;
}

/**
 * Handle arrival at pickup point: spawn NPC and begin camera sequence.
 */
stock TaxiNPC_OnArrivePickup(playerid)
{
    if (TaxiNPC_Stage[playerid] != TAXI_NPC_STAGE_GOING_PICKUP) return;
    if (!TaxiNPC_IsInTaxiVehicle(playerid)) return;

    TaxiNPC_Stage[playerid] = TAXI_NPC_STAGE_ARRIVED_PICKUP;

    DisablePlayerRaceCheckpoint(playerid);

    if (TaxiNPC_MapIcon[playerid] != -1)
    {
        DestroyDynamicMapIcon(TaxiNPC_MapIcon[playerid]);
        TaxiNPC_MapIcon[playerid] = -1;
    }

    new vehicleid_sp = GetPlayerVehicleID(playerid);
    TaxiNPC_PassengerSeat[playerid] = TaxiNPC_FindFreePassengerSeat(vehicleid_sp);
    if (TaxiNPC_PassengerSeat[playerid] == -1)
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}[تاكسي] {"#cWH"}لا يوجد مقعد فارغ للراكب في السيارة."
        );
        TaxiNPC_CancelOrder(playerid);
        return;
    }

    TaxiNPC_NpcSerial++;
    if (TaxiNPC_NpcSerial > 999999) TaxiNPC_NpcSerial = 1;

    new npc_name[MAX_PLAYER_NAME + 1];
    format(npc_name, sizeof(npc_name), "Taxi_%d_%d", playerid, TaxiNPC_NpcSerial);
    new npcid = FCNPC_Create(npc_name);
    if (npcid == INVALID_PLAYER_ID)
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}[تاكسي] {"#cWH"}تعذّر إنشاء الراكب لأن أماكن الـNPC ممتلئة. اختر طلباً جديداً."
        );
        TaxiNPC_CancelOrder(playerid);
        return;
    }

    TaxiNPC_NpcId[playerid] = npcid;

    new Float:vx, Float:vy, Float:vz, Float:va;
    GetVehiclePos(vehicleid_sp, vx, vy, vz);
    GetVehicleZAngle(vehicleid_sp, va);
    new Float:sx = vx + 3.5 * floatcos(-va, degrees);
    new Float:sy = vy - 3.5 * floatsin(-va, degrees);

    FCNPC_Spawn(npcid, TaxiNPC_RandomSkin(), sx, sy, vz + 0.5);
    FCNPC_SetVirtualWorld(npcid, GetPlayerVirtualWorld(playerid));
    FCNPC_SetInterior(npcid, GetPlayerInterior(playerid));
    FCNPC_SetPosition(npcid, sx, sy, vz + 0.5);
    FCNPC_SetAngle(npcid, va);
    FCNPC_SetInvulnerable(npcid, true);

    TaxiNPC_CamStage[playerid] = 0;
    TaxiNPC_BoardAttempts[playerid] = 0;
    SendClientMessage(playerid, col_green,
        "{"#cGR"}[تاكسي] {"#cWH"}وصل الراكب، انتظر لحظة حتى يركب السيارة."
    );
    TaxiNPC_CamTimer[playerid] = SetTimerEx("TaxiNPC_CameraSequence", 700, false, "ii", playerid, 2);
}

/**
 * Handle arrival at destination: NPC exit sequence and payment.
 */
stock TaxiNPC_OnArriveDest(playerid)
{
    TaxiNPC_Stage[playerid] = TAXI_NPC_STAGE_ARRIVED_DEST;

    // No exit cinematic / control lockout (keeps camera normal, never stuck).

    // Remove destination checkpoint
    DisablePlayerRaceCheckpoint(playerid);

    // Destroy destination map icon
    if (TaxiNPC_MapIcon[playerid] != -1)
    {
        DestroyDynamicMapIcon(TaxiNPC_MapIcon[playerid]);
        TaxiNPC_MapIcon[playerid] = -1;
    }

    new npcid = TaxiNPC_NpcId[playerid];
    if (!FCNPC_IsValid(npcid))
    {
        // NPC is gone, just pay and clean up
        TaxiNPC_CompletePayment(playerid);
        TogglePlayerControllable(playerid, true);
        return;
    }

    TaxiNPC_CamStage[playerid] = 0;

    FCNPC_Destroy(npcid);
    TaxiNPC_NpcId[playerid] = INVALID_PLAYER_ID;

    // Timer to finalize
    TaxiNPC_CamTimer[playerid] = SetTimerEx("TaxiNPC_ExitSequence", 700, false, "i", playerid);
}

/**
 * Process payment and update statistics.
 */
stock TaxiNPC_CompletePayment(playerid)
{
    TaxiNPC_StopProximityTimer(playerid);

    new price = TaxiNPC_Price[playerid];

    // Give money (persisted to SQL via give_money so taxi earnings are
    // saved immediately and survive relog, instead of client-only display).
    give_money(playerid, price);

    // Update stats
    TaxiNPC_TotalTrips[playerid]++;
    TaxiNPC_TotalEarnings[playerid] += price;
    TaxiNPC_Level[playerid] = TaxiNPC_GetLevel(playerid);

    // Notify player
    format(global_string, 4096,
        "{"#cGR"}[Taxi] {"#cWH"}وصلت بنجاح! الأجرة: {"#cGR"}$%d {"#cWH"}| الرحلات: {"#cGR"}%d {"#cWH"}| المستوى: {"#cGR"}%d",
        price, TaxiNPC_TotalTrips[playerid], TaxiNPC_Level[playerid]
    );
    SendClientMessage(playerid, col_green, global_string);

    // Reset order state but keep session stats
    TaxiNPC_OrderID[playerid]   = -1;
    TaxiNPC_PickupIdx[playerid] = -1;
    TaxiNPC_DestIdx[playerid]   = -1;
    TaxiNPC_Price[playerid]     = 0;
    TaxiNPC_Stage[playerid]     = TAXI_NPC_STAGE_NONE;
    TaxiNPC_CamStage[playerid]  = 0;
    TaxiNPC_BoardAttempts[playerid] = 0;
    TaxiNPC_PassengerSeat[playerid] = -1;
}

/**
 * Cancel the current order and clean up.
 */
stock TaxiNPC_CancelOrder(playerid)
{
    TaxiNPC_StopProximityTimer(playerid);

    // Kill any active camera timer
    if (TaxiNPC_CamTimer[playerid] != -1)
    {
        KillTimer(TaxiNPC_CamTimer[playerid]);
        TaxiNPC_CamTimer[playerid] = -1;
    }

    // Destroy NPC
    if (TaxiNPC_NpcId[playerid] != INVALID_PLAYER_ID && FCNPC_IsValid(TaxiNPC_NpcId[playerid]))
    {
        FCNPC_Destroy(TaxiNPC_NpcId[playerid]);
    }
    TaxiNPC_NpcId[playerid] = INVALID_PLAYER_ID;

    // Remove checkpoint
    DisablePlayerRaceCheckpoint(playerid);

    // Remove map icon
    if (TaxiNPC_MapIcon[playerid] != -1)
    {
        DestroyDynamicMapIcon(TaxiNPC_MapIcon[playerid]);
        TaxiNPC_MapIcon[playerid] = -1;
    }

    // Reset camera
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);

    // Reset order state
    TaxiNPC_OrderID[playerid]   = -1;
    TaxiNPC_PickupIdx[playerid] = -1;
    TaxiNPC_DestIdx[playerid]   = -1;
    TaxiNPC_Price[playerid]     = 0;
    TaxiNPC_Stage[playerid]     = TAXI_NPC_STAGE_NONE;
    TaxiNPC_CamStage[playerid]  = 0;
    TaxiNPC_BoardAttempts[playerid] = 0;
    TaxiNPC_PassengerSeat[playerid] = -1;
}

/**
 * Full cleanup when player ends shift or disconnects.
 */
stock TaxiNPC_EndShift(playerid)
{
    if (!TaxiNPC_Active[playerid]) return;

    // Cancel any active order
    TaxiNPC_CancelOrder(playerid);

    // Report earnings
    if (TaxiNPC_TotalTrips[playerid] > 0)
    {
        format(global_string, 4096,
            "{"#cGR"}[Taxi] {"#cWH"}انتهت الوردية. عدد الرحلات: {"#cGR"}%d {"#cWH"}| إجمالي الأرباح: {"#cGR"}$%d",
            TaxiNPC_TotalTrips[playerid], TaxiNPC_TotalEarnings[playerid]
        );
        SendClientMessage(playerid, col_green, global_string);
    }

    TaxiNPC_Active[playerid]        = false;
    TaxiNPC_TotalEarnings[playerid] = 0;
    TaxiNPC_TotalTrips[playerid]    = 0;
    TaxiNPC_Level[playerid]         = 0;
}

// ============================================================================
//  SECTION 8 - Dialog display functions
// ============================================================================

/**
 * Show the taxi NPC launcher overlay.
 * Sends a sentinel dialog [!TAXI_OPEN] with encoded stats + orders.
 * The launcher intercepts this and renders a professional UI.
 */
stock TaxiNPC_ShowOverlay(playerid)
{
    // Generate fresh orders
    TaxiNPC_GenerateOrders(playerid);

    new Float:bonus = TaxiNPC_GetBonus(playerid);
    new tripsToNext = (TaxiNPC_Level[playerid] < TAXI_NPC_MAX_LEVEL) ?
        (TAXI_NPC_TRIPS_PER_LEVEL - (TaxiNPC_TotalTrips[playerid] % TAXI_NPC_TRIPS_PER_LEVEL)) : 0;

    // Build the data payload for the launcher overlay
    // Format:
    //   STATS:trips|earnings|level|maxlevel|bonus|tripstonext
    //   ORDER:name|pickup_name|dest_name|distance|price|pickup_idx|dest_idx
    new info[4096];
    format(info, sizeof(info), "STATS:%d|%d|%d|%d|%.2f|%d\n",
        TaxiNPC_TotalTrips[playerid],
        TaxiNPC_TotalEarnings[playerid],
        TaxiNPC_Level[playerid],
        TAXI_NPC_MAX_LEVEL,
        bonus,
        tripsToNext
    );

    for (new i = 0; i < MAX_TAXI_NPC_ORDERS; i++)
    {
        new row[256];
        new pickup = TaxiNPC_Orders[playerid][i][tno_pickup];
        new dest   = TaxiNPC_Orders[playerid][i][tno_dest];
        format(row, sizeof(row), "ORDER:%s|%s|%s|%.0f|%d|%d|%d\n",
            TaxiNPC_Orders[playerid][i][tno_npc_name],
            TaxiNPC_Locations[pickup][tnl_name],
            TaxiNPC_Locations[dest][tnl_name],
            TaxiNPC_Orders[playerid][i][tno_distance],
            TaxiNPC_Orders[playerid][i][tno_price],
            pickup,
            dest
        );
        strcat(info, row, sizeof(info));
    }

    show_dialog(playerid, d_taxi_npc_orders, DIALOG_STYLE_LIST,
        "[!TAXI_OPEN]", info, "OK", "Cancel"
    );
    return 1;
}

/**
 * Close the taxi NPC launcher overlay.
 */
stock TaxiNPC_CloseOverlay(playerid)
{
    show_dialog(playerid, d_taxi_npc_start, DIALOG_STYLE_MSGBOX,
        "[!TAXI_CLOSE]", "", "OK", ""
    );
}

// Keep legacy functions for fallback compatibility
stock TaxiNPC_ShowStartDialog(playerid)
{
    TaxiNPC_ShowOverlay(playerid);
}

stock TaxiNPC_ShowOrdersDialog(playerid)
{
    TaxiNPC_ShowOverlay(playerid);
}

stock TaxiNPC_ShowStatsDialog(playerid)
{
    TaxiNPC_ShowOverlay(playerid);
}

// ============================================================================
//  SECTION 9 - Dialog response handler
// ============================================================================

/**
 * Handle dialog responses for taxi NPC dialogs.
 * The launcher overlay sends:
 *   button=1, listitem=order_index  -> Accept order
 *   button=0                        -> Cancel/Close
 */
stock TaxiNPC_OnDialogResponse(playerid, dialogid, response, listitem)
{
    switch (dialogid)
    {
        case d_taxi_npc_start:
        {
            // Close overlay sentinel response - ignore
            return 1;
        }
        case d_taxi_npc_orders:
        {
            if (!response)
            {
                // Player closed the overlay
                return 1;
            }

            // Player accepted an order from the overlay
            if (TaxiNPC_Stage[playerid] != TAXI_NPC_STAGE_NONE)
            {
                SendClientMessage(playerid, col_gray,
                    "{"#cRD"}[تاكسي] {"#cWH"}عندك طلب نشط حالياً. أكمله أو ألغه أولاً."
                );
                return 1;
            }

            if (TaxiNPC_AcceptOrder(playerid, listitem))
            {
                TaxiNPC_GenerateOrders(playerid);
            }
            else
            {
                SendClientMessage(playerid, col_gray,
                    "{"#cRD"}[تاكسي] {"#cWH"}تعذّر قبول الطلب. حاول مرة ثانية."
                );
            }
            return 1;
        }
        case d_taxi_npc_stats:
        {
            return 1;
        }
    }
    return 0;
}

// ============================================================================
//  SECTION 10 - Checkpoint handler
// ============================================================================

/**
 * Handle race checkpoint entry for taxi NPC system.
 * Call this from OnPlayerEnterRaceCheckpoint. Returns 1 if handled.
 */
stock TaxiNPC_OnEnterRaceCheckpoint(playerid)
{
    if (!TaxiNPC_Active[playerid]) return 0;

    switch (TaxiNPC_Stage[playerid])
    {
        case TAXI_NPC_STAGE_GOING_PICKUP:
        {
            // Verify player is near pickup
            new pickup = TaxiNPC_PickupIdx[playerid];
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);

            new Float:dist = TaxiNPC_GetDistance(
                px, py, pz,
                TaxiNPC_Locations[pickup][tnl_x],
                TaxiNPC_Locations[pickup][tnl_y],
                TaxiNPC_Locations[pickup][tnl_z]
            );

            if (dist > 20.0) return 0; // too far, ignore

            // Must still be in taxi vehicle
            if (!TaxiNPC_IsInTaxiVehicle(playerid))
            {
                SendClientMessage(playerid, col_gray,
                    "{"#cRD"}[تاكسي] {"#cWH"}لازم تكون داخل سيارة التاكسي!"
                );
                return 1;
            }

            TaxiNPC_OnArrivePickup(playerid);
            return 1;
        }
        case TAXI_NPC_STAGE_DRIVING_DEST:
        {
            // Verify player is near destination
            new dest = TaxiNPC_DestIdx[playerid];
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);

            new Float:dist = TaxiNPC_GetDistance(
                px, py, pz,
                TaxiNPC_Locations[dest][tnl_x],
                TaxiNPC_Locations[dest][tnl_y],
                TaxiNPC_Locations[dest][tnl_z]
            );

            if (dist > 20.0) return 0;

            if (!TaxiNPC_IsInTaxiVehicle(playerid))
            {
                SendClientMessage(playerid, col_gray,
                    "{"#cRD"}[تاكسي] {"#cWH"}لازم تكون داخل سيارة التاكسي!"
                );
                return 1;
            }

            TaxiNPC_OnArriveDest(playerid);
            return 1;
        }
    }
    return 0;
}

// ============================================================================
//  SECTION 11 - Timer callbacks (camera sequences)
// ============================================================================

forward TaxiNPC_CameraSequence(playerid, stage);
forward TaxiNPC_ExitSequence(playerid);
forward TaxiNPC_DestroyNpcDelayed(playerid);
forward TaxiNPC_ProximityCheck(playerid);

stock TaxiNPC_StartDestination(playerid)
{
    TaxiNPC_CamStage[playerid] = 0;
    TogglePlayerControllable(playerid, true);
    TaxiNPC_Stage[playerid] = TAXI_NPC_STAGE_DRIVING_DEST;

    new dest = TaxiNPC_DestIdx[playerid];

    SetPlayerRaceCheckpoint(playerid, 1,
        TaxiNPC_Locations[dest][tnl_x], TaxiNPC_Locations[dest][tnl_y], TaxiNPC_Locations[dest][tnl_z],
        0.0, 0.0, 0.0,
        TAXI_NPC_CP_SIZE
    );

    TaxiNPC_MapIcon[playerid] = CreateDynamicMapIcon(
        TaxiNPC_Locations[dest][tnl_x], TaxiNPC_Locations[dest][tnl_y], TaxiNPC_Locations[dest][tnl_z],
        56, 0, .playerid = playerid, .style = 1
    );

    format(global_string, 4096,
        "{"#cGR"}[تاكسي] {"#cWH"}ركب الراكب. توجّه الآن إلى {"#cGR"}%s{"#cWH"}.",
        TaxiNPC_Locations[dest][tnl_name]
    );
    SendClientMessage(playerid, col_green, global_string);
}

public TaxiNPC_ProximityCheck(playerid)
{
    if (!IsPlayerConnected(playerid) ||
        !TaxiNPC_Active[playerid] ||
        TaxiNPC_OrderID[playerid] == -1)
    {
        TaxiNPC_StopProximityTimer(playerid);
        return 0;
    }

    if (!TaxiNPC_IsInTaxiVehicle(playerid)) return 1;
    if (GetPlayerVirtualWorld(playerid) != 0 || GetPlayerInterior(playerid) != 0) return 1;

    new location = -1;
    if (TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_GOING_PICKUP)
    {
        location = TaxiNPC_PickupIdx[playerid];
    }
    else if (TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_DRIVING_DEST)
    {
        location = TaxiNPC_DestIdx[playerid];
    }

    if (location == -1) return 1;

    if (!IsPlayerInRangeOfPoint(playerid, TAXI_NPC_ARRIVAL_RADIUS,
        TaxiNPC_Locations[location][tnl_x],
        TaxiNPC_Locations[location][tnl_y],
        TaxiNPC_Locations[location][tnl_z]))
    {
        return 1;
    }

    if (TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_GOING_PICKUP)
    {
        TaxiNPC_OnArrivePickup(playerid);
    }
    else if (TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_DRIVING_DEST)
    {
        TaxiNPC_OnArriveDest(playerid);
    }
    return 1;
}

/**
 * Timer callback: camera sequence at pickup.
 *
 * Stage 2: Put the NPC in the taxi.
 * Stage 3: Verify boarding and retry if FCNPC did not apply it.
 */
public TaxiNPC_CameraSequence(playerid, stage)
{
    TaxiNPC_CamTimer[playerid] = -1;

    if (!IsPlayerConnected(playerid)) return;
    if (TaxiNPC_Stage[playerid] != TAXI_NPC_STAGE_ARRIVED_PICKUP) return;
    if (!TaxiNPC_IsInTaxiVehicle(playerid))
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}[تاكسي] {"#cWH"}تم إلغاء الطلب لأنك غادرت سيارة التاكسي."
        );
        TaxiNPC_CancelOrder(playerid);
        return;
    }

    new npcid = TaxiNPC_NpcId[playerid];
    new vehicleid = GetPlayerVehicleID(playerid);

    if (!FCNPC_IsValid(npcid))
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}[تاكسي] {"#cWH"}اختفى الراكب، تم إلغاء الطلب بأمان."
        );
        TaxiNPC_CancelOrder(playerid);
        return;
    }

    switch (stage)
    {
        case 2:
        {
            TaxiNPC_CamStage[playerid] = 2;

            new Float:vx, Float:vy, Float:vz, Float:va;
            GetVehiclePos(vehicleid, vx, vy, vz);
            GetVehicleZAngle(vehicleid, va);

            FCNPC_SetPosition(
                npcid,
                vx + 2.0 * floatcos(-va, degrees),
                vy - 2.0 * floatsin(-va, degrees),
                vz + 0.5
            );
            FCNPC_SetAngle(npcid, va);
            TaxiNPC_PutPassengerInVehicle(
                npcid,
                vehicleid,
                TaxiNPC_PassengerSeat[playerid]
            );
            TaxiNPC_BoardAttempts[playerid]++;

            TaxiNPC_CamTimer[playerid] = SetTimerEx("TaxiNPC_CameraSequence",
                TAXI_NPC_BOARD_RETRY_DELAY, false, "ii", playerid, 3);
        }
        case 3:
        {
            TaxiNPC_CamStage[playerid] = 3;

            if ((FCNPC_GetVehicleID(npcid) == vehicleid &&
                FCNPC_GetVehicleSeat(npcid) == TaxiNPC_PassengerSeat[playerid]) ||
                (GetPlayerVehicleID(npcid) == vehicleid &&
                GetPlayerVehicleSeat(npcid) == TaxiNPC_PassengerSeat[playerid]))
            {
                TaxiNPC_StartDestination(playerid);
                return;
            }

            printf(
                "[TaxiNPC] board retry owner=%d npc=%d veh=%d model=%d seat=%d native=%d/%d fcnpc=%d/%d attempt=%d",
                playerid,
                npcid,
                vehicleid,
                GetVehicleModel(vehicleid),
                TaxiNPC_PassengerSeat[playerid],
                GetPlayerVehicleID(npcid),
                GetPlayerVehicleSeat(npcid),
                FCNPC_GetVehicleID(npcid),
                FCNPC_GetVehicleSeat(npcid),
                TaxiNPC_BoardAttempts[playerid]
            );

            if (TaxiNPC_BoardAttempts[playerid] >= TAXI_NPC_MAX_BOARD_ATTEMPTS)
            {
                SendClientMessage(playerid, col_gray,
                    "{"#cRD"}[تاكسي] {"#cWH"}تعذّر إدخال الراكب إلى السيارة، تم إلغاء الطلب."
                );
                TaxiNPC_CancelOrder(playerid);
                return;
            }

            TaxiNPC_CamTimer[playerid] = SetTimerEx("TaxiNPC_CameraSequence",
                TAXI_NPC_BOARD_RETRY_DELAY, false, "ii", playerid, 2);
        }
    }
}

/**
 * Timer callback: NPC exit sequence at destination.
 * NPC has walked away, finalize payment and clean up.
 */
public TaxiNPC_ExitSequence(playerid)
{
    TaxiNPC_CamTimer[playerid] = -1;

    if (!IsPlayerConnected(playerid)) return;

    // Restore camera and controls
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);

    // Process payment
    TaxiNPC_CompletePayment(playerid);

    // Schedule NPC destruction (let the walk animation finish)
    TaxiNPC_CamTimer[playerid] = SetTimerEx("TaxiNPC_DestroyNpcDelayed",
        2000, false, "i", playerid);
}

/**
 * Timer callback: destroy NPC after exit walk animation.
 */
public TaxiNPC_DestroyNpcDelayed(playerid)
{
    TaxiNPC_CamTimer[playerid] = -1;

    new npcid = TaxiNPC_NpcId[playerid];
    if (npcid != INVALID_PLAYER_ID && FCNPC_IsValid(npcid))
    {
        FCNPC_Destroy(npcid);
    }
    TaxiNPC_NpcId[playerid] = INVALID_PLAYER_ID;
}

// ============================================================================
//  SECTION 12 - Cleanup functions
// ============================================================================

/**
 * Full cleanup for a player (disconnect, death, etc.).
 * Destroys NPC, removes checkpoints, resets all state.
 */
stock TaxiNPC_FullCleanup(playerid)
{
    TaxiNPC_StopProximityTimer(playerid);

    // Kill any active timer
    if (TaxiNPC_CamTimer[playerid] != -1)
    {
        KillTimer(TaxiNPC_CamTimer[playerid]);
        TaxiNPC_CamTimer[playerid] = -1;
    }

    // Destroy NPC if active
    if (TaxiNPC_NpcId[playerid] != INVALID_PLAYER_ID && FCNPC_IsValid(TaxiNPC_NpcId[playerid]))
    {
        FCNPC_Destroy(TaxiNPC_NpcId[playerid]);
    }

    // Remove checkpoint
    DisablePlayerRaceCheckpoint(playerid);

    // Remove map icon
    if (TaxiNPC_MapIcon[playerid] != -1)
    {
        DestroyDynamicMapIcon(TaxiNPC_MapIcon[playerid]);
    }

    // Restore controls if needed
    if (IsPlayerConnected(playerid))
    {
        TogglePlayerControllable(playerid, true);
        SetCameraBehindPlayer(playerid);
    }

    // Reset all state
    TaxiNPC_ResetPlayer(playerid);
}

// ============================================================================
//  SECTION 13 - Commands
// ============================================================================

/**
 * Command: /taxinpc
 * Opens the taxi NPC job menu for players with the taxi job.
 */
alias:taxinpc("taxiui")
CMD:taxinpc(playerid, params[])
{
    // Check player has taxi job
    if (p_info[playerid][job] != job_taxi)
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}* {"#cWH"}لازم تكون موظف تاكسي لاستخدام هذي الميزة."
        );
        return 1;
    }

    // Check player is in a valid taxi vehicle
    if (!TaxiNPC_IsInTaxiVehicle(playerid))
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}* {"#cWH"}لازم تكون داخل سيارة تاكسي للعمل."
        );
        return 1;
    }

    // Check player doesn't have an active cinematic in progress
    if (TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_ARRIVED_PICKUP ||
        TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_ARRIVED_DEST)
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}* {"#cWH"}انتظر حتى تنتهي العملية الحالية."
        );
        return 1;
    }

    // Activate session if not already active
    if (!TaxiNPC_Active[playerid])
    {
        TaxiNPC_Active[playerid] = true;
        TaxiNPC_Stage[playerid]  = TAXI_NPC_STAGE_NONE;
        SendClientMessage(playerid, col_green,
            "{"#cGR"}[تاكسي] {"#cWH"}بدأت وردية التاكسي! بالتوفيق."
        );
    }

    TaxiNPC_ShowOverlay(playerid);
    return 1;
}

/**
 * Command: /txai
 * Tells the player to use /taxi to open the taxi NPC job menu.
 */
CMD:txai(playerid, params[])
{
    SendClientMessage(playerid, col_green,
        "{"#cGR"}[Taxi] {"#cWH"}\xc7\xdf\xca\xc8 {"#cGR"}/taxinpc {"#cWH"}\xda\xd4\xc7\xd2 \xca\xdd\xca\xcd \xde\xc7\xc6\xe3\xc9 \xd8\xe1\xc8\xc7\xca \xc7\xe1\xca\xc7\xdf\xd3\xed"
    );
    return 1;
}

/**
 * Command: /canceltaxi
 * Cancels the current taxi NPC order.
 */
CMD:canceltaxi(playerid, params[])
{
    if (!TaxiNPC_Active[playerid])
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}* {"#cWH"}ما عندك وردية تاكسي شغّالة."
        );
        return 1;
    }

    if (TaxiNPC_OrderID[playerid] == -1)
    {
        SendClientMessage(playerid, col_gray,
            "{"#cRD"}* {"#cWH"}ما عندك طلب نشط حالياً."
        );
        return 1;
    }

    // Penalize for cancellation (no money deducted, just a warning)
    SendClientMessage(playerid, col_gray,
        "{"#cRD"}[تاكسي] {"#cWH"}تم إلغاء الطلب. حاول تكمّل الطلبات القادمة."
    );

    TaxiNPC_CancelOrder(playerid);
    return 1;
}

// ============================================================================
//  SECTION 14 - Hook callbacks (connect, disconnect, death, vehicle exit)
// ============================================================================

/**
 * Call from OnPlayerConnect to initialize state.
 */
stock TaxiNPC_OnPlayerConnect(playerid)
{
    TaxiNPC_ResetPlayer(playerid);
}

/**
 * Call from OnPlayerDisconnect to clean up.
 */
stock TaxiNPC_OnPlayerDisconnect(playerid)
{
    TaxiNPC_FullCleanup(playerid);
}

/**
 * Call from OnPlayerDeath to clean up active orders.
 */
stock TaxiNPC_OnPlayerDeath(playerid)
{
    if (!TaxiNPC_Active[playerid]) return;

    SendClientMessage(playerid, col_gray,
        "{"#cRD"}[تاكسي] {"#cWH"}متّ أثناء الرحلة، تم إلغاء الطلب."
    );
    TaxiNPC_FullCleanup(playerid);
}

/**
 * Call from OnPlayerStateChange to detect when player exits vehicle.
 * newstate/oldstate are player state constants.
 */
stock TaxiNPC_OnPlayerStateChange(playerid, newstate, oldstate)
{
    #pragma unused oldstate

    // If player was driving and exits vehicle during active order
    if (!TaxiNPC_Active[playerid]) return;
    if (TaxiNPC_OrderID[playerid] == -1) return;

    // PLAYER_STATE_ONFOOT = 1, PLAYER_STATE_DRIVER = 2
    if (newstate == 1 && oldstate == 2)
    {
        // Player got out of vehicle during an active order
        // Give them a grace period message instead of instant cancel
        SendClientMessage(playerid, col_gray,
        "{"#cRD"}[تاكسي] {"#cWH"}تحذير! خرجت من السيارة، ارجع بسرعة."
        );

        // If NPC is in vehicle and we're in driving stage, cancel after brief window
        if (TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_DRIVING_DEST ||
            TaxiNPC_Stage[playerid] == TAXI_NPC_STAGE_GOING_PICKUP)
        {
            // Cancel the order when driver exits (NPC can't wait forever)
            TaxiNPC_CancelOrder(playerid);
            SendClientMessage(playerid, col_gray,
                "{"#cRD"}[تاكسي] {"#cWH"}تم إلغاء الطلب لأنك تركت السيارة."
            );
        }
    }
}

/**
 * Call from OnVehicleDeath if the taxi vehicle is destroyed.
 */
stock TaxiNPC_OnVehicleDeath(vehicleid)
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!TaxiNPC_Active[i]) continue;
        if (player_rentcar[i] != vehicleid) continue;

        SendClientMessage(i, col_gray,
        "{"#cRD"}[تاكسي] {"#cWH"}تدمّرت سيارة التاكسي، تم إلغاء الطلب."
        );
        TaxiNPC_FullCleanup(i);
    }
}
