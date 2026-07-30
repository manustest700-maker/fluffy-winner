/*
 *  Car Rental Agency (HavanaRP)
 *  ============================
 *  Owner-based rental business (like the mechanic workshop):
 *  - The agency is bought at a wallet auction (/z) — daily at 17:00 while unowned.
 *  - The OWNER lists his OWN personal cars for rent (sets a display name and
 *    hour/day prices), manages the fleet and treasury from the launcher panel.
 *  - Players rent fleet cars; the money goes to the agency treasury.
 *
 *  Dialog channel (launcher intercepts by title):
 *    [!CRENT_OPEN]  d_crent_panel  body lines:
 *        CR:<owner_name>|<treasury>|<isowner>|<viewer_name>|<fleetcnt>|<fleetmax>
 *        CAR:<slot>|<name>|<hour$>|<day$>|<state>|<renter>|<left_min>
 *        MY:<vehid>|<name>|<model>            (owner only: his personal cars)
 *    answer: response=1 + inputtext subcommand:
 *        REFRESH | CLOSE | RENT <slot> <duridx> | ADD <vehid> <hour> <day> <name> |
 *        REM <slot> | PN <slot> <name> | PH <slot> <amount> | PD <slot> <amount> | PP <slot> <h> <d> |
 *        KICK <slot> | WITHDRAW <amount> | DEPOSIT <amount>
 *    [!CRENT_CLOSE] sentinel to hide the overlay
 */

#define CR_FLEET_MAX          15
#define CR_VEHICLE_TYPE       99

// ---- Agency auction (buying the agency) ----
#define CR_AUC_HOUR           17          // opens daily at 17:00 (5 PM)
#define CR_AUC_START          150000      // opening price
#define CR_AUC_INC            50000       // minimum raise per bid
#define CR_AUC_SECONDS        30          // countdown; every valid bid resets it
#define CR_AUC_BOOTSTRAP       540         // first auction starts 9 minutes after restart
#define CR_FIXED_OWNER_NAME    "Karim_Corleone"
#define CR_FIXED_OWNER_ALT     "Karim Corleone"

new g_cr_auc_active   = 0 ;
new g_cr_auc_bid      = 0 ;
new g_cr_auc_bidder   = INVALID_PLAYER_ID ;
new g_cr_auc_acc      = 0 ;
new g_cr_auc_name [ MAX_PLAYER_NAME + 1 ] ;
new g_cr_auc_deadline = 0 ;
new g_cr_auc_after    = 0 ;               // unix: no auto-auction before this
new g_cr_auc_notice   = 0 ;
new bool:g_cr_auc_enabled = false ;

new g_cr_owner = 0 ;                      // owner account id (users.u_id), 0 = none
new g_cr_owner_name [ MAX_PLAYER_NAME + 1 ] ;
new g_cr_treasury = 0 ;

// ---- fleet (owner's personal cars listed for rent) ----
new g_cr_model    [ CR_FLEET_MAX ] ;      // vehicle model id, -1 = empty slot
new g_cr_dbid     [ CR_FLEET_MAX ] ;      // users_vehicles.v_id of the listed car
new g_cr_cname    [ CR_FLEET_MAX ] [ 28 ] ; // display name set by the owner
new g_cr_c1       [ CR_FLEET_MAX ] ;
new g_cr_c2       [ CR_FLEET_MAX ] ;
new g_cr_plate    [ CR_FLEET_MAX ] [ 12 ] ;
new g_cr_veh      [ CR_FLEET_MAX ] ;
new g_cr_hourp    [ CR_FLEET_MAX ] ;
new g_cr_dayp     [ CR_FLEET_MAX ] ;
new g_cr_renter   [ CR_FLEET_MAX ] ;      // renter account id, 0 = available
new g_cr_rname    [ CR_FLEET_MAX ] [ MAX_PLAYER_NAME + 1 ] ;
new g_cr_expire   [ CR_FLEET_MAX ] ;      // gettime() when the rent ends
new Text3D:g_cr_tag [ CR_FLEET_MAX ] ;
new Text3D:g_cr_label = Text3D:INVALID_3DTEXT_ID ;

new g_cr_sel_slot [ MAX_PLAYERS ] ;
new g_cr_sel_idx  [ MAX_PLAYERS ] ;
new g_cr_sel_act  [ MAX_PLAYERS ] ;       // 1=hour 2=day 3=withdraw 4=deposit 5=car name

stock bool:CR_IsOwner ( playerid )
{
	return ( g_cr_owner > 0 && p_info [ playerid ] [ id ] == g_cr_owner ) ;
}

stock CR_FleetCount ( )
{
	new c = 0 ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		if ( g_cr_model [ s ] >= 0 ) c ++ ;
	return c ;
}

stock CR_FreeSlot ( )
{
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		if ( g_cr_model [ s ] < 0 ) return s ;
	return -1 ;
}

stock CR_FindByVeh ( vehid )
{
	if ( vehid <= 0 || vehid == INVALID_VEHICLE_ID ) return -1 ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		if ( g_cr_model [ s ] >= 0 && g_cr_veh [ s ] == vehid ) return s ;
	return -1 ;
}

stock bool:CR_RentalBelongsToPlayer ( playerid, s )
{
	if (
		s < 0 || s >= CR_FLEET_MAX
		|| g_cr_renter [ s ] <= 0
		|| p_info [ playerid ] [ id ] <= 0
	) return false ;
	if ( g_cr_renter [ s ] == p_info [ playerid ] [ id ] ) return true ;
	if ( g_cr_rname [ s ] [ 0 ] && ! strcmp ( g_cr_rname [ s ], p_info [ playerid ] [ name ], true ) )
	{
		g_cr_renter [ s ] = p_info [ playerid ] [ id ] ;
		CR_SaveSlot ( s ) ;
		return true ;
	}
	return false ;
}

// -1 = not an agency car, 0 = deny, 1 = allow.
stock CR_PlayerVehicleLockAccess ( playerid, vehicleid )
{
	new s = CR_FindByVeh ( vehicleid ) ;
	if ( s < 0 ) return -1 ;
	if ( g_cr_renter [ s ] > 0 ) return CR_RentalBelongsToPlayer ( playerid, s ) ;
	return CR_IsOwner ( playerid ) ;
}

// Is this users_vehicles.v_id currently listed in the rental fleet?
// (used to skip spawning the personal copy when the owner logs in)
stock bool:CR_IsListedCarDB ( dbid )
{
	if ( dbid <= 0 ) return false ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		if ( g_cr_model [ s ] >= 0 && g_cr_dbid [ s ] == dbid ) return true ;
	return false ;
}

stock CR_ParkPos ( slot, &Float:x, &Float:y, &Float:z, &Float:a )
{
	new col = slot % 5 ;
	new row = slot / 5 ;
	x = TRENT_SPAWN_X + ( col - 2 ) * 4.5 ;
	y = TRENT_SPAWN_Y - row * 6.5 ;
	z = TRENT_SPAWN_Z ;
	a = TRENT_SPAWN_A ;
	return 1 ;
}

stock CR_SetVehicleLockState ( s, bool:locked )
{
	if ( s < 0 || s >= CR_FLEET_MAX || ! IsValidVehicle ( g_cr_veh [ s ] ) ) return 0 ;
	new vehicleid = g_cr_veh [ s ] ;
	new engine, lights, alarm, doors, bonnet, boot, objective ;
	veh_info [ vehicleid - 1 ] [ v_locked ] = locked ;
	GetVehicleParamsEx ( vehicleid, engine, lights, alarm, doors, bonnet, boot, objective ) ;
	SetVehicleParamsEx ( vehicleid, engine, lights, alarm, locked, bonnet, boot, objective ) ;
	return 1 ;
}

stock CR_SaveMain ( )
{
	new q [ 300 ] ;
	format ( q, sizeof q, "UPDATE `car_rental` SET `owner` = '%d', `owner_name` = '%s', `treasury` = '%d', `auc_after` = '%d' WHERE `id` = 1 LIMIT 1", g_cr_owner, g_cr_owner_name, g_cr_treasury, g_cr_auc_after ) ;
	mysql_tquery ( sql_connection, q, "", "" ) ;
}

stock CR_SaveSlot ( s )
{
	new q [ 360 ] ;
	if ( g_cr_model [ s ] < 0 )
		format ( q, sizeof q, "DELETE FROM `car_rental_fleet2` WHERE `slot` = '%d' LIMIT 1", s ) ;
	else
		mysql_format ( sql_connection, q, sizeof q, "REPLACE INTO `car_rental_fleet2` (`slot`,`car_dbid`,`car_name`,`model`,`c1`,`c2`,`plate`,`hour_price`,`day_price`,`renter_acc`,`renter_name`,`expire_unix`) VALUES ('%d','%d','%e','%d','%d','%d','%e','%d','%d','%d','%e','%d')", s, g_cr_dbid [ s ], g_cr_cname [ s ], g_cr_model [ s ], g_cr_c1 [ s ], g_cr_c2 [ s ], g_cr_plate [ s ], g_cr_hourp [ s ], g_cr_dayp [ s ], g_cr_renter [ s ], g_cr_rname [ s ], g_cr_expire [ s ] ) ;
	mysql_tquery ( sql_connection, q, "", "" ) ;
}

