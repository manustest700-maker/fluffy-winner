// =====================================================================
//  حدث جمع الهدايا المفقودة  -  Lost Gifts Collection Event
//  10 مهمات جديدة مرتبطة بحدث جمع الهدايا المفقودة
//  NPC: ميمز  |  حفظ التقدم بقاعدة البيانات لكل لاعب
//  المكافآت: مبالغ قوية + سيارات فاخرة + أغلى اكسسوار للحقيبة
//  (Devin-injected, self-contained module, CP1256)
// =====================================================================

#if defined _lostgifts_included
    #endinput
#endif
#define _lostgifts_included

// ---- إعدادات الحدث ----
#define LG_MISSIONS            10
#define LG_MAX_GIFTS           8
#define LG_DLG_LIST            30801
#define LG_DLG_DETAIL          30802
#define LG_PICKUP_MODEL        19135      // أيقونة المعلومات فوق ميمز
#define LG_GIFT_MODEL          1210       // حقيبة الهدية المفقودة
#define LG_NPC_SKIN            240

// نوع المهمة
#define LG_T_COLLECT           1          // اجمع الهدايا
#define LG_T_GOTO              2          // سلّم الهدية بمكان
#define LG_T_KILL              3          // اقتل لص الهدايا
#define LG_T_DRIVE             4          // قُد المركبة وسلّم
#define LG_T_ROUTE             5          // جولة عدة نقاط
#define LG_T_ESCAPE            6          // اهرب من الكمين
#define LG_T_CHASE             7          // الحق بالهارب

// موقع ميمز (كما طلب اللاعب)
#define LG_NPC_X               2037.288452
#define LG_NPC_Y               (-1412.104614)
#define LG_NPC_Z               17.164062
#define LG_NPC_A               112.21

// ---- بيانات الحدث ----
new g_lg_actor      = INVALID_ACTOR_ID;
new g_lg_pickup     = 0;
new STREAMER_TAG_3D_TEXT_LABEL:g_lg_label;

// ---- حالة اللاعب ----
new g_lg_loaded     [ MAX_PLAYERS ];
new g_lg_done       [ MAX_PLAYERS ];           // عدد المهمات المكتملة (0..10)
new g_lg_active     [ MAX_PLAYERS ];           // المهمة الجارية (1..10) أو 0
new g_lg_progress   [ MAX_PLAYERS ];           // تقدم الهدف الحالي
new g_lg_gift       [ MAX_PLAYERS ] [ LG_MAX_GIFTS ];
new g_lg_thief      [ MAX_PLAYERS ];           // معرف الـ FCNPC اللص
new g_lg_icon       [ MAX_PLAYERS ];           // علامة الخريطة للهدف
new g_lg_cp         [ MAX_PLAYERS ];           // نقطة (checkpoint) الهدف
new g_lg_atnpc      [ MAX_PLAYERS ];           // لاعب بجانب ميمز (منع تمرا± الديلوج)
new g_lg_gicon      [ MAX_PLAYERS ] [ LG_MAX_GIFTS ];
new g_lg_veh        [ MAX_PLAYERS ];           // مركبة المهمة
new PlayerText:g_lg_hud [ MAX_PLAYERS ];

// عنوان كل مهمة
new const g_lg_title [ LG_MISSIONS ] [ 48 ] =
{
    "هدايا الحي المفقودة",
    "توصيل صندوق الهدايا",
    "جولة توزيع الهدايا",
    "مطاردة لص الهدايا",
    "كنز الهدايا الكبير",
    "شحنة ميناء لوس سانتوس",
    "كمين اللصوص",
    "توصيل هدية كبار الشخصيات",
    "اللحاق بالحارس الهارب",
    "أسطورة الهدايا: زعيم العصابة"
};

