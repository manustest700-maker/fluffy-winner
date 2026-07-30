/*
 *  Car Port Job
 *  ============
 *  Launcher dialog channel: [!PORT_OPEN]
 */

#define PORT_JOB_DIALOG             (31980)
#define PORT_JOB_MODEL              (15784)
#define PORT_JOB_STAGE_NONE         (0)
#define PORT_JOB_STAGE_COLLECT      (1)
#define PORT_JOB_STAGE_DELIVER      (2)
#define PORT_JOB_STAGE_RETURN       (3)
#define PORT_JOB_MAX_ORDERS         (4)
#define PORT_JOB_MAX_TIME           (1800000)
#define PORT_JOB_ABANDON_TIME       (90000)
#define PORT_JOB_MAP_ICON           (97)
#define PORT_JOB_ROTATION_SECONDS   (2100)
#define PORT_JOB_MAX_LEVEL          (50)
#define PORT_JOB_REQUIRED_LEVEL     (4)
#define PORT_JOB_TRIPS_PER_LEVEL    (5)
#define PORT_JOB_DELIVERY_RADIUS    (12.0)
#define PORT_JOB_DELIVERY_FALLBACK  (16.0)
#define PORT_JOB_SPAWN_CLEARANCE    (5.0)

#define PORT_JOB_NPC_X              (2797.000488)
#define PORT_JOB_NPC_Y              (-2396.435058)
#define PORT_JOB_NPC_Z              (13.638290)
#define PORT_JOB_NPC_A              (186.98)
#define PORT_JOB_PICKUP_X           (2796.878174)
#define PORT_JOB_PICKUP_Y           (-2397.427490)
#define PORT_JOB_PICKUP_Z           (13.638290)

#pragma warning disable 239

enum E_PORT_JOB_TYPE
{
    port_type_name [ 32 ],
    port_type_color_1,
    port_type_color_2
}

new const g_port_types [ ] [ E_PORT_JOB_TYPE ] =
{
    { "سيارة عائلية", 1, 1 },
    { "سيارة رياضية", 3, 3 },
    { "سيارة كلاسيكية", 6, 1 },
    { "سيارة فاخرة", 0, 0 },
    { "سيارة معرض", 36, 36 },
    { "سيارة مستوردة", 53, 53 },
    { "سيارة نادرة", 126, 126 },
    { "سيارة رجال أعمال", 13, 13 }
};

enum E_PORT_DESTINATION
{
    port_destination_name [ 48 ],
    Float: port_destination_x,
    Float: port_destination_y,
    Float: port_destination_z,
    port_destination_pay
}

new const g_port_destinations [ ] [ E_PORT_DESTINATION ] =
{
    { "موقف طريق مطار لوس سانتوس", 1707.0332, -2321.8752, 13.5159, 7600 },
    { "موقف محطة يونيتي", 1776.2261, -1916.6229, 13.5428, 7200 },
    { "موقف ساحة بيرشينغ", 1475.7048, -1729.0171, 13.5162, 7400 },
    { "موقف سوق لوس سانتوس", 956.6282, -1356.3705, 13.8730, 8800 },
    { "موقف طريق روديو", 483.8956, -1283.9414, 15.6080, 8500 },
    { "موقف جنوب لوس سانتوس", 1651.3114, -2192.1038, 13.5079, 7000 },
    { "موقف طريق أوشن دوكس", 2362.6572, -2048.8418, 13.2761, 7900 },
    { "موقف طريق إيست بيتش", 2822.1694, -1657.4464, 10.3992, 8300 },
    { "موقف طريق جيفرسون", 1820.0616, -1460.8405, 13.0566, 6500 },
    { "موقف طريق فين وود", 2091.5491, -1099.1356, 24.6460, 11200 },
    { "موقف طريق فيرونا", 713.9892, -1769.4553, 13.8480, 9200 },
    { "موقف طريق سانتا ماريا", 419.2585, -1772.8204, 4.9821, 10800 }
};

new const Float:g_port_spawns [ 5 ] [ 4 ] =
{
    { 2766.537353, -2444.105957, 13.648437, 4.36 },
    { 2756.211669, -2452.827880, 13.455636, 7.14 },
    { 2767.241455, -2469.067626, 13.648437, 4.76 },
    { 2763.933593, -2505.177490, 13.648107, 38.10 },
    { 2754.719726, -2484.809814, 13.648437, 355.19 }
};

