/*
 *  Mechanic Job Menu Module (HavanaRP)
 *  ===================================
 *  Launcher-driven mechanic tuning system.
 *
 *  Flow:
 *    /mech [id]  (mechanic job only, near the target's personal car)
 *        -> target receives [!MECHREQ_ASK] overlay (accept / deny)
 *        -> on accept the mechanic gets the [!MECH_OPEN] tuning menu
 *        -> every purchase: the car owner pays, the mechanic earns 20%
 *        -> mods applied with Safe_AddVehicleComponent and saved to
 *           users_vehicles (v_components / v_color_1 / v_color_2 / v_paint)
 *
 *  Dialog channel (launcher intercepts by title):
 *    [!MECHREQ_ASK]  d_mech_ask   body "MECH:name\n<arabic text>"
 *                    answer: response=1 accept / 0 deny
 *    [!MECH_OPEN]    d_mech_menu  body "INFO:..." + "CUR:..."
 *                    answer: response=1 + inputtext subcommand:
 *                      COLOR <c1> <c2> | PJ <n> | COMP <slot> <idx> |
 *                      REM <slot> | REFRESH | CLOSE
 *    [!MECH_CLOSE]   d_mech_menu  sentinel to hide the overlay
 */

#define MECH_PRICE_COLOR      15000
#define MECH_PRICE_PJ         50000
#define MECH_PRICE_WHEEL      35000
#define MECH_PRICE_EXHAUST    25000
#define MECH_PRICE_BULLBAR    20000
#define MECH_PRICE_ROOF       25000
#define MECH_PRICE_FBUMPER    30000
#define MECH_PRICE_RBUMPER    30000
#define MECH_PRICE_SPOILER    30000
#define MECH_PRICE_SIDESKIRT  25000
#define MECH_PRICE_NITRO      100000
#define MECH_PRICE_HYDRA      75000
#define MECH_PRICE_REMOVE     5000

#define MECH_COMMISSION_PCT   20
#define MECH_ASK_TIMEOUT      45
#define MECH_MAX_DIST         8.0

// Mechanic shop: the only place tuning is allowed. Mechanic must stand here.
#define MECH_SHOP_X           973.715148
#define MECH_SHOP_Y           (-1270.737060)
#define MECH_SHOP_Z           15.063035
#define MECH_SHOP_RANGE       30.0
// workshop garage interior (entered through the workshop pickup)
#define MECH_GARAGE_X         1196.764160
#define MECH_GARAGE_Y         994.289611
#define MECH_GARAGE_Z         998.398437

stock bool:Mech_AtShop ( playerid )
{
        if ( IsPlayerInRangeOfPoint ( playerid, MECH_SHOP_RANGE, MECH_SHOP_X, MECH_SHOP_Y, MECH_SHOP_Z ) ) return true ;
        return IsPlayerInRangeOfPoint ( playerid, MECH_SHOP_RANGE, MECH_GARAGE_X, MECH_GARAGE_Y, MECH_GARAGE_Z ) ? true : false ;
}

