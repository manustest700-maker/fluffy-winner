// =====================================================================
//  وضع الصيانة (نسخة آمنة ومبسّطة) - يتحكم به من قاعدة البيانات
//  جدول havana_maintenance: enabled = 1 (صيانة) / 0 (مفتوح)
//  الاسم المسموح له ثابت بالسكربت (MAINT_ALLOWED_NAME).
// =====================================================================

#if !defined MAX_PLAYER_NAME
    #define MAX_PLAYER_NAME (24)
#endif

#define MAINT_ALLOWED_NAME "Mister_Muhammed"

new g_maint_enabled = 0;

forward Maintenance_Refresh();
forward Maintenance_OnRefresh();
forward Maintenance_KickDelayed(playerid);

Maintenance_Init()
{
    mysql_tquery(sql_connection, "CREATE TABLE IF NOT EXISTS `havana_maintenance` (`id` INT NOT NULL, `enabled` INT NOT NULL DEFAULT 0, PRIMARY KEY (`id`)) ENGINE=InnoDB", "", "");
    mysql_tquery(sql_connection, "INSERT IGNORE INTO `havana_maintenance` (`id`,`enabled`) VALUES ('1','1')", "", "");
    Maintenance_Refresh();
    SetTimer("Maintenance_Refresh", 15000, true);
    return 1;
}

public Maintenance_Refresh()
{
    mysql_tquery(sql_connection, "SELECT `enabled` FROM `havana_maintenance` WHERE `id`='1' LIMIT 1", "Maintenance_OnRefresh", "");
    return 1;
}

public Maintenance_OnRefresh()
{
    if(cache_num_rows() > 0)
        g_maint_enabled = cache_get_field_content_int(0, "enabled", sql_connection);
    return 1;
}

// ترجع 1 لو منع اللاعب، 0 لو مسموح
Maintenance_OnConnect(playerid)
{
    if(!g_maint_enabled) return 0;
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof pname);
    if(strcmp(pname, MAINT_ALLOWED_NAME, true) == 0) return 0;
    SendClientMessage(playerid, 0xFF6347FF, "{FF6347}[صيانة] {FFFFFF}السيرفر حاليا في وضع الصيانة.");
    SendClientMessage(playerid, 0xFF6347FF, "{FF6347}[صيانة] {FFFFFF}فقط الإدارة تقدر تدخل الآن، حاول لاحقا.");
    GameTextForPlayer(playerid, "~r~Server Under Maintenance~n~~w~Admins Only", 6000, 5);
    SetTimerEx("Maintenance_KickDelayed", 800, false, "d", playerid);
    return 1;
}

public Maintenance_KickDelayed(playerid)
{
    if(IsPlayerConnected(playerid)) Kick(playerid);
    return 1;
}