new g_port_actor = INVALID_ACTOR_ID;
new g_port_pickup = -1;
new g_port_vehicle [ MAX_PLAYERS ];
new g_port_checkpoint [ MAX_PLAYERS ];
new g_port_stage [ MAX_PLAYERS ];
new g_port_order [ MAX_PLAYERS ];
new g_port_type [ MAX_PLAYERS ];
new g_port_destination [ MAX_PLAYERS ];
new g_port_pay [ MAX_PLAYERS ];
new g_port_spawn [ MAX_PLAYERS ];
new g_port_trips [ MAX_PLAYERS ];
new g_port_earnings [ MAX_PLAYERS ];
new g_port_streak [ MAX_PLAYERS ];
new g_port_level [ MAX_PLAYERS ];
new g_port_started_at [ MAX_PLAYERS ];
new g_port_last_near [ MAX_PLAYERS ];
new g_port_rotation_id = -1;
new g_port_rotation_type [ PORT_JOB_MAX_ORDERS ];
new g_port_rotation_destination [ PORT_JOB_MAX_ORDERS ];
new g_port_rotation_pay [ PORT_JOB_MAX_ORDERS ];

stock PortJob_ResetPlayer ( playerid )
{
    g_port_vehicle [ playerid ] = INVALID_VEHICLE_ID;
    g_port_checkpoint [ playerid ] = -1;
    g_port_stage [ playerid ] = PORT_JOB_STAGE_NONE;
    g_port_order [ playerid ] = 0;
    g_port_type [ playerid ] = 0;
    g_port_destination [ playerid ] = 0;
    g_port_pay [ playerid ] = 0;
    g_port_spawn [ playerid ] = 0;
    g_port_started_at [ playerid ] = 0;
    g_port_last_near [ playerid ] = 0;
    return 1;
}

stock PortJob_LevelFromTrips ( trips )
{
    new port_level = ( trips / PORT_JOB_TRIPS_PER_LEVEL ) + 1;
    if ( port_level < 1 ) port_level = 1;
    if ( port_level > PORT_JOB_MAX_LEVEL ) port_level = PORT_JOB_MAX_LEVEL;
    return port_level;
}

stock PortJob_TripsToNext ( playerid )
{
    if ( g_port_level [ playerid ] >= PORT_JOB_MAX_LEVEL ) return 0;
    new remaining = g_port_level [ playerid ] * PORT_JOB_TRIPS_PER_LEVEL - g_port_trips [ playerid ];
    if ( remaining < 1 ) remaining = 1;
    return remaining;
}

stock PortJob_AdjustPay ( basepay, port_level )
{
    if ( port_level < 1 ) port_level = 1;
    if ( port_level > PORT_JOB_MAX_LEVEL ) port_level = PORT_JOB_MAX_LEVEL;
    return basepay + ( basepay * ( port_level - 1 ) * 5 / 100 );
}

stock PortJob_CanWork ( playerid )
{
    if ( p_info [ playerid ] [ level ] >= PORT_JOB_REQUIRED_LEVEL ) return 1;
    new message [ 120 ] ;
    format (
        message,
        sizeof message,
        "{FF5555}[ ميناء السيارات ] {FFFFFF}هذا العمل متاح من المستوى {FFFF00}%d {FFFFFF}فما فوق. مستواك الحالي: {FF5555}%d{FFFFFF}.",
        PORT_JOB_REQUIRED_LEVEL,
        p_info [ playerid ] [ level ]
    ) ;
    SendClientMessage ( playerid, col_gray, message ) ;
    return 0;
}

stock PortJob_IsSpawnAvailable ( spawnid )
{
    if ( spawnid < 0 || spawnid >= sizeof g_port_spawns ) return 0;
    for ( new owner = 0 ; owner < MAX_PLAYERS ; owner ++ )
    {
        if ( g_port_stage [ owner ] != PORT_JOB_STAGE_NONE && g_port_spawn [ owner ] == spawnid ) return 0;
    }
    for ( new vehicleid = 1 ; vehicleid < MAX_VEHICLES ; vehicleid ++ )
    {
        if ( ! IsValidVehicle ( vehicleid ) || GetVehicleVirtualWorld ( vehicleid ) != 0 ) continue;
        if (
            GetVehicleDistanceFromPoint (
                vehicleid,
                g_port_spawns [ spawnid ] [ 0 ],
                g_port_spawns [ spawnid ] [ 1 ],
                g_port_spawns [ spawnid ] [ 2 ]
            ) < PORT_JOB_SPAWN_CLEARANCE
        ) return 0;
    }
    return 1;
}

stock PortJob_SelectFreeSpawn ( )
{
    new first = random ( sizeof g_port_spawns ) ;
    for ( new offset = 0 ; offset < sizeof g_port_spawns ; offset ++ )
    {
        new spawnid = ( first + offset ) % sizeof g_port_spawns;
        if ( PortJob_IsSpawnAvailable ( spawnid ) ) return spawnid;
    }
    return -1;
}

