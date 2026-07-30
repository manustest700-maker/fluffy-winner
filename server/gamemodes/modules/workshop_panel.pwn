/*
 *  Mechanic Workshop Control Panel (HavanaRP)
 *  ===========================================
 *  Launcher-driven "Windows PC" control panel for the mechanic workshop.
 *
 *  - Workshop treasury: the workshop share of every tuning payment
 *    (everything except the mechanic's commission) is deposited here.
 *  - Only the workshop OWNER can withdraw money or hire/fire staff.
 *  - Staff: up to 5 employed mechanics, with hire date / jobs / revenue stats.
 *
 *  Dialog channel (launcher intercepts by title):
 *    [!WSHOP_OPEN]   d_wshop_menu  body:
 *        WS:<owner_name>|<treasury>|<isowner>|<viewer_name>
 *        EMP:<slot>|<name>|<days>|<jobs>|<earned>|<online>
 *        CAND:<playerid>|<name>
 *    answer: response=1 + inputtext subcommand:
 *        REFRESH | CLOSE | HIRE <playerid> | FIRE <slot> | WITHDRAW <amount>
 *    [!WSHOP_CLOSE]  sentinel to hide the overlay
 */

#if !defined cGD
	#define cGD FFD700
#endif

#define WS_MAX_STAFF          5
#define WS_SHOP_X             973.715148
#define WS_SHOP_Y             (-1270.737060)
#define WS_SHOP_Z             15.063035
#define WS_GARAGE_X           1196.764160
#define WS_GARAGE_Y           994.289611
#define WS_GARAGE_Z           998.398437
#define WS_RANGE              30.0

// ---- Workshop auction (buying the workshop) ----
// kept in the script for later use; daily auto-start is disabled and the
// auction can only be launched manually by an admin with /wsauction.
#define WS_AUC_AUTO_DAILY     0           // 1 = auction opens daily at WS_AUC_HOUR
#define WS_AUC_HOUR           17          // auction opens daily at 17:00 (5 PM)
#define WS_AUC_START          150000      // opening price
#define WS_AUC_INC            50000       // minimum raise per bid
#define WS_AUC_SECONDS        30          // countdown; every valid bid resets it

new g_ws_auc_active   = 0 ;
new g_ws_auc_bid      = 0 ;               // current highest bid
new g_ws_auc_bidder   = INVALID_PLAYER_ID ;  // current leader (playerid)
new g_ws_auc_acc      = 0 ;               // current leader account id
new g_ws_auc_name [ MAX_PLAYER_NAME + 1 ] ;
new g_ws_auc_deadline = 0 ;               // gettime() at which the auction ends
new g_ws_auc_last_day = -1 ;              // getdate() day the auction last opened
new STREAMER_TAG_3D_TEXT_LABEL:g_ws_auc_label = STREAMER_TAG_3D_TEXT_LABEL:0 ; // label above the entrance pickup

new g_ws_owner = 0 ;                          // owner account id (users.u_id), 0 = none
new g_ws_owner_name [ MAX_PLAYER_NAME + 1 ] ;
new g_ws_treasury = 0 ;
new g_ws_acc    [ WS_MAX_STAFF ] ;            // staff account ids (0 = empty slot)
new g_ws_name   [ WS_MAX_STAFF ] [ MAX_PLAYER_NAME + 1 ] ;
new g_ws_hired  [ WS_MAX_STAFF ] ;            // gettime() at hire
new g_ws_jobs   [ WS_MAX_STAFF ] ;            // completed tuning jobs
new g_ws_earned [ WS_MAX_STAFF ] ;            // total revenue generated

stock bool:WS_AtWorkshop ( playerid )
{
	if ( IsPlayerInRangeOfPoint ( playerid, WS_RANGE, WS_SHOP_X, WS_SHOP_Y, WS_SHOP_Z ) ) return true ;
	if ( IsPlayerInRangeOfPoint ( playerid, WS_RANGE, WS_GARAGE_X, WS_GARAGE_Y, WS_GARAGE_Z ) ) return true ;
	return false ;
}

stock WS_StaffSlotByAcc ( acc )
{
	if ( acc <= 0 ) return - 1 ;
	for ( new s = 0 ; s < WS_MAX_STAFF ; s ++ )
		if ( g_ws_acc [ s ] == acc ) return s ;
	return - 1 ;
}

