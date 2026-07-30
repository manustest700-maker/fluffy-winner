// ============================================================
//  Family UI v2 — launcher panel with full leader control:
//  news (post/pin/delete), vault (deposit/withdraw), members
//  (kick / set rank), car slots (buy 500k / spawn), wars.
// ============================================================
#if defined _family_menu_included
    #endinput
#endif
#define _family_menu_included

#define FAM_NEWS_MAX        6
#define FAM_NEWS_TEXT_LEN   101
#define FAM_UI_MEMBER_CAP   30
#define FAM_CAR_SLOT_PRICE  500000
#define FAM_BANK_MAX_ACTION 100000000

forward Family_ShowUI(playerid);
forward Family_UIData(playerid);
forward Family_NewsLoad();
forward Family_NewsInserted(family_id);

new bool:g_fam_open[MAX_PLAYERS];
new g_fam_bank_action_time[MAX_PLAYERS];

stock Family_BankActionAllowed(playerid)
{
    new action_time = gettime();
    if (g_fam_bank_action_time[playerid] == action_time) return 0;
    g_fam_bank_action_time[playerid] = action_time;
    return 1;
}

// news cache (loaded from `family_news` at startup)
new g_fnews_count[MAX_FAMILY];
new g_fnews_id[MAX_FAMILY][FAM_NEWS_MAX];
new g_fnews_pin[MAX_FAMILY][FAM_NEWS_MAX];
new g_fnews_text[MAX_FAMILY][FAM_NEWS_MAX][FAM_NEWS_TEXT_LEN];
new g_fnews_author[MAX_FAMILY][FAM_NEWS_MAX][MAX_PLAYER_NAME];
new g_fnews_date[MAX_FAMILY][FAM_NEWS_MAX][12];

stock Family_MenuInit()
{
    mysql_tquery(sql_connection,
        "CREATE TABLE IF NOT EXISTS `family_news` (`n_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, `fam_id` INT NOT NULL, `author` VARCHAR(24) NOT NULL DEFAULT '', `pinned` INT NOT NULL DEFAULT 0, `ndate` VARCHAR(12) NOT NULL DEFAULT '', `ntext` VARCHAR(128) NOT NULL DEFAULT '') CHARACTER SET cp1256 COLLATE cp1256_general_ci");
    mysql_tquery(sql_connection, "SELECT * FROM `family_news` ORDER BY `n_id` DESC", "Family_NewsLoad");
    return 1;
}

public Family_NewsLoad()
{
    for (new f = 0; f < MAX_FAMILY; f++) g_fnews_count[f] = 0;
    new rows = cache_num_rows();
    for (new r = 0; r < rows; r++)
    {
        new fid = cache_get_field_content_int(r, "fam_id");
        if (fid < 1 || fid > MAX_FAMILY) continue;
        new f = fid - 1;
        if (g_fnews_count[f] >= FAM_NEWS_MAX) continue;
        new n = g_fnews_count[f];
        g_fnews_id[f][n] = cache_get_field_content_int(r, "n_id");
        g_fnews_pin[f][n] = cache_get_field_content_int(r, "pinned");
        cache_get_field_content(r, "ntext", g_fnews_text[f][n], sql_connection, FAM_NEWS_TEXT_LEN);
        cache_get_field_content(r, "author", g_fnews_author[f][n], sql_connection, MAX_PLAYER_NAME);
        cache_get_field_content(r, "ndate", g_fnews_date[f][n], sql_connection, 12);
        g_fnews_count[f]++;
    }
    return 1;
}

stock Family_GetCarModel(family_id, slot)
{
    switch (slot)
    {
        case 1: return family_info[family_id][fam_car1];
        case 2: return family_info[family_id][fam_car2];
        case 3: return family_info[family_id][fam_car3];
        case 4: return family_info[family_id][fam_car4];
        case 5: return family_info[family_id][fam_car5];
    }
    return 0;
}

stock Family_GetCarSpawned(family_id, slot)
{
    switch (slot)
    {
        case 1: return family_info[family_id][fam_car1_spawned];
        case 2: return family_info[family_id][fam_car2_spawned];
        case 3: return family_info[family_id][fam_car3_spawned];
        case 4: return family_info[family_id][fam_car4_spawned];
        case 5: return family_info[family_id][fam_car5_spawned];
    }
    return 0;
}