stock CR_SetCarName ( playerid, s, const new_name [ ] )
{
	if ( ! CR_IsOwner ( playerid ) ) return 0 ;
	if ( s < 0 || s >= CR_FLEET_MAX || g_cr_model [ s ] < 0 ) return 0 ;
	if ( strlen ( new_name ) < 2 || strlen ( new_name ) > 27 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اسم السيارة لازم يكون بين حرفين و27 حرفاً." ) ;
	format ( g_cr_cname [ s ], 28, "%s", new_name ) ;
	for ( new i = 0 ; g_cr_cname [ s ] [ i ] ; i ++ )
	{
		if ( g_cr_cname [ s ] [ i ] == '_' ) g_cr_cname [ s ] [ i ] = ' ' ;
		else if (
			g_cr_cname [ s ] [ i ] == '|'
			|| g_cr_cname [ s ] [ i ] == '\n'
			|| g_cr_cname [ s ] [ i ] == '\r'
			|| g_cr_cname [ s ] [ i ] == '\t'
		) g_cr_cname [ s ] [ i ] = '-' ;
	}
	CR_SaveSlot ( s ) ;
	CR_UpdateTag ( s ) ;
	new msg [ 150 ] ;
	format ( msg, sizeof msg, "{"#cGN"}[المعرض] {"#cWH"}تم تغيير اسم السيارة إلى {"#cGN"}%s{"#cWH"}.", g_cr_cname [ s ] ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	return 1 ;
}

stock CR_UpdateTag ( s )
{
	if ( g_cr_model [ s ] < 0 ) return ;
	new t [ 256 ] ;
	if ( g_cr_renter [ s ] > 0 )
		format ( t, sizeof t, "{FFC04A}[ %s ]\n{FF5555}مؤجرة لـ: %s", g_cr_cname [ s ], g_cr_rname [ s ] ) ;
	else
		format ( t, sizeof t, "{FFC04A}[ %s ]\n{FFFFFF}الساعة: {33FF66}$%d {FFFFFF}| اليوم: {33FF66}$%d\n{AAAAAA}للإيجار: قف عند مكتب التأجير", g_cr_cname [ s ], g_cr_hourp [ s ], g_cr_dayp [ s ] ) ;
	if ( g_cr_tag [ s ] != Text3D:INVALID_3DTEXT_ID )
		UpdateDynamic3DTextLabelText ( g_cr_tag [ s ], 0xFFC04AFF, t ) ;
}

stock CR_UpdateLabel ( left )
{
	if ( g_cr_label == Text3D:INVALID_3DTEXT_ID ) return ;
	new t [ 340 ] ;
	if ( g_cr_auc_active )
	{
		if ( g_cr_auc_acc > 0 )
			format ( t, sizeof t, "{FFD700}[ مزاد معرض تأجير السيارات ]\n{FFFFFF}أعلى مزايدة: {33FF66}$%d {FFFFFF}بواسطة {33CCFF}%s\n{FFFFFF}الوقت المتبقي: {FF5555}%d ثانية\n{AAAAAA}للمزايدة: /z %d", g_cr_auc_bid, g_cr_auc_name, left, g_cr_auc_bid + CR_AUC_INC ) ;
		else
			format ( t, sizeof t, "{FFD700}[ مزاد معرض تأجير السيارات ]\n{FFFFFF}السعر الافتتاحي: {33FF66}$%d\n{FFFFFF}الوقت المتبقي: {FF5555}%d ثانية\n{AAAAAA}للمزايدة: /z %d", CR_AUC_START, left, CR_AUC_START ) ;
		UpdateDynamic3DTextLabelText ( g_cr_label, 0xFFD700FF, t ) ;
		return ;
	}
	if ( g_cr_auc_enabled && g_cr_owner == 0 && g_cr_auc_after > gettime ( ) )
	{
		new left_minutes = ( g_cr_auc_after - gettime ( ) + 59 ) / 60 ;
		format ( t, sizeof t, "{FFD700}[ مزاد معرض تأجير السيارات ]\n{FFFFFF}يبدأ المزاد بعد: {FF5555}%d دقيقة\n{FFFFFF}السعر الافتتاحي: {33FF66}$%d\n{AAAAAA}جهّز الكاش للمزايدة بأمر /z", left_minutes, CR_AUC_START ) ;
		UpdateDynamic3DTextLabelText ( g_cr_label, 0xFFD700FF, t ) ;
		return ;
	}
	new owner_text [ 48 ] ;
	if ( g_cr_owner > 0 ) format ( owner_text, sizeof owner_text, "%s", g_cr_owner_name ) ;
	else if ( g_cr_auc_enabled ) format ( owner_text, sizeof owner_text, "لا يوجد — يُباع بالمزاد" ) ;
	else format ( owner_text, sizeof owner_text, "لا يوجد — المزاد متوقف" ) ;
	format ( t, sizeof t, "{FFC04A}[ معرض تأجير السيارات ]\n{FFFFFF}المالك: {33FF66}%s\n{FFFFFF}سيارات متاحة: {33FF66}%d\n{AAAAAA}قف بالنقطة الحمراء للإيجار / لوحة التحكم", owner_text, CR_AvailCount ( ) ) ;
	UpdateDynamic3DTextLabelText ( g_cr_label, 0xFFC04AFF, t ) ;
}

stock CR_ScheduleBootstrapAuction ( )
{
	if ( ! g_cr_auc_enabled )
	{
		g_cr_auc_after = 0 ;
		g_cr_auc_notice = 0 ;
		CR_SaveMain ( ) ;
		CR_UpdateLabel ( 0 ) ;
		return 1 ;
	}
	g_cr_auc_after = gettime ( ) + CR_AUC_BOOTSTRAP ;
	g_cr_auc_notice = 0 ;
	CR_SaveMain ( ) ;
	CR_UpdateLabel ( 0 ) ;
	return 1 ;
}

stock CR_ScheduleNextDailyAuction ( )
{
	if ( ! g_cr_auc_enabled )
	{
		g_cr_auc_after = 0 ;
		g_cr_auc_notice = 0 ;
		CR_SaveMain ( ) ;
		CR_UpdateLabel ( 0 ) ;
		return 1 ;
	}
	new h, m, s ;
	gettime ( h, m, s ) ;
	new now = gettime ( ) ;
	g_cr_auc_after = now - ( h * 3600 + m * 60 + s ) + CR_AUC_HOUR * 3600 ;
	if ( g_cr_auc_after <= now ) g_cr_auc_after += 86400 ;
	g_cr_auc_notice = 0 ;
	CR_SaveMain ( ) ;
	CR_UpdateLabel ( 0 ) ;
	return 1 ;
}

forward CR_OnLoadInitialOwner ( ) ;
public CR_OnLoadInitialOwner ( )
{
	if ( cache_num_rows ( ) <= 0 ) return 1 ;
	g_cr_owner = cache_get_field_content_int ( 0, "u_id", sql_connection ) ;
	cache_get_field_content ( 0, "u_name", g_cr_owner_name, sql_connection, MAX_PLAYER_NAME ) ;
	g_cr_auc_active = 0 ;
	g_cr_auc_after = 0 ;
	g_cr_auc_notice = 0 ;
	CR_SaveMain ( ) ;
	CR_UpdateLabel ( 0 ) ;
	#pragma warning disable 239
	mysql_tquery ( sql_connection, "REPLACE INTO `car_rental_owner_seed` (`id`) VALUES (1)", "", "" ) ;
	#pragma warning enable 239
	return 1 ;
}

forward CR_OnLoadOwnerSeed ( ) ;
public CR_OnLoadOwnerSeed ( )
{
	if ( cache_num_rows ( ) > 0 ) return 1 ;
	#pragma warning disable 239
	mysql_tquery (
		sql_connection,
		"SELECT `u_id`,`u_name` FROM `users` WHERE REPLACE(`u_name`,'_',' ')='Karim Corleone' ORDER BY (`u_name`='Karim_Corleone') DESC LIMIT 1",
		"CR_OnLoadInitialOwner",
		""
	) ;
	#pragma warning enable 239
	return 1 ;
}

stock CR_LoadInitialOwner ( )
{
	#pragma warning disable 239
	mysql_tquery ( sql_connection, "SELECT `id` FROM `car_rental_owner_seed` WHERE `id` = 1 LIMIT 1", "CR_OnLoadOwnerSeed", "" ) ;
	#pragma warning enable 239
	return 1 ;
}

stock CR_AvailCount ( )
{
	new c = 0 ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		if ( g_cr_model [ s ] >= 0 && g_cr_renter [ s ] == 0 ) c ++ ;
	return c ;
}

stock CR_SpawnFleetVeh ( s )
{
	if ( g_cr_model [ s ] < 0 ) return 0 ;
	new Float:x, Float:y, Float:z, Float:a ;
	CR_ParkPos ( s, x, y, z, a ) ;
	g_cr_veh [ s ] = AC_CreateVehicle ( g_cr_model [ s ], x, y, z, a, g_cr_c1 [ s ], g_cr_c2 [ s ], -1 ) ;
	if ( ! IsValidVehicle ( g_cr_veh [ s ] ) )
	{
		g_cr_veh [ s ] = INVALID_VEHICLE_ID ;
		return 0 ;
	}
	new vehicleid = g_cr_veh [ s ] ;
	veh_info [ vehicleid - 1 ] [ v_id ] = 0 ;
	veh_info [ vehicleid - 1 ] [ v_type ] = CR_VEHICLE_TYPE ;
	veh_info [ vehicleid - 1 ] [ v_vehicle ] = vehicleid ;
	veh_info [ vehicleid - 1 ] [ v_owner ] = 0 ;
	veh_info [ vehicleid - 1 ] [ v_model ] = g_cr_model [ s ] ;
	veh_info [ vehicleid - 1 ] [ v_color ] [ 0 ] = g_cr_c1 [ s ] ;
	veh_info [ vehicleid - 1 ] [ v_color ] [ 1 ] = g_cr_c2 [ s ] ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 0 ] = x ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 1 ] = y ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 2 ] = z ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 3 ] = a ;
	veh_info [ vehicleid - 1 ] [ v_now_pos ] [ 0 ] = x ;
	veh_info [ vehicleid - 1 ] [ v_now_pos ] [ 1 ] = y ;
	veh_info [ vehicleid - 1 ] [ v_now_pos ] [ 2 ] = z ;
	veh_info [ vehicleid - 1 ] [ v_millage ] = 0.0 ;
	veh_info [ vehicleid - 1 ] [ v_fuel ] = 100.0 ;
	veh_info [ vehicleid - 1 ] [ v_rank ] = 0 ;
	veh_info [ vehicleid - 1 ] [ v_health ] = 1000.0 ;
	veh_info [ vehicleid - 1 ] [ v_driver ] = INVALID_PLAYER_ID ;
	veh_info [ vehicleid - 1 ] [ v_paint ] = 3 ;
	veh_info [ vehicleid - 1 ] [ v_engine_boost ] = 0.0 ;
	veh_info [ vehicleid - 1 ] [ v_brake_boost ] = 0.0 ;
	veh_info [ vehicleid - 1 ] [ v_stability_boost ] = 0.0 ;
	veh_info [ vehicleid - 1 ] [ v_vw ] = 0 ;
	veh_info [ vehicleid - 1 ] [ v_int ] = 0 ;
	format ( veh_info [ vehicleid - 1 ] [ v_plate ], 12, "%s", g_cr_plate [ s ] ) ;
	if ( g_cr_plate [ s ] [ 0 ] ) SetVehicleNumberPlate ( g_cr_veh [ s ], g_cr_plate [ s ] ) ;
	SetVehicleToRespawn ( vehicleid ) ;
	SetVehiclePos ( vehicleid, x, y, z ) ;
	SetVehicleZAngle ( vehicleid, a ) ;
	AC_SetVehicleHealth ( vehicleid, 1000.0 ) ;
	veh_info [ vehicleid - 1 ] [ v_type ] = CR_VEHICLE_TYPE ;
	veh_info [ vehicleid - 1 ] [ v_fuel ] = 100.0 ;
	CR_SetVehicleLockState ( s, true ) ;
	if ( g_cr_tag [ s ] != Text3D:INVALID_3DTEXT_ID )
	{
		DestroyDynamic3DTextLabel ( g_cr_tag [ s ] ) ;
		g_cr_tag [ s ] = Text3D:INVALID_3DTEXT_ID ;
	}
	g_cr_tag [ s ] = CreateDynamic3DTextLabel ( " ", 0xFFC04AFF, x, y, z, 30.0, INVALID_PLAYER_ID, g_cr_veh [ s ], 0, 0, 0 ) ;
	CR_UpdateTag ( s ) ;
	return 1 ;
}

stock CR_DespawnFleetVeh ( s )
{
	if ( g_cr_tag [ s ] != Text3D:INVALID_3DTEXT_ID )
	{
		DestroyDynamic3DTextLabel ( g_cr_tag [ s ] ) ;
		g_cr_tag [ s ] = Text3D:INVALID_3DTEXT_ID ;
	}
	if ( g_cr_veh [ s ] != INVALID_VEHICLE_ID )
	{
		DestroyVehicle ( g_cr_veh [ s ] ) ;
		g_cr_veh [ s ] = INVALID_VEHICLE_ID ;
	}
	return 1 ;
}