stock WS_StaffCount ( )
{
	new c = 0 ;
	for ( new s = 0 ; s < WS_MAX_STAFF ; s ++ )
		if ( g_ws_acc [ s ] != 0 ) c ++ ;
	return c ;
}

stock bool:WS_IsOwner ( playerid )
{
	return ( g_ws_owner > 0 && p_info [ playerid ] [ id ] == g_ws_owner ) ;
}

stock bool:WS_IsStaff ( playerid )
{
	return ( WS_StaffSlotByAcc ( p_info [ playerid ] [ id ] ) != - 1 ) ;
}

stock WS_SaveMain ( )
{
	new q [ 256 ] ;
	format ( q, sizeof q, "UPDATE `mech_workshop` SET `owner` = '%d', `owner_name` = '%s', `treasury` = '%d' WHERE `id` = 1 LIMIT 1", g_ws_owner, g_ws_owner_name, g_ws_treasury ) ;
	mysql_tquery ( sql_connection, q, "", "" ) ;
}

stock WS_SaveStaff ( s )
{
	new q [ 300 ] ;
	if ( g_ws_acc [ s ] == 0 )
		format ( q, sizeof q, "DELETE FROM `mech_workshop_staff` WHERE `slot` = '%d' LIMIT 1", s ) ;
	else
		format ( q, sizeof q, "REPLACE INTO `mech_workshop_staff` (`slot`,`acc`,`name`,`hired`,`jobs`,`earned`) VALUES ('%d','%d','%s','%d','%d','%d')", s, g_ws_acc [ s ], g_ws_name [ s ], g_ws_hired [ s ], g_ws_jobs [ s ], g_ws_earned [ s ] ) ;
	mysql_tquery ( sql_connection, q, "", "" ) ;
}

forward WS_OnLoadMain ( ) ;
public WS_OnLoadMain ( )
{
	if ( cache_num_rows ( ) > 0 )
	{
		g_ws_owner = cache_get_field_content_int ( 0, "owner", sql_connection ) ;
		cache_get_field_content ( 0, "owner_name", g_ws_owner_name, sql_connection, MAX_PLAYER_NAME ) ;
		g_ws_treasury = cache_get_field_content_int ( 0, "treasury", sql_connection ) ;
		WS_Auction_UpdateLabel ( 0 ) ;
	}
	else mysql_tquery ( sql_connection, "INSERT INTO `mech_workshop` (`id`,`owner`,`owner_name`,`treasury`) VALUES (1,0,'',0)", "", "" ) ;
	return 1 ;
}

forward WS_OnLoadStaff ( ) ;
public WS_OnLoadStaff ( )
{
	new rows = cache_num_rows ( ) ;
	for ( new i = 0 ; i < rows ; i ++ )
	{
		new s = cache_get_field_content_int ( i, "slot", sql_connection ) ;
		if ( s < 0 || s >= WS_MAX_STAFF ) continue ;
		g_ws_acc [ s ] = cache_get_field_content_int ( i, "acc", sql_connection ) ;
		cache_get_field_content ( i, "name", g_ws_name [ s ], sql_connection, MAX_PLAYER_NAME ) ;
		g_ws_hired [ s ] = cache_get_field_content_int ( i, "hired", sql_connection ) ;
		g_ws_jobs [ s ] = cache_get_field_content_int ( i, "jobs", sql_connection ) ;
		g_ws_earned [ s ] = cache_get_field_content_int ( i, "earned", sql_connection ) ;
	}
	return 1 ;
}

stock WS_Init ( )
{
	for ( new s = 0 ; s < WS_MAX_STAFF ; s ++ )
	{
		g_ws_acc [ s ] = 0 ;
		g_ws_name [ s ] [ 0 ] = 0 ;
		g_ws_hired [ s ] = 0 ;
		g_ws_jobs [ s ] = 0 ;
		g_ws_earned [ s ] = 0 ;
	}
	mysql_tquery ( sql_connection, "CREATE TABLE IF NOT EXISTS `mech_workshop` (`id` INT NOT NULL, `owner` INT NOT NULL DEFAULT 0, `owner_name` VARCHAR(32) NOT NULL DEFAULT '', `treasury` INT NOT NULL DEFAULT 0, PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8", "", "" ) ;
	mysql_tquery ( sql_connection, "CREATE TABLE IF NOT EXISTS `mech_workshop_staff` (`slot` INT NOT NULL, `acc` INT NOT NULL, `name` VARCHAR(32) NOT NULL DEFAULT '', `hired` INT NOT NULL DEFAULT 0, `jobs` INT NOT NULL DEFAULT 0, `earned` INT NOT NULL DEFAULT 0, PRIMARY KEY (`slot`)) ENGINE=InnoDB DEFAULT CHARSET=utf8", "", "" ) ;
	mysql_tquery ( sql_connection, "SELECT * FROM `mech_workshop` WHERE `id` = 1 LIMIT 1", "WS_OnLoadMain", "" ) ;
	mysql_tquery ( sql_connection, "SELECT * FROM `mech_workshop_staff`", "WS_OnLoadStaff", "" ) ;
}