// شرح كل مهمة بالعربي
new const g_lg_desc [ LG_MISSIONS ] [ 360 ] =
{
    "{ffffff}انتشرت هدايا مفقودة في الحي حول ميمز.\nاجمع {FFD700}5 هدايا{ffffff} قبل أن تختفي.\n\n{00FF7F}المكافأة: 60,000$",
    "{ffffff}وصلت شحنة هدايا.\n{FFD700}اركب مركبة التوصيل{ffffff} وأوصلها إلى نقطة التسليم على الخريطة (يجب أن تكون داخل المركبة).\n\n{00FF7F}المكافأة: 90,000$",
    "{ffffff}وزّع الهدايا على الحي.\nمُر على {FFD700}3 نقاط توصيل{ffffff} بالترتيب (اتبع العلامة).\n\n{00FF7F}المكافأة: 120,000$",
    "{ffffff}شوهد لص يسرق هدايا الأطفال!\nالحقه و{FF5555}اقضِ عليه{ffffff} لاستعادة الهدايا.\n\n{FFD700}مهمة Overlay\n{00FF7F}المكافأة: 180,000$",
    "{ffffff}كنز كبير من الهدايا المفقودة تناثر في منطقة واسعة.\nاجمع {FFD700}8 هدايا{ffffff}.\n\n{00FF7F}المكافأة: 250,000$ + سيارة فاخرة (توريزمو)",
    "{ffffff}شحنة هدايا كبيرة في الميناء.\n{FFD700}قُد الشاحنة{ffffff} وأوصلها إلى نقطة الاستلام (ابقَ داخل المركبة).\n\n{00FF7F}المكافأة: 320,000$",
    "{ffffff}كمنت لك عصابة اللصوص!\n{FF5555}اهرب{ffffff} وانجُ إلى نقطة الأمان على الخريطة قبل أن يمسكوك.\n\n{FFD700}مهمة Overlay\n{00FF7F}المكافأة: 450,000$",
    "{ffffff}هدية ثمينة لكبار الشخصيات.\nأوصلها عبر {FFD700}3 نقاط آمنة{ffffff} بالترتيب.\n\n{00FF7F}المكافأة: 600,000$ + اكسسوار فاخر",
    "{ffffff}حارس الهدايا يحاول الهرب بالغنيمة!\n{FF5555}الحق به{ffffff} وأمسكه قبل أن يفلت.\n\n{FFD700}مهمة Overlay\n{00FF7F}المكافأة: 800,000$ + سيارة فاخرة (إنفرنو)",
    "{ffffff}المواجهة الأخيرة مع زعيم عصابة سرقة الهدايا.\n{FF5555}اقضِ على الزعيم{ffffff} واستعد كل الهدايا.\n\n{FFD700}مهمة Overlay\n{00FF7F}المكافأة: 1,500,000$ + سيارة فاخرة (بوليت) + أغلى اكسسوار"
};

new const g_lg_title_en [ LG_MISSIONS ] [ 40 ] =
{
    "Lost Neighborhood Gifts",
    "Gift Box Delivery",
    "Gift Distribution Run",
    "Gift Thief Chase",
    "The Great Gift Treasure",
    "Port Gift Shipment",
    "Thieves Ambush",
    "VIP Gift Delivery",
    "Catch the Runaway Guard",
    "Lost Gifts Legend: Boss"
};

new const g_lg_type  [ LG_MISSIONS ] = { 1, 4, 5, 3, 1, 4, 6, 5, 7, 3 };
new const g_lg_need  [ LG_MISSIONS ] = { 5, 1, 3, 1, 8, 1, 1, 3, 1, 1 };
new const g_lg_money [ LG_MISSIONS ] = { 60000, 90000, 120000, 180000, 250000, 320000, 450000, 600000, 800000, 1500000 };
new const g_lg_car   [ LG_MISSIONS ] = { 0, 0, 0, 0, 451, 0, 0, 0, 411, 541 };
new const g_lg_acc   [ LG_MISSIONS ] = { 0, 0, 0, 0, 0, 0, 0, 19043, 0, 19632 };
new const bool:g_lg_ovl [ LG_MISSIONS ] = { false, false, false, true, false, false, true, false, true, true };

// مركز هدف كل مهمة (قرب ميمز - منطقة منبسطة)
new const Float:g_lg_cx [ LG_MISSIONS ] = { 1782.21, 2617.25, 958.25, 1263.77, 1270.88, 2801.19, 1499.65, 2566.18, 717.64, 1551.56 };
new const Float:g_lg_cy [ LG_MISSIONS ] = { -1887.29, -2391.56, -1387.63, -1273.14, -1346.70, -1171.87, -1486.31, -2450.56, -1435.95, -1675.66 };
new const Float:g_lg_cz [ LG_MISSIONS ] = { 13.0, 13.3, 13.0, 13.2, 13.6, 25.6, 13.6, 13.7, 13.6, 16.0 };
#define LG_POOL 12
// Open Los Santos spots (streets/plazas) - verified not inside walls/houses
new const Float:g_lg_gpx [ LG_POOL ] = { 1782.21, 2617.25, 958.25, 1263.77, 1270.88, 2801.19, 1499.65, 2566.18, 717.64, 1551.56, 951.49, 2791.83 };
new const Float:g_lg_gpy [ LG_POOL ] = { -1887.29, -2391.56, -1387.63, -1273.14, -1346.70, -1171.87, -1486.31, -2450.56, -1435.95, -1675.66, -1358.38, -1450.01 };
new const Float:g_lg_gpz [ LG_POOL ] = { 13.0, 13.3, 13.0, 13.2, 13.6, 25.6, 13.6, 13.7, 13.6, 16.0, 13.4, 28.2 };

forward LostGifts_Tick();
forward LostGifts_OnLoad(playerid);
forward LostGifts_OpenDeferred(playerid);