stock PortJob_RotationRemaining ( )
{
    new remaining = PORT_JOB_ROTATION_SECONDS - ( gettime ( ) % PORT_JOB_ROTATION_SECONDS );
    if ( remaining < 1 || remaining > PORT_JOB_ROTATION_SECONDS ) remaining = PORT_JOB_ROTATION_SECONDS;
    return remaining;
}

stock PortJob_RefreshRotation ( )
{
    new rotation = gettime ( ) / PORT_JOB_ROTATION_SECONDS;
    if ( rotation == g_port_rotation_id ) return 0;
    g_port_rotation_id = rotation;
    for ( new i = 0 ; i < PORT_JOB_MAX_ORDERS ; i ++ )
    {
        new destination = ( rotation * 7 + i * 5 ) % sizeof g_port_destinations;
        new type = ( rotation * 3 + i * 5 ) % sizeof g_port_types;
        new variation = ( rotation * 137 + i * 311 + destination * 97 ) % 1801;
        g_port_rotation_destination [ i ] = destination;
        g_port_rotation_type [ i ] = type;
        g_port_rotation_pay [ i ] = g_port_destinations [ destination ] [ port_destination_pay ] + variation;
    }
    return 1;
}

stock PortJob_LoadStats ( playerid, trips, earnings, streak, saved_level )
{
    g_port_trips [ playerid ] = trips;
    g_port_earnings [ playerid ] = earnings;
    g_port_streak [ playerid ] = streak;
    g_port_level [ playerid ] = PortJob_LevelFromTrips ( trips ) ;
    if ( saved_level > g_port_level [ playerid ] && saved_level <= PORT_JOB_MAX_LEVEL ) g_port_level [ playerid ] = saved_level;
    return 1;
}

stock PortJob_SaveStats ( playerid )
{
    if ( p_info [ playerid ] [ id ] <= 0 ) return 0;
    new query [ 256 ] ;
    mysql_format (
        sql_connection,
        query,
        sizeof query,
        "UPDATE `users` SET `u_port_trips`='%d',`u_port_earnings`='%d',`u_port_streak`='%d',`u_port_level`='%d' WHERE `u_id`='%d' LIMIT 1",
        g_port_trips [ playerid ],
        g_port_earnings [ playerid ],
        g_port_streak [ playerid ],
        g_port_level [ playerid ],
        p_info [ playerid ] [ id ]
    ) ;
    mysql_tquery ( sql_connection, query, "", "" ) ;
    return 1;
}

stock PortJob_Init ( )
{
    PortJob_RefreshRotation ( ) ;
    g_port_actor = CreateActor ( 37, PORT_JOB_NPC_X, PORT_JOB_NPC_Y, PORT_JOB_NPC_Z, PORT_JOB_NPC_A ) ;
    if ( g_port_actor != INVALID_ACTOR_ID )
    {
        SetActorInvulnerable ( g_port_actor, 1 ) ;
        ApplyActorAnimation ( g_port_actor, "DEALER", "DEALER_IDLE", 4.1, 1, 0, 0, 1, 0 ) ;
    }
    g_port_pickup = CreateDynamicPickup ( 15228, 1, PORT_JOB_PICKUP_X, PORT_JOB_PICKUP_Y, PORT_JOB_PICKUP_Z, 0, 0 ) ;
    CreateDynamic3DTextLabel (
        "{00AEEF}[ ميناء السيارات ]\n{FFFFFF}اقترب من العلامة لعرض طلبات المشترين\n{FFFF00}عمل جديد",
        0x00AEEFFF,
        PORT_JOB_NPC_X,
        PORT_JOB_NPC_Y,
        PORT_JOB_NPC_Z + 1.05,
        25.0,
        INVALID_PLAYER_ID,
        INVALID_VEHICLE_ID,
        0,
        0,
        0
    ) ;
    CreateDynamicMapIcon ( PORT_JOB_NPC_X, PORT_JOB_NPC_Y, PORT_JOB_NPC_Z, 55, 0x00AEEFFF, 0, 0, -1, 300.0 ) ;
    for ( new playerid = 0 ; playerid < MAX_PLAYERS ; playerid ++ ) PortJob_ResetPlayer ( playerid ) ;
    SetTimer ( "PortJob_Tick", 5000, true ) ;
    return 1;
}

stock PortJob_ClearCheckpoint ( playerid )
{
    if ( g_port_checkpoint [ playerid ] != -1 )
    {
        DestroyDynamicCP ( g_port_checkpoint [ playerid ] ) ;
        g_port_checkpoint [ playerid ] = -1;
    }
    DisablePlayerRaceCheckpoint ( playerid ) ;
    RemovePlayerMapIcon ( playerid, PORT_JOB_MAP_ICON ) ;
    return 1;
}