// Deposit the workshop share of a tuning payment + update the mechanic's stats.
stock WS_OnTuneIncome ( mechid, price, cut )
{
	new share = price - cut ;
	if ( share > 0 )
	{
		g_ws_treasury += share ;
		WS_SaveMain ( ) ;
	}
	new s = WS_StaffSlotByAcc ( p_info [ mechid ] [ id ] ) ;
	if ( s != - 1 )
	{
		g_ws_jobs [ s ] ++ ;
		g_ws_earned [ s ] += price ;
		WS_SaveStaff ( s ) ;
	}
}

// Push (or refresh) the control panel overlay.
stock WS_ShowPanel ( playerid )
{
	new isowner = WS_IsOwner ( playerid ) ? 1 : 0 ;
	new body [ 1024 ] ;
	format ( body, sizeof body, "WS:%s|%d|%d|%s\n",
		( g_ws_owner > 0 ) ? g_ws_owner_name : ( "-" ), g_ws_treasury, isowner, p_info [ playerid ] [ name ] ) ;

	new now = gettime ( ) ;
	for ( new s = 0 ; s < WS_MAX_STAFF ; s ++ )
	{
		if ( g_ws_acc [ s ] == 0 ) continue ;
		new online = 0 ;
		for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
			if ( IsPlayerConnected ( i ) && p_info [ i ] [ id ] == g_ws_acc [ s ] ) { online = 1 ; break ; }
		new days = ( now - g_ws_hired [ s ] ) / 86400 ;
		new line [ 128 ] ;
		format ( line, sizeof line, "EMP:%d|%s|%d|%d|%d|%d\n", s, g_ws_name [ s ], days, g_ws_jobs [ s ], g_ws_earned [ s ], online ) ;
		strcat ( body, line ) ;
	}

	// hire candidates: online players who are not staff and not the owner
	if ( isowner && WS_StaffCount ( ) < WS_MAX_STAFF )
	{
		new cands = 0 ;
		for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
		{
			if ( ! IsPlayerConnected ( i ) ) continue ;
			if ( i == playerid ) continue ;
			if ( p_info [ i ] [ id ] <= 0 ) continue ;
			if ( WS_StaffSlotByAcc ( p_info [ i ] [ id ] ) != - 1 ) continue ;
			new line [ 64 ] ;
			format ( line, sizeof line, "CAND:%d|%s\n", i, p_info [ i ] [ name ] ) ;
			if ( strlen ( body ) + strlen ( line ) >= sizeof body - 2 ) break ;
			strcat ( body, line ) ;
			if ( ++ cands >= 15 ) break ;
		}
	}
	show_dialog ( playerid, d_wshop_menu, DIALOG_STYLE_INPUT, "[!WSHOP_OPEN]", body, "تنفيذ", "إغلاق" ) ;
}

stock WS_HidePanel ( playerid )
{
	show_dialog ( playerid, d_wshop_menu, DIALOG_STYLE_MSGBOX, "[!WSHOP_CLOSE]", " ", "OK", "" ) ;
}