// commands-list menu; appends the workshop/mechanic category for eligible players
stock Mech_ShowCmdsMenu ( playerid )
{
	new menu [ 512 ] ;
	strcat ( menu, "{"#cBL"}1.{ffffff} أوامر عامة\n{"#cBL"}2.{ffffff} الوظائف\n{"#cBL"}3.{ffffff} التواصل (الشاتات)\n{"#cBL"}4.{ffffff} البيت\n{"#cBL"}5.{ffffff} المحل ومحطة البنزين\n{"#cBL"}6.{ffffff} الفاكشن\n{"#cBL"}7.{ffffff} القادة\n{"#cBL"}8.{ffffff} السيارة\n{"#cBL"}9.{ffffff} العائلة" ) ;
	if ( Mech_CanTune ( playerid ) )
		strcat ( menu, "\n{"#cBL"}10.{ffffff} أوامر الميكانيك (الورشة)" ) ;
	show_dialog ( playerid, d_mm_cmds, DIALOG_STYLE_LIST, "{"#cBL"}قائمة الأوامر", menu, "اختيار", "رجوع" ) ;
	return 1 ;
}

// May this player run tuning? (mechanic job, workshop owner, or hired workshop staff)
stock bool:Mech_CanTune ( playerid )
{
	if ( p_info [ playerid ] [ job ] == job_mechanic ) return true ;
	if ( WS_IsOwner ( playerid ) ) return true ;
	if ( WS_IsStaff ( playerid ) ) return true ;
	return false ;
}

// per-mechanic session
new g_mech_target [ MAX_PLAYERS ] ;      // playerid of the customer (or INVALID_PLAYER_ID)
new g_mech_veh    [ MAX_PLAYERS ] ;      // vehicle being tuned
// per-customer state
new g_mech_by     [ MAX_PLAYERS ] ;      // mechanic playerid asking / working (or INVALID_PLAYER_ID)
new g_mech_asktime[ MAX_PLAYERS ] ;      // gettime() when the request was sent
new bool:g_mech_test [ MAX_PLAYERS ] ;   // admin self-test session (/mtunetest)
// live-preview state (indexed by mechanic id)
new g_prev_comp  [ MAX_PLAYERS ] [ 10 ] ; // previewed component model per slot (0 = none)
new bool:g_prev_rem [ MAX_PLAYERS ] [ 10 ] ; // slot visually stripped for preview
new g_prev_color [ MAX_PLAYERS ] [ 2 ] ;  // previewed colors (-1 = none)
new g_prev_pj    [ MAX_PLAYERS ] ;        // previewed paintjob (-1 = none)
// pending checkout cart (indexed by mechanic id)
new g_mech_cart  [ MAX_PLAYERS ] [ 144 ] ;
new g_mech_cart_total [ MAX_PLAYERS ] ;

// Parse "CMD a1 a2" out of the launcher's inputtext answer.
stock Mech_ParseCmd ( const text [ ], cmd [ ], cmdlen, &a1, &a2 )
{
	a1 = - 1 ; a2 = - 1 ;
	new i = 0, j = 0 ;
	while ( text [ i ] == ' ' ) i ++ ;
	while ( text [ i ] && text [ i ] != ' ' && j < cmdlen - 1 ) cmd [ j ++ ] = text [ i ++ ] ;
	cmd [ j ] = 0 ;
	if ( j == 0 ) return 0 ;
	while ( text [ i ] == ' ' ) i ++ ;
	if ( text [ i ] )
	{
		new tmp [ 16 ] ;
		new k = 0 ;
		while ( text [ i ] && text [ i ] != ' ' && k < 15 ) tmp [ k ++ ] = text [ i ++ ] ;
		tmp [ k ] = 0 ;
		a1 = strval ( tmp ) ;
		while ( text [ i ] == ' ' ) i ++ ;
		if ( text [ i ] )
		{
			k = 0 ;
			while ( text [ i ] && text [ i ] != ' ' && k < 15 ) tmp [ k ++ ] = text [ i ++ ] ;
			tmp [ k ] = 0 ;
			a2 = strval ( tmp ) ;
		}
	}
	return 1 ;
}

// Read an unsigned integer at s[i]; advances i. Returns -1 when no digits.
stock Mech_ReadNum ( const s [ ], &i )
{
	new v = 0, got = 0 ;
	while ( s [ i ] >= '0' && s [ i ] <= '9' ) { v = v * 10 + s [ i ] - '0' ; i ++ ; got = 1 ; }
	return got ? v : - 1 ;
}

// Validate one cart item and return its display name + price.
// itype: 'C' colors x/y  'P' paintjob x  'M' component slot x idx y  'R' remove slot x
stock Mech_ItemInfo ( itype, x, y, vid, &price, dest [ ], namelen )
{
	price = 0 ;
	switch ( itype )
	{
		case 'C':
		{
			if ( x < 0 || x > 255 || y < 0 || y > 255 ) return 0 ;
			price = MECH_PRICE_COLOR ;
			format ( dest, namelen, "طلاء جديد (لونين)" ) ;
			return 1 ;
		}
		case 'P':
		{
			if ( x < 0 || x > 3 ) return 0 ;
			if ( Custom_GetVehicleDisplayModel ( vid ) > 611 && IsTuneBlockedModel ( Custom_GetVehicleDisplayModel ( vid ) ) ) return 0 ;
			price = MECH_PRICE_PJ ;
			format ( dest, namelen, "بينت جوب %d", x + 1 ) ;
			return 1 ;
		}
		case 'M':
		{
			if ( x < 0 || x > 9 ) return 0 ;
			new model ;
			if ( x == 0 ) model = 1087 ;
			else if ( x == 1 ) model = 1010 ;
			else model = Mech_SlotModel ( x, y ) ;
			if ( model == 0 || ! IsVehicleComponentSafe ( vid, model ) ) return 0 ;
			price = Mech_SlotPrice ( x ) ;
			Mech_SlotName ( x, dest, namelen ) ;
			return 1 ;
		}
		case 'R':
		{
			if ( x < 0 || x > 9 || veh_info [ vid - 1 ] [ v_component ] [ x ] == 0 ) return 0 ;
			price = MECH_PRICE_REMOVE ;
			new sn [ 32 ] ;
			Mech_SlotName ( x, sn, sizeof sn ) ;
			format ( dest, namelen, "فك %s", sn ) ;
			return 1 ;
		}
	}
	return 0 ;
}

// Permanently apply a validated cart string to the vehicle (veh_info + world).
stock Mech_ApplyCart ( vid, const cart [ ] )
{
	new i = 0 ;
	while ( cart [ i ] )
	{
		new itype = cart [ i ++ ] ;
		new x = - 1, y = - 1 ;
		if ( cart [ i ] == '.' ) { i ++ ; x = Mech_ReadNum ( cart, i ) ; }
		if ( cart [ i ] == '.' ) { i ++ ; y = Mech_ReadNum ( cart, i ) ; }
		switch ( itype )
		{
			case 'C':
			{
				if ( x >= 0 && x <= 255 && y >= 0 && y <= 255 )
				{
					veh_info [ vid - 1 ] [ v_color ] [ 0 ] = x ;
					veh_info [ vid - 1 ] [ v_color ] [ 1 ] = y ;
					ChangeVehicleColor ( vid, x, y ) ;
				}
			}
			case 'P':
			{
				if ( x >= 0 && x <= 3 && ( Custom_GetVehicleDisplayModel ( vid ) <= 611 || ! IsTuneBlockedModel ( Custom_GetVehicleDisplayModel ( vid ) ) ) )
				{
					veh_info [ vid - 1 ] [ v_paint ] = x ;
					ChangeVehiclePaintjob ( vid, x ) ;
					ChangeVehicleColor ( vid, veh_info [ vid - 1 ] [ v_color ] [ 0 ], veh_info [ vid - 1 ] [ v_color ] [ 1 ] ) ;
				}
			}
			case 'M':
			{
				if ( x >= 0 && x <= 9 )
				{
					new model ;
					if ( x == 0 ) model = 1087 ;
					else if ( x == 1 ) model = 1010 ;
					else model = Mech_SlotModel ( x, y ) ;
					if ( model != 0 && IsVehicleComponentSafe ( vid, model ) )
					{
						veh_info [ vid - 1 ] [ v_component ] [ x ] = model ;
						Safe_AddVehicleComponent ( vid, model ) ;
					}
				}
			}
			case 'R':
			{
				if ( x >= 0 && x <= 9 && veh_info [ vid - 1 ] [ v_component ] [ x ] != 0 )
				{
					RemoveVehicleComponent ( vid, veh_info [ vid - 1 ] [ v_component ] [ x ] ) ;
					veh_info [ vid - 1 ] [ v_component ] [ x ] = 0 ;
				}
			}
		}
		while ( cart [ i ] && cart [ i ] != ';' ) i ++ ;
		if ( cart [ i ] == ';' ) i ++ ;
	}
}

stock Mech_Reset ( playerid )
{
	g_mech_target [ playerid ] = INVALID_PLAYER_ID ;
	g_mech_veh    [ playerid ] = INVALID_VEHICLE_ID ;
	g_mech_by     [ playerid ] = INVALID_PLAYER_ID ;
	g_mech_asktime[ playerid ] = 0 ;
	g_mech_test   [ playerid ] = false ;
	Mech_ClearPreviewState ( playerid ) ;
}

stock Mech_ClearPreviewState ( mechid )
{
	for ( new s = 0 ; s < 10 ; s ++ ) { g_prev_comp [ mechid ] [ s ] = 0 ; g_prev_rem [ mechid ] [ s ] = false ; }
	g_prev_color [ mechid ] [ 0 ] = - 1 ;
	g_prev_color [ mechid ] [ 1 ] = - 1 ;
	g_prev_pj [ mechid ] = - 1 ;
	g_mech_cart [ mechid ] [ 0 ] = 0 ;
	g_mech_cart_total [ mechid ] = 0 ;
}

// Revert every previewed change back to the vehicle's saved state.
stock Mech_RestorePreview ( mechid )
{
	new vid = g_mech_veh [ mechid ] ;
	if ( vid >= 1 && vid <= MAX_VEHICLES )
	{
		for ( new s = 0 ; s < 10 ; s ++ )
		{
			new saved = veh_info [ vid - 1 ] [ v_component ] [ s ] ;
			if ( g_prev_comp [ mechid ] [ s ] != 0 && g_prev_comp [ mechid ] [ s ] != saved )
			{
				RemoveVehicleComponent ( vid, g_prev_comp [ mechid ] [ s ] ) ;
				if ( saved != 0 ) Safe_AddVehicleComponent ( vid, saved ) ;
			}
			else if ( g_prev_rem [ mechid ] [ s ] && saved != 0 )
				Safe_AddVehicleComponent ( vid, saved ) ;
		}
		if ( g_prev_pj [ mechid ] != - 1 )
			ChangeVehiclePaintjob ( vid, veh_info [ vid - 1 ] [ v_paint ] ) ;
		if ( g_prev_color [ mechid ] [ 0 ] != - 1 || g_prev_pj [ mechid ] != - 1 )
			ChangeVehicleColor ( vid, veh_info [ vid - 1 ] [ v_color ] [ 0 ], veh_info [ vid - 1 ] [ v_color ] [ 1 ] ) ;
	}
	Mech_ClearPreviewState ( mechid ) ;
}

// Break the session from either side and notify the other party.
stock Mech_EndSession ( playerid, const reason [ ] )
{
	if ( g_mech_target [ playerid ] != INVALID_PLAYER_ID ) Mech_RestorePreview ( playerid ) ;
	else if ( g_mech_by [ playerid ] != INVALID_PLAYER_ID && IsPlayerConnected ( g_mech_by [ playerid ] ) )
		Mech_RestorePreview ( g_mech_by [ playerid ] ) ;
	new other = INVALID_PLAYER_ID ;
	if ( g_mech_target [ playerid ] != INVALID_PLAYER_ID ) other = g_mech_target [ playerid ] ;
	else if ( g_mech_by [ playerid ] != INVALID_PLAYER_ID ) other = g_mech_by [ playerid ] ;

	if ( g_mech_target [ playerid ] != INVALID_PLAYER_ID )
		show_dialog ( playerid, d_mech_menu, DIALOG_STYLE_MSGBOX, "[!MECH_CLOSE]", " ", "OK", "" ) ;

	g_mech_target [ playerid ] = INVALID_PLAYER_ID ;
	g_mech_veh    [ playerid ] = INVALID_VEHICLE_ID ;
	g_mech_by     [ playerid ] = INVALID_PLAYER_ID ;
	g_mech_test   [ playerid ] = false ;

	if ( other != INVALID_PLAYER_ID && IsPlayerConnected ( other ) )
	{
		if ( g_mech_target [ other ] == playerid || g_mech_by [ other ] == playerid )
		{
			if ( g_mech_target [ other ] == playerid )
				show_dialog ( other, d_mech_menu, DIALOG_STYLE_MSGBOX, "[!MECH_CLOSE]", " ", "OK", "" ) ;
			g_mech_target [ other ] = INVALID_PLAYER_ID ;
			g_mech_veh    [ other ] = INVALID_VEHICLE_ID ;
			g_mech_by     [ other ] = INVALID_PLAYER_ID ;
			if ( strlen ( reason ) ) SendClientMessage ( other, col_gray, reason ) ;
		}
	}
	if ( strlen ( reason ) ) SendClientMessage ( playerid, col_gray, reason ) ;
}

// Session still valid? (both online, target driving the same car, mechanic near it)
stock bool:Mech_SessionValid ( mechid )
{
	new target = g_mech_target [ mechid ] ;
	if ( target == INVALID_PLAYER_ID || ! IsPlayerConnected ( target ) ) return false ;
	if ( g_mech_by [ target ] != mechid ) return false ;
	new vid = g_mech_veh [ mechid ] ;
	if ( vid < 1 || vid > MAX_VEHICLES ) return false ;
	if ( GetPlayerVehicleID ( target ) != vid || GetPlayerVehicleSeat ( target ) != 0 ) return false ;
	if ( ! Mech_CanTune ( mechid ) && ! g_mech_test [ mechid ] ) return false ;
	// the mechanic must be seated inside the customer's vehicle
	if ( GetPlayerVehicleID ( mechid ) != vid && ! g_mech_test [ mechid ] ) return false ;
	// tuning only within the workshop bounds (30m)
	if ( ! Mech_AtShop ( mechid ) && ! g_mech_test [ mechid ] ) return false ;
	return true ;
}

// Push (or refresh) the tuning menu overlay to the mechanic.
stock Mech_ShowMenu ( mechid )
{
	new target = g_mech_target [ mechid ] ;
	new vid = g_mech_veh [ mechid ] ;
	new tname [ MAX_PLAYER_NAME + 1 ] ;
	GetPlayerName ( target, tname, sizeof tname ) ;

	new disp = Custom_GetVehicleDisplayModel ( vid ) ;
	new payload [ 512 ] ;
	format ( payload, sizeof payload,
		"INFO:%s|%d|%d|%d|%d|%d|%d\nCUR:%d|%d|%d|%d|%d|%d|%d|%d|%d|%d\n",
		tname,
		GetVehicleModel ( vid ),
		disp,
		p_info [ target ] [ money ],
		veh_info [ vid - 1 ] [ v_color ] [ 0 ],
		veh_info [ vid - 1 ] [ v_color ] [ 1 ],
		veh_info [ vid - 1 ] [ v_paint ],
		veh_info [ vid - 1 ] [ v_component ] [ 0 ],
		veh_info [ vid - 1 ] [ v_component ] [ 1 ],
		veh_info [ vid - 1 ] [ v_component ] [ 2 ],
		veh_info [ vid - 1 ] [ v_component ] [ 3 ],
		veh_info [ vid - 1 ] [ v_component ] [ 4 ],
		veh_info [ vid - 1 ] [ v_component ] [ 5 ],
		veh_info [ vid - 1 ] [ v_component ] [ 6 ],
		veh_info [ vid - 1 ] [ v_component ] [ 7 ],
		veh_info [ vid - 1 ] [ v_component ] [ 8 ],
		veh_info [ vid - 1 ] [ v_component ] [ 9 ] ) ;
	show_dialog ( mechid, d_mech_menu, DIALOG_STYLE_INPUT, "[!MECH_OPEN]", payload, "تنفيذ", "إغلاق" ) ;
}

// Persist the vehicle's tuning to users_vehicles.
stock Mech_SaveVehicle ( vid )
{
	if ( veh_info [ vid - 1 ] [ v_type ] != vehicle_type_player ) return 0 ;
	new q [ 300 ] ;
	format ( q, sizeof q,
		"UPDATE `users_vehicles` SET `v_components` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d',`v_color_1` = '%d',`v_color_2` = '%d',`v_paint`='%d' WHERE `v_id` = '%d' LIMIT 1",
		veh_info [ vid - 1 ] [ v_component ] [ 0 ],
		veh_info [ vid - 1 ] [ v_component ] [ 1 ],
		veh_info [ vid - 1 ] [ v_component ] [ 2 ],
		veh_info [ vid - 1 ] [ v_component ] [ 3 ],
		veh_info [ vid - 1 ] [ v_component ] [ 4 ],
		veh_info [ vid - 1 ] [ v_component ] [ 5 ],
		veh_info [ vid - 1 ] [ v_component ] [ 6 ],
		veh_info [ vid - 1 ] [ v_component ] [ 7 ],
		veh_info [ vid - 1 ] [ v_component ] [ 8 ],
		veh_info [ vid - 1 ] [ v_component ] [ 9 ],
		veh_info [ vid - 1 ] [ v_color ] [ 0 ],
		veh_info [ vid - 1 ] [ v_color ] [ 1 ],
		veh_info [ vid - 1 ] [ v_paint ],
		veh_info [ vid - 1 ] [ v_id ] ) ;
	mysql_tquery ( sql_connection, q ) ;
	return 1 ;
}

// Charge the customer, pay the mechanic his cut, log both. 1 = paid.
stock Mech_Charge ( mechid, target, price, const what [ ] )
{
	if ( p_info [ target ] [ money ] < price )
	{
		SendClientMessage ( mechid, col_gray, "{"#cRD"}* {"#cWH"}الزبون ما معه كاش كافي لهذا التعديل." ) ;
		SendClientMessage ( target, col_gray, "{"#cRD"}* {"#cWH"}ما معك كاش كافي لهذا التعديل." ) ;
		return 0 ;
	}
	new cut = ( price * MECH_COMMISSION_PCT ) / 100 ;
	give_money ( target, - price ) ;
	give_money ( mechid, cut ) ;
	insert_money_log ( target, mechid, - price, "mechanic tuning" ) ;
	insert_money_log ( mechid, target, cut, "mechanic commission" ) ;
	WS_OnTuneIncome ( mechid, price, cut ) ;

	new msg [ 200 ] ;
	format ( msg, sizeof msg, "{"#cGR"}[ميكانيكي] {"#cWH"}تم تركيب %s بسعر {"#cGR"}$%d{"#cWH"} (عمولتك $%d).", what, price, cut ) ;
	SendClientMessage ( mechid, col_green, msg ) ;
	format ( msg, sizeof msg, "{"#cGR"}[ميكانيكي] {"#cWH"}الميكانيكي ركّب لسيارتك %s وانخصم منك {"#cGR"}$%d{"#cWH"}.", what, price ) ;
	SendClientMessage ( target, col_green, msg ) ;
	return 1 ;
}

// Map a menu slot to its component model array. Returns model id or 0.
stock Mech_SlotModel ( slot, idx )
{
	switch ( slot )
	{
		case 2: { if ( idx >= 0 && idx < sizeof exhaust_models ) return exhaust_models [ idx ] ; }
		case 3: { if ( idx >= 0 && idx < sizeof bullbar_models ) return bullbar_models [ idx ] ; }
		case 4: { if ( idx >= 0 && idx < sizeof roof_models ) return roof_models [ idx ] ; }
		case 5: { if ( idx >= 0 && idx < sizeof front_bumper_models ) return front_bumper_models [ idx ] ; }
		case 6: { if ( idx >= 0 && idx < sizeof rear_bumper_models ) return rear_bumper_models [ idx ] ; }
		case 7: { if ( idx >= 0 && idx < sizeof spoiler_models ) return spoiler_models [ idx ] ; }
		case 8: { if ( idx >= 0 && idx < sizeof sideskirt_models ) return sideskirt_models [ idx ] ; }
		case 9: { if ( idx >= 0 && idx < sizeof tuning_wheels ) return tuning_wheels [ idx ] ; }
	}
	return 0 ;
}

stock Mech_SlotPrice ( slot )
{
	switch ( slot )
	{
		case 0: return MECH_PRICE_HYDRA ;
		case 1: return MECH_PRICE_NITRO ;
		case 2: return MECH_PRICE_EXHAUST ;
		case 3: return MECH_PRICE_BULLBAR ;
		case 4: return MECH_PRICE_ROOF ;
		case 5: return MECH_PRICE_FBUMPER ;
		case 6: return MECH_PRICE_RBUMPER ;
		case 7: return MECH_PRICE_SPOILER ;
		case 8: return MECH_PRICE_SIDESKIRT ;
		case 9: return MECH_PRICE_WHEEL ;
	}
	return 0 ;
}

stock Mech_SlotName ( slot, dest [ ], len )
{
	switch ( slot )
	{
		case 0: format ( dest, len, "هيدروليك" ) ;
		case 1: format ( dest, len, "نيترو" ) ;
		case 2: format ( dest, len, "شكمان رياضي" ) ;
		case 3: format ( dest, len, "دعامية أمامية" ) ;
		case 4: format ( dest, len, "سقف رياضي" ) ;
		case 5: format ( dest, len, "صدام أمامي" ) ;
		case 6: format ( dest, len, "صدام خلفي" ) ;
		case 7: format ( dest, len, "جناح خلفي" ) ;
		case 8: format ( dest, len, "سايد سكيرت" ) ;
		case 9: format ( dest, len, "عجلات" ) ;
		default: format ( dest, len, "تعديل" ) ;
	}
}

// ---------------------------------------------------------------------------
//  Commands
// ---------------------------------------------------------------------------
alias:mtune("mechmenu", "tunemenu")
CMD:mtune ( playerid, params [ ] )
{
	if ( ! Mech_CanTune ( playerid ) )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}هذا الأمر لمالك الورشة وموظفيها فقط." ) ;

	if ( ! Mech_AtShop ( playerid ) )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}التعديل يتم فقط في ورشة الميكانيكي. استخدم {"#cGR"}/gps{"#cWH"} واختر (ورشة الميكانيك) للوصول." ) ;

	// re-open an active session menu
	if ( ! strlen ( params ) )
	{
		if ( g_mech_target [ playerid ] != INVALID_PLAYER_ID )
		{
			if ( ! Mech_SessionValid ( playerid ) )
			{
				Mech_EndSession ( playerid, "{"#cRD"}* {"#cWH"}انتهت جلسة التعديل (الزبون ابتعد أو نزل من السيارة)." ) ;
				return 1 ;
			}
			Mech_ShowMenu ( playerid ) ;
			return 1 ;
		}
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}استخدم: {"#cGR"}/mtune [ID اللاعب]{"#cWH"} وأنت راكب داخل سيارته." ) ;
	}

	new target = strval ( params ) ;
	if ( ! IsPlayerConnected ( target ) || target == playerid )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اللاعب غير متصل." ) ;
	if ( g_mech_target [ playerid ] != INVALID_PLAYER_ID )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}عندك جلسة تعديل شغالة. اكتب /mtune لفتحها أو /mechend لإنهائها." ) ;
	if ( g_mech_by [ target ] != INVALID_PLAYER_ID && gettime ( ) - g_mech_asktime [ target ] < MECH_ASK_TIMEOUT )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اللاعب عنده طلب تعديل معلق بالفعل." ) ;

	new vid = GetPlayerVehicleID ( target ) ;
	if ( vid < 1 || vid > MAX_VEHICLES || GetPlayerVehicleSeat ( target ) != 0 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}اللاعب لازم يكون سائق سيارته الخاصة." ) ;
	if ( veh_info [ vid - 1 ] [ v_type ] != vehicle_type_player || veh_info [ vid - 1 ] [ v_owner ] != p_info [ target ] [ id ] )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}هذي مو سيارة اللاعب الخاصة — التعديل فقط للسيارات المملوكة." ) ;

	if ( GetPlayerVehicleID ( playerid ) != vid )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لازم تكون راكب داخل سيارة الزبون عشان تعدلها." ) ;

	// register the pending request
	g_mech_by [ target ] = playerid ;
	g_mech_asktime [ target ] = gettime ( ) ;

	new mname [ MAX_PLAYER_NAME + 1 ] ;
	GetPlayerName ( playerid, mname, sizeof mname ) ;
	new body [ 300 ] ;
	format ( body, sizeof body, "MECH:%s\nالميكانيكي %s يطلب تعديل سيارتك.\nكل تعديل توافق عليه سيُخصم سعره من أموالك مباشرة.\nهل توافق؟", mname, mname ) ;
	show_dialog ( target, d_mech_ask, DIALOG_STYLE_MSGBOX, "[!MECHREQ_ASK]", body, "قبول", "رفض" ) ;

	SendClientMessage ( playerid, col_green, "{"#cGR"}[ميكانيكي] {"#cWH"}تم إرسال طلب التعديل للزبون — بانتظار موافقته." ) ;
	return 1 ;
}

// Admin self-test: shows the accept popup then opens the tuning menu on your
// own vehicle (no mechanic job needed). Charges still apply (you pay yourself).
CMD:mtunetest ( playerid, params [ ] )
{
	#pragma unused params
	if ( p_info [ playerid ] [ admin ] < 1 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}هذا الأمر للأدمن فقط." ) ;

	new vid = GetPlayerVehicleID ( playerid ) ;
	if ( vid < 1 || vid > MAX_VEHICLES || GetPlayerVehicleSeat ( playerid ) != 0 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}لازم تكون سائق سيارة لتجربة النظام." ) ;

	if ( g_mech_target [ playerid ] != INVALID_PLAYER_ID || g_mech_by [ playerid ] != INVALID_PLAYER_ID )
		Mech_EndSession ( playerid, "" ) ;

	g_mech_test [ playerid ] = true ;
	g_mech_by [ playerid ] = playerid ;
	g_mech_asktime [ playerid ] = gettime ( ) ;

	new mname [ MAX_PLAYER_NAME + 1 ] ;
	GetPlayerName ( playerid, mname, sizeof mname ) ;
	new body [ 300 ] ;
	format ( body, sizeof body, "MECH:%s\nالميكانيكي %s يطلب تعديل سيارتك.\nكل تعديل توافق عليه سيخصم سعره من أموالك مباشرة.\nهل توافق؟", mname, mname ) ;
	show_dialog ( playerid, d_mech_ask, DIALOG_STYLE_MSGBOX, "[!MECHREQ_ASK]", body, "قبول", "رفض" ) ;

	SendClientMessage ( playerid, col_green, "{"#cGR"}[تيست] {"#cWH"}وصلتك شاشة القبول — اقبلها وبتفتح لك قائمة التعديلات على سيارتك." ) ;
	return 1 ;
}

// Toggle body-tuning block for a launcher model that crashes clients.
alias:mblock("mtuneblock")
CMD:mblock ( playerid, params [ ] )
{
	if ( p_info [ playerid ] [ admin ] < 1 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}هذا الأمر للأدمن فقط." ) ;
	new m = strval ( params ) ;
	if ( m <= 611 )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}استخدم: {"#cGR"}/mblock [ايدي موديل اللانشر]{"#cWH"} لحظر/فك حظر تيونينق البودي عليه." ) ;
	new q [ 128 ], msg [ 144 ] ;
	if ( IsTuneBlockedModel ( m ) )
	{
		UnblockTuneModel ( m ) ;
		format ( q, sizeof q, "DELETE FROM `mech_blockmodels` WHERE `model` = %d", m ) ;
		format ( msg, sizeof msg, "{"#cGR"}* {"#cWH"}انفك حظر التيونينق عن الموديل %d.", m ) ;
	}
	else
	{
		BlockTuneModel ( m ) ;
		format ( q, sizeof q, "INSERT IGNORE INTO `mech_blockmodels` (`model`) VALUES (%d)", m ) ;
		format ( msg, sizeof msg, "{"#cRD"}* {"#cWH"}انحظر تيونينق البودي والبينت جوب على الموديل %d (العجلات/النيترو/الهيدروليك مسموحة).", m ) ;
	}
	mysql_tquery ( sql_connection, q, "", "" ) ;
	SendClientMessage ( playerid, col_gray, msg ) ;
	return 1 ;
}

// Loads the persisted blocked-model list at gamemode init.
forward Mech_LoadBlockedModels ( ) ;
public Mech_LoadBlockedModels ( )
{
	new rows = cache_num_rows ( ) ;
	for ( new i = 0 ; i < rows ; i ++ )
		BlockTuneModel ( cache_get_field_content_int ( i, "model", sql_connection ) ) ;
	return 1 ;
}

CMD:mechend ( playerid, params [ ] )
{
	#pragma unused params
	if ( g_mech_target [ playerid ] == INVALID_PLAYER_ID && g_mech_by [ playerid ] == INVALID_PLAYER_ID )
		return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما عندك جلسة تعديل شغالة." ) ;
	Mech_EndSession ( playerid, "{"#cRD"}* {"#cWH"}تم إنهاء جلسة التعديل." ) ;
	return 1 ;
}

// ---------------------------------------------------------------------------
//  Dialog handling — returns 1 when consumed
// ---------------------------------------------------------------------------
stock Mech_OnDialogResponse ( playerid, dialogid, response, listitem, inputtext [ ] )
{
	#pragma unused listitem
	if ( dialogid == d_mech_ask )
	{
		new mechid = g_mech_by [ playerid ] ;
		if ( mechid == INVALID_PLAYER_ID || ! IsPlayerConnected ( mechid ) )
		{
			g_mech_by [ playerid ] = INVALID_PLAYER_ID ;
			return 1 ;
		}
		if ( ! response )
		{
			g_mech_by [ playerid ] = INVALID_PLAYER_ID ;
			SendClientMessage ( mechid, col_gray, "{"#cRD"}* {"#cWH"}الزبون رفض طلب التعديل." ) ;
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}رفضت طلب التعديل." ) ;
			return 1 ;
		}
		if ( gettime ( ) - g_mech_asktime [ playerid ] > MECH_ASK_TIMEOUT )
		{
			g_mech_by [ playerid ] = INVALID_PLAYER_ID ;
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}انتهت صلاحية الطلب." ) ;
			return 1 ;
		}
		// bind the session
		new vid = GetPlayerVehicleID ( playerid ) ;
		if ( vid < 1 || vid > MAX_VEHICLES || GetPlayerVehicleSeat ( playerid ) != 0
			|| ( ! g_mech_test [ playerid ] && ( veh_info [ vid - 1 ] [ v_type ] != vehicle_type_player
			|| veh_info [ vid - 1 ] [ v_owner ] != p_info [ playerid ] [ id ] ) ) )
		{
			g_mech_by [ playerid ] = INVALID_PLAYER_ID ;
			SendClientMessage ( mechid, col_gray, "{"#cRD"}* {"#cWH"}الزبون ما عاد بسيارته — انلغى الطلب." ) ;
			return 1 ;
		}
		g_mech_target [ mechid ] = playerid ;
		g_mech_veh [ mechid ] = vid ;
		SendClientMessage ( playerid, col_green, "{"#cGR"}[ميكانيكي] {"#cWH"}قبلت الطلب — ابقَ بسيارتك حتى يخلص الميكانيكي." ) ;
		SendClientMessage ( mechid, col_green, "{"#cGR"}[ميكانيكي] {"#cWH"}الزبون قبل! انفتحت لك قائمة التعديل." ) ;
		Mech_ShowMenu ( mechid ) ;
		return 1 ;
	}

	if ( dialogid == d_mech_invoice )
	{
		new mechid = g_mech_by [ playerid ] ;
		if ( mechid == INVALID_PLAYER_ID || ! IsPlayerConnected ( mechid ) || g_mech_target [ mechid ] != playerid ) return 1 ;
		new total = g_mech_cart_total [ mechid ] ;
		if ( ! response || total <= 0 )
		{
			Mech_RestorePreview ( mechid ) ;
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}رفضت الفاتورة — رجعت السيارة لوضعها السابق." ) ;
			SendClientMessage ( mechid, col_gray, "{"#cRD"}* {"#cWH"}الزبون رفض الفاتورة — انرجعت التعديلات." ) ;
			Mech_ShowMenu ( mechid ) ;
			return 1 ;
		}
		if ( p_info [ playerid ] [ money ] < total )
		{
			Mech_RestorePreview ( mechid ) ;
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}ما معك كاش كافي للفاتورة." ) ;
			SendClientMessage ( mechid, col_gray, "{"#cRD"}* {"#cWH"}الزبون ما معه كاش كافي للفاتورة." ) ;
			Mech_ShowMenu ( mechid ) ;
			return 1 ;
		}
		new vid = g_mech_veh [ mechid ] ;
		if ( vid < 1 || vid > MAX_VEHICLES ) { Mech_RestorePreview ( mechid ) ; return 1 ; }

		new cart [ 144 ] ;
		format ( cart, sizeof cart, "%s", g_mech_cart [ mechid ] ) ;

		new cut = ( total * MECH_COMMISSION_PCT ) / 100 ;
		give_money ( playerid, - total ) ;
		give_money ( mechid, cut ) ;
		insert_money_log ( playerid, mechid, - total, "mechanic tuning invoice" ) ;
		insert_money_log ( mechid, playerid, cut, "mechanic commission" ) ;
		WS_OnTuneIncome ( mechid, total, cut ) ;

		Mech_RestorePreview ( mechid ) ;
		Mech_ApplyCart ( vid, cart ) ;
		Mech_SaveVehicle ( vid ) ;

		new msg [ 200 ] ;
		format ( msg, sizeof msg, "{"#cGR"}[ميكانيكي] {"#cWH"}وافقت على الفاتورة وانخصم منك {"#cGR"}$%d{"#cWH"} — تم تركيب التعديلات وحفظها.", total ) ;
		SendClientMessage ( playerid, col_green, msg ) ;
		format ( msg, sizeof msg, "{"#cGR"}[ميكانيكي] {"#cWH"}الزبون وافق! انخصم منه {"#cGR"}$%d{"#cWH"} وعمولتك {"#cGR"}$%d{"#cWH"}.", total, cut ) ;
		SendClientMessage ( mechid, col_green, msg ) ;
		Mech_ShowMenu ( mechid ) ;
		return 1 ;
	}

	if ( dialogid != d_mech_menu ) return 0 ;

	// mechanic answered the tuning menu
	if ( g_mech_target [ playerid ] == INVALID_PLAYER_ID ) return 1 ;
	if ( ! response )
	{
		Mech_EndSession ( playerid, "{"#cRD"}* {"#cWH"}تم إغلاق قائمة التعديل." ) ;
		return 1 ;
	}
	if ( ! Mech_SessionValid ( playerid ) )
	{
		Mech_EndSession ( playerid, "{"#cRD"}* {"#cWH"}انتهت جلسة التعديل (الزبون ابتعد أو نزل من السيارة)." ) ;
		return 1 ;
	}

	new target = g_mech_target [ playerid ] ;
	new vid = g_mech_veh [ playerid ] ;
	new cmd [ 16 ], a1 = - 1, a2 = - 1 ;
	if ( ! Mech_ParseCmd ( inputtext, cmd, sizeof cmd, a1, a2 ) ) { Mech_ShowMenu ( playerid ) ; return 1 ; }

	if ( ! strcmp ( cmd, "CLOSE", true ) )
	{
		Mech_EndSession ( playerid, "{"#cGR"}[ميكانيكي] {"#cWH"}انتهت جلسة التعديل — شكرا!" ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "REFRESH", true ) )
	{
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	// ---- live preview (no charge, reverted unless purchased) ----
	if ( ! strcmp ( cmd, "PCOL", true ) )
	{
		if ( a1 < 0 || a1 > 255 || a2 < 0 || a2 > 255 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		g_prev_color [ playerid ] [ 0 ] = a1 ;
		g_prev_color [ playerid ] [ 1 ] = a2 ;
		ChangeVehicleColor ( vid, a1, a2 ) ;
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "PPJ", true ) )
	{
		if ( a1 < 0 || a1 > 3 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		if ( Custom_GetVehicleDisplayModel ( vid ) > 611 && IsTuneBlockedModel ( Custom_GetVehicleDisplayModel ( vid ) ) )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}التعديل محظور على هذا الموديل (يسبب كراش)." ) ;
			Mech_ShowMenu ( playerid ) ;
			return 1 ;
		}
		g_prev_pj [ playerid ] = a1 ;
		ChangeVehiclePaintjob ( vid, a1 ) ;
		new pc1 = ( g_prev_color [ playerid ] [ 0 ] != - 1 ) ? g_prev_color [ playerid ] [ 0 ] : veh_info [ vid - 1 ] [ v_color ] [ 0 ] ;
		new pc2 = ( g_prev_color [ playerid ] [ 1 ] != - 1 ) ? g_prev_color [ playerid ] [ 1 ] : veh_info [ vid - 1 ] [ v_color ] [ 1 ] ;
		ChangeVehicleColor ( vid, pc1, pc2 ) ;
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "PCOMP", true ) )
	{
		if ( a1 < 0 || a1 > 9 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		new model ;
		if ( a1 == 0 ) model = 1087 ;
		else if ( a1 == 1 ) model = 1010 ;
		else model = Mech_SlotModel ( a1, a2 ) ;
		if ( model == 0 || ! IsVehicleComponentSafe ( vid, model ) )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}هذا التعديل غير متوافق مع هذي السيارة." ) ;
			Mech_ShowMenu ( playerid ) ;
			return 1 ;
		}
		if ( g_prev_comp [ playerid ] [ a1 ] != 0 && g_prev_comp [ playerid ] [ a1 ] != model )
			RemoveVehicleComponent ( vid, g_prev_comp [ playerid ] [ a1 ] ) ;
		g_prev_comp [ playerid ] [ a1 ] = model ;
		g_prev_rem [ playerid ] [ a1 ] = false ;
		Safe_AddVehicleComponent ( vid, model ) ;
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "PREM", true ) )
	{
		if ( a1 < 0 || a1 > 9 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		if ( g_prev_comp [ playerid ] [ a1 ] != 0 )
		{
			RemoveVehicleComponent ( vid, g_prev_comp [ playerid ] [ a1 ] ) ;
			g_prev_comp [ playerid ] [ a1 ] = 0 ;
		}
		if ( veh_info [ vid - 1 ] [ v_component ] [ a1 ] != 0 )
		{
			RemoveVehicleComponent ( vid, veh_info [ vid - 1 ] [ v_component ] [ a1 ] ) ;
			g_prev_rem [ playerid ] [ a1 ] = true ;
		}
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "RESTORE", true ) )
	{
		Mech_RestorePreview ( playerid ) ;
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	// ---- checkout: cart -> customer invoice, charged only on approval ----
	if ( ! strcmp ( cmd, "BUY", true ) )
	{
		new ci = 0 ;
		while ( inputtext [ ci ] == ' ' ) ci ++ ;
		while ( inputtext [ ci ] && inputtext [ ci ] != ' ' ) ci ++ ;
		while ( inputtext [ ci ] == ' ' ) ci ++ ;
		if ( ! inputtext [ ci ] ) { Mech_ShowMenu ( playerid ) ; return 1 ; }

		new items [ 700 ], total = 0, count = 0 ;
		new i = ci ;
		while ( inputtext [ i ] && count < 10 )
		{
			new itype = inputtext [ i ++ ] ;
			new x = - 1, y = - 1 ;
			if ( inputtext [ i ] == '.' ) { i ++ ; x = Mech_ReadNum ( inputtext, i ) ; }
			if ( inputtext [ i ] == '.' ) { i ++ ; y = Mech_ReadNum ( inputtext, i ) ; }
			new price, iname [ 48 ] ;
			if ( Mech_ItemInfo ( itype, x, y, vid, price, iname, sizeof iname ) )
			{
				new line [ 96 ] ;
				format ( line, sizeof line, "ITEM:%s|%d\n", iname, price ) ;
				strcat ( items, line ) ;
				total += price ;
				count ++ ;
			}
			while ( inputtext [ i ] && inputtext [ i ] != ';' ) i ++ ;
			if ( inputtext [ i ] == ';' ) i ++ ;
		}
		if ( count == 0 || total <= 0 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }

		strmid ( g_mech_cart [ playerid ], inputtext, ci, ci + 143 ) ;
		g_mech_cart_total [ playerid ] = total ;

		new mname [ MAX_PLAYER_NAME + 1 ] ;
		GetPlayerName ( playerid, mname, sizeof mname ) ;
		new body [ 1024 ] ;
		format ( body, sizeof body, "MECH:%s\n%sTOTAL:%d\nMONEY:%d\nهل توافق على الفاتورة وخصم المبلغ؟", mname, items, total, p_info [ target ] [ money ] ) ;
		show_dialog ( target, d_mech_invoice, DIALOG_STYLE_MSGBOX, "[!MECH_INVOICE]", body, "موافق", "رفض" ) ;
		SendClientMessage ( playerid, col_green, "{"#cGR"}[ميكانيكي] {"#cWH"}انرسلت الفاتورة للزبون — بانتظار موافقته." ) ;
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "COLOR", true ) )
	{
		if ( a1 < 0 || a1 > 255 || a2 < 0 || a2 > 255 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		if ( Mech_Charge ( playerid, target, MECH_PRICE_COLOR, "طلاء جديد (لونين)" ) )
		{
			veh_info [ vid - 1 ] [ v_color ] [ 0 ] = a1 ;
			veh_info [ vid - 1 ] [ v_color ] [ 1 ] = a2 ;
			ChangeVehicleColor ( vid, a1, a2 ) ;
			Mech_SaveVehicle ( vid ) ;
		}
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "PJ", true ) )
	{
		if ( a1 < 0 || a1 > 3 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		if ( Custom_GetVehicleDisplayModel ( vid ) > 611 && IsTuneBlockedModel ( Custom_GetVehicleDisplayModel ( vid ) ) )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}التعديل محظور على هذا الموديل (يسبب كراش)." ) ;
			Mech_ShowMenu ( playerid ) ;
			return 1 ;
		}
		if ( Mech_Charge ( playerid, target, MECH_PRICE_PJ, "بينت جوب" ) )
		{
			veh_info [ vid - 1 ] [ v_paint ] = a1 ;
			ChangeVehiclePaintjob ( vid, a1 ) ;
			if ( a1 == 3 ) ChangeVehicleColor ( vid, veh_info [ vid - 1 ] [ v_color ] [ 0 ], veh_info [ vid - 1 ] [ v_color ] [ 1 ] ) ;
			Mech_SaveVehicle ( vid ) ;
		}
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "COMP", true ) )
	{
		if ( a1 < 0 || a1 > 9 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		new compmodel ;
		if ( a1 == 0 ) compmodel = 1087 ;
		else if ( a1 == 1 ) compmodel = 1010 ;
		else compmodel = Mech_SlotModel ( a1, a2 ) ;
		if ( compmodel == 0 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }

		if ( ! IsVehicleComponentSafe ( vid, compmodel ) )
		{
			SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cWH"}هذا التعديل غير متوافق مع هذي السيارة." ) ;
			Mech_ShowMenu ( playerid ) ;
			return 1 ;
		}
		new sname [ 32 ] ;
		Mech_SlotName ( a1, sname, sizeof sname ) ;
		if ( Mech_Charge ( playerid, target, Mech_SlotPrice ( a1 ), sname ) )
		{
			veh_info [ vid - 1 ] [ v_component ] [ a1 ] = compmodel ;
			Safe_AddVehicleComponent ( vid, compmodel ) ;
			Mech_SaveVehicle ( vid ) ;
		}
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	if ( ! strcmp ( cmd, "REM", true ) )
	{
		if ( a1 < 0 || a1 > 9 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		new oldcomp = veh_info [ vid - 1 ] [ v_component ] [ a1 ] ;
		if ( oldcomp == 0 ) { Mech_ShowMenu ( playerid ) ; return 1 ; }
		new sname [ 32 ] ;
		Mech_SlotName ( a1, sname, sizeof sname ) ;
		new fullname [ 48 ] ;
		format ( fullname, sizeof fullname, "فك %s", sname ) ;
		if ( Mech_Charge ( playerid, target, MECH_PRICE_REMOVE, fullname ) )
		{
			veh_info [ vid - 1 ] [ v_component ] [ a1 ] = 0 ;
			RemoveVehicleComponent ( vid, oldcomp ) ;
			Mech_SaveVehicle ( vid ) ;
		}
		Mech_ShowMenu ( playerid ) ;
		return 1 ;
	}
	Mech_ShowMenu ( playerid ) ;
	return 1 ;
}

// Call from OnPlayerConnect / OnPlayerDisconnect.
stock Mech_OnPlayerConnect ( playerid )
{
	Mech_Reset ( playerid ) ;
}

stock Mech_OnPlayerDisconnect ( playerid )
{
	if ( g_mech_target [ playerid ] != INVALID_PLAYER_ID || g_mech_by [ playerid ] != INVALID_PLAYER_ID )
		Mech_EndSession ( playerid, "{"#cRD"}* {"#cWH"}انتهت جلسة التعديل (الطرف الآخر خرج)." ) ;
	Mech_Reset ( playerid ) ;
}