stock CR_ReturnToLot ( s )
{
	if ( g_cr_veh [ s ] == INVALID_VEHICLE_ID ) return 0 ;
	new Float:x, Float:y, Float:z, Float:a ;
	CR_ParkPos ( s, x, y, z, a ) ;
	new vehicleid = g_cr_veh [ s ] ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 0 ] = x ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 1 ] = y ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 2 ] = z ;
	veh_info [ vehicleid - 1 ] [ v_pos ] [ 3 ] = a ;
	veh_info [ vehicleid - 1 ] [ v_type ] = CR_VEHICLE_TYPE ;
	veh_info [ vehicleid - 1 ] [ v_owner ] = 0 ;
	veh_info [ vehicleid - 1 ] [ v_fuel ] = 100.0 ;
	veh_info [ vehicleid - 1 ] [ v_health ] = 1000.0 ;
	SetVehicleToRespawn ( g_cr_veh [ s ] ) ;
	SetVehiclePos ( g_cr_veh [ s ], x, y, z ) ;
	SetVehicleZAngle ( g_cr_veh [ s ], a ) ;
	AC_SetVehicleHealth ( g_cr_veh [ s ], 1000.0 ) ;
	veh_info [ vehicleid - 1 ] [ v_type ] = CR_VEHICLE_TYPE ;
	veh_info [ vehicleid - 1 ] [ v_fuel ] = 100.0 ;
	CR_SetVehicleLockState ( s, true ) ;
	return 1 ;
}

forward CR_OnLoadMain ( ) ;
public CR_OnLoadMain ( )
{
	if ( cache_num_rows ( ) > 0 )
	{
		g_cr_owner = cache_get_field_content_int ( 0, "owner", sql_connection ) ;
		cache_get_field_content ( 0, "owner_name", g_cr_owner_name, sql_connection, MAX_PLAYER_NAME ) ;
		g_cr_treasury = cache_get_field_content_int ( 0, "treasury", sql_connection ) ;
		g_cr_auc_after = cache_get_field_content_int ( 0, "auc_after", sql_connection ) ;
		if ( g_cr_owner == 0 ) CR_ScheduleBootstrapAuction ( ) ;
	}
	else
	{
		g_cr_auc_after = gettime ( ) + CR_AUC_BOOTSTRAP ;
		new q [ 200 ] ;
		format ( q, sizeof q, "INSERT INTO `car_rental` (`id`,`owner`,`owner_name`,`treasury`,`auc_after`) VALUES (1,0,'',0,'%d')", g_cr_auc_after ) ;
		mysql_tquery ( sql_connection, q, "", "" ) ;
	}
	CR_UpdateLabel ( 0 ) ;
	CR_LoadInitialOwner ( ) ;
	return 1 ;
}

forward CR_OnLoadFleet ( ) ;
public CR_OnLoadFleet ( )
{
	new rows = cache_num_rows ( ) ;
	for ( new i = 0 ; i < rows ; i ++ )
	{
		new s = cache_get_field_content_int ( i, "slot", sql_connection ) ;
		if ( s < 0 || s >= CR_FLEET_MAX ) continue ;
		g_cr_model [ s ] = cache_get_field_content_int ( i, "model", sql_connection ) ;
		if ( g_cr_model [ s ] < 400 ) { g_cr_model [ s ] = -1 ; continue ; }
		g_cr_dbid [ s ] = cache_get_field_content_int ( i, "car_dbid", sql_connection ) ;
		cache_get_field_content ( i, "car_name", g_cr_cname [ s ], sql_connection, 27 ) ;
		g_cr_c1 [ s ] = cache_get_field_content_int ( i, "c1", sql_connection ) ;
		g_cr_c2 [ s ] = cache_get_field_content_int ( i, "c2", sql_connection ) ;
		cache_get_field_content ( i, "plate", g_cr_plate [ s ], sql_connection, 11 ) ;
		g_cr_hourp [ s ] = cache_get_field_content_int ( i, "hour_price", sql_connection ) ;
		g_cr_dayp [ s ] = cache_get_field_content_int ( i, "day_price", sql_connection ) ;
		g_cr_renter [ s ] = cache_get_field_content_int ( i, "renter_acc", sql_connection ) ;
		cache_get_field_content ( i, "renter_name", g_cr_rname [ s ], sql_connection, MAX_PLAYER_NAME ) ;
		g_cr_expire [ s ] = cache_get_field_content_int ( i, "expire_unix", sql_connection ) ;
		if ( g_cr_renter [ s ] > 0 && g_cr_expire [ s ] <= gettime ( ) )
		{
			g_cr_renter [ s ] = 0 ;
			g_cr_rname [ s ] [ 0 ] = 0 ;
			g_cr_expire [ s ] = 0 ;
			CR_SaveSlot ( s ) ;
		}
		CR_SpawnFleetVeh ( s ) ;
	}
	CR_UpdateLabel ( 0 ) ;
	return 1 ;
}

stock CR_Init ( )
{
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		g_cr_model [ s ] = -1 ;
		g_cr_dbid [ s ] = 0 ;
		g_cr_cname [ s ] [ 0 ] = 0 ;
		g_cr_c1 [ s ] = 1 ;
		g_cr_c2 [ s ] = 1 ;
		g_cr_plate [ s ] [ 0 ] = 0 ;
		g_cr_veh [ s ] = INVALID_VEHICLE_ID ;
		g_cr_hourp [ s ] = 0 ;
		g_cr_dayp [ s ] = 0 ;
		g_cr_renter [ s ] = 0 ;
		g_cr_rname [ s ] [ 0 ] = 0 ;
		g_cr_expire [ s ] = 0 ;
		g_cr_tag [ s ] = Text3D:INVALID_3DTEXT_ID ;
	}
	for ( new p = 0 ; p < MAX_PLAYERS ; p ++ )
	{
		g_cr_sel_slot [ p ] = -1 ;
		g_cr_sel_idx [ p ] = -1 ;
		g_cr_sel_act [ p ] = 0 ;
	}
	g_cr_label = CreateDynamic3DTextLabel ( "{FFC04A}[ معرض تأجير السيارات ]", 0xFFC04AFF, TRENT_PICKUP_X, TRENT_PICKUP_Y, TRENT_PICKUP_Z + 2.6, 50.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0 ) ;
	mysql_tquery ( sql_connection, "CREATE TABLE IF NOT EXISTS `car_rental` (`id` INT NOT NULL PRIMARY KEY, `owner` INT NOT NULL DEFAULT 0, `owner_name` VARCHAR(30) NOT NULL DEFAULT '', `treasury` INT NOT NULL DEFAULT 0, `auc_after` INT NOT NULL DEFAULT 0)", "", "" ) ;
	#pragma warning disable 239
	mysql_tquery ( sql_connection, "CREATE TABLE IF NOT EXISTS `car_rental_owner_seed` (`id` TINYINT NOT NULL PRIMARY KEY)", "", "" ) ;
	#pragma warning enable 239
	mysql_tquery ( sql_connection, "CREATE TABLE IF NOT EXISTS `car_rental_fleet2` (`slot` INT NOT NULL PRIMARY KEY, `car_dbid` INT NOT NULL DEFAULT 0, `car_name` VARCHAR(30) NOT NULL DEFAULT '', `model` INT NOT NULL DEFAULT -1, `c1` INT NOT NULL DEFAULT 1, `c2` INT NOT NULL DEFAULT 1, `plate` VARCHAR(12) NOT NULL DEFAULT '', `hour_price` INT NOT NULL DEFAULT 0, `day_price` INT NOT NULL DEFAULT 0, `renter_acc` INT NOT NULL DEFAULT 0, `renter_name` VARCHAR(30) NOT NULL DEFAULT '', `expire_unix` INT NOT NULL DEFAULT 0)", "", "" ) ;
	// Purge the old player-rental system + old catalog fleet completely.
	mysql_tquery ( sql_connection, "DROP TABLE IF EXISTS `trent_rentals`", "", "" ) ;
	mysql_tquery ( sql_connection, "DROP TABLE IF EXISTS `car_rental_fleet`", "", "" ) ;
	mysql_tquery ( sql_connection, "SELECT * FROM `car_rental` WHERE `id` = 1", "CR_OnLoadMain", "" ) ;
	mysql_tquery ( sql_connection, "SELECT * FROM `car_rental_fleet2`", "CR_OnLoadFleet", "" ) ;
	SetTimer ( "CR_Tick", 1000, true ) ;
	return 1 ;
}

// =====================  CONTROL PANEL (owner)  =====================

stock CR_ShowPanel ( playerid )
{
	static body [ 4096 ] ;
	new line [ 256 ] ;
	body [ 0 ] = EOS ;
	format ( line, sizeof line, "CR:%s|%d|%d|%s|%d|%d\n", ( g_cr_owner > 0 ) ? g_cr_owner_name : ( "-" ), g_cr_treasury, CR_IsOwner ( playerid ) ? 1 : 0, p_info [ playerid ] [ name ], CR_FleetCount ( ), CR_FLEET_MAX ) ;
	strcat ( body, line ) ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		if ( g_cr_model [ s ] < 0 ) continue ;
		new left_min = 0 ;
		if ( g_cr_renter [ s ] > 0 ) left_min = ( g_cr_expire [ s ] - gettime ( ) ) / 60 ;
		if ( left_min < 0 ) left_min = 0 ;
		format ( line, sizeof line, "CAR:%d|%s|%d|%d|%d|%s|%d\n", s, g_cr_cname [ s ], g_cr_hourp [ s ], g_cr_dayp [ s ], ( g_cr_renter [ s ] > 0 ) ? 1 : 0, ( g_cr_renter [ s ] > 0 ) ? g_cr_rname [ s ] : ( "-" ), left_min ) ;
		strcat ( body, line ) ;
	}
	if ( CR_IsOwner ( playerid ) )
	{
		foreach ( new mv:player_vehicles[playerid])
		{
			if ( mv <= 0 || mv > MAX_VEHICLES ) continue ;
			if ( veh_info [ mv - 1 ] [ v_type ] != vehicle_type_player ) continue ;
			if ( veh_info [ mv - 1 ] [ v_owner ] != p_info [ playerid ] [ id ] ) continue ;
			if ( CR_IsListedCarDB ( veh_info [ mv - 1 ] [ v_id ] ) ) continue ;
			format ( line, sizeof line, "MY:%d|%s|%d\n", mv, VehModelName ( veh_info [ mv - 1 ] [ v_model ] ), veh_info [ mv - 1 ] [ v_model ] ) ;
			strcat ( body, line ) ;
		}
	}
	show_dialog ( playerid, d_crent_panel, DIALOG_STYLE_INPUT, "[!CRENT_OPEN]", body, "تنفيذ", "إغلاق" ) ;
	return 1 ;
}

stock CR_ClosePanel ( playerid )
{
	show_dialog ( playerid, d_crent_panel, DIALOG_STYLE_MSGBOX, "[!CRENT_CLOSE]", " ", "OK", "" ) ;
	return 1 ;
}

// Fallback dialog panel (styled) — used from the panel dialog response and
// as the direct UI when the launcher overlay is not present.
stock CR_ShowOwnerMenu ( playerid )
{
	new body [ 1200 ] ;
	format ( body, sizeof body,
		"{FFFFFF}المالك\t{33FF66}%s\n\
{FFFFFF}الخزينة\t{33FF66}$%d\n\
{FFFFFF}الأسطول\t{FFC04A}%d / %d\n\
{FFC04A}إضافة سيارة للتأجير\t{AAAAAA}من سياراتك الخاصة\n\
{FFC04A}إدارة الأسطول\t{AAAAAA}أسعار / بيع / استرجاع\n\
{FFC04A}سحب من الخزينة\t{33FF66}$%d\n\
{FFC04A}إيداع في الخزينة\t{AAAAAA}كاش\n\
{FFC04A}تحديث\t{AAAAAA}إعادة فتح اللوحة",
		( g_cr_owner > 0 ) ? g_cr_owner_name : ( "-" ), g_cr_treasury, CR_FleetCount ( ), CR_FLEET_MAX, g_cr_treasury ) ;
	show_dialog ( playerid, d_crent_owner, DIALOG_STYLE_TABLIST, "{FFC04A}لوحة تحكم معرض التأجير", body, "اختيار", "إغلاق" ) ;
	return 1 ;
}