stock Family_GetVehicleID(family_id, slot)
{
    switch (slot)
    {
        case 1: return familyvehicle1[family_id];
        case 2: return familyvehicle2[family_id];
        case 3: return familyvehicle3[family_id];
        case 4: return familyvehicle4[family_id];
        case 5: return familyvehicle5[family_id];
    }
    return 0;
}

// ------------------------------------------------------------
//  UI payload — built inside the members-query callback
// ------------------------------------------------------------
public Family_ShowUI(playerid)
{
    if (p_info[playerid][family] < 1)
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}أنت لست في عائلة.");

    new q[196];
    mysql_format(sql_connection, q, sizeof q,
        "SELECT `u_name`,`u_family_rank`,`u_online` FROM `users` WHERE `u_family`='%d' ORDER BY `u_family_rank` DESC, `u_name` ASC LIMIT %d",
        p_info[playerid][family], FAM_UI_MEMBER_CAP);
    mysql_tquery(sql_connection, q, "Family_UIData", "i", playerid);
    return 1;
}

public Family_UIData(playerid)
{
    if (!IsPlayerConnected(playerid) || p_info[playerid][family] < 1) return 1;

    new f = p_info[playerid][family] - 1;
    static payload[4096];
    new line[356];
    payload[0] = EOS;

    // INFO:name|members|creator|bank|seasonpts|myrankname|myrang|rankcount|isleader|house|wins|losses
    new myrang = p_info[playerid][family_rang];
    new rankname[32];
    if (myrang >= 1 && myrang <= 7) format(rankname, 32, "%s", family_rank[f][myrang - 1]);
    else format(rankname, 32, "عضو");
    format(line, sizeof line, "INFO:%s|%d|%s|%d|%d|%s|%d|%d|%d|%d|%d|%d\n",
        family_info[f][fam_name], family_info[f][fam_members], family_info[f][fam_creator],
        family_info[f][fam_bank], g_fw_season_pts[f], rankname, myrang,
        family_info[f][fam_settings][3], (FAM_IS_LEADER(playerid, f) ? 1 : 0),
        family_info[f][fam_house], g_fw_wins[f], g_fw_losses[f]);
    strcat(payload, line);

    // RNK:r1|r2|... (assignable ranks 1..6)
    format(line, sizeof line, "RNK:%s|%s|%s|%s|%s|%s\n",
        family_rank[f][0], family_rank[f][1], family_rank[f][2],
        family_rank[f][3], family_rank[f][4], family_rank[f][5]);
    strcat(payload, line);

    // CARi:model|vname|spawned   (model 1 = locked slot, 0 = empty)
    for (new slot = 1; slot <= 5; slot++)
    {
        new model = Family_GetCarModel(f, slot);
        new vname[32];
        vname[0] = EOS;
        if (model > 1) GetLuxName(model, vname);
        format(line, sizeof line, "CAR%d:%d|%s|%d\n", slot, model, vname, Family_GetCarSpawned(f, slot));
        strcat(payload, line);
    }

    // MEMi:name|rang|rankname|online
    new rows = cache_num_rows();
    if (rows > FAM_UI_MEMBER_CAP) rows = FAM_UI_MEMBER_CAP;
    for (new r = 0; r < rows; r++)
    {
        new mname[MAX_PLAYER_NAME], mrang, monline, mrankname[32];
        cache_get_field_content(r, "u_name", mname, sql_connection, MAX_PLAYER_NAME);
        mrang = cache_get_field_content_int(r, "u_family_rank");
        monline = cache_get_field_content_int(r, "u_online");
        if (mrang >= 1 && mrang <= 7) format(mrankname, 32, "%s", family_rank[f][mrang - 1]);
        else format(mrankname, 32, "عضو");
        format(line, sizeof line, "MEM%d:%s|%d|%s|%d\n", r + 1, mname, mrang, mrankname, monline);
        if (strlen(payload) + strlen(line) >= sizeof payload - 350) break;
        strcat(payload, line);
    }

    // NWSi:pin|author|date|text  (pinned first)
    new nw = 0;
    for (new pass = 1; pass >= 0; pass--)
    {
        for (new n = 0; n < g_fnews_count[f]; n++)
        {
            if (g_fnews_pin[f][n] != pass) continue;
            nw++;
            format(line, sizeof line, "NWS%d:%d|%s|%s|%s\n",
                nw, g_fnews_pin[f][n], g_fnews_author[f][n], g_fnews_date[f][n], g_fnews_text[f][n]);
            if (strlen(payload) + strlen(line) >= sizeof payload - 200) break;
            strcat(payload, line);
        }
    }

    // WAR:state|enemy|mypts|enemypts|secleft|bet|joinedcnt|ijoined|minonline|durmin
    new wstate = 0, enemy[68], mypts = 0, enpts = 0, secleft = 0;
    enemy[0] = EOS;
    if (g_fw_state == FWS_PENDING)
    {
        if (f == g_fw_famA) { wstate = 1; format(enemy, 68, "%s", family_info[g_fw_famB][fam_name]); secleft = g_fw_pending_expire - gettime(); }
        else if (f == g_fw_famB) { wstate = 2; format(enemy, 68, "%s", family_info[g_fw_famA][fam_name]); secleft = g_fw_pending_expire - gettime(); }
    }
    else if (g_fw_state == FWS_ACTIVE)
    {
        secleft = g_fw_endtime - gettime();
        if (f == g_fw_famA) { wstate = 3; format(enemy, 68, "%s", family_info[g_fw_famB][fam_name]); mypts = g_fw_ptsA; enpts = g_fw_ptsB; }
        else if (f == g_fw_famB) { wstate = 3; format(enemy, 68, "%s", family_info[g_fw_famA][fam_name]); mypts = g_fw_ptsB; enpts = g_fw_ptsA; }
        else
        {
            wstate = 4;
            format(enemy, 68, "%s ضد %s", family_info[g_fw_famA][fam_name], family_info[g_fw_famB][fam_name]);
            mypts = g_fw_ptsA; enpts = g_fw_ptsB;
        }
    }
    if (secleft < 0) secleft = 0;
    format(line, sizeof line, "WAR:%d|%s|%d|%d|%d|%d|%d|%d|%d|%d\n",
        wstate, enemy, mypts, enpts, secleft, g_fw_bet, Family_GetJoinedCount(),
        (g_fw_joined[playerid] ? 1 : 0), FAM_WAR_MIN_ONLINE, FAM_WAR_DURATION / 60);
    strcat(payload, line);

    // TOP1 / TOP2
    new tname[68], tleader[MAX_PLAYER_NAME], tmembers, tscore;
    Family_GetTopInfo(1, tname, 68, tmembers, tscore, tleader, MAX_PLAYER_NAME);
    format(line, sizeof line, "TOP1:%s|%d|%d|%s\n", tname, tmembers, tscore, tleader);
    strcat(payload, line);
    Family_GetTopInfo(2, tname, 68, tmembers, tscore, tleader, MAX_PLAYER_NAME);
    format(line, sizeof line, "TOP2:%s|%d|%d|%s\n", tname, tmembers, tscore, tleader);
    strcat(payload, line);

    // FLn:name|seasonpts|members — all registered families (target list / top list)
    new fln = 0;
    for (new ff = 0; ff < MAX_FAMILY; ff++)
    {
        if (family_info[ff][fam_id] <= 0) continue;
        if (fln >= 40) break;
        fln++;
        format(line, sizeof line, "FL%d:%s|%d|%d\n", fln, family_info[ff][fam_name], g_fw_season_pts[ff], family_info[ff][fam_members]);
        if (strlen(payload) + strlen(line) >= sizeof payload - 60) break;
        strcat(payload, line);
    }

    g_fam_open[playerid] = true;
    show_dialog(playerid, d_family_ui, DIALOG_STYLE_INPUT, "[!FAM_OPEN]", payload, "تنفيذ", "إغلاق");
    return 1;
}