stock PortJob_DestroyVehicle ( playerid )
{
    if ( g_port_vehicle [ playerid ] != INVALID_VEHICLE_ID && IsValidVehicle ( g_port_vehicle [ playerid ] ) )
    {
        if ( GetPlayerVehicleID ( playerid ) == g_port_vehicle [ playerid ] ) RemovePlayerFromVehicle ( playerid ) ;
        AC_DestroyVehicle ( g_port_vehicle [ playerid ] ) ;
    }
    g_port_vehicle [ playerid ] = INVALID_VEHICLE_ID;
    return 1;
}

stock PortJob_CancelShipment ( playerid, bool: notify )
{
    new bool: had_shipment = g_port_stage [ playerid ] != PORT_JOB_STAGE_NONE;
    PortJob_ClearCheckpoint ( playerid ) ;
    PortJob_DestroyVehicle ( playerid ) ;
    g_port_stage [ playerid ] = PORT_JOB_STAGE_NONE;
    g_port_started_at [ playerid ] = 0;
    g_port_last_near [ playerid ] = 0;
    if ( had_shipment )
    {
        g_port_streak [ playerid ] = 0;
        PortJob_SaveStats ( playerid ) ;
    }
    if ( notify ) SendClientMessage ( playerid, col_gray, "{FF5555}[ ميناء السيارات ] {FFFFFF}تم إلغاء الشحنة وإعادة السيارة إلى الميناء." ) ;
    return 1;
}

stock PortJob_OpenMenu ( playerid )
{
    if ( ! PortJob_CanWork ( playerid ) ) return 0;
    PortJob_RefreshRotation ( ) ;
    new body [ 620 ], line [ 80 ] ;
    format (
        body,
        sizeof body,
        "STATS:%d|%d|%d|%d|%d|%d|%d\nSTATE:%d\n",
        g_port_trips [ playerid ],
        g_port_earnings [ playerid ],
        g_port_streak [ playerid ],
        p_info [ playerid ] [ timejob ] == job_car_port,
        g_port_level [ playerid ],
        PortJob_RotationRemaining ( ),
        PortJob_TripsToNext ( playerid ),
        g_port_stage [ playerid ]
    ) ;
    for ( new i = 0 ; i < PORT_JOB_MAX_ORDERS ; i ++ )
    {
        new payment = PortJob_AdjustPay ( g_port_rotation_pay [ i ], g_port_level [ playerid ] ) ;
        format (
            line,
            sizeof line,
            "ORDER2:%d|%d|%d|%d\n",
            i,
            g_port_rotation_type [ i ],
            g_port_rotation_destination [ i ],
            payment
        ) ;
        strcat ( body, line ) ;
    }
    return show_dialog (
        playerid,
        PORT_JOB_DIALOG,
        DIALOG_STYLE_MSGBOX,
        "[!PORT_OPEN]",
        body,
        "فتح",
        "إغلاق"
    ) ;
}

stock PortJob_Employ ( playerid )
{
    if ( ! PortJob_CanWork ( playerid ) ) return 0;
    if ( p_info [ playerid ] [ timejob ] != job_none && p_info [ playerid ] [ timejob ] != job_car_port )
    {
        SendClientMessage ( playerid, col_gray, "{FF5555}* {FFFFFF}لازم تنهي عملك الحالي قبل ما تبدأ في ميناء السيارات." ) ;
        return 0;
    }
    if ( p_info [ playerid ] [ timejob ] != job_car_port )
    {
        p_info [ playerid ] [ timejob ] = job_car_port;
        update_int_sql ( playerid, "u_timejob", job_car_port ) ;
        SendClientMessage ( playerid, col_white, "{00AEEF}[ ميناء السيارات ] {FFFFFF}تم توظيفك. اختر طلب المشتري المناسب وابدأ التوصيل." ) ;
    }
    return 1;
}