// nth addable personal car (vehicleid) of the owner, -1 if none
stock CR_MyCarByOrder ( playerid, n )
{
	new k = 0 ;
	foreach ( new mv:player_vehicles[playerid])
	{
		if ( mv <= 0 || mv > MAX_VEHICLES ) continue ;
		if ( veh_info [ mv - 1 ] [ v_type ] != vehicle_type_player ) continue ;
		if ( veh_info [ mv - 1 ] [ v_owner ] != p_info [ playerid ] [ id ] ) continue ;
		if ( CR_IsListedCarDB ( veh_info [ mv - 1 ] [ v_id ] ) ) continue ;
		if ( k == n ) return mv ;
		k ++ ;
	}
	return -1 ;
}

stock CR_ShowMyCars ( playerid )
{
	new body [ 1400 ] ;
	new cnt = 0 ;
	strcat ( body, "{FFFF00}السيارة\t{FFFF00}الموديل\n" ) ;
	foreach ( new mv:player_vehicles[playerid])
	{
		if ( mv <= 0 || mv > MAX_VEHICLES ) continue ;
		if ( veh_info [ mv - 1 ] [ v_type ] != vehicle_type_player ) continue ;
		if ( veh_info [ mv - 1 ] [ v_owner ] != p_info [ playerid ] [ id ] ) continue ;
		if ( CR_IsListedCarDB ( veh_info [ mv - 1 ] [ v_id ] ) ) continue ;
		new line [ 96 ] ;
		format ( line, sizeof line, "{FFFFFF}%s\t{AAAAAA}%d\n", VehModelName ( veh_info [ mv - 1 ] [ v_model ] ), veh_info [ mv - 1 ] [ v_model ] ) ;
		strcat ( body, line ) ;
		cnt ++ ;
	}
	if ( ! cnt )
	{
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما عندك سيارات شخصية متاحة للإضافة (لازم تكون ظاهرة بالشارع)." ) ;
		return CR_ShowOwnerMenu ( playerid ) ;
	}
	show_dialog ( playerid, d_crent_buy, DIALOG_STYLE_TABLIST_HEADERS, "{FFC04A}إضافة سيارة من سياراتك للتأجير", body, "إضافة", "رجوع" ) ;
	return 1 ;
}

stock CR_ShowFleetMenu ( playerid )
{
	if ( CR_FleetCount ( ) == 0 )
	{
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}الأسطول فاضي — أضف سيارات من سياراتك أول." ) ;
		return CR_ShowOwnerMenu ( playerid ) ;
	}
	new body [ 1800 ] ;
	strcat ( body, "{FFFF00}السيارة\t{FFFF00}ساعة/يوم\t{FFFF00}الحالة\n" ) ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		if ( g_cr_model [ s ] < 0 ) continue ;
		new line [ 160 ] ;
		new st [ 64 ] ;
		if ( g_cr_renter [ s ] > 0 )
		{
			new left = ( g_cr_expire [ s ] - gettime ( ) ) / 60 ;
			if ( left < 0 ) left = 0 ;
			format ( st, sizeof st, "{FF5555}مؤجرة: %s (%dد)", g_cr_rname [ s ], left ) ;
		}
		else format ( st, sizeof st, "{33FF66}متاحة" ) ;
		format ( line, sizeof line, "{FFFFFF}%s\t{33FF66}$%d / $%d\t%s\n", g_cr_cname [ s ], g_cr_hourp [ s ], g_cr_dayp [ s ], st ) ;
		strcat ( body, line ) ;
	}
	show_dialog ( playerid, d_crent_fleet, DIALOG_STYLE_TABLIST_HEADERS, "{FFC04A}إدارة الأسطول", body, "إدارة", "رجوع" ) ;
	return 1 ;
}

stock CR_FleetSlotByOrder ( n )
{
	new k = 0 ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		if ( g_cr_model [ s ] < 0 ) continue ;
		if ( k == n ) return s ;
		k ++ ;
	}
	return -1 ;
}

stock CR_ShowFleetItem ( playerid, s )
{
	if ( s < 0 || s >= CR_FLEET_MAX || g_cr_model [ s ] < 0 ) return 0 ;
	new body [ 700 ] ;
	format ( body, sizeof body,
		"{FFFFFF}تغيير اسم السيارة {AAAAAA}(حالياً %s)\n\
{FFFFFF}تغيير سعر {FFFF00}الساعة {AAAAAA}(حالياً $%d)\n\
{FFFFFF}تغيير سعر {FFFF00}اليوم {AAAAAA}(حالياً $%d)\n\
{FFFFFF}إرجاع السيارة {FFFF00}للموقف الآن\n\
{FFFFFF}إنهاء الإيجار الحالي {AAAAAA}(طرد المستأجر)\n\
{FF5555}إزالة من التأجير {AAAAAA}(ترجع لك كسيارة شخصية)",
		g_cr_cname [ s ], g_cr_hourp [ s ], g_cr_dayp [ s ] ) ;
	new title [ 96 ] ;
	format ( title, sizeof title, "{FFC04A}إدارة %s", g_cr_cname [ s ] ) ;
	show_dialog ( playerid, d_crent_fleet_item, DIALOG_STYLE_LIST, title, body, "اختيار", "رجوع" ) ;
	return 1 ;
}

stock CR_ShowInput ( playerid, act )
{
	g_cr_sel_act [ playerid ] = act ;
	new title [ 80 ], body [ 220 ] ;
	switch ( act )
	{
		case 1: { format ( title, sizeof title, "{FFC04A}سعر الساعة" ) ; format ( body, sizeof body, "{FFFFFF}أدخل سعر الإيجار بالساعة (بالدولار):" ) ; }
		case 2: { format ( title, sizeof title, "{FFC04A}سعر اليوم" ) ; format ( body, sizeof body, "{FFFFFF}أدخل سعر الإيجار باليوم (بالدولار):" ) ; }
		case 3: { format ( title, sizeof title, "{FFC04A}سحب من الخزينة" ) ; format ( body, sizeof body, "{FFFFFF}أدخل المبلغ الذي تريد سحبه (الرصيد: {33FF66}$%d{FFFFFF}):", g_cr_treasury ) ; }
		case 4: { format ( title, sizeof title, "{FFC04A}إيداع في الخزينة" ) ; format ( body, sizeof body, "{FFFFFF}أدخل المبلغ الذي تريد إيداعه:" ) ; }
		case 5: { format ( title, sizeof title, "{FFC04A}اسم السيارة" ) ; format ( body, sizeof body, "{FFFFFF}أدخل الاسم الذي سيظهر للمستأجرين، مثال: {33FF66}BMW M5" ) ; }
	}
	show_dialog ( playerid, d_crent_input, DIALOG_STYLE_INPUT, title, body, "تأكيد", "رجوع" ) ;
	return 1 ;
}

// List one of the owner's personal cars for rent. The personal car is
// despawned while listed (it "moves" to the rental lot).
stock CR_DoAdd ( playerid, vehid, hourp, dayp, const cname [ ] )
{
	if ( ! CR_IsOwner ( playerid ) ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}الإضافة لمالك المعرض فقط." ) ;
	if ( vehid <= 0 || vehid > MAX_VEHICLES ) return 1 ;
	if ( veh_info [ vehid - 1 ] [ v_type ] != vehicle_type_player || veh_info [ vehid - 1 ] [ v_owner ] != p_info [ playerid ] [ id ] )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}هذي مو سيارتك الشخصية." ) ;
	if ( veh_info [ vehid - 1 ] [ v_id ] <= 0 || CR_IsListedCarDB ( veh_info [ vehid - 1 ] [ v_id ] ) ) return 1 ;
	new s = CR_FreeSlot ( ) ;
	if ( s == -1 ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}الأسطول ممتلئ." ) ;
	if ( hourp <= 0 || hourp > 1000000 ) hourp = 500 ;
	if ( dayp <= 0 || dayp > 10000000 ) dayp = hourp * 15 ;
	g_cr_model [ s ] = veh_info [ vehid - 1 ] [ v_model ] ;
	g_cr_dbid [ s ] = veh_info [ vehid - 1 ] [ v_id ] ;
	g_cr_c1 [ s ] = veh_info [ vehid - 1 ] [ v_color ] [ 0 ] ;
	g_cr_c2 [ s ] = veh_info [ vehid - 1 ] [ v_color ] [ 1 ] ;
	format ( g_cr_plate [ s ], 12, "%s", veh_info [ vehid - 1 ] [ v_plate ] ) ;
	if ( strlen ( cname ) ) format ( g_cr_cname [ s ], 28, "%s", cname ) ;
	else format ( g_cr_cname [ s ], 28, "%s", VehModelName ( g_cr_model [ s ] ) ) ;
	for ( new ci = 0 ; g_cr_cname [ s ] [ ci ] ; ci ++ )
		if ( g_cr_cname [ s ] [ ci ] == '|' || g_cr_cname [ s ] [ ci ] == '_' || g_cr_cname [ s ] [ ci ] == '\n' ) g_cr_cname [ s ] [ ci ] = ( g_cr_cname [ s ] [ ci ] == '_' ) ? ' ' : '-' ;
	g_cr_hourp [ s ] = hourp ;
	g_cr_dayp [ s ] = dayp ;
	g_cr_renter [ s ] = 0 ;
	g_cr_rname [ s ] [ 0 ] = 0 ;
	g_cr_expire [ s ] = 0 ;
	// remove the personal copy from the street
	AC_DestroyVehicle ( vehid ) ;
	Iter_Remove ( player_vehicles[playerid], vehid ) ;
	CR_SpawnFleetVeh ( s ) ;
	CR_SaveSlot ( s ) ;
	CR_UpdateLabel ( 0 ) ;
	new msg [ 200 ] ;
	format ( msg, sizeof msg, "{"#cGN"}[المعرض] {"#cWH"}أضفت {"#cGN"}%s {"#cWH"}للتأجير (الساعة: $%d | اليوم: $%d).", g_cr_cname [ s ], g_cr_hourp [ s ], g_cr_dayp [ s ] ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	return 1 ;
}