stock Family_CloseUI(playerid)
{
    g_fam_open[playerid] = false;
    show_dialog(playerid, d_family_ui, DIALOG_STYLE_MSGBOX, "[!FAM_CLOSE]", " ", "OK", "");
    return 1;
}

// ------------------------------------------------------------
//  actions
// ------------------------------------------------------------
stock Family_ToggleVehicleSlot(playerid, slot)
{
    if (p_info[playerid][family] < 1) return 1;
    if (slot < 1 || slot > 5) return 1;

    new f = p_info[playerid][family] - 1;
    new model = Family_GetCarModel(f, slot);

    if (model == 1)
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}هذه الخانة غير مشتراة بعد.");
    if (model == 0)
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}لا توجد سيارة في هذه الخانة.");
    if (p_info[playerid][family_rang] < family_info[f][fam_settings][4] && !FAM_IS_LEADER(playerid, f))
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}ليس لديك صلاحية استخدام سيارات العائلة.");
    if (family_info[f][fam_house] == -1)
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}عائلتك ما عندها بيت!");
    if (family_info[f][fam_house_xgpos] == 0 && family_info[f][fam_house_ygpos] == 0)
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}بيت العائلة ما عنده جراج!");

    if (Family_GetCarSpawned(f, slot))
    {
        new vid = Family_GetVehicleID(f, slot);
        if (vid >= 1 && vid <= MAX_VEHICLES)
        {
            foreach (new i : logged_players)
            {
                if (IsPlayerInVehicle(i, vid))
                    return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}مركبة العائلة مستخدمة من أحد أفراد العائلة!");
            }
        }
        switch (slot)
        {
            case 1: DestroyFamilyVehicle_1(playerid, familyvehicle1[f]);
            case 2: DestroyFamilyVehicle_2(playerid, familyvehicle2[f]);
            case 3: DestroyFamilyVehicle_3(playerid, familyvehicle3[f]);
            case 4: DestroyFamilyVehicle_4(playerid, familyvehicle4[f]);
            case 5: DestroyFamilyVehicle_5(playerid, familyvehicle5[f]);
        }
    }
    else
    {
        switch (slot)
        {
            case 1: SpawnFamilyVehicle_1(playerid, family_info[f][fam_car1]);
            case 2: SpawnFamilyVehicle_2(playerid, family_info[f][fam_car2]);
            case 3: SpawnFamilyVehicle_3(playerid, family_info[f][fam_car3]);
            case 4: SpawnFamilyVehicle_4(playerid, family_info[f][fam_car4]);
            case 5: SpawnFamilyVehicle_5(playerid, family_info[f][fam_car5]);
        }
    }
    return 1;
}