stock PortJob_StartShipment ( playerid, orderid )
{
    PortJob_RefreshRotation ( ) ;
    if ( orderid < 0 || orderid >= PORT_JOB_MAX_ORDERS ) return 0;
    if ( ! PortJob_Employ ( playerid ) ) return 0;
    if ( g_port_stage [ playerid ] != PORT_JOB_STAGE_NONE )
    {
        SendClientMessage ( playerid, col_gray, "{FF5555}* {FFFFFF}عندك شحنة نشطة حالياً. سلّمها أو ألغها قبل اختيار طلب جديد." ) ;
        return 0;
    }
    if ( ! IsPlayerInRangeOfPoint ( playerid, 25.0, PORT_JOB_NPC_X, PORT_JOB_NPC_Y, PORT_JOB_NPC_Z ) )
    {
        SendClientMessage ( playerid, col_gray, "{FF5555}* {FFFFFF}لازم تكون عند مسؤول ميناء السيارات لاختيار شحنة." ) ;
        return 0;
    }

    new spawnid = PortJob_SelectFreeSpawn ( ) ;
    if ( spawnid == -1 )
    {
        SendClientMessage ( playerid, col_gray, "{FF5555}[ ميناء السيارات ] {FFFFFF}كل مواقف الاستلام مشغولة الآن. انتظر خروج إحدى السيارات ثم حاول مرة ثانية." ) ;
        return 0;
    }
    new type = g_port_rotation_type [ orderid ];
    new destination = g_port_rotation_destination [ orderid ];
    new vehicleid = AC_CreateVehicle (
        PORT_JOB_MODEL,
        g_port_spawns [ spawnid ] [ 0 ],
        g_port_spawns [ spawnid ] [ 1 ],
        g_port_spawns [ spawnid ] [ 2 ],
        g_port_spawns [ spawnid ] [ 3 ],
        g_port_types [ type ] [ port_type_color_1 ],
        g_port_types [ type ] [ port_type_color_2 ],
        -1
    ) ;
    if ( vehicleid == INVALID_VEHICLE_ID || ! IsValidVehicle ( vehicleid ) )
    {
        SendClientMessage ( playerid, col_gray, "{FF5555}* {FFFFFF}تعذر تجهيز سيارة الشحنة الآن. حاول مرة ثانية." ) ;
        return 0;
    }

    g_port_vehicle [ playerid ] = vehicleid;
    g_port_order [ playerid ] = orderid;
    g_port_type [ playerid ] = type;
    g_port_destination [ playerid ] = destination;
    g_port_pay [ playerid ] = PortJob_AdjustPay ( g_port_rotation_pay [ orderid ], g_port_level [ playerid ] ) ;
    g_port_spawn [ playerid ] = spawnid;
    g_port_stage [ playerid ] = PORT_JOB_STAGE_COLLECT;
    g_port_started_at [ playerid ] = GetTickCount ( ) ;
    g_port_last_near [ playerid ] = g_port_started_at [ playerid ];
    veh_info [ vehicleid - 1 ] [ v_fuel ] = 100.0;
    SetVehicleParamsEx ( vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_ON ) ;
    PortJob_ClearCheckpoint ( playerid ) ;
    SetPlayerRaceCheckpoint (
        playerid,
        1,
        g_port_spawns [ spawnid ] [ 0 ],
        g_port_spawns [ spawnid ] [ 1 ],
        g_port_spawns [ spawnid ] [ 2 ],
        0.0,
        0.0,
        0.0,
        4.0
    ) ;
    SetPlayerMapIcon (
        playerid,
        PORT_JOB_MAP_ICON,
        g_port_spawns [ spawnid ] [ 0 ],
        g_port_spawns [ spawnid ] [ 1 ],
        g_port_spawns [ spawnid ] [ 2 ],
        0,
        0xFF9D23FF,
        0
    ) ;

    new message [ 180 ] ;
    format (
        message,
        sizeof message,
        "{00AEEF}[ ميناء السيارات ] {FFFFFF}سيارة الطلب جاهزة. اركبها ثم سلّمها إلى {FFFF00}%s{FFFFFF}.",
        g_port_destinations [ destination ] [ port_destination_name ]
    ) ;
    SendClientMessage ( playerid, col_white, message ) ;
    SendClientMessage ( playerid, col_white, "{FF9D23}* {FFFFFF}تم تحديد سيارة الميناء بعلامة برتقالية واضحة على الخريطة." ) ;
    SendClientMessage ( playerid, col_white, "{FFFF00}* {FFFFFF}حافظ على السيارة وسلّمها بسرعة لتحصل على مكافأة الحالة والوقت." ) ;
    return 1;
}