// Opens the panel from the question-mark pickup / command.
stock WS_TryOpen ( playerid )
{
	if ( WS_IsOwner ( playerid ) || WS_IsStaff ( playerid ) || p_info [ playerid ] [ admin ] >= 3 )
	{
		WS_ShowPanel ( playerid ) ;
		return 1 ;
	}
	new info [ 200 ] ;
	format ( info, sizeof info, "{"#cBL"}[الورشة] {"#cWH"}ورشة الميكانيك لتعديل السيارات — المالك: {"#cGR"}%s{"#cWH"}. اطلب ميكانيكي بالأمر /mtune.", ( g_ws_owner > 0 ) ? g_ws_owner_name : ( "لا يوجد" ) ) ;
	SendClientMessage ( playerid, col_gray, info ) ;
	return 0 ;
}

// Admin: set the workshop owner.
CMD:setwowner ( playerid, params [ ] )
{
	if ( p_info [ playerid ] [ admin ] < 3 ) return 1 ;
	if ( sscanf ( params, "d", params [ 0 ] ) ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cGR"}الاستخدام: /setwowner [ID]" ) ;
	if ( ! IsPlayerConnected ( params [ 0 ] ) ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cGR"}اللاعب غير موجود." ) ;
	if ( p_info [ params [ 0 ] ] [ id ] <= 0 ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cGR"}اللاعب غير مسجل." ) ;
	g_ws_owner = p_info [ params [ 0 ] ] [ id ] ;
	format ( g_ws_owner_name, MAX_PLAYER_NAME, "%s", p_info [ params [ 0 ] ] [ name ] ) ;
	WS_SaveMain ( ) ;
	new msg [ 144 ] ;
	format ( msg, sizeof msg, "{"#cGN"}* {"#cWH"}تم تعيين {"#cGN"}%s {"#cWH"}مالكاً لورشة الميكانيك.", g_ws_owner_name ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	SendClientMessage ( params [ 0 ], col_white, "{"#cGN"}* {"#cWH"}أصبحت مالك ورشة الميكانيك! افتح لوحة التحكم من علامة الاستفهام داخل الورشة." ) ;
	if ( ! g_ws_auc_active ) WS_Auction_UpdateLabel ( 0 ) ;
	return 1 ;
}

// Admin: manually start the workshop auction (the daily auto-start is disabled).
CMD:wsauction ( playerid, params [ ] )
{
	#pragma unused params
	if ( p_info [ playerid ] [ admin ] < 3 ) return 1 ;
	if ( g_ws_auc_active ) return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}المزاد شغال أصلاً." ) ;
	WS_Auction_Start ( ) ;
	return 1 ;
}

alias:wpanel("workshop")
CMD:wpanel ( playerid, params [ ] )
{
	#pragma unused params
	if ( ! WS_AtWorkshop ( playerid ) )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لوحة تحكم الورشة تفتح فقط داخل ورشة الميكانيك." ) ;
	WS_TryOpen ( playerid ) ;
	return 1 ;
}

// Dialog handling — returns 1 when consumed.
stock WS_OnDialogResponse ( playerid, dialogid, response, inputtext [ ] )
{
	if ( dialogid != d_wshop_menu ) return 0 ;
	if ( ! response ) return 1 ;

	new cmd [ 16 ], a1 = - 1, a2 = - 1 ;
	if ( ! Mech_ParseCmd ( inputtext, cmd, sizeof cmd, a1, a2 ) ) return 1 ;

	if ( ! strcmp ( cmd, "CLOSE", true ) ) return 1 ;
	if ( ! strcmp ( cmd, "REFRESH", true ) )
	{
		WS_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "HIRE", true ) )
	{
		if ( ! WS_IsOwner ( playerid ) )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}التوظيف للمالك فقط." ) ;
			WS_ShowPanel ( playerid ) ;
			return 1 ;
		}
		if ( WS_StaffCount ( ) >= WS_MAX_STAFF )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}الورشة ممتلئة — الحد الأقصى 5 موظفين." ) ;
			WS_ShowPanel ( playerid ) ;
			return 1 ;
		}
		if ( a1 < 0 || ! IsPlayerConnected ( a1 ) || a1 == playerid || p_info [ a1 ] [ id ] <= 0 )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اللاعب غير متصل." ) ;
			WS_ShowPanel ( playerid ) ;
			return 1 ;
		}
		if ( WS_StaffSlotByAcc ( p_info [ a1 ] [ id ] ) != - 1 )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اللاعب موظف بالورشة أصلاً." ) ;
			WS_ShowPanel ( playerid ) ;
			return 1 ;
		}
		new s = - 1 ;
		for ( new k = 0 ; k < WS_MAX_STAFF ; k ++ ) if ( g_ws_acc [ k ] == 0 ) { s = k ; break ; }
		if ( s == - 1 ) { WS_ShowPanel ( playerid ) ; return 1 ; }
		g_ws_acc [ s ] = p_info [ a1 ] [ id ] ;
		format ( g_ws_name [ s ], MAX_PLAYER_NAME, "%s", p_info [ a1 ] [ name ] ) ;
		g_ws_hired [ s ] = gettime ( ) ;
		g_ws_jobs [ s ] = 0 ;
		g_ws_earned [ s ] = 0 ;
		WS_SaveStaff ( s ) ;
		if ( p_info [ a1 ] [ job ] != job_mechanic )
		{
			p_info [ a1 ] [ job ] = job_mechanic ;
			update_int_sql ( a1, "u_job", p_info [ a1 ] [ job ] ) ;
		}
		new msg [ 160 ] ;
		format ( msg, sizeof msg, "{"#cGN"}[الورشة] {"#cWH"}تم توظيف {"#cGN"}%s {"#cWH"}كميكانيكي بالورشة.", g_ws_name [ s ] ) ;
		SendClientMessage ( playerid, col_white, msg ) ;
		format ( msg, sizeof msg, "{"#cGN"}[الورشة] {"#cWH"}مالك الورشة {"#cGN"}%s {"#cWH"}وظّفك كميكانيكي! استخدم /mtune داخل الورشة.", p_info [ playerid ] [ name ] ) ;
		SendClientMessage ( a1, col_white, msg ) ;
		WS_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "FIRE", true ) )
	{
		if ( ! WS_IsOwner ( playerid ) )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}الفصل للمالك فقط." ) ;
			WS_ShowPanel ( playerid ) ;
			return 1 ;
		}
		if ( a1 < 0 || a1 >= WS_MAX_STAFF || g_ws_acc [ a1 ] == 0 ) { WS_ShowPanel ( playerid ) ; return 1 ; }
		new acc = g_ws_acc [ a1 ] ;
		new fname [ MAX_PLAYER_NAME + 1 ] ;
		format ( fname, MAX_PLAYER_NAME, "%s", g_ws_name [ a1 ] ) ;
		g_ws_acc [ a1 ] = 0 ;
		g_ws_name [ a1 ] [ 0 ] = 0 ;
		g_ws_hired [ a1 ] = 0 ;
		g_ws_jobs [ a1 ] = 0 ;
		g_ws_earned [ a1 ] = 0 ;
		WS_SaveStaff ( a1 ) ;
		for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
		{
			if ( ! IsPlayerConnected ( i ) ) continue ;
			if ( p_info [ i ] [ id ] == acc )
			{
				if ( p_info [ i ] [ job ] == job_mechanic )
				{
					p_info [ i ] [ job ] = 0 ;
					update_int_sql ( i, "u_job", 0 ) ;
				}
				SendClientMessage ( i, col_gray, "{"#cRD"}[الورشة] {"#cWH"}تم فصلك من ورشة الميكانيك." ) ;
				break ;
			}
		}
		new msg [ 144 ] ;
		format ( msg, sizeof msg, "{"#cRD"}[الورشة] {"#cWH"}تم فصل الموظف {"#cRD"}%s{"#cWH"}.", fname ) ;
		SendClientMessage ( playerid, col_white, msg ) ;
		WS_ShowPanel ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "WITHDRAW", true ) )
	{
		if ( ! WS_IsOwner ( playerid ) )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}سحب أموال الخزينة للمالك فقط." ) ;
			WS_ShowPanel ( playerid ) ;
			return 1 ;
		}
		if ( a1 <= 0 || a1 > g_ws_treasury )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}المبلغ غير صحيح أو أكبر من رصيد الخزينة." ) ;
			WS_ShowPanel ( playerid ) ;
			return 1 ;
		}
		g_ws_treasury -= a1 ;
		WS_SaveMain ( ) ;
		give_money ( playerid, a1 ) ;
		insert_money_log ( playerid, INVALID_PLAYER_ID, a1, "workshop treasury withdraw" ) ;
		new msg [ 144 ] ;
		format ( msg, sizeof msg, "{"#cGN"}[الورشة] {"#cWH"}سحبت {"#cGN"}$%d {"#cWH"}من خزينة الورشة (المتبقي: $%d).", a1, g_ws_treasury ) ;
		SendClientMessage ( playerid, col_white, msg ) ;
		WS_ShowPanel ( playerid ) ;
		return 1 ;
	}
	#pragma unused a2
	WS_ShowPanel ( playerid ) ;
	return 1 ;
}