stock Family_BuyCarSlot(playerid, slot)
{
    if (p_info[playerid][family] < 1) return 1;
    if (slot < 3 || slot > 5) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}هذه الخانة لا تُشترى.");
    new f = p_info[playerid][family] - 1;
    if (Family_GetCarModel(f, slot) != 1) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}هذه الخانة مشتراة أصلاً.");
    if (p_info[playerid][money] < FAM_CAR_SLOT_PRICE) return SendClientMessage(playerid, 0xACACACFF, "ليس لديك مال كافٍ!");

    switch (slot)
    {
        case 3: family_info[f][fam_car3] = 0;
        case 4: family_info[f][fam_car4] = 0;
        case 5: family_info[f][fam_car5] = 0;
    }
    give_money(playerid, -FAM_CAR_SLOT_PRICE);
    new q[144];
    mysql_format(sql_connection, q, sizeof q, "UPDATE `family` SET `fam_car%d`='0' WHERE `fam_id`='%d' LIMIT 1", slot, f + 1);
    mysql_tquery(sql_connection, q);

    new msg[196];
    format(msg, sizeof msg, "{%s}[%s] {e0e0de}%s اشترى الخانة #%d من سيارات العائلة مقابل {1ad609}$500.000",
        family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], slot);
    family_message(p_info[playerid][family], col_gray, msg);
    return 1;
}

stock Family_BankDeposit(playerid, amount)
{
    if (p_info[playerid][family] < 1) return 1;
    new f = p_info[playerid][family] - 1;
    if (amount < 1 || amount > FAM_BANK_MAX_ACTION) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}مبلغ غير صحيح.");
    if (p_info[playerid][money] < amount) return SendClientMessage(playerid, 0xACACACFF, "ليس لديك مال كافٍ!");
    if (family_info[f][fam_bank] > 2000000000 - amount) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}خزنة العائلة وصلت إلى الحد الأقصى.");
    if (!Family_BankActionAllowed(playerid)) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}انتظر لحظة قبل تنفيذ عملية بنكية أخرى.");

    give_money(playerid, -amount);
    family_info[f][fam_bank] += amount;
    Family_SaveBank(f);
    insert_money_log(playerid, INVALID_PLAYER_ID, -amount, "family vault deposit");

    new msg[196];
    format(msg, sizeof msg, "{%s}[%s] {e0e0de}%s أودع {1ad609}$%d {e0e0de}في خزنة العائلة. الرصيد: {1ad609}$%d",
        family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], amount, family_info[f][fam_bank]);
    family_message(p_info[playerid][family], col_gray, msg);
    return 1;
}