stock PortJob_FinishShipment ( playerid )
{
    new vehicleid = g_port_vehicle [ playerid ] ;
    if ( vehicleid == INVALID_VEHICLE_ID || ! IsValidVehicle ( vehicleid ) ) return PortJob_CancelShipment ( playerid, true ) ;

    new Float:health;
    GetVehicleHealth ( vehicleid, health ) ;
    if ( health < 450.0 )
    {
        SendClientMessage ( playerid, col_gray, "{FF5555}[ ميناء السيارات ] {FFFFFF}السيارة متضررة جداً ورفض المشتري استلامها." ) ;
        return PortJob_CancelShipment ( playerid, false ) ;
    }

    new payment = g_port_pay [ playerid ];
    new condition_bonus = 0;
    if ( health >= 900.0 ) condition_bonus = payment / 5;
    else if ( health >= 700.0 ) condition_bonus = payment / 10;

    new elapsed = GetTickCount ( ) - g_port_started_at [ playerid ];
    new time_bonus = elapsed <= 600000 ? payment / 10 : 0;
    g_port_streak [ playerid ] ++;
    new streak_bonus = g_port_streak [ playerid ] * 250;
    if ( streak_bonus > 1500 ) streak_bonus = 1500;
    new payout_total = payment + condition_bonus + time_bonus + streak_bonus;

    give_money ( playerid, payout_total ) ;
    insert_money_log ( playerid, INVALID_PLAYER_ID, payout_total, "car port job" ) ;
    g_port_trips [ playerid ] ++;
    g_port_earnings [ playerid ] += payout_total;
    new old_level = g_port_level [ playerid ];
    g_port_level [ playerid ] = PortJob_LevelFromTrips ( g_port_trips [ playerid ] ) ;
    PortJob_SaveStats ( playerid ) ;

    new message [ 190 ] ;
    format (
        message,
        sizeof message,
        "{00AEEF}[ ميناء السيارات ] {FFFFFF}تمت إعادة السيارة وصرف الأجر: {5FD46A}$%d {FFFFFF}(حالة $%d + سرعة $%d + سلسلة $%d).",
        payout_total,
        condition_bonus,
        time_bonus,
        streak_bonus
    ) ;
    SendClientMessage ( playerid, col_white, message ) ;
    PortJob_ClearCheckpoint ( playerid ) ;
    PortJob_DestroyVehicle ( playerid ) ;
    g_port_stage [ playerid ] = PORT_JOB_STAGE_NONE;
    g_port_started_at [ playerid ] = 0;
    g_port_last_near [ playerid ] = 0;
    if ( g_port_level [ playerid ] > old_level )
    {
        format ( message, sizeof message, "{FFFF00}[ ميناء السيارات ] {FFFFFF}مبروك! ارتفع مستوى العمل إلى {5FD46A}%d{FFFFFF} وزادت أسعار طلباتك.", g_port_level [ playerid ] ) ;
        SendClientMessage ( playerid, col_white, message ) ;
    }
    SendClientMessage ( playerid, col_white, "{FFFF00}* {FFFFFF}ارجع لمسؤول الميناء لاختيار طلب جديد، أو استخدم GPS ثم الأعمال." ) ;
    return 1;
}

stock PortJob_Quit ( playerid )
{
    PortJob_CancelShipment ( playerid, false ) ;
    if ( p_info [ playerid ] [ timejob ] == job_car_port )
    {
        p_info [ playerid ] [ timejob ] = job_none;
        JobMission_End ( playerid ) ;
    }
    SendClientMessage ( playerid, col_white, "{00AEEF}[ ميناء السيارات ] {FFFFFF}أنهيت دوامك في الميناء." ) ;
    return 1;
}

stock PortJob_OnDialogResponse ( playerid, dialogid, response, const inputtext [ ] )
{
    if ( dialogid != PORT_JOB_DIALOG ) return 0;
    if ( ! response ) return 1;
    if ( ! strlen ( inputtext ) )
    {
        PortJob_StartShipment ( playerid, 0 ) ;
        return 1;
    }
    if ( ! strcmp ( inputtext, "CLOSE", true ) ) return 1;
    if ( ! strcmp ( inputtext, "REFRESH", true ) ) return PortJob_OpenMenu ( playerid ) ;
    if ( ! strcmp ( inputtext, "START", true ) )
    {
        PortJob_Employ ( playerid ) ;
        return PortJob_OpenMenu ( playerid ) ;
    }
    if ( ! strcmp ( inputtext, "QUIT", true ) ) return PortJob_Quit ( playerid ) ;
    if ( ! strcmp ( inputtext, "CANCEL", true ) )
    {
        PortJob_CancelShipment ( playerid, true ) ;
        return 1;
    }
    if ( ! strfind ( inputtext, "ACCEPT ", true ) )
    {
        new orderid;
        if ( sscanf ( inputtext [ 7 ], "d", orderid ) ) return 1;
        PortJob_StartShipment ( playerid, orderid ) ;
        return 1;
    }
    return 1;
}

stock PortJob_OnPickup ( playerid, pickupid )
{
    if ( pickupid != g_port_pickup ) return 0;
    if ( GetPlayerState ( playerid ) != PLAYER_STATE_ONFOOT ) return 1;
    if ( GetPVarInt ( playerid, "port_menu_lock" ) ) return 1;
    SetPVarInt ( playerid, "port_menu_lock", 1 ) ;
    SetTimerEx ( "PortJob_UnlockMenu", 1500, false, "i", playerid ) ;
    PortJob_OpenMenu ( playerid ) ;
    return 1;
}

stock PortJob_OnPlayerConnect ( playerid )
{
    PortJob_ResetPlayer ( playerid ) ;
    g_port_trips [ playerid ] = 0;
    g_port_earnings [ playerid ] = 0;
    g_port_streak [ playerid ] = 0;
    g_port_level [ playerid ] = 1;
    DeletePVar ( playerid, "port_menu_lock" ) ;
    return 1;
}