// =====================  WORKSHOP AUCTION  =====================
// Opens daily at WS_AUC_HOUR. Bidding with /z <amount>; each valid bid
// resets the countdown to WS_AUC_SECONDS. When it expires, the last
// bidder pays their bid and becomes the workshop owner.

stock WS_Auction_UpdateLabel ( left )
{
	if ( g_ws_auc_label == STREAMER_TAG_3D_TEXT_LABEL:0 ) return ;
	new t [ 300 ] ;
	if ( ! g_ws_auc_active )
	{
		format ( t, sizeof t, "{33CCFF}[ ورشة الميكانيك ]\n{FFFFFF}المالك: {33FF66}%s\n{FFFFFF}قف هنا (أو بسيارتك) لدخول الورشة", ( g_ws_owner > 0 ) ? g_ws_owner_name : ( "لا يوجد" ) ) ;
		UpdateDynamic3DTextLabelText ( g_ws_auc_label, 0x33CCFFFF, t ) ;
		return ;
	}
	if ( g_ws_auc_acc > 0 )
		format ( t, sizeof t, "{FFD700}[ مزاد الورشة جارٍ الآن ]\n{FFFFFF}أعلى مزايدة: {33FF66}$%d {FFFFFF}بواسطة {33CCFF}%s\n{FFFFFF}الوقت المتبقي: {FF5555}%d ثانية\n{AAAAAA}للمزايدة: /z %d", g_ws_auc_bid, g_ws_auc_name, left, g_ws_auc_bid + WS_AUC_INC ) ;
	else
		format ( t, sizeof t, "{FFD700}[ مزاد الورشة جارٍ الآن ]\n{FFFFFF}السعر الافتتاحي: {33FF66}$%d\n{FFFFFF}الوقت المتبقي: {FF5555}%d ثانية\n{AAAAAA}للمزايدة: /z %d", WS_AUC_START, left, WS_AUC_START ) ;
	UpdateDynamic3DTextLabelText ( g_ws_auc_label, 0xFFD700FF, t ) ;
}