// Remove a car from the rental fleet and give it back to the owner as his
// personal car (respawned from users_vehicles).
stock CR_DoRemove ( playerid, s )
{
	if ( ! CR_IsOwner ( playerid ) ) return 1 ;
	if ( s < 0 || s >= CR_FLEET_MAX || g_cr_model [ s ] < 0 ) return 1 ;
	if ( g_cr_renter [ s ] > 0 ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}السيارة مؤجرة حالياً — أنهِ الإيجار أول." ) ;
	new dbid = g_cr_dbid [ s ] ;
	new cname [ 28 ] ;
	format ( cname, sizeof cname, "%s", g_cr_cname [ s ] ) ;
	CR_DespawnFleetVeh ( s ) ;
	g_cr_model [ s ] = -1 ;
	g_cr_dbid [ s ] = 0 ;
	g_cr_cname [ s ] [ 0 ] = 0 ;
	CR_SaveSlot ( s ) ;
	CR_UpdateLabel ( 0 ) ;
	if ( dbid > 0 )
	{
		new q [ 128 ] ;
		format ( q, sizeof q, "SELECT * FROM `users_vehicles` WHERE `v_id` = '%d' LIMIT 1", dbid ) ;
		mysql_tquery ( sql_connection, q, "load_single_vehicle", "i", playerid ) ;
	}
	new msg [ 190 ] ;
	format ( msg, sizeof msg, "{"#cGN"}[المعرض] {"#cWH"}شلت {"#cGN"}%s {"#cWH"}من التأجير ورجعت لك كسيارة شخصية.", cname ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	return 1 ;
}

stock CR_DoKick ( playerid, s )
{
	if ( ! CR_IsOwner ( playerid ) ) return 1 ;
	if ( s < 0 || s >= CR_FLEET_MAX || g_cr_model [ s ] < 0 || g_cr_renter [ s ] == 0 ) return 1 ;
	new racc = g_cr_renter [ s ] ;
	g_cr_renter [ s ] = 0 ;
	g_cr_rname [ s ] [ 0 ] = 0 ;
	g_cr_expire [ s ] = 0 ;
	CR_ReturnToLot ( s ) ;
	CR_SaveSlot ( s ) ;
	CR_UpdateTag ( s ) ;
	CR_UpdateLabel ( 0 ) ;
	for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
		if ( IsPlayerConnected ( i ) && p_info [ i ] [ id ] == racc )
		{
			SendClientMessage ( i, col_gray, "{"#cRD"}[المعرض] {"#cWH"}مالك المعرض أنهى إيجار سيارتك." ) ;
			break ;
		}
	SendClientMessage ( playerid, col_white, "{"#cGN"}[المعرض] {"#cWH"}تم إنهاء الإيجار وإرجاع السيارة للموقف." ) ;
	return 1 ;
}

// =====================  RENTING (players)  =====================

stock CR_OnCheckpoint ( playerid )
{
	if ( g_cr_auc_active )
	{
		new msg [ 200 ] ;
		new required = ( g_cr_auc_acc > 0 ) ? ( g_cr_auc_bid + CR_AUC_INC ) : CR_AUC_START ;
		format ( msg, sizeof msg, "{"#cGD"}[مزاد المعرض] {"#cWH"}المزاد شغال الآن — للمزايدة اكتب {"#cGN"}/z %d{"#cWH"}.", required ) ;
		SendClientMessage ( playerid, col_white, msg ) ;
	}
	return CR_ShowPanel ( playerid ) ;
}

stock CR_ShowRentList ( playerid )
{
	if ( g_cr_owner == 0 )
	{
		if ( g_cr_auc_enabled )
			show_dialog ( playerid, d_none, DIALOG_STYLE_MSGBOX, "{FFC04A}معرض تأجير السيارات",
				"{FFFFFF}المعرض حالياً {FF5555}بدون مالك{FFFFFF}.\n\n{AAAAAA}يُباع المعرض بمزاد المحفظة يومياً الساعة {FFD700}17:00{AAAAAA}\nكن جاهزاً بالكاش وزايد بأمر {33FF66}/z{AAAAAA}!", "OK", "" ) ;
		#pragma warning disable 239
		else
			show_dialog ( playerid, d_none, DIALOG_STYLE_MSGBOX, "{FFC04A}معرض تأجير السيارات",
				"{FFFFFF}المعرض حالياً {FF5555}بدون مالك{FFFFFF}.\n\n{AAAAAA}نظام المزاد متوقف مؤقتاً، وسيتم تفعيله لاحقاً.", "OK", "" ) ;
		#pragma warning enable 239
		return 1 ;
	}
	if ( CR_AvailCount ( ) == 0 )
	{
		show_dialog ( playerid, d_none, DIALOG_STYLE_MSGBOX, "{FFC04A}معرض تأجير السيارات",
			"{FFFFFF}ما في سيارات متاحة للإيجار حالياً.\n{AAAAAA}ارجع لاحقاً — المالك يضيف سيارات للأسطول.", "OK", "" ) ;
		return 1 ;
	}
	new body [ 1800 ] ;
	strcat ( body, "{FFFF00}السيارة\t{FFFF00}الساعة\t{FFFF00}اليوم\n" ) ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		if ( g_cr_model [ s ] < 0 || g_cr_renter [ s ] > 0 ) continue ;
		new line [ 128 ] ;
		format ( line, sizeof line, "{FFFFFF}%s\t{33FF66}$%d\t{33FF66}$%d\n", g_cr_cname [ s ], g_cr_hourp [ s ], g_cr_dayp [ s ] ) ;
		strcat ( body, line ) ;
	}
	show_dialog ( playerid, d_crent_rent_list, DIALOG_STYLE_TABLIST_HEADERS, "{FFC04A}تأجير سيارة", body, "اختيار", "إغلاق" ) ;
	return 1 ;
}

stock CR_AvailSlotByOrder ( n )
{
	new k = 0 ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		if ( g_cr_model [ s ] < 0 || g_cr_renter [ s ] > 0 ) continue ;
		if ( k == n ) return s ;
		k ++ ;
	}
	return -1 ;
}

new const g_cr_dur_hours [ 7 ] = { 1, 3, 6, 12, 24, 72, 168 } ;
new const g_cr_dur_name [ 7 ] [ 20 ] = { "ساعة", "3 ساعات", "6 ساعات", "12 ساعة", "يوم", "3 أيام", "أسبوع" } ;

stock CR_DurPrice ( s, d )
{
	if ( g_cr_dur_hours [ d ] < 24 ) return g_cr_hourp [ s ] * g_cr_dur_hours [ d ] ;
	return g_cr_dayp [ s ] * ( g_cr_dur_hours [ d ] / 24 ) ;
}

stock CR_ShowRentDur ( playerid )
{
	new s = g_cr_sel_slot [ playerid ] ;
	if ( s < 0 || s >= CR_FLEET_MAX || g_cr_model [ s ] < 0 || g_cr_renter [ s ] > 0 ) return CR_ShowRentList ( playerid ) ;
	new body [ 1100 ] ;
	strcat ( body, "{FFFF00}المدة\t{FFFF00}السعر\n" ) ;
	for ( new d = 0 ; d < 7 ; d ++ )
	{
		new line [ 96 ] ;
		format ( line, sizeof line, "{FFFFFF}%s\t{33FF66}$%d\n", g_cr_dur_name [ d ], CR_DurPrice ( s, d ) ) ;
		strcat ( body, line ) ;
	}
	new title [ 96 ] ;
	format ( title, sizeof title, "{FFC04A}تأجير %s — اختر المدة", g_cr_cname [ s ] ) ;
	show_dialog ( playerid, d_crent_rent_dur, DIALOG_STYLE_TABLIST_HEADERS, title, body, "تأجير", "رجوع" ) ;
	return 1 ;
}

stock CR_DoRent ( playerid, d, slot_override = -2 )
{
	new s = ( slot_override != -2 ) ? slot_override : g_cr_sel_slot [ playerid ] ;
	if ( s < 0 || s >= CR_FLEET_MAX || g_cr_model [ s ] < 0 ) return 1 ;
	if ( g_cr_renter [ s ] > 0 ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}السيارة انأجرت للتو — اختر غيرها." ) ;
	if ( d < 0 || d >= 7 ) return 1 ;
	if ( p_info [ playerid ] [ id ] <= 0 ) return 1 ;
	new cost = CR_DurPrice ( s, d ) ;
	if ( p_info [ playerid ] [ money ] < cost ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما معك كاش كافي." ) ;
	give_money ( playerid, - cost ) ;
	insert_money_log ( playerid, INVALID_PLAYER_ID, - cost, "car rental payment" ) ;
	g_cr_treasury += cost ;
	CR_SaveMain ( ) ;
	g_cr_renter [ s ] = p_info [ playerid ] [ id ] ;
	format ( g_cr_rname [ s ], MAX_PLAYER_NAME, "%s", p_info [ playerid ] [ name ] ) ;
	g_cr_expire [ s ] = gettime ( ) + g_cr_dur_hours [ d ] * 3600 ;
	if ( IsValidVehicle ( g_cr_veh [ s ] ) )
	{
		veh_info [ g_cr_veh [ s ] - 1 ] [ v_type ] = CR_VEHICLE_TYPE ;
		veh_info [ g_cr_veh [ s ] - 1 ] [ v_owner ] = 0 ;
		veh_info [ g_cr_veh [ s ] - 1 ] [ v_fuel ] = 100.0 ;
		AC_SetVehicleHealth ( g_cr_veh [ s ], 1000.0 ) ;
		CR_SetVehicleLockState ( s, true ) ;
	}
	CR_SaveSlot ( s ) ;
	CR_UpdateTag ( s ) ;
	CR_UpdateLabel ( 0 ) ;
	new msg [ 200 ] ;
	format ( msg, sizeof msg, "{"#cGN"}[المعرض] {"#cWH"}أجّرت {"#cGN"}%s {"#cWH"}لمدة {"#cGN"}%s {"#cWH"}بـ {"#cGN"}$%d{"#cWH"} — استخدم {"#cGN"}/timecar {"#cWH"}لعرض السيارة وإدارتها.", g_cr_cname [ s ], g_cr_dur_name [ d ], cost ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	SendClientMessage ( playerid, col_white, "{"#cGN"}[المعرض] {"#cWH"}السيارة موجودة في موقف المعرض؛ من /timecar تقدر تحدد موقعها أو ترجعها." ) ;
	SendClientMessage ( playerid, col_white, "{"#cGN"}[المعرض] {"#cWH"}السيارة مقفلة لك؛ استخدم {"#cGN"}/lk {"#cWH"}قربها للفتح أو الإغلاق، ولا يقدر غيرك يتحكم بقفلها." ) ;
	// notify online owner
	for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
		if ( IsPlayerConnected ( i ) && g_cr_owner > 0 && p_info [ i ] [ id ] == g_cr_owner )
		{
			format ( msg, sizeof msg, "{"#cGN"}[المعرض] {"#cWH"}%s أجّر {"#cGN"}%s {"#cWH"}(%s) — دخل الخزينة {"#cGN"}$%d{"#cWH"}.", p_info [ playerid ] [ name ], g_cr_cname [ s ], g_cr_dur_name [ d ], cost ) ;
			SendClientMessage ( i, col_white, msg ) ;
			break ;
		}
	return 1 ;
}

stock CR_PlayerRentCount ( playerid )
{
	if ( p_info [ playerid ] [ id ] <= 0 ) return 0 ;
	new count = 0 ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		if ( g_cr_model [ s ] >= 0 && CR_RentalBelongsToPlayer ( playerid, s ) && g_cr_expire [ s ] > gettime ( ) ) count ++ ;
	return count ;
}

stock CR_PlayerRentSlotByOrder ( playerid, order )
{
	if ( p_info [ playerid ] [ id ] <= 0 ) return -1 ;
	new count = 0 ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		if ( g_cr_model [ s ] < 0 || ! CR_RentalBelongsToPlayer ( playerid, s ) || g_cr_expire [ s ] <= gettime ( ) ) continue ;
		if ( count == order ) return s ;
		count ++ ;
	}
	return -1 ;
}

stock CR_ShowPlayerRentals ( playerid )
{
	new body [ 1400 ] ;
	strcat ( body, "{FFFF00}السيارة\t{FFFF00}الوقت المتبقي\t{FFFF00}المكان\n" ) ;
	for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
	{
		if ( g_cr_model [ s ] < 0 || ! CR_RentalBelongsToPlayer ( playerid, s ) || g_cr_expire [ s ] <= gettime ( ) ) continue ;
		new left = g_cr_expire [ s ] - gettime ( ) ;
		new days = left / 86400 ;
		new hours = ( left % 86400 ) / 3600 ;
		new minutes = ( left % 3600 ) / 60 ;
		new remaining [ 48 ] ;
		if ( days > 0 ) format ( remaining, sizeof remaining, "%dي %dس %dد", days, hours, minutes ) ;
		else format ( remaining, sizeof remaining, "%dس %dد", hours, minutes ) ;
		new line [ 160 ] ;
		format ( line, sizeof line, "{FFFFFF}%s\t{33FF66}%s\t{AAAAAA}موقف المعرض\n", g_cr_cname [ s ], remaining ) ;
		strcat ( body, line ) ;
	}
	if ( p_info [ playerid ] [ mont_used ] == 1 && p_info [ playerid ] [ mont_car_expire ] >= gettime ( ) )
		strcat ( body, "{FFC04A}سيارة كود Mont\t{AAAAAA}مؤقتة\t{FFFFFF}استخراج السيارة\n" ) ;
	if ( trent_count_player ( playerid ) > 0 )
		strcat ( body, "{FFC04A}إيجارات مركز السيارات الأخرى\t{AAAAAA}-\t{FFFFFF}فتح القائمة\n" ) ;
	#pragma warning disable 239
	show_dialog ( playerid, d_crent_my_rentals, DIALOG_STYLE_TABLIST_HEADERS, "{FFC04A}سياراتي المستأجرة", body, "إدارة", "إغلاق" ) ;
	#pragma warning enable 239
	return 1 ;
}

stock CR_ShowPlayerRentalItem ( playerid, s )
{
	if (
		s < 0 || s >= CR_FLEET_MAX
		|| g_cr_model [ s ] < 0
		|| ! CR_RentalBelongsToPlayer ( playerid, s )
	) return 0 ;
	new title [ 96 ] ;
	format ( title, sizeof title, "{FFC04A}إدارة %s", g_cr_cname [ s ] ) ;
	#pragma warning disable 239
	show_dialog (
		playerid,
		d_crent_my_rental_item,
		DIALOG_STYLE_LIST,
		title,
		"{FFFFFF}تحديد موقع السيارة على الخريطة\n{FF5555}إرجاع السيارة للمعرض الآن {AAAAAA}(بدون استرداد)",
		"اختيار",
		"رجوع"
	) ;
	#pragma warning enable 239
	return 1 ;
}

stock CR_ReturnPlayerRental ( playerid, s )
{
	if (
		s < 0 || s >= CR_FLEET_MAX
		|| g_cr_model [ s ] < 0
		|| ! CR_RentalBelongsToPlayer ( playerid, s )
	) return 0 ;
	g_cr_renter [ s ] = 0 ;
	g_cr_rname [ s ] [ 0 ] = 0 ;
	g_cr_expire [ s ] = 0 ;
	CR_ReturnToLot ( s ) ;
	CR_SaveSlot ( s ) ;
	CR_UpdateTag ( s ) ;
	CR_UpdateLabel ( 0 ) ;
	SendClientMessage ( playerid, col_white, "{"#cGN"}[المعرض] {"#cWH"}تم إرجاع السيارة للمعرض وإنهاء الإيجار بدون استرداد." ) ;
	return 1 ;
}

// Block driving fleet cars unless you are the current renter.
// Returns 1 when the entry was blocked.
stock CR_OnEnterVehicle ( playerid, vehicleid, ispassenger )
{
	if ( ispassenger ) return 0 ;
	new s = CR_FindByVeh ( vehicleid ) ;
	if ( s < 0 ) return 0 ;
	if ( g_cr_renter [ s ] > 0 && CR_RentalBelongsToPlayer ( playerid, s ) ) return 0 ;
	if ( g_cr_renter [ s ] == 0 && CR_IsOwner ( playerid ) ) return 0 ;
	RemovePlayerFromVehicle ( playerid ) ;
	if ( g_cr_renter [ s ] > 0 )
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cGR"}هذي السيارة مؤجرة للاعب ثاني." ) ;
	else
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cGR"}سيارة معرض — أجّرها من مكتب التأجير أول." ) ;
	return 1 ;
}

// =====================  AGENCY AUCTION  =====================

stock CR_Auction_Start ( )
{
	if ( ! g_cr_auc_enabled || g_cr_auc_active || g_cr_owner > 0 ) return 0 ;
	g_cr_auc_active = 1 ;
	g_cr_auc_bid = CR_AUC_START ;
	g_cr_auc_bidder = INVALID_PLAYER_ID ;
	g_cr_auc_acc = 0 ;
	g_cr_auc_name [ 0 ] = 0 ;
	g_cr_auc_deadline = gettime ( ) + CR_AUC_SECONDS ;
	g_cr_auc_after = 0 ;
	g_cr_auc_notice = 0 ;
	CR_SaveMain ( ) ;
	new msg [ 230 ] ;
	format ( msg, sizeof msg, "{"#cGD"}[مزاد المعرض] {"#cWH"}بدأ مزاد معرض تأجير السيارات! السعر الافتتاحي {"#cGN"}$%d{"#cWH"} — للمزايدة اكتب {"#cGN"}/z %d{"#cWH"} (الزيادة $%d).", CR_AUC_START, CR_AUC_START, CR_AUC_INC ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	CR_UpdateLabel ( CR_AUC_SECONDS ) ;
	return 1 ;
}

stock CR_Auction_End ( )
{
	g_cr_auc_active = 0 ;
	new msg [ 230 ] ;
	if ( g_cr_auc_acc <= 0 )
	{
		SendClientMessageToAll ( col_gray, "{"#cGD"}[مزاد المعرض] {"#cWH"}انتهى المزاد بدون أي مزايدة — المعرض ما زال بدون مالك." ) ;
		CR_ScheduleNextDailyAuction ( ) ;
		return ;
	}
	new pid = g_cr_auc_bidder ;
	if ( pid == INVALID_PLAYER_ID || ! IsPlayerConnected ( pid ) || p_info [ pid ] [ id ] != g_cr_auc_acc || p_info [ pid ] [ money ] < g_cr_auc_bid )
	{
		format ( msg, sizeof msg, "{"#cGD"}[مزاد المعرض] {"#cWH"}انتهى المزاد لكن الفائز %s غير متصل أو لا يملك المبلغ — أُلغيت النتيجة.", g_cr_auc_name ) ;
		SendClientMessageToAll ( col_gray, msg ) ;
		CR_ScheduleNextDailyAuction ( ) ;
		return ;
	}
	give_money ( pid, - g_cr_auc_bid ) ;
	insert_money_log ( pid, INVALID_PLAYER_ID, - g_cr_auc_bid, "rental agency auction purchase" ) ;
	g_cr_owner = g_cr_auc_acc ;
	format ( g_cr_owner_name, MAX_PLAYER_NAME, "%s", g_cr_auc_name ) ;
	CR_SaveMain ( ) ;
	format ( msg, sizeof msg, "{"#cGD"}[مزاد المعرض] {"#cWH"}انتهى المزاد! {"#cGN"}%s {"#cWH"}اشترى معرض تأجير السيارات بمبلغ {"#cGN"}$%d {"#cWH"}وأصبح مالكه الجديد!", g_cr_owner_name, g_cr_auc_bid ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	SendClientMessage ( pid, col_white, "{"#cGN"}* {"#cWH"}مبروك! أصبحت مالك معرض التأجير — قف بالنقطة الحمراء عند المكتب لفتح لوحة التحكم." ) ;
	CR_UpdateLabel ( 0 ) ;
}

// /z <amount> — returns 1 when consumed
stock CR_Auction_TryBid ( playerid, const params [ ] )
{
	if ( ! g_cr_auc_active ) return 0 ;
	if ( ! strlen ( params ) )
	{
		new required = ( g_cr_auc_acc > 0 ) ? ( g_cr_auc_bid + CR_AUC_INC ) : CR_AUC_START ;
		new msg [ 180 ] ;
		format ( msg, sizeof msg, "{"#cGD"}[مزاد المعرض] {"#cWH"}للمزايدة اكتب {"#cGN"}/z %d{"#cWH"} (أقل مزايدة مقبولة).", required ) ;
		SendClientMessage ( playerid, col_white, msg ) ;
		return 1 ;
	}
	new amount = strval ( params ) ;
	if ( amount <= 0 ) return 0 ;
	new required = ( g_cr_auc_acc > 0 ) ? ( g_cr_auc_bid + CR_AUC_INC ) : CR_AUC_START ;
	new msg [ 200 ] ;
	if ( p_info [ playerid ] [ id ] <= 0 )
	{
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لازم تكون مسجل دخول للمزايدة." ) ;
		return 1 ;
	}
	if ( g_cr_auc_acc > 0 && p_info [ playerid ] [ id ] == g_cr_auc_acc )
	{
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}أنت صاحب أعلى مزايدة أصلاً." ) ;
		return 1 ;
	}
	if ( amount < required )
	{
		format ( msg, sizeof msg, "{"#cRD"}* {"#cWH"}المزايدة أقل من المطلوب — أقل مزايدة مقبولة: {"#cGN"}$%d{"#cWH"}.", required ) ;
		SendClientMessage ( playerid, col_gray, msg ) ;
		return 1 ;
	}
	if ( ( amount - CR_AUC_START ) % CR_AUC_INC != 0 )
	{
		format ( msg, sizeof msg, "{"#cRD"}* {"#cWH"}المزايدة تكون بمضاعفات {"#cGN"}$%d {"#cWH"}(مثال: /z %d).", CR_AUC_INC, required ) ;
		SendClientMessage ( playerid, col_gray, msg ) ;
		return 1 ;
	}
	if ( p_info [ playerid ] [ money ] < amount )
	{
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما معك كاش كافي لهذي المزايدة." ) ;
		return 1 ;
	}
	g_cr_auc_bid = amount ;
	g_cr_auc_bidder = playerid ;
	g_cr_auc_acc = p_info [ playerid ] [ id ] ;
	format ( g_cr_auc_name, MAX_PLAYER_NAME, "%s", p_info [ playerid ] [ name ] ) ;
	g_cr_auc_deadline = gettime ( ) + CR_AUC_SECONDS ;
	format ( msg, sizeof msg, "{"#cGD"}[مزاد المعرض] {"#cGN"}%s {"#cWH"}زايد بمبلغ {"#cGN"}$%d{"#cWH"}! الوقت رجع {"#cRD"}%d ثانية{"#cWH"} — للمزايدة: {"#cGN"}/z %d", g_cr_auc_name, amount, CR_AUC_SECONDS, amount + CR_AUC_INC ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	CR_UpdateLabel ( CR_AUC_SECONDS ) ;
	return 1 ;
}

forward CR_Tick ( ) ;
public CR_Tick ( )
{
	static cr_vehicle_gate = 0 ;
	cr_vehicle_gate ++ ;
	if ( cr_vehicle_gate >= 5 )
	{
		cr_vehicle_gate = 0 ;
		for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		{
			if ( g_cr_model [ s ] < 0 || ! IsValidVehicle ( g_cr_veh [ s ] ) ) continue ;
			new vehicleid = g_cr_veh [ s ] ;
			veh_info [ vehicleid - 1 ] [ v_type ] = CR_VEHICLE_TYPE ;
			veh_info [ vehicleid - 1 ] [ v_owner ] = 0 ;
			if ( veh_info [ vehicleid - 1 ] [ v_fuel ] < 5.0 )
				veh_info [ vehicleid - 1 ] [ v_fuel ] = 100.0 ;
		}
	}
	// rent expiry (checked once a second)
	static cr_exp_gate = 0 ;
	cr_exp_gate ++ ;
	if ( cr_exp_gate >= 10 )
	{
		cr_exp_gate = 0 ;
		new now = gettime ( ) ;
		for ( new s = 0 ; s < CR_FLEET_MAX ; s ++ )
		{
			if ( g_cr_model [ s ] < 0 || g_cr_renter [ s ] == 0 ) continue ;
			if ( g_cr_expire [ s ] > now ) continue ;
			new racc = g_cr_renter [ s ] ;
			g_cr_renter [ s ] = 0 ;
			g_cr_rname [ s ] [ 0 ] = 0 ;
			g_cr_expire [ s ] = 0 ;
			CR_ReturnToLot ( s ) ;
			CR_SaveSlot ( s ) ;
			CR_UpdateTag ( s ) ;
			CR_UpdateLabel ( 0 ) ;
			for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
				if ( IsPlayerConnected ( i ) && p_info [ i ] [ id ] == racc )
				{
					SendClientMessage ( i, col_gray, "{"#cRD"}[المعرض] {"#cWH"}انتهت مدة إيجار سيارتك ورجعت للمعرض." ) ;
					break ;
				}
		}
	}
	// auction
	if ( ! g_cr_auc_active )
	{
		new now = gettime ( ) ;
		if ( g_cr_auc_enabled && g_cr_owner == 0 && g_cr_auc_after > 0 )
		{
			new left = g_cr_auc_after - now ;
			if ( left <= 0 )
			{
				CR_Auction_Start ( ) ;
				return 1 ;
			}
			if ( left <= 10 && g_cr_auc_notice < 3 )
			{
				g_cr_auc_notice = 3 ;
				SendClientMessageToAll ( col_white, "{"#cGD"}[مزاد المعرض] {"#cWH"}مزاد معرض تأجير السيارات يبدأ خلال {"#cRD"}10 ثوانٍ{"#cWH"}!" ) ;
			}
			else if ( left <= 60 && g_cr_auc_notice < 2 )
			{
				g_cr_auc_notice = 2 ;
				SendClientMessageToAll ( col_white, "{"#cGD"}[مزاد المعرض] {"#cWH"}مزاد معرض تأجير السيارات يبدأ خلال {"#cGD"}دقيقة واحدة{"#cWH"}." ) ;
			}
			else if ( left <= 300 && g_cr_auc_notice < 1 )
			{
				g_cr_auc_notice = 1 ;
				SendClientMessageToAll ( col_white, "{"#cGD"}[مزاد المعرض] {"#cWH"}مزاد معرض تأجير السيارات يبدأ خلال {"#cGD"}5 دقائق{"#cWH"} — جهّز الكاش." ) ;
			}
			CR_UpdateLabel ( left ) ;
		}
		return 1 ;
	}
	new left = g_cr_auc_deadline - gettime ( ) ;
	if ( left <= 0 )
	{
		CR_Auction_End ( ) ;
		return 1 ;
	}
	CR_UpdateLabel ( left ) ;
	return 1 ;
}

// =====================  DIALOG / PANEL DISPATCH  =====================

stock CR_HandleAction ( playerid, const inputtext [ ] )
{
	new cmd [ 24 ], a1 = -1, a2 = -1 ;
	new n = sscanf ( inputtext, "s[24]D(-1)D(-1)", cmd, a1, a2 ) ;
	#pragma unused n
	if ( ! strcmp ( cmd, "PONG", true ) ) return 1 ;
	if ( ! strcmp ( cmd, "CLOSE", true ) ) { CR_ClosePanel ( playerid ) ; return 1 ; }
	if ( ! strcmp ( cmd, "REFRESH", true ) ) { CR_ShowPanel ( playerid ) ; return 1 ; }
	if ( ! strcmp ( cmd, "MENU", true ) )
	{
		if ( CR_IsOwner ( playerid ) ) CR_ShowOwnerMenu ( playerid ) ;
		else CR_ShowRentList ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "RENT", true ) ) { CR_DoRent ( playerid, a2, a1 ) ; CR_ShowPanel ( playerid ) ; return 1 ; }
	if ( ! strcmp ( cmd, "ADD", true ) )
	{
		new vehid = -1, hp = -1, dp = -1, aname [ 28 ] ;
		new m2 = sscanf ( inputtext, "s[24]D(-1)D(-1)D(-1)S(-)[28]", cmd, vehid, hp, dp, aname ) ;
		#pragma unused m2
		if ( ! strcmp ( aname, "-" ) ) aname [ 0 ] = 0 ;
		CR_DoAdd ( playerid, vehid, hp, dp, aname ) ;
		CR_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "REM", true ) ) { CR_DoRemove ( playerid, a1 ) ; CR_ShowPanel ( playerid ) ; return 1 ; }
	if ( ! strcmp ( cmd, "KICK", true ) ) { CR_DoKick ( playerid, a1 ) ; CR_ShowPanel ( playerid ) ; return 1 ; }
	if ( ! strcmp ( cmd, "PN", true ) )
	{
		new slot = -1, car_name [ 28 ] ;
		new parsed = sscanf ( inputtext, "s[24]D(-1)S(-)[28]", cmd, slot, car_name ) ;
		#pragma unused parsed
		if ( strcmp ( car_name, "-" ) ) CR_SetCarName ( playerid, slot, car_name ) ;
		CR_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "PH", true ) )
	{
		if ( CR_IsOwner ( playerid ) && a1 >= 0 && a1 < CR_FLEET_MAX && g_cr_model [ a1 ] >= 0 && a2 > 0 && a2 <= 1000000 )
		{
			g_cr_hourp [ a1 ] = a2 ;
			CR_SaveSlot ( a1 ) ;
			CR_UpdateTag ( a1 ) ;
		}
		CR_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "PD", true ) )
	{
		if ( CR_IsOwner ( playerid ) && a1 >= 0 && a1 < CR_FLEET_MAX && g_cr_model [ a1 ] >= 0 && a2 > 0 && a2 <= 10000000 )
		{
			g_cr_dayp [ a1 ] = a2 ;
			CR_SaveSlot ( a1 ) ;
			CR_UpdateTag ( a1 ) ;
		}
		CR_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "PP", true ) )
	{
		new slot = -1, hp = -1, dp = -1 ;
		new m = sscanf ( inputtext, "s[24]D(-1)D(-1)D(-1)", cmd, slot, hp, dp ) ;
		#pragma unused m
		if ( CR_IsOwner ( playerid ) && slot >= 0 && slot < CR_FLEET_MAX && g_cr_model [ slot ] >= 0 )
		{
			if ( hp > 0 && hp <= 1000000 ) g_cr_hourp [ slot ] = hp ;
			if ( dp > 0 && dp <= 10000000 ) g_cr_dayp [ slot ] = dp ;
			CR_SaveSlot ( slot ) ;
			CR_UpdateTag ( slot ) ;
		}
		CR_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "WITHDRAW", true ) )
	{
		if ( CR_IsOwner ( playerid ) && a1 > 0 && a1 <= g_cr_treasury )
		{
			g_cr_treasury -= a1 ;
			CR_SaveMain ( ) ;
			give_money ( playerid, a1 ) ;
			insert_money_log ( playerid, INVALID_PLAYER_ID, a1, "rental agency treasury withdraw" ) ;
			new msg [ 150 ] ;
			format ( msg, sizeof msg, "{"#cGN"}[المعرض] {"#cWH"}سحبت {"#cGN"}$%d {"#cWH"}من الخزينة (المتبقي: $%d).", a1, g_cr_treasury ) ;
			SendClientMessage ( playerid, col_white, msg ) ;
		}
		CR_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "DEPOSIT", true ) )
	{
		if ( CR_IsOwner ( playerid ) && a1 > 0 && p_info [ playerid ] [ money ] >= a1 )
		{
			give_money ( playerid, - a1 ) ;
			insert_money_log ( playerid, INVALID_PLAYER_ID, - a1, "rental agency treasury deposit" ) ;
			g_cr_treasury += a1 ;
			CR_SaveMain ( ) ;
			new msg [ 150 ] ;
			format ( msg, sizeof msg, "{"#cGN"}[المعرض] {"#cWH"}أودعت {"#cGN"}$%d {"#cWH"}في الخزينة (الرصيد: $%d).", a1, g_cr_treasury ) ;
			SendClientMessage ( playerid, col_white, msg ) ;
		}
		CR_ShowPanel ( playerid ) ;
		return 1 ;
	}
	#pragma unused a2
	CR_ShowPanel ( playerid ) ;
	return 1 ;
}

stock CR_OnDialogResponse ( playerid, dialogid, response, listitem, const inputtext [ ] )
{
	if ( dialogid == d_crent_panel )
	{
		if ( ! response ) return 1 ;
		if ( ! strlen ( inputtext ) )
		{
			if ( CR_IsOwner ( playerid ) ) CR_ShowOwnerMenu ( playerid ) ;
			else CR_ShowRentList ( playerid ) ;
			return 1 ;
		}
		CR_HandleAction ( playerid, inputtext ) ;
		return 1 ;
	}
	if ( dialogid == d_crent_owner )
	{
		if ( ! response ) return 1 ;
		if ( ! CR_IsOwner ( playerid ) ) return 1 ;
		switch ( listitem )
		{
			case 3: CR_ShowMyCars ( playerid ) ;
			case 4: CR_ShowFleetMenu ( playerid ) ;
			case 5: CR_ShowInput ( playerid, 3 ) ;
			case 6: CR_ShowInput ( playerid, 4 ) ;
			default: CR_ShowOwnerMenu ( playerid ) ;
		}
		return 1 ;
	}
	if ( dialogid == d_crent_buy )
	{
		if ( ! response ) { CR_ShowOwnerMenu ( playerid ) ; return 1 ; }
		new mv = CR_MyCarByOrder ( playerid, listitem ) ;
		if ( mv > 0 ) CR_DoAdd ( playerid, mv, 500, 7500, "" ) ;
		CR_ShowOwnerMenu ( playerid ) ;
		return 1 ;
	}
	if ( dialogid == d_crent_fleet )
	{
		if ( ! response ) { CR_ShowOwnerMenu ( playerid ) ; return 1 ; }
		new s = CR_FleetSlotByOrder ( listitem ) ;
		if ( s < 0 ) { CR_ShowOwnerMenu ( playerid ) ; return 1 ; }
		g_cr_sel_slot [ playerid ] = s ;
		CR_ShowFleetItem ( playerid, s ) ;
		return 1 ;
	}
	if ( dialogid == d_crent_fleet_item )
	{
		if ( ! response ) { CR_ShowFleetMenu ( playerid ) ; return 1 ; }
		new s = g_cr_sel_slot [ playerid ] ;
		if ( s < 0 || s >= CR_FLEET_MAX || g_cr_model [ s ] < 0 ) { CR_ShowFleetMenu ( playerid ) ; return 1 ; }
		switch ( listitem )
		{
			case 0: CR_ShowInput ( playerid, 5 ) ;
			case 1: CR_ShowInput ( playerid, 1 ) ;
			case 2: CR_ShowInput ( playerid, 2 ) ;
			case 3: { CR_ReturnToLot ( s ) ; SendClientMessage ( playerid, col_white, "{"#cGN"}* {"#cWH"}رجعت السيارة للموقف." ) ; CR_ShowFleetMenu ( playerid ) ; }
			case 4: { CR_DoKick ( playerid, s ) ; CR_ShowFleetMenu ( playerid ) ; }
			case 5: { CR_DoRemove ( playerid, s ) ; CR_ShowFleetMenu ( playerid ) ; }
		}
		return 1 ;
	}
	if ( dialogid == d_crent_input )
	{
		new act = g_cr_sel_act [ playerid ] ;
		g_cr_sel_act [ playerid ] = 0 ;
		if ( ! response )
		{
			if ( act == 1 || act == 2 || act == 5 ) CR_ShowFleetItem ( playerid, g_cr_sel_slot [ playerid ] ) ;
			else CR_ShowOwnerMenu ( playerid ) ;
			return 1 ;
		}
		new v = strval ( inputtext ) ;
		new s = g_cr_sel_slot [ playerid ] ;
		switch ( act )
		{
			case 1:
			{
				if ( CR_IsOwner ( playerid ) && s >= 0 && s < CR_FLEET_MAX && g_cr_model [ s ] >= 0 && v > 0 && v <= 1000000 )
				{
					g_cr_hourp [ s ] = v ;
					CR_SaveSlot ( s ) ;
					CR_UpdateTag ( s ) ;
					SendClientMessage ( playerid, col_white, "{"#cGN"}* {"#cWH"}تم تحديث سعر الساعة." ) ;
				}
				CR_ShowFleetItem ( playerid, s ) ;
			}
			case 2:
			{
				if ( CR_IsOwner ( playerid ) && s >= 0 && s < CR_FLEET_MAX && g_cr_model [ s ] >= 0 && v > 0 && v <= 10000000 )
				{
					g_cr_dayp [ s ] = v ;
					CR_SaveSlot ( s ) ;
					CR_UpdateTag ( s ) ;
					SendClientMessage ( playerid, col_white, "{"#cGN"}* {"#cWH"}تم تحديث سعر اليوم." ) ;
				}
				CR_ShowFleetItem ( playerid, s ) ;
			}
			case 3:
			{
				new buf [ 16 ] ;
				format ( buf, sizeof buf, "%d", v ) ;
				new cmdbuf [ 32 ] ;
				format ( cmdbuf, sizeof cmdbuf, "WITHDRAW %d", v ) ;
				CR_HandleAction ( playerid, cmdbuf ) ;
			}
			case 4:
			{
				new cmdbuf [ 32 ] ;
				format ( cmdbuf, sizeof cmdbuf, "DEPOSIT %d", v ) ;
				CR_HandleAction ( playerid, cmdbuf ) ;
			}
			case 5:
			{
				CR_SetCarName ( playerid, s, inputtext ) ;
				CR_ShowFleetItem ( playerid, s ) ;
			}
		}
		return 1 ;
	}
	if ( dialogid == d_crent_my_rentals )
	{
		if ( ! response ) return 1 ;
		new count = CR_PlayerRentCount ( playerid ) ;
		if ( listitem < count )
		{
			new s = CR_PlayerRentSlotByOrder ( playerid, listitem ) ;
			if ( s < 0 ) return CR_ShowPlayerRentals ( playerid ) ;
			g_cr_sel_slot [ playerid ] = s ;
			CR_ShowPlayerRentalItem ( playerid, s ) ;
			return 1 ;
		}
		new offset = count ;
		if ( p_info [ playerid ] [ mont_used ] == 1 && p_info [ playerid ] [ mont_car_expire ] >= gettime ( ) )
		{
			if ( listitem == offset ) return Mont_SpawnCar ( playerid ) ;
			offset ++ ;
		}
		if ( listitem == offset && trent_count_player ( playerid ) > 0 ) trent_show_manage ( playerid ) ;
		return 1 ;
	}
	if ( dialogid == d_crent_my_rental_item )
	{
		if ( ! response ) return CR_ShowPlayerRentals ( playerid ) ;
		new s = g_cr_sel_slot [ playerid ] ;
		if (
			s < 0 || s >= CR_FLEET_MAX
			|| g_cr_model [ s ] < 0
			|| g_cr_renter [ s ] != p_info [ playerid ] [ id ]
		) return CR_ShowPlayerRentals ( playerid ) ;
		switch ( listitem )
		{
			case 0:
			{
				if ( g_cr_veh [ s ] != INVALID_VEHICLE_ID )
				{
					new Float:x, Float:y, Float:z ;
					GetVehiclePos ( g_cr_veh [ s ], x, y, z ) ;
					SetPlayerCheckpoint ( playerid, x, y, z, 4.0 ) ;
					SendClientMessage ( playerid, col_white, "{"#cGN"}[المعرض] {"#cWH"}تم تحديد موقع سيارتك المستأجرة على الخريطة." ) ;
				}
				CR_ShowPlayerRentalItem ( playerid, s ) ;
			}
			case 1:
			{
				CR_ReturnPlayerRental ( playerid, s ) ;
				if ( CR_PlayerRentCount ( playerid ) > 0 ) CR_ShowPlayerRentals ( playerid ) ;
			}
		}
		return 1 ;
	}
	if ( dialogid == d_crent_rent_list )
	{
		if ( ! response ) return 1 ;
		new s = CR_AvailSlotByOrder ( listitem ) ;
		if ( s < 0 ) { CR_ShowRentList ( playerid ) ; return 1 ; }
		g_cr_sel_slot [ playerid ] = s ;
		CR_ShowRentDur ( playerid ) ;
		return 1 ;
	}
	if ( dialogid == d_crent_rent_dur )
	{
		if ( ! response ) { CR_ShowRentList ( playerid ) ; return 1 ; }
		CR_DoRent ( playerid, listitem ) ;
		return 1 ;
	}
	return 0 ;
}

// ---- owner-to-player agency sale (/crsell + /craccept) ----
new g_cr_sell_to    = INVALID_PLAYER_ID ;
new g_cr_sell_price = 0 ;
new g_cr_sell_time  = 0 ;

CMD:crsell ( playerid, params [ ] )
{
	if ( ! CR_IsOwner ( playerid ) )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}أمر بيع المعرض لمالكه فقط." ) ;
	if ( g_cr_auc_active )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما تقدر تبيع المعرض أثناء المزاد." ) ;
	new target, price ;
	if ( sscanf ( params, "ud", target, price ) )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}استخدم: {"#cGR"}/crsell [ID اللاعب] [السعر]" ) ;
	if ( target == INVALID_PLAYER_ID || ! IsPlayerConnected ( target ) || target == playerid )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لاعب غير متصل." ) ;
	if ( price < 0 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}سعر غير صحيح." ) ;
	if ( p_info [ target ] [ id ] <= 0 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اللاعب غير مسجل دخول." ) ;
	g_cr_sell_to = target ;
	g_cr_sell_price = price ;
	g_cr_sell_time = gettime ( ) ;
	new msg [ 230 ] ;
	format ( msg, sizeof msg, "{"#cGN"}* {"#cWH"}عرضت بيع المعرض على {"#cGN"}%s{"#cWH"} بمبلغ {"#cGN"}$%d{"#cWH"} — عنده 60 ثانية للقبول بـ /craccept.", p_info [ target ] [ name ], price ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	format ( msg, sizeof msg, "{"#cGD"}[المعرض] {"#cWH"}%s يعرض عليك شراء معرض تأجير السيارات بمبلغ {"#cGN"}$%d{"#cWH"} — للقبول اكتب {"#cGN"}/craccept{"#cWH"} خلال 60 ثانية.", g_cr_owner_name, price ) ;
	SendClientMessage ( target, col_white, msg ) ;
	return 1 ;
}

CMD:craccept ( playerid, params [ ] )
{
	#pragma unused params
	if ( g_cr_sell_to != playerid || gettime ( ) - g_cr_sell_time > 60 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما في عرض بيع للمعرض باسمك (أو انتهت مدته)." ) ;
	if ( p_info [ playerid ] [ money ] < g_cr_sell_price )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما معك كاش كافي." ) ;
	new ownerid = INVALID_PLAYER_ID ;
	for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
		if ( IsPlayerConnected ( i ) && p_info [ i ] [ id ] == g_cr_owner ) { ownerid = i ; break ; }
	if ( ownerid == INVALID_PLAYER_ID )
	{
		g_cr_sell_to = INVALID_PLAYER_ID ;
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}المالك غير متصل — أُلغي العرض." ) ;
	}
	if ( g_cr_sell_price > 0 )
	{
		give_money ( playerid, - g_cr_sell_price ) ;
		give_money ( ownerid, g_cr_sell_price ) ;
		insert_money_log ( playerid, ownerid, g_cr_sell_price, "rental agency sale" ) ;
	}
	g_cr_owner = p_info [ playerid ] [ id ] ;
	format ( g_cr_owner_name, MAX_PLAYER_NAME, "%s", p_info [ playerid ] [ name ] ) ;
	CR_SaveMain ( ) ;
	g_cr_sell_to = INVALID_PLAYER_ID ;
	g_cr_sell_price = 0 ;
	new msg [ 200 ] ;
	format ( msg, sizeof msg, "{"#cGD"}[المعرض] {"#cGN"}%s {"#cWH"}اشترى معرض تأجير السيارات وأصبح مالكه الجديد!", g_cr_owner_name ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	CR_UpdateLabel ( 0 ) ;
	return 1 ;
}

CMD:crauction ( playerid, params [ ] )
{
	#pragma unused params
	if ( p_info [ playerid ] [ admin ] < 3 ) return 1 ;
	if ( ! g_cr_auc_enabled ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}نظام مزاد معرض التأجير متوقف حالياً." ) ;
	if ( g_cr_auc_active ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}المزاد شغال أصلاً." ) ;
	CR_Auction_Start ( ) ;
	return 1 ;
}

CMD:setcrowner ( playerid, params [ ] )
{
	if ( p_info [ playerid ] [ admin ] < 5 ) return 1 ;
	if ( sscanf ( params, "d", params [ 0 ] ) ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cGR"}الاستخدام: /setcrowner [ID] (أو -1 لإزالة المالك)" ) ;
	new t = strval ( params ) ;
	if ( t == -1 )
	{
		g_cr_owner = 0 ;
		g_cr_owner_name [ 0 ] = 0 ;
		CR_ScheduleBootstrapAuction ( ) ;
		if ( g_cr_auc_enabled ) return SendClientMessage ( playerid, col_white, "{"#cGN"}* {"#cWH"}تمت إزالة مالك المعرض وجدولة المزاد بعد 9 دقائق." ) ;
		return SendClientMessage ( playerid, col_white, "{"#cGN"}* {"#cWH"}تمت إزالة مالك المعرض، ونظام المزاد متوقف حالياً." ) ;
	}
	if ( ! IsPlayerConnected ( t ) || p_info [ t ] [ id ] <= 0 ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لاعب غير متصل." ) ;
	g_cr_owner = p_info [ t ] [ id ] ;
	format ( g_cr_owner_name, MAX_PLAYER_NAME, "%s", p_info [ t ] [ name ] ) ;
	CR_SaveMain ( ) ;
	CR_UpdateLabel ( 0 ) ;
	new msg [ 150 ] ;
	format ( msg, sizeof msg, "{"#cGN"}* {"#cWH"}تم تعيين {"#cGN"}%s {"#cWH"}مالكاً للمعرض.", p_info [ t ] [ name ] ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	return 1 ;
}