stock PortJob_OnPlayerDisconnect ( playerid )
{
    if ( g_port_stage [ playerid ] != PORT_JOB_STAGE_NONE ) PortJob_CancelShipment ( playerid, false ) ;
    else
    {
        PortJob_ClearCheckpoint ( playerid ) ;
        PortJob_DestroyVehicle ( playerid ) ;
    }
    PortJob_ResetPlayer ( playerid ) ;
    return 1;
}

stock PortJob_OnPlayerDeath ( playerid )
{
    if ( g_port_stage [ playerid ] != PORT_JOB_STAGE_NONE ) PortJob_CancelShipment ( playerid, true ) ;
    return 1;
}

stock PortJob_OnPlayerStateChange ( playerid, newstate )
{
    if ( newstate != PLAYER_STATE_DRIVER ) return 0;
    new vehicleid = GetPlayerVehicleID ( playerid ) ;
    for ( new owner = 0 ; owner < MAX_PLAYERS ; owner ++ )
    {
        if ( owner == playerid || g_port_vehicle [ owner ] != vehicleid ) continue;
        RemovePlayerFromVehicle ( playerid ) ;
        SendClientMessage ( playerid, col_gray, "{FF5555}* {FFFFFF}هذه السيارة محجوزة لموظف آخر في ميناء السيارات." ) ;
        return 2;
    }
    if ( g_port_vehicle [ playerid ] != vehicleid ) return 0;
    SetVehicleParamsEx ( vehicleid, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_ON ) ;
    if ( g_port_stage [ playerid ] != PORT_JOB_STAGE_COLLECT ) return 1;

    PortJob_ClearCheckpoint ( playerid ) ;
    g_port_stage [ playerid ] = PORT_JOB_STAGE_DELIVER;
    new destination = g_port_destination [ playerid ];
    SetPlayerRaceCheckpoint (
        playerid,
        1,
        g_port_destinations [ destination ] [ port_destination_x ],
        g_port_destinations [ destination ] [ port_destination_y ],
        g_port_destinations [ destination ] [ port_destination_z ],
        0.0,
        0.0,
        0.0,
        PORT_JOB_DELIVERY_RADIUS
    ) ;
    SetPlayerMapIcon (
        playerid,
        PORT_JOB_MAP_ICON,
        g_port_destinations [ destination ] [ port_destination_x ],
        g_port_destinations [ destination ] [ port_destination_y ],
        g_port_destinations [ destination ] [ port_destination_z ],
        0,
        0xFF9D23FF,
        0
    ) ;
    new message [ 150 ] ;
    format ( message, sizeof message, "{00AEEF}[ ميناء السيارات ] {FFFFFF}تم تحديد موقع {FFFF00}%s {FFFFFF}بعلامة GPS برتقالية على الخريطة.", g_port_destinations [ destination ] [ port_destination_name ] ) ;
    SendClientMessage ( playerid, col_white, message ) ;
    SendClientMessage ( playerid, col_white, "{FF9D23}* {FFFFFF}اتبع علامة السباق على الخريطة حتى نقطة تسليم السيارة." ) ;
    return 1;
}

stock PortJob_OnPlayerEnterDynamicCP ( playerid, checkpointid )
{
    #pragma unused playerid
    #pragma unused checkpointid
    return 0;
}