stock Family_BankWithdraw(playerid, amount)
{
    if (p_info[playerid][family] < 1) return 1;
    new f = p_info[playerid][family] - 1;
    if (!FAM_IS_LEADER(playerid, f)) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}قائد العائلة فقط يقدر يسحب من الخزنة.");
    if (amount < 1 || amount > FAM_BANK_MAX_ACTION) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}مبلغ غير صحيح.");
    if (family_info[f][fam_bank] < amount) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}رصيد الخزنة لا يكفي.");
    if (!Family_BankActionAllowed(playerid)) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}انتظر لحظة قبل تنفيذ عملية بنكية أخرى.");

    family_info[f][fam_bank] -= amount;
    give_money(playerid, amount);
    Family_SaveBank(f);
    insert_money_log(playerid, INVALID_PLAYER_ID, amount, "family vault withdraw");

    new msg[196];
    format(msg, sizeof msg, "{%s}[%s] {e0e0de}القائد %s سحب {1ad609}$%d {e0e0de}من خزنة العائلة. الرصيد: {1ad609}$%d",
        family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], amount, family_info[f][fam_bank]);
    family_message(p_info[playerid][family], col_gray, msg);
    return 1;
}

stock Family_NewsPost(playerid, text[])
{
    if (p_info[playerid][family] < 1) return 1;
    new f = p_info[playerid][family] - 1;
    if (!FAM_IS_LEADER(playerid, f)) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}قائد العائلة فقط يقدر ينشر الأخبار.");

    // sanitize
    for (new i = 0, l = strlen(text); i < l; i++)
        if (text[i] == '|' || text[i] == '\n' || text[i] == '%') text[i] = ' ';
    if (strlen(text) < 2) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}الخبر قصير جداً.");
    if (strlen(text) > FAM_NEWS_TEXT_LEN - 1) text[FAM_NEWS_TEXT_LEN - 1] = EOS;

    new yy, mm, dd;
    getdate(yy, mm, dd);
    new datestr[12];
    format(datestr, sizeof datestr, "%02d/%02d/%d", dd, mm, yy);

    new q[400];
    mysql_format(sql_connection, q, sizeof q,
        "INSERT INTO `family_news` (`fam_id`,`author`,`pinned`,`ndate`,`ntext`) VALUES ('%d','%e','0','%s','%e')",
        f + 1, p_info[playerid][name], datestr, text);
    mysql_tquery(sql_connection, q, "Family_NewsInserted", "i", f);

    // update memory cache (newest first)
    new shift_from;
    if (g_fnews_count[f] < FAM_NEWS_MAX)
    {
        g_fnews_count[f]++;
        shift_from = g_fnews_count[f] - 1;
    }
    else
    {
        // full: drop oldest unpinned entry (from DB too)
        new drop = -1;
        for (new n = g_fnews_count[f] - 1; n >= 0; n--)
            if (!g_fnews_pin[f][n]) { drop = n; break; }
        if (drop == -1) drop = g_fnews_count[f] - 1;
        if (g_fnews_id[f][drop] > 0)
        {
            new dq[128];
            mysql_format(sql_connection, dq, sizeof dq, "DELETE FROM `family_news` WHERE `n_id`='%d' LIMIT 1", g_fnews_id[f][drop]);
            mysql_tquery(sql_connection, dq);
        }
        shift_from = drop;
    }
    for (new n = shift_from; n > 0; n--)
    {
        g_fnews_id[f][n] = g_fnews_id[f][n - 1];
        g_fnews_pin[f][n] = g_fnews_pin[f][n - 1];
        format(g_fnews_text[f][n], FAM_NEWS_TEXT_LEN, "%s", g_fnews_text[f][n - 1]);
        format(g_fnews_author[f][n], MAX_PLAYER_NAME, "%s", g_fnews_author[f][n - 1]);
        format(g_fnews_date[f][n], 12, "%s", g_fnews_date[f][n - 1]);
    }
    g_fnews_id[f][0] = 0;
    g_fnews_pin[f][0] = 0;
    format(g_fnews_text[f][0], FAM_NEWS_TEXT_LEN, "%s", text);
    format(g_fnews_author[f][0], MAX_PLAYER_NAME, "%s", p_info[playerid][name]);
    format(g_fnews_date[f][0], 12, "%s", datestr);

    new msg[228];
    format(msg, sizeof msg, "{%s}[%s] {F2C94C}خبر جديد من القائد %s: {e0e0de}%s",
        family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], text);
    family_message(p_info[playerid][family], col_gray, msg);
    return 1;
}