stock WS_Auction_Start ( )
{
	g_ws_auc_active   = 1 ;
	g_ws_auc_bid      = WS_AUC_START ;
	g_ws_auc_bidder   = INVALID_PLAYER_ID ;
	g_ws_auc_acc      = 0 ;
	g_ws_auc_name [ 0 ] = 0 ;
	g_ws_auc_deadline = gettime ( ) + WS_AUC_SECONDS ;
	new msg [ 220 ] ;
	format ( msg, sizeof msg, "{"#cGD"}[مزاد الورشة] {"#cWH"}بدأ مزاد ورشة الميكانيك! السعر الافتتاحي {"#cGN"}$%d{"#cWH"} — للمزايدة اكتب {"#cGN"}/z %d{"#cWH"} (الزيادة $%d).", WS_AUC_START, WS_AUC_START, WS_AUC_INC ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	WS_Auction_UpdateLabel ( WS_AUC_SECONDS ) ;
}

stock WS_Auction_End ( )
{
	g_ws_auc_active = 0 ;
	new msg [ 220 ] ;
	if ( g_ws_auc_acc <= 0 )
	{
		SendClientMessageToAll ( col_gray, "{"#cGD"}[مزاد الورشة] {"#cWH"}انتهى المزاد بدون أي مزايدة — الورشة ما زالت بدون مالك جديد." ) ;
		WS_Auction_UpdateLabel ( 0 ) ;
		return ;
	}
	new pid = g_ws_auc_bidder ;
	if ( pid == INVALID_PLAYER_ID || ! IsPlayerConnected ( pid ) || p_info [ pid ] [ id ] != g_ws_auc_acc || p_info [ pid ] [ money ] < g_ws_auc_bid )
	{
		format ( msg, sizeof msg, "{"#cGD"}[مزاد الورشة] {"#cWH"}انتهى المزاد لكن الفائز %s غير متصل أو لا يملك المبلغ — أُلغيت النتيجة.", g_ws_auc_name ) ;
		SendClientMessageToAll ( col_gray, msg ) ;
		WS_Auction_UpdateLabel ( 0 ) ;
		return ;
	}
	give_money ( pid, - g_ws_auc_bid ) ;
	insert_money_log ( pid, INVALID_PLAYER_ID, - g_ws_auc_bid, "workshop auction purchase" ) ;
	g_ws_owner = g_ws_auc_acc ;
	format ( g_ws_owner_name, MAX_PLAYER_NAME, "%s", g_ws_auc_name ) ;
	WS_SaveMain ( ) ;
	format ( msg, sizeof msg, "{"#cGD"}[مزاد الورشة] {"#cWH"}انتهى المزاد! {"#cGN"}%s {"#cWH"}اشترى ورشة الميكانيك بمبلغ {"#cGN"}$%d {"#cWH"}وأصبح مالكها الجديد!", g_ws_owner_name, g_ws_auc_bid ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	SendClientMessage ( pid, col_white, "{"#cGN"}* {"#cWH"}مبروك! أصبحت مالك ورشة الميكانيك — افتح لوحة التحكم من علامة الاستفهام داخل الورشة." ) ;
	WS_Auction_UpdateLabel ( 0 ) ;
}

// /z <amount> — returns 1 when consumed (auction active + numeric bid)
stock WS_Auction_TryBid ( playerid, const params [ ] )
{
	if ( ! g_ws_auc_active ) return 0 ;
	if ( ! strlen ( params ) )
	{
		new required = ( g_ws_auc_acc > 0 ) ? ( g_ws_auc_bid + WS_AUC_INC ) : WS_AUC_START ;
		new msg [ 180 ] ;
		format ( msg, sizeof msg, "{"#cGD"}[مزاد الورشة] {"#cWH"}للمزايدة اكتب {"#cGN"}/z %d{"#cWH"} (أقل مزايدة مقبولة).", required ) ;
		SendClientMessage ( playerid, col_white, msg ) ;
		return 1 ;
	}
	new amount = strval ( params ) ;
	if ( amount <= 0 ) return 0 ;
	new required = ( g_ws_auc_acc > 0 ) ? ( g_ws_auc_bid + WS_AUC_INC ) : WS_AUC_START ;
	new msg [ 200 ] ;
	if ( p_info [ playerid ] [ id ] <= 0 )
	{
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لازم تكون مسجل دخول للمزايدة." ) ;
		return 1 ;
	}
	if ( g_ws_auc_acc > 0 && p_info [ playerid ] [ id ] == g_ws_auc_acc )
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
	if ( ( amount - WS_AUC_START ) % WS_AUC_INC != 0 )
	{
		format ( msg, sizeof msg, "{"#cRD"}* {"#cWH"}المزايدة تكون بمضاعفات {"#cGN"}$%d {"#cWH"}(مثال: /z %d).", WS_AUC_INC, required ) ;
		SendClientMessage ( playerid, col_gray, msg ) ;
		return 1 ;
	}
	if ( p_info [ playerid ] [ money ] < amount )
	{
		SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما معك كاش كافي لهذي المزايدة." ) ;
		return 1 ;
	}

	g_ws_auc_bid    = amount ;
	g_ws_auc_bidder = playerid ;
	g_ws_auc_acc    = p_info [ playerid ] [ id ] ;
	format ( g_ws_auc_name, MAX_PLAYER_NAME, "%s", p_info [ playerid ] [ name ] ) ;
	g_ws_auc_deadline = gettime ( ) + WS_AUC_SECONDS ;   // every bid resets the clock to 30s
	format ( msg, sizeof msg, "{"#cGD"}[مزاد الورشة] {"#cGN"}%s {"#cWH"}زايد بمبلغ {"#cGN"}$%d{"#cWH"}! الوقت رجع {"#cRD"}%d ثانية{"#cWH"} — للمزايدة: {"#cGN"}/z %d", g_ws_auc_name, amount, WS_AUC_SECONDS, amount + WS_AUC_INC ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	WS_Auction_UpdateLabel ( WS_AUC_SECONDS ) ;
	return 1 ;
}

// ---- owner-to-player workshop sale (/wsell + /waccept) ----
new g_ws_sell_to    = INVALID_PLAYER_ID ;   // playerid of the buyer offer
new g_ws_sell_price = 0 ;
new g_ws_sell_time  = 0 ;                    // gettime() when the offer was made

CMD:wsell ( playerid, params [ ] )
{
	if ( ! WS_IsOwner ( playerid ) )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}أمر بيع الورشة لمالكها فقط." ) ;
	if ( g_ws_auc_active )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما تقدر تبيع الورشة أثناء المزاد." ) ;
	new target, price ;
	if ( sscanf ( params, "ud", target, price ) )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}استخدم: {"#cGR"}/wsell [ID اللاعب] [السعر]" ) ;
	if ( target == INVALID_PLAYER_ID || ! IsPlayerConnected ( target ) || target == playerid )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لاعب غير متصل." ) ;
	if ( price < 0 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}سعر غير صحيح." ) ;
	if ( p_info [ target ] [ id ] <= 0 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اللاعب غير مسجل دخول." ) ;
	g_ws_sell_to    = target ;
	g_ws_sell_price = price ;
	g_ws_sell_time  = gettime ( ) ;
	new msg [ 220 ] ;
	format ( msg, sizeof msg, "{"#cGN"}* {"#cWH"}عرضت بيع الورشة على {"#cGN"}%s{"#cWH"} بمبلغ {"#cGN"}$%d{"#cWH"} — عنده 60 ثانية للقبول بـ /waccept.", p_info [ target ] [ name ], price ) ;
	SendClientMessage ( playerid, col_white, msg ) ;
	format ( msg, sizeof msg, "{"#cGD"}[الورشة] {"#cWH"}%s يعرض عليك شراء ورشة الميكانيك بمبلغ {"#cGN"}$%d{"#cWH"} — للقبول اكتب {"#cGN"}/waccept{"#cWH"} خلال 60 ثانية.", g_ws_owner_name, price ) ;
	SendClientMessage ( target, col_white, msg ) ;
	return 1 ;
}

CMD:waccept ( playerid, params [ ] )
{
	#pragma unused params
	if ( g_ws_sell_to != playerid || gettime ( ) - g_ws_sell_time > 60 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما في عرض بيع للورشة باسمك (أو انتهت مدته)." ) ;
	if ( p_info [ playerid ] [ money ] < g_ws_sell_price )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما معك كاش كافي." ) ;
	// find the current owner online to pay him
	new ownerid = INVALID_PLAYER_ID ;
	for ( new i = 0 ; i < MAX_PLAYERS ; i ++ )
		if ( IsPlayerConnected ( i ) && p_info [ i ] [ id ] == g_ws_owner ) { ownerid = i ; break ; }
	if ( ownerid == INVALID_PLAYER_ID )
	{
		g_ws_sell_to = INVALID_PLAYER_ID ;
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}المالك غير متصل — أُلغي العرض." ) ;
	}
	if ( g_ws_sell_price > 0 )
	{
		give_money ( playerid, - g_ws_sell_price ) ;
		give_money ( ownerid, g_ws_sell_price ) ;
		insert_money_log ( playerid, ownerid, g_ws_sell_price, "workshop sale" ) ;
	}
	g_ws_owner = p_info [ playerid ] [ id ] ;
	format ( g_ws_owner_name, MAX_PLAYER_NAME, "%s", p_info [ playerid ] [ name ] ) ;
	WS_SaveMain ( ) ;
	g_ws_sell_to = INVALID_PLAYER_ID ;
	g_ws_sell_price = 0 ;
	new msg [ 200 ] ;
	format ( msg, sizeof msg, "{"#cGD"}[الورشة] {"#cGN"}%s {"#cWH"}اشترى ورشة الميكانيك وأصبح مالكها الجديد!", g_ws_owner_name ) ;
	SendClientMessageToAll ( col_white, msg ) ;
	WS_Auction_UpdateLabel ( 0 ) ;
	return 1 ;
}

forward WS_Auction_Tick ( ) ;
public WS_Auction_Tick ( )
{
	if ( ! g_ws_auc_active )
	{
		#if WS_AUC_AUTO_DAILY
		new h, m, s, y, mo, d ;
		gettime ( h, m, s ) ;
		getdate ( y, mo, d ) ;
		// auction only while the workshop has no owner; once won it's theirs for good
		if ( g_ws_owner == 0 && h == WS_AUC_HOUR && g_ws_auc_last_day != d )
		{
			g_ws_auc_last_day = d ;
			WS_Auction_Start ( ) ;
		}
		#endif
		return 1 ;
	}
	new left = g_ws_auc_deadline - gettime ( ) ;
	if ( left <= 0 )
	{
		WS_Auction_End ( ) ;
		return 1 ;
	}
	WS_Auction_UpdateLabel ( left ) ;
	return 1 ;
}