stock PortJob_OnEnterRaceCP ( playerid )
{
    if ( g_port_stage [ playerid ] == PORT_JOB_STAGE_NONE ) return 0;
    if ( g_port_stage [ playerid ] == PORT_JOB_STAGE_COLLECT )
    {
        SendClientMessage ( playerid, col_white, "{00AEEF}[ ميناء السيارات ] {FFFFFF}اركب سيارة الشحنة لعرض موقع المشتري." ) ;
        return 1;
    }
    if ( GetPlayerState ( playerid ) != PLAYER_STATE_DRIVER || GetPlayerVehicleID ( playerid ) != g_port_vehicle [ playerid ] )
    {
        SendClientMessage ( playerid, col_gray, "{FF5555}* {FFFFFF}لازم تدخل العلامة وأنت تقود نفس سيارة الشحنة." ) ;
        return 1;
    }
    if ( g_port_stage [ playerid ] == PORT_JOB_STAGE_DELIVER )
    {
        new vehicleid = g_port_vehicle [ playerid ];
        new Float:health;
        GetVehicleHealth ( vehicleid, health ) ;
        if ( health < 450.0 )
        {
            SendClientMessage ( playerid, col_gray, "{FF5555}[ ميناء السيارات ] {FFFFFF}السيارة متضررة جداً ورفض المشتري تسجيل التسليم." ) ;
            PortJob_CancelShipment ( playerid, false ) ;
            return 1;
        }
        new spawnid = g_port_spawn [ playerid ];
        PortJob_ClearCheckpoint ( playerid ) ;
        g_port_stage [ playerid ] = PORT_JOB_STAGE_RETURN;
        SetPlayerRaceCheckpoint (
            playerid,
            1,
            g_port_spawns [ spawnid ] [ 0 ],
            g_port_spawns [ spawnid ] [ 1 ],
            g_port_spawns [ spawnid ] [ 2 ],
            0.0,
            0.0,
            0.0,
            5.5
        ) ;
        SetPlayerMapIcon (
            playerid,
            PORT_JOB_MAP_ICON,
            g_port_spawns [ spawnid ] [ 0 ],
            g_port_spawns [ spawnid ] [ 1 ],
            g_port_spawns [ spawnid ] [ 2 ],
            0,
            0x5FD46AFF,
            0
        ) ;
        SendClientMessage ( playerid, col_white, "{00AEEF}[ ميناء السيارات ] {FFFFFF}تم تسجيل التسليم للمشتري. أعد نفس السيارة إلى ميناء السيارات لتحصل على المكافأة." ) ;
        SendClientMessage ( playerid, col_white, "{5FD46A}* {FFFFFF}تم تحديد نفس موقف الاستلام بعلامة خضراء على الخريطة." ) ;
        return 1;
    }
    if ( g_port_stage [ playerid ] == PORT_JOB_STAGE_RETURN )
    {
        PortJob_FinishShipment ( playerid ) ;
        return 1;
    }
    return 1;
}

stock PortJob_OnVehicleDeath ( vehicleid )
{
    for ( new playerid = 0 ; playerid < MAX_PLAYERS ; playerid ++ )
    {
        if ( g_port_vehicle [ playerid ] != vehicleid ) continue;
        g_port_vehicle [ playerid ] = INVALID_VEHICLE_ID;
        PortJob_CancelShipment ( playerid, true ) ;
        return 1;
    }
    return 0;
}

forward PortJob_UnlockMenu ( playerid ) ;
public PortJob_UnlockMenu ( playerid )
{
    DeletePVar ( playerid, "port_menu_lock" ) ;
    return 1;
}

forward PortJob_Tick ( ) ;
public PortJob_Tick ( )
{
    PortJob_RefreshRotation ( ) ;
    new now = GetTickCount ( ) ;
    for ( new playerid = 0 ; playerid < MAX_PLAYERS ; playerid ++ )
    {
        if ( ! IsPlayerConnected ( playerid ) || g_port_stage [ playerid ] == PORT_JOB_STAGE_NONE ) continue;
        new vehicleid = g_port_vehicle [ playerid ];
        if ( vehicleid == INVALID_VEHICLE_ID || ! IsValidVehicle ( vehicleid ) )
        {
            PortJob_CancelShipment ( playerid, true ) ;
            continue;
        }
        if ( now - g_port_started_at [ playerid ] > PORT_JOB_MAX_TIME )
        {
            SendClientMessage ( playerid, col_gray, "{FF5555}[ ميناء السيارات ] {FFFFFF}انتهى وقت تسليم الشحنة." ) ;
            PortJob_CancelShipment ( playerid, false ) ;
            continue;
        }
        new Float:vx, Float:vy, Float:vz;
        GetVehiclePos ( vehicleid, vx, vy, vz ) ;
        if (
            g_port_stage [ playerid ] == PORT_JOB_STAGE_DELIVER
            && GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER
            && GetPlayerVehicleID ( playerid ) == vehicleid
        )
        {
            new destination = g_port_destination [ playerid ];
            if (
                GetVehicleDistanceFromPoint (
                    vehicleid,
                    g_port_destinations [ destination ] [ port_destination_x ],
                    g_port_destinations [ destination ] [ port_destination_y ],
                    g_port_destinations [ destination ] [ port_destination_z ]
                ) <= PORT_JOB_DELIVERY_FALLBACK
            )
            {
                PortJob_OnEnterRaceCP ( playerid ) ;
                continue;
            }
        }
        if ( IsPlayerInRangeOfPoint ( playerid, 100.0, vx, vy, vz ) )
        {
            g_port_last_near [ playerid ] = now;
            continue;
        }
        if ( now - g_port_last_near [ playerid ] > PORT_JOB_ABANDON_TIME )
        {
            SendClientMessage ( playerid, col_gray, "{FF5555}[ ميناء السيارات ] {FFFFFF}تم إلغاء الشحنة لأنك ابتعدت عن السيارة." ) ;
            PortJob_CancelShipment ( playerid, false ) ;
        }
    }
    return 1;
}

#pragma warning enable 239