public Family_NewsInserted(family_id)
{
    // attach auto-increment id to the newest cache entry (index 0)
    if (family_id >= 0 && family_id < MAX_FAMILY && g_fnews_count[family_id] > 0)
        g_fnews_id[family_id][0] = cache_insert_id();
    return 1;
}

stock Family_NewsPin(playerid, idx)
{
    if (p_info[playerid][family] < 1) return 1;
    new f = p_info[playerid][family] - 1;
    if (!FAM_IS_LEADER(playerid, f)) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}قائد العائلة فقط يقدر يثبت الأخبار.");
    if (idx < 0 || idx >= g_fnews_count[f]) return 1;

    g_fnews_pin[f][idx] = g_fnews_pin[f][idx] ? 0 : 1;
    if (g_fnews_id[f][idx] > 0)
    {
        new q[128];
        mysql_format(sql_connection, q, sizeof q, "UPDATE `family_news` SET `pinned`='%d' WHERE `n_id`='%d' LIMIT 1",
            g_fnews_pin[f][idx], g_fnews_id[f][idx]);
        mysql_tquery(sql_connection, q);
    }
    SendClientMessage(playerid, col_green, g_fnews_pin[f][idx] ? ("* {FFFFFF}تم تثبيت الخبر.") : ("* {FFFFFF}تم إلغاء تثبيت الخبر."));
    return 1;
}

stock Family_NewsDelete(playerid, idx)
{
    if (p_info[playerid][family] < 1) return 1;
    new f = p_info[playerid][family] - 1;
    if (!FAM_IS_LEADER(playerid, f)) return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}قائد العائلة فقط يقدر يحذف الأخبار.");
    if (idx < 0 || idx >= g_fnews_count[f]) return 1;

    if (g_fnews_id[f][idx] > 0)
    {
        new q[128];
        mysql_format(sql_connection, q, sizeof q, "DELETE FROM `family_news` WHERE `n_id`='%d' LIMIT 1", g_fnews_id[f][idx]);
        mysql_tquery(sql_connection, q);
    }
    for (new n = idx; n < g_fnews_count[f] - 1; n++)
    {
        g_fnews_id[f][n] = g_fnews_id[f][n + 1];
        g_fnews_pin[f][n] = g_fnews_pin[f][n + 1];
        format(g_fnews_text[f][n], FAM_NEWS_TEXT_LEN, "%s", g_fnews_text[f][n + 1]);
        format(g_fnews_author[f][n], MAX_PLAYER_NAME, "%s", g_fnews_author[f][n + 1]);
        format(g_fnews_date[f][n], 12, "%s", g_fnews_date[f][n + 1]);
    }
    g_fnews_count[f]--;
    SendClientMessage(playerid, col_green, "* {FFFFFF}تم حذف الخبر.");
    return 1;
}

stock Family_NewsFindByOrder(f, order)
{
    // payload sends pinned first; map that order back to cache index
    new nw = 0;
    for (new pass = 1; pass >= 0; pass--)
    {
        for (new n = 0; n < g_fnews_count[f]; n++)
        {
            if (g_fnews_pin[f][n] != pass) continue;
            nw++;
            if (nw == order) return n;
        }
    }
    return -1;
}