// ---------------------------------------------------------------------
LostGifts_Init()
{
    g_lg_actor = CreateActor(LG_NPC_SKIN, LG_NPC_X, LG_NPC_Y, LG_NPC_Z, LG_NPC_A);
    if(IsValidActor(g_lg_actor))
    {
        SetActorInvulnerable(g_lg_actor, true);
        ApplyActorAnimation(g_lg_actor, "PED", "IDLE_chat", 4.0, 1, 0, 0, 0, 0);
    }
    g_lg_pickup = CreateDynamicPickup(LG_PICKUP_MODEL, 1, LG_NPC_X, LG_NPC_Y, LG_NPC_Z);

    new lbl[160];
    format(lbl, sizeof lbl, "{FFD700}ميمز\n{FFFFFF}حدث جمع الهدايا المفقودة\n{00FF7F}قف هنا لفتح قائمة المهمات");
    g_lg_label = CreateDynamic3DTextLabel(lbl, 0xFFD700FF, LG_NPC_X, LG_NPC_Y, LG_NPC_Z + 0.7, 12.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    // [LG-FIX] The `havana_lost_gifts` table is now created in OnGameModeInit's
    // successful-connection branch (case 0). LostGifts_Init() runs BEFORE
    // mysql_connect(), so creating it here ran on an invalid handle (0) and the
    // table was never created -> progress never persisted across restarts.

    SetTimer("LostGifts_Tick", 1000, true);
    return 1;
}

// ---------------------------------------------------------------------
LostGifts_OnConnect(playerid)
{
    g_lg_loaded[playerid]   = 0;
    g_lg_done[playerid]     = 0;
    g_lg_active[playerid]   = 0;
    g_lg_progress[playerid] = 0;
    g_lg_thief[playerid]    = INVALID_PLAYER_ID;
    g_lg_icon[playerid]     = 0;
    g_lg_cp[playerid]       = -1;
    g_lg_atnpc[playerid]    = 0;
    g_lg_hud[playerid]      = PlayerText:INVALID_TEXT_DRAW;
    for(new i = 0; i < LG_MAX_GIFTS; i++) { g_lg_gift[playerid][i] = 0; g_lg_gicon[playerid][i] = 0; }
    g_lg_veh[playerid] = 0;
    return 1;
}

LostGifts_LoadProgress(playerid)
{
    if(p_info[playerid][id] <= 0) return 1;
    new q[128];
    mysql_format(sql_connection, q, sizeof q, "SELECT `done` FROM `havana_lost_gifts` WHERE `user_id`='%d' LIMIT 1", p_info[playerid][id]);
    mysql_tquery(sql_connection, q, "LostGifts_OnLoad", "d", playerid);
    return 1;
}

public LostGifts_OnLoad(playerid)
{
    if(!IsPlayerConnected(playerid)) return 1;
    if(cache_num_rows() > 0)
        g_lg_done[playerid] = cache_get_field_content_int(0, "done", sql_connection);
    if(g_lg_done[playerid] < 0) g_lg_done[playerid] = 0;
    if(g_lg_done[playerid] > LG_MISSIONS) g_lg_done[playerid] = LG_MISSIONS;
    g_lg_loaded[playerid] = 1;
    return 1;
}

LostGifts_Save(playerid)
{
    if(p_info[playerid][id] <= 0) return 1;
    new q[200];
    mysql_format(sql_connection, q, sizeof q,
        "INSERT INTO `havana_lost_gifts` (`user_id`,`done`) VALUES ('%d','%d') ON DUPLICATE KEY UPDATE `done`=VALUES(`done`)",
        p_info[playerid][id], g_lg_done[playerid]);
    mysql_tquery(sql_connection, q, "", "");
    return 1;
}

LostGifts_OnDisconnect(playerid)
{
    LostGifts_ClearMission(playerid);
    return 1;
}

// ---------------------------------------------------------------------
//  واجهة الـ HUD (Overlay داخل اللعبة)
// ---------------------------------------------------------------------
LostGifts_ShowHud(playerid)
{
    new m = g_lg_active[playerid];
    if(m < 1 || m > LG_MISSIONS) return 1;
    new idx = m - 1, hud[256], objtxt[96];
    switch(g_lg_type[idx])
    {
        case LG_T_COLLECT: format(objtxt, sizeof objtxt, "Collect Gifts: %d/%d", g_lg_progress[playerid], g_lg_need[idx]);
        case LG_T_GOTO:    format(objtxt, sizeof objtxt, "Deliver the gift to the marker");
        case LG_T_KILL:    format(objtxt, sizeof objtxt, "Eliminate the gift thief");
        case LG_T_DRIVE:   format(objtxt, sizeof objtxt, "Drive the gift vehicle to the marker");
        case LG_T_ROUTE:   format(objtxt, sizeof objtxt, "Delivery stops: %d/%d", g_lg_progress[playerid], g_lg_need[idx]);
        case LG_T_ESCAPE:  format(objtxt, sizeof objtxt, "Escape to the safe point!");
        case LG_T_CHASE:   format(objtxt, sizeof objtxt, "Catch the fleeing thief");
    }
    format(hud, sizeof hud, "~y~Lost Gifts Event~n~~y~Mission %d:~w~ %s~n~~g~%s", m, g_lg_title_en[idx], objtxt);

    if(g_lg_hud[playerid] == PlayerText:INVALID_TEXT_DRAW)
    {
        g_lg_hud[playerid] = CreatePlayerTextDraw(playerid, 320.0, 130.0, hud);
        PlayerTextDrawAlignment(playerid, g_lg_hud[playerid], 2);
        PlayerTextDrawFont(playerid, g_lg_hud[playerid], 1);
        PlayerTextDrawLetterSize(playerid, g_lg_hud[playerid], 0.30, 1.25);
        PlayerTextDrawColor(playerid, g_lg_hud[playerid], -1);
        PlayerTextDrawSetOutline(playerid, g_lg_hud[playerid], 1);
        PlayerTextDrawSetShadow(playerid, g_lg_hud[playerid], 0);
        PlayerTextDrawBackgroundColor(playerid, g_lg_hud[playerid], 80);
        PlayerTextDrawShow(playerid, g_lg_hud[playerid]);
    }
    else
    {
        PlayerTextDrawSetString(playerid, g_lg_hud[playerid], hud);
    }
    return 1;
}

LostGifts_HideHud(playerid)
{
    if(g_lg_hud[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawDestroy(playerid, g_lg_hud[playerid]);
        g_lg_hud[playerid] = PlayerText:INVALID_TEXT_DRAW;
    }
    return 1;
}

// إشعار Overlay مرتبط باللانشر (يستخدم نفس قناة رسائل اللانشر)
LostGifts_PushOverlay(playerid, bool:show)
{
    new m = g_lg_active[playerid];
    if(show && m >= 1 && m <= LG_MISSIONS)
        GameTextForPlayer(playerid, "~y~* Lost Gifts Event *", 1500, 6);
    return 1;
}

// ---------------------------------------------------------------------
//  فتح قائمة المهمات
// ---------------------------------------------------------------------
public LostGifts_OpenDeferred(playerid)
{
    if(!IsPlayerConnected(playerid)) return 1;
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
    if(!IsPlayerInRangeOfPoint(playerid, 6.0, LG_NPC_X, LG_NPC_Y, LG_NPC_Z)) return 1;
    LostGifts_OpenList(playerid);
    return 1;
}

LostGifts_OpenList(playerid)
{
    new list[1400], line[200], st[40];
    list[0] = EOS;
    for(new i = 0; i < LG_MISSIONS; i++)
    {
        if(g_lg_done[playerid] > i)        format(st, sizeof st, "{00FF7F}مكتملة");
        else if(g_lg_active[playerid] == i+1) format(st, sizeof st, "{FFFF00}قيد التنفيذ");
        else if(g_lg_done[playerid] == i)  format(st, sizeof st, "{FFD700}متاحة");
        else                               format(st, sizeof st, "{FF5555}مقفلة");
        format(line, sizeof line, "{FFD700}%d. {FFFFFF}%s\t%s\n", i+1, g_lg_title[i], st);
        strcat(list, line);
    }
    show_dialog(playerid, LG_DLG_LIST, DIALOG_STYLE_TABLIST, "{FFD700}حدث جمع الهدايا المفقودة - ميمز", list, "عرض", "إغلاق");
    return 1;
}

// ---------------------------------------------------------------------
//  بدء / إنهاء المهمة
// ---------------------------------------------------------------------
LostGifts_ClearMission(playerid)
{
    for(new i = 0; i < LG_MAX_GIFTS; i++)
    {
        if(g_lg_gift[playerid][i] != 0)
        {
            if(IsValidDynamicPickup(g_lg_gift[playerid][i])) DestroyDynamicPickup(g_lg_gift[playerid][i]);
            g_lg_gift[playerid][i] = 0;
        }
        if(g_lg_gicon[playerid][i] != 0)
        {
            if(IsValidDynamicMapIcon(g_lg_gicon[playerid][i])) DestroyDynamicMapIcon(g_lg_gicon[playerid][i]);
            g_lg_gicon[playerid][i] = 0;
        }
    }
    if(g_lg_thief[playerid] != INVALID_PLAYER_ID)
    {
        if(FCNPC_IsValid(g_lg_thief[playerid])) FCNPC_Destroy(g_lg_thief[playerid]);
        g_lg_thief[playerid] = INVALID_PLAYER_ID;
    }
    if(g_lg_icon[playerid] != 0)
    {
        if(IsValidDynamicMapIcon(g_lg_icon[playerid])) DestroyDynamicMapIcon(g_lg_icon[playerid]);
        g_lg_icon[playerid] = 0;
    }
    if(g_lg_cp[playerid] != -1)
    {
        if(IsValidDynamicCP(g_lg_cp[playerid])) DestroyDynamicCP(g_lg_cp[playerid]);
        g_lg_cp[playerid] = -1;
    }
    if(g_lg_veh[playerid] != 0 && g_lg_veh[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(g_lg_veh[playerid]);
        g_lg_veh[playerid] = 0;
    }
    LostGifts_HideHud(playerid);
    LostGifts_PushOverlay(playerid, false);
    return 1;
}

LostGifts_SetCP(playerid, Float:x, Float:y, Float:z)
{
    if(g_lg_cp[playerid] != -1)
    {
        if(IsValidDynamicCP(g_lg_cp[playerid])) DestroyDynamicCP(g_lg_cp[playerid]);
        g_lg_cp[playerid] = -1;
    }
    g_lg_cp[playerid] = CreateDynamicCP(x, y, z, 3.0, 0, 0, playerid, 12000.0);
    return 1;
}

LostGifts_StartMission(playerid, m)
{
    if(m < 1 || m > LG_MISSIONS) return 0;
    if(g_lg_done[playerid] != m - 1) return 0;        // تسلسلي
    if(g_lg_active[playerid] != 0) LostGifts_ClearMission(playerid);

    g_lg_active[playerid]   = m;
    g_lg_progress[playerid] = 0;
    new idx = m - 1;

    switch(g_lg_type[idx])
    {
        case LG_T_COLLECT:
        {
            new need = g_lg_need[idx];
            if(need > LG_MAX_GIFTS) need = LG_MAX_GIFTS;
            for(new i = 0; i < need; i++)
            {
                new pi = (idx * 2 + i) % LG_POOL;
                new Float:gx = g_lg_gpx[pi];
                new Float:gy = g_lg_gpy[pi];
                new Float:gz = g_lg_gpz[pi];
                g_lg_gift[playerid][i] = CreateDynamicPickup(LG_GIFT_MODEL, 1, gx, gy, gz, -1, -1, playerid, 300.0);
                g_lg_gicon[playerid][i] = CreateDynamicMapIcon(gx, gy, gz, 0, 0x00C800FF, -1, -1, playerid, 12000.0, MAPICON_GLOBAL);
            }
        }
        case LG_T_GOTO:
        {
            // الهدف: العودة لنقطة التسليم قرب ميمز
        }
        case LG_T_KILL:
        {
            LostGifts_SpawnThief(playerid, idx);
        }
        case LG_T_DRIVE:
        {
            new Float:px, Float:py, Float:pz, Float:pa;
            GetPlayerPos(playerid, px, py, pz);
            GetPlayerFacingAngle(playerid, pa);
            new Float:vx = px + 5.0 * floatsin(-pa, degrees);
            new Float:vy = py + 5.0 * floatcos(-pa, degrees);
            new vmodel = (idx == 5) ? 413 : 498;
            g_lg_veh[playerid] = CreateVehicle(vmodel, vx, vy, pz + 1.0, pa, 3, 3, -1);
            if(g_lg_veh[playerid] != INVALID_VEHICLE_ID)
            {
                LinkVehicleToInterior(g_lg_veh[playerid], GetPlayerInterior(playerid));
                SetVehicleVirtualWorld(g_lg_veh[playerid], GetPlayerVirtualWorld(playerid));
                veh_info[g_lg_veh[playerid] - 1][v_fuel] = 100.0;
                PutPlayerInVehicle(playerid, g_lg_veh[playerid], 0);
                SetVehicleParamsEx(g_lg_veh[playerid], 1, 0, 0, 0, 0, 0, 0);
            }
        }
        case LG_T_ROUTE:
        {
            g_lg_progress[playerid] = 0;
        }
        case LG_T_ESCAPE:
        {
            LostGifts_SpawnChaser(playerid, idx);
        }
        case LG_T_CHASE:
        {
            LostGifts_SpawnThief(playerid, idx);
        }
    }

    new msg[128];
    format(msg, sizeof msg, "{FFD700}[حدث الهدايا] {FFFFFF}بدأت المهمة %d: {FFD700}%s{FFFFFF}. تابع الـ Overlay.", m, g_lg_title[idx]);
    SendClientMessage(playerid, 0xFFFFFFFF, msg);
    GameTextForPlayer(playerid, "~y~Lost Gifts~n~~w~Mission Started", 3000, 5);
    new tt = g_lg_type[idx];
    if(tt == LG_T_GOTO || tt == LG_T_DRIVE || tt == LG_T_ESCAPE)
        g_lg_icon[playerid] = CreateDynamicMapIcon(g_lg_cx[idx], g_lg_cy[idx], g_lg_cz[idx], 0, (tt == LG_T_ESCAPE) ? 0x00C800FF : 0x33CCFFFF, -1, -1, playerid, 12000.0, MAPICON_GLOBAL);
    else if(tt == LG_T_KILL || tt == LG_T_CHASE)
        g_lg_icon[playerid] = CreateDynamicMapIcon(g_lg_cx[idx] + 4.0, g_lg_cy[idx] + 4.0, g_lg_cz[idx], 0, 0xFF3030FF, -1, -1, playerid, 12000.0, MAPICON_GLOBAL);
    else if(tt == LG_T_ROUTE)
    {
        new Float:rx, Float:ry, Float:rz;
        LostGifts_RouteStop(idx, 0, rx, ry, rz);
        g_lg_icon[playerid] = CreateDynamicMapIcon(rx, ry, rz, 0, 0x33CCFFFF, -1, -1, playerid, 12000.0, MAPICON_GLOBAL);
    }
    if(tt == LG_T_KILL || tt == LG_T_CHASE)
        LostGifts_SetCP(playerid, g_lg_cx[idx] + 4.0, g_lg_cy[idx] + 4.0, g_lg_cz[idx]);
    else if(tt == LG_T_GOTO || tt == LG_T_DRIVE || tt == LG_T_ESCAPE)
        LostGifts_SetCP(playerid, g_lg_cx[idx], g_lg_cy[idx], g_lg_cz[idx]);
    else if(tt == LG_T_ROUTE)
    {
        new Float:crx, Float:cry, Float:crz;
        LostGifts_RouteStop(idx, 0, crx, cry, crz);
        LostGifts_SetCP(playerid, crx, cry, crz);
    }
    LostGifts_ShowHud(playerid);
    if(g_lg_ovl[idx]) LostGifts_PushOverlay(playerid, true);
    return 1;
}

LostGifts_SpawnThief(playerid, idx)
{
    new tname[24];
    format(tname, sizeof tname, "Gift_Thief_%d", playerid);
    new npc = FCNPC_Create(tname);
    if(npc == INVALID_PLAYER_ID)
    {
        g_lg_thief[playerid] = INVALID_PLAYER_ID;
        return 0;
    }
    g_lg_thief[playerid] = npc;
    FCNPC_Spawn(npc, 102, g_lg_cx[idx] + 4.0, g_lg_cy[idx] + 4.0, g_lg_cz[idx]);
    FCNPC_SetHealth(npc, 100.0);
    FCNPC_SetWeapon(npc, 24);
    FCNPC_SetAngleToPlayer(npc, playerid);
    return 1;
}

LostGifts_RouteStop(idx, stop, &Float:x, &Float:y, &Float:z)
{
    new pi = (idx + stop) % LG_POOL;
    x = g_lg_gpx[pi];
    y = g_lg_gpy[pi];
    z = g_lg_gpz[pi];
    return 1;
}

LostGifts_SpawnChaser(playerid, idx)
{
    #pragma unused idx
    new tname[24];
    format(tname, sizeof tname, "Gift_Thief_%d", playerid);
    new npc = FCNPC_Create(tname);
    if(npc == INVALID_PLAYER_ID)
    {
        g_lg_thief[playerid] = INVALID_PLAYER_ID;
        return 0;
    }
    g_lg_thief[playerid] = npc;
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    FCNPC_Spawn(npc, 102, px + 6.0, py + 6.0, pz);
    FCNPC_SetHealth(npc, 100.0);
    FCNPC_SetWeapon(npc, 24);
    return 1;
}

LostGifts_CompleteMission(playerid)
{
    new m = g_lg_active[playerid];
    if(m < 1 || m > LG_MISSIONS) return 0;
    new idx = m - 1;

    LostGifts_ClearMission(playerid);

    g_lg_active[playerid] = 0;
    if(g_lg_done[playerid] < m) g_lg_done[playerid] = m;
    LostGifts_Save(playerid);

    // ---- المكافآت ----
    if(g_lg_money[idx] > 0)
    {
        give_money(playerid, g_lg_money[idx]);
        insert_money_log(playerid, INVALID_PLAYER_ID, g_lg_money[idx], "lostgifts");
    }
    if(g_lg_car[idx] > 0)  Casino_GiveCar(playerid, g_lg_car[idx]);
    if(g_lg_acc[idx] > 0)  GiveItem(playerid, g_lg_acc[idx]);

    new msg[200];
    format(msg, sizeof msg, "{00FF7F}[حدث الهدايا] {FFFFFF}أكملت المهمة %d ({FFD700}%s{FFFFFF}) واستلمت {00FF7F}%d${FFFFFF}.", m, g_lg_title[idx], g_lg_money[idx]);
    SendClientMessage(playerid, 0xFFFFFFFF, msg);
    if(g_lg_car[idx] > 0) SendClientMessage(playerid, 0xFFFFFFFF, "{00FF7F}[حدث الهدايا] {FFFFFF}حصلت على سيارة فاخرة! تجدها عند أقرب كراج/معرض.");
    if(g_lg_acc[idx] > 0) SendClientMessage(playerid, 0xFFFFFFFF, "{00FF7F}[حدث الهدايا] {FFFFFF}حصلت على اكسسوار فاخر! تجده في حقيبتك /inv.");
    GameTextForPlayer(playerid, "~g~Mission Complete!", 3500, 5);

    if(g_lg_done[playerid] < LG_MISSIONS)
        SendClientMessage(playerid, 0xFFFFFFFF, "{FFD700}[حدث الهدايا] {FFFFFF}فُتحت المهمة التالية! ارجع إلى ميمز لبدئها.");
    else
        SendClientMessage(playerid, 0xFFFFFFFF, "{FFD700}[حدث الهدايا] {00FF7F}أنهيت كل مهمات حدث جمع الهدايا المفقودة! أحسنت.");
    return 1;
}

// ---------------------------------------------------------------------
//  هوكات الكولباكات
// ---------------------------------------------------------------------
LostGifts_OnPickup(playerid, pickupid)
{
    if(pickupid == g_lg_pickup)
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
        if(p_info[playerid][id] <= 0) return 1;
        if(g_lg_atnpc[playerid]) return 1;
        g_lg_atnpc[playerid] = 1;
        SetTimerEx("LostGifts_OpenDeferred", 60, false, "d", playerid);
        return 1;
    }
    new m = g_lg_active[playerid];
    if(m >= 1 && m <= LG_MISSIONS && g_lg_type[m-1] == LG_T_COLLECT)
    {
        for(new i = 0; i < LG_MAX_GIFTS; i++)
        {
            if(g_lg_gift[playerid][i] != 0 && pickupid == g_lg_gift[playerid][i])
            {
                if(IsValidDynamicPickup(g_lg_gift[playerid][i])) DestroyDynamicPickup(g_lg_gift[playerid][i]);
                g_lg_gift[playerid][i] = 0;
                if(g_lg_gicon[playerid][i] != 0)
                {
                    if(IsValidDynamicMapIcon(g_lg_gicon[playerid][i])) DestroyDynamicMapIcon(g_lg_gicon[playerid][i]);
                    g_lg_gicon[playerid][i] = 0;
                }
                g_lg_progress[playerid]++;
                PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
                LostGifts_ShowHud(playerid);
                if(g_lg_ovl[m-1]) LostGifts_PushOverlay(playerid, true);
                if(g_lg_progress[playerid] >= g_lg_need[m-1])
                    LostGifts_CompleteMission(playerid);
                return 1;
            }
        }
    }
    return 0;
}

LostGifts_OnDeath(playerid, killerid)
{
    // playerid هو من مات. لو كان لص أحد اللاعبين وقتله صاحب المهمة
    if(!IsPlayerNPC(playerid)) return 0;
    for(new pid = 0; pid < MAX_PLAYERS; pid++)
    {
        if(g_lg_thief[pid] == playerid)
        {
            g_lg_thief[pid] = INVALID_PLAYER_ID;
            if(g_lg_active[pid] >= 1)
            {
                #pragma unused killerid
                if(g_lg_type[g_lg_active[pid]-1] == LG_T_KILL || g_lg_type[g_lg_active[pid]-1] == LG_T_CHASE)
                {
                    g_lg_progress[pid] = g_lg_need[g_lg_active[pid]-1];
                    LostGifts_CompleteMission(pid);
                }
            }
            return 1;
        }
    }
    return 0;
}

// استجابة الدايلوجات
LostGifts_OnDialogResponse(playerid, dialogid, response, listitem)
{
    if(dialogid == LG_DLG_LIST)
    {
        p_t_info[playerid][p_dialog] = -1;
        if(!response) return 1;
        if(listitem < 0 || listitem >= LG_MISSIONS) return 1;
        new idx = listitem, detail[420], btn[24];
        new bool:can_start = (g_lg_done[playerid] == idx && g_lg_active[playerid] == 0);
        new bool:in_prog    = (g_lg_active[playerid] == idx + 1);
        new bool:done       = (g_lg_done[playerid] > idx);
        format(detail, sizeof detail, "%s\n\n", g_lg_desc[idx]);
        if(done)            { strcat(detail, "{00FF7F}هذه المهمة مكتملة."); format(btn, sizeof btn, "رجوع"); }
        else if(in_prog)    { strcat(detail, "{FFFF00}المهمة قيد التنفيذ حالياً."); format(btn, sizeof btn, "إلغاء المهمة"); }
        else if(can_start)  { strcat(detail, "{FFD700}اضغط (ابدأ) لبدء المهمة الآن."); format(btn, sizeof btn, "ابدأ"); }
        else                { strcat(detail, "{FF5555}يجب إكمال المهمة السابقة أولاً."); format(btn, sizeof btn, "رجوع"); }
        SetPVarInt(playerid, "lg_view", idx + 1);
        show_dialog(playerid, LG_DLG_DETAIL, DIALOG_STYLE_MSGBOX, "{FFD700}تفاصيل المهمة", detail, btn, "رجوع");
        return 1;
    }
    if(dialogid == LG_DLG_DETAIL)
    {
        p_t_info[playerid][p_dialog] = -1;
        new idx = GetPVarInt(playerid, "lg_view") - 1;
        if(idx < 0 || idx >= LG_MISSIONS) return 1;
        if(!response)
        {
            LostGifts_OpenList(playerid);
            return 1;
        }
        new bool:can_start = (g_lg_done[playerid] == idx && g_lg_active[playerid] == 0);
        new bool:in_prog    = (g_lg_active[playerid] == idx + 1);
        if(can_start)       LostGifts_StartMission(playerid, idx + 1);
        else if(in_prog)
        {
            LostGifts_ClearMission(playerid);
            g_lg_active[playerid] = 0;
            SendClientMessage(playerid, 0xFFFFFFFF, "{FF5555}[حدث الهدايا] {FFFFFF}ألغيت المهمة الحالية.");
        }
        else LostGifts_OpenList(playerid);
        return 1;
    }
    return 0;
}

// مؤقت لكل ثانية: تحقق من مهمات الوصول وتحديث الـ HUD
public LostGifts_Tick()
{
    foreach(new playerid : logged_players)
    {
        if(g_lg_atnpc[playerid] && !IsPlayerInRangeOfPoint(playerid, 6.0, LG_NPC_X, LG_NPC_Y, LG_NPC_Z))
            g_lg_atnpc[playerid] = 0;
        new m = g_lg_active[playerid];
        if(m < 1 || m > LG_MISSIONS) continue;
        new idx = m - 1;
        if(g_lg_type[idx] == LG_T_GOTO)
        {
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);
            new Float:dx = px - g_lg_cx[idx], Float:dy = py - g_lg_cy[idx];
            if((dx*dx + dy*dy) < (4.0 * 4.0))
            {
                g_lg_progress[playerid] = g_lg_need[idx];
                LostGifts_CompleteMission(playerid);
            }
        }
        else if(g_lg_type[idx] == LG_T_KILL)
        {
            if(g_lg_thief[playerid] != INVALID_PLAYER_ID && FCNPC_IsValid(g_lg_thief[playerid]))
            {
                if(FCNPC_IsDead(g_lg_thief[playerid]))
                {
                    g_lg_progress[playerid] = g_lg_need[idx];
                    LostGifts_CompleteMission(playerid);
                }
                else FCNPC_SetAngleToPlayer(g_lg_thief[playerid], playerid);
            }
        }
        else if(g_lg_type[idx] == LG_T_DRIVE)
        {
            if(GetPlayerVehicleID(playerid) != 0)
            {
                new Float:px, Float:py, Float:pz;
                GetPlayerPos(playerid, px, py, pz);
                new Float:dx = px - g_lg_cx[idx], Float:dy = py - g_lg_cy[idx];
                if((dx*dx + dy*dy) < (7.0 * 7.0))
                {
                    g_lg_progress[playerid] = g_lg_need[idx];
                    LostGifts_CompleteMission(playerid);
                }
            }
        }
        else if(g_lg_type[idx] == LG_T_ROUTE)
        {
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);
            new Float:rx, Float:ry, Float:rz;
            LostGifts_RouteStop(idx, g_lg_progress[playerid], rx, ry, rz);
            new Float:dx = px - rx, Float:dy = py - ry;
            if((dx*dx + dy*dy) < (5.0 * 5.0))
            {
                g_lg_progress[playerid]++;
                PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
                if(g_lg_progress[playerid] >= g_lg_need[idx])
                    LostGifts_CompleteMission(playerid);
                else
                {
                    if(g_lg_icon[playerid] != 0 && IsValidDynamicMapIcon(g_lg_icon[playerid]))
                        DestroyDynamicMapIcon(g_lg_icon[playerid]);
                    LostGifts_RouteStop(idx, g_lg_progress[playerid], rx, ry, rz);
                    g_lg_icon[playerid] = CreateDynamicMapIcon(rx, ry, rz, 0, 0x33CCFFFF, -1, -1, playerid, 12000.0, MAPICON_GLOBAL);
                    LostGifts_SetCP(playerid, rx, ry, rz);
                    LostGifts_ShowHud(playerid);
                }
            }
        }
        else if(g_lg_type[idx] == LG_T_ESCAPE)
        {
            if(g_lg_thief[playerid] != INVALID_PLAYER_ID && FCNPC_IsValid(g_lg_thief[playerid]))
                FCNPC_GoToPlayer(g_lg_thief[playerid], playerid);
            new Float:px, Float:py, Float:pz;
            GetPlayerPos(playerid, px, py, pz);
            new Float:dx = px - g_lg_cx[idx], Float:dy = py - g_lg_cy[idx];
            if((dx*dx + dy*dy) < (6.0 * 6.0))
            {
                g_lg_progress[playerid] = g_lg_need[idx];
                LostGifts_CompleteMission(playerid);
            }
        }
        else if(g_lg_type[idx] == LG_T_CHASE)
        {
            if(g_lg_thief[playerid] != INVALID_PLAYER_ID && FCNPC_IsValid(g_lg_thief[playerid]))
            {
                new Float:tx, Float:ty, Float:tz;
                GetPlayerPos(g_lg_thief[playerid], tx, ty, tz);
                FCNPC_GoTo(g_lg_thief[playerid], g_lg_cx[idx] + 70.0, g_lg_cy[idx] + 70.0, g_lg_cz[idx]);
                if(g_lg_icon[playerid] != 0 && IsValidDynamicMapIcon(g_lg_icon[playerid]))
                    Streamer_SetItemPos(STREAMER_TYPE_MAP_ICON, g_lg_icon[playerid], tx, ty, tz);
                if(g_lg_cp[playerid] != -1 && IsValidDynamicCP(g_lg_cp[playerid]))
                    Streamer_SetItemPos(STREAMER_TYPE_CP, g_lg_cp[playerid], tx, ty, tz);
                new Float:px, Float:py, Float:pz;
                GetPlayerPos(playerid, px, py, pz);
                new Float:dx = px - tx, Float:dy = py - ty;
                if((dx*dx + dy*dy) < (5.0 * 5.0))
                {
                    g_lg_progress[playerid] = g_lg_need[idx];
                    LostGifts_CompleteMission(playerid);
                }
            }
        }
    }
    return 1;
}