stock Family_KickMember(playerid, const target[])
{
    if (p_info[playerid][family] < 1) return 1;
    new f = p_info[playerid][family] - 1;
    if (p_info[playerid][family_rang] < family_info[f][fam_settings][1] && !FAM_IS_LEADER(playerid, f))
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}ليس لديك صلاحية طرد الأعضاء.");
    if (!strcmp(target, p_info[playerid][name], true))
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}لا يمكنك طرد نفسك.");
    if (!strcmp(target, family_info[f][fam_creator], true))
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}لا يمكن طرد مؤسس العائلة.");

    // online member?
    foreach (new i : logged_players)
    {
        if (p_info[i][family] != p_info[playerid][family]) continue;
        if (strcmp(p_info[i][name], target, true) != 0) continue;
        if (p_info[i][family_rang] >= p_info[playerid][family_rang])
            return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}لا يمكنك طرد عضو رتبته أعلى أو تساوي رتبتك.");

        family_info[f][fam_members]--;
        Family_SaveMembers(f);
        p_info[i][family] = 0;
        p_info[i][family_rang] = 0;
        if (p_info[i][family_text] != Text3D:INVALID_3DTEXT_ID)
        {
            DestroyDynamic3DTextLabel(p_info[i][family_text]);
            p_info[i][family_text] = Text3D:INVALID_3DTEXT_ID;
        }
        new q[144];
        format(q, sizeof q, "UPDATE `users` SET `u_family`='0',`u_family_rank`='0' WHERE `u_id`='%d'", p_info[i][id]);
        mysql_tquery(sql_connection, q);
        SendClientMessage(i, col_gray, "تم طردك من العائلة");

        new msg[196];
        format(msg, sizeof msg, "{%s}[%s] {e0e0de}%s طرد العضو %s من العائلة.",
            family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], target);
        family_message(p_info[playerid][family], col_gray, msg);
        return 1;
    }

    // offline member — kick by name in DB
    new q[228];
    mysql_format(sql_connection, q, sizeof q,
        "UPDATE `users` SET `u_family`='0',`u_family_rank`='0' WHERE `u_name`='%e' AND `u_family`='%d' LIMIT 1",
        target, p_info[playerid][family]);
    mysql_tquery(sql_connection, q);
    family_info[f][fam_members]--;
    if (family_info[f][fam_members] < 1) family_info[f][fam_members] = 1;
    Family_SaveMembers(f);

    new msg[196];
    format(msg, sizeof msg, "{%s}[%s] {e0e0de}%s طرد العضو %s من العائلة (غير متصل).",
        family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], target);
    family_message(p_info[playerid][family], col_gray, msg);
    return 1;
}

stock Family_SaveMembers(family_id)
{
    new q[144];
    mysql_format(sql_connection, q, sizeof q, "UPDATE `family` SET `fam_members`='%d' WHERE `fam_id`='%d' LIMIT 1",
        family_info[family_id][fam_members], family_id + 1);
    mysql_tquery(sql_connection, q);
    return 1;
}

stock Family_SetMemberRank(playerid, rang, const target[])
{
    if (p_info[playerid][family] < 1) return 1;
    new f = p_info[playerid][family] - 1;
    if (p_info[playerid][family_rang] < family_info[f][fam_settings][2] && !FAM_IS_LEADER(playerid, f))
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}ليس لديك صلاحية تعديل الرتب.");
    if (rang < 1 || rang > 6)
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}الرتبة لازم تكون بين 1 و 6.");
    if (rang >= p_info[playerid][family_rang] && !FAM_IS_LEADER(playerid, f))
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}لا يمكنك إعطاء رتبة أعلى أو تساوي رتبتك.");
    if (!strcmp(target, family_info[f][fam_creator], true))
        return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}لا يمكن تعديل رتبة مؤسس العائلة.");

    // online?
    foreach (new i : logged_players)
    {
        if (p_info[i][family] != p_info[playerid][family]) continue;
        if (strcmp(p_info[i][name], target, true) != 0) continue;
        if (p_info[i][family_rang] >= p_info[playerid][family_rang] && !FAM_IS_LEADER(playerid, f))
            return SendClientMessage(playerid, col_gray, "{"#cRD"}* {"#cGR"}لا يمكنك تعديل رتبة عضو رتبته أعلى أو تساوي رتبتك.");

        p_info[i][family_rang] = rang;
        new q[144];
        format(q, sizeof q, "UPDATE `users` SET `u_family_rank`='%d' WHERE `u_id`='%d'", rang, p_info[i][id]);
        mysql_tquery(sql_connection, q);

        new msg[196];
        format(msg, sizeof msg, "{%s}[%s] {e0e0de}%s أعطى %s رتبة: %s (%d)",
            family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], target, family_rank[f][rang - 1], rang);
        family_message(p_info[playerid][family], col_gray, msg);
        return 1;
    }

    // offline
    new q[228];
    mysql_format(sql_connection, q, sizeof q,
        "UPDATE `users` SET `u_family_rank`='%d' WHERE `u_name`='%e' AND `u_family`='%d' LIMIT 1",
        rang, target, p_info[playerid][family]);
    mysql_tquery(sql_connection, q);

    new msg[196];
    format(msg, sizeof msg, "{%s}[%s] {e0e0de}%s أعطى %s رتبة: %s (%d)",
        family_info[f][fam_chat_color], family_info[f][fam_name], p_info[playerid][name], target, family_rank[f][rang - 1], rang);
    family_message(p_info[playerid][family], col_gray, msg);
    return 1;
}

// ------------------------------------------------------------
//  dialog dispatcher — commands sent by the launcher UI
//  format: CMD|arg1|arg2 (last arg may contain spaces)
// ------------------------------------------------------------
stock Family_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused listitem
    if (dialogid != d_family_ui) return 0;
    if (!response) { g_fam_open[playerid] = false; return 1; }
    if (!g_fam_open[playerid]) return 1;

    new cmd[16], rest[160];
    cmd[0] = EOS; rest[0] = EOS;
    new sep = strfind(inputtext, "|");
    if (sep == -1)
    {
        format(cmd, sizeof cmd, "%s", inputtext);
    }
    else
    {
        new tmplen = (sep < 15) ? sep : 15;
        strmid(cmd, inputtext, 0, tmplen, sizeof cmd);
        strmid(rest, inputtext, sep + 1, strlen(inputtext), sizeof rest);
    }

    if (!strcmp(cmd, "CLOSE", true)) return Family_CloseUI(playerid);
    if (!strcmp(cmd, "R", true)) return Family_ShowUI(playerid);

    if (!strcmp(cmd, "CAR", true))
    {
        Family_ToggleVehicleSlot(playerid, strval(rest));
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "CARBUY", true))
    {
        Family_BuyCarSlot(playerid, strval(rest));
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "BNKP", true))
    {
        Family_BankDeposit(playerid, strval(rest));
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "BNKT", true))
    {
        Family_BankWithdraw(playerid, strval(rest));
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "NEWSP", true))
    {
        Family_NewsPost(playerid, rest);
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "NEWSPIN", true) || !strcmp(cmd, "NEWSDEL", true))
    {
        new f = p_info[playerid][family] - 1;
        if (f >= 0)
        {
            new idx = Family_NewsFindByOrder(f, strval(rest));
            if (idx != -1)
            {
                if (!strcmp(cmd, "NEWSPIN", true)) Family_NewsPin(playerid, idx);
                else Family_NewsDelete(playerid, idx);
            }
        }
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "KICK", true))
    {
        Family_KickMember(playerid, rest);
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "RANK", true))
    {
        // RANK|rang|name
        new sep2 = strfind(rest, "|");
        if (sep2 != -1)
        {
            new rangstr[8], tname[MAX_PLAYER_NAME];
            strmid(rangstr, rest, 0, (sep2 < 7) ? sep2 : 7, sizeof rangstr);
            strmid(tname, rest, sep2 + 1, strlen(rest), sizeof tname);
            Family_SetMemberRank(playerid, strval(rangstr), tname);
        }
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "WARCH", true))
    {
        // WARCH|bet|familyname
        new sep2 = strfind(rest, "|");
        if (sep2 != -1)
        {
            new betstr[16], tfam[68];
            strmid(betstr, rest, 0, (sep2 < 15) ? sep2 : 15, sizeof betstr);
            strmid(tfam, rest, sep2 + 1, strlen(rest), sizeof tfam);
            Family_WarChallenge(playerid, strval(betstr), tfam);
        }
        return Family_ShowUI(playerid);
    }
    if (!strcmp(cmd, "WARAC", true)) { Family_WarAccept(playerid);  return Family_ShowUI(playerid); }
    if (!strcmp(cmd, "WARDC", true)) { Family_WarDecline(playerid); return Family_ShowUI(playerid); }
    if (!strcmp(cmd, "WARJN", true)) { Family_WarJoin(playerid);    return Family_ShowUI(playerid); }
    if (!strcmp(cmd, "WARLV", true)) { Family_WarLeave(playerid);   return Family_ShowUI(playerid); }

    return Family_ShowUI(playerid);
}
