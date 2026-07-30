/*
 *  Launcher Gate (HavanaRP)
 *  ========================
 *  Verifies every connecting player against the launcher backend.
 *  Players whose client was not started through the official launcher
 *  (no valid auth ticket on the backend) are rejected and kicked.
 *
 *  Backend: https://havanarp-launcher-gate.onrender.com
 *  Route:   GET /api/server/verify?key=<secret>&nick=<name>&ip=<ip>
 *  200 = accepted, anything else = rejected (426 = launcher update missing).
 */

#include <requests>

#define LG_ENDPOINT   "https://havanarp-launcher-gate.onrender.com"
#define LG_VERIFY     "/api/server/verify"
#define LG_KEY        "4598738499ad190bdfdd609c21905029d0005f8a0bbc46308ecdf8fa4e30a540"
#define LG_MAX_RETRY  1

static RequestsClient:lg_client = RequestsClient:-1 ;
static lg_req_player [ 4096 ] ;

forward LauncherGate_OnWarm   ( Request:id, E_HTTP_STATUS:status, data [ ], dataLen ) ;
forward LauncherGate_OnVerify ( Request:id, E_HTTP_STATUS:status, data [ ], dataLen ) ;
forward LauncherGate_Kick     ( playerid ) ;

stock LauncherGate_Init ( )
{
	lg_client = RequestsClient ( LG_ENDPOINT, RequestHeaders ( "Connection", "keep-alive" ) ) ;
	if ( lg_client == RequestsClient:-1 )
	{
		print ( "[LAUNCHER_GATE] failed to initialize requests clients" ) ;
		return 0 ;
	}
	for ( new i = 0 ; i < sizeof ( lg_req_player ) ; i ++ ) lg_req_player [ i ] = INVALID_PLAYER_ID ;
	// warm up the backend (free-tier hosts sleep when idle)
	Request ( lg_client, LG_VERIFY "?key=" LG_KEY "&nick=__warmup__&ip=0.0.0.0", HTTP_METHOD_GET, "LauncherGate_OnWarm" ) ;
	return 1 ;
}

stock LauncherGate_SendVerify ( playerid )
{
	if ( lg_client == RequestsClient:-1 ) return 0 ;

	new nick [ MAX_PLAYER_NAME + 1 ], ip [ 16 ], path [ 256 ] ;
	GetPlayerName ( playerid, nick, sizeof ( nick ) ) ;
	GetPlayerIp ( playerid, ip, sizeof ( ip ) ) ;
	format ( path, sizeof ( path ), "%s?key=%s&nick=%s&ip=%s", LG_VERIFY, LG_KEY, nick, ip ) ;

	new Request:req = Request ( lg_client, path, HTTP_METHOD_GET, "LauncherGate_OnVerify" ) ;
	if ( _:req >= 0 && _:req < sizeof ( lg_req_player ) )
	{
		lg_req_player [ _:req ] = playerid ;
		SetPVarInt ( playerid, "launcher_gate_request", _:req ) ;
		SetPVarInt ( playerid, "launcher_gate_pending", 1 ) ;
	}
	return 1 ;
}

stock LauncherGate_OnPlayerConnect ( playerid )
{
	if ( IsPlayerNPC ( playerid ) ) return 1 ;
	new ip [ 16 ] ;
	GetPlayerIp ( playerid, ip, sizeof ( ip ) ) ;
	if ( ! strcmp ( ip, "127.0.0.1" ) ) return 1 ;
	SetPVarInt ( playerid, "launcher_gate_retry", 0 ) ;
	LauncherGate_SendVerify ( playerid ) ;
	return 1 ;
}

public LauncherGate_OnWarm ( Request:id, E_HTTP_STATUS:status, data [ ], dataLen )
{
	printf ( "[LAUNCHER_GATE] backend warm status=%d", _:status ) ;
	return 1 ;
}

public LauncherGate_OnVerify ( Request:id, E_HTTP_STATUS:status, data [ ], dataLen )
{
	if ( _:id < 0 || _:id >= sizeof ( lg_req_player ) ) return 1 ;
	new playerid = lg_req_player [ _:id ] ;
	lg_req_player [ _:id ] = INVALID_PLAYER_ID ;

	if ( playerid == INVALID_PLAYER_ID || ! IsPlayerConnected ( playerid ) ) return 1 ;
	if ( GetPVarInt ( playerid, "launcher_gate_request" ) != _:id ) return 1 ;
	DeletePVar ( playerid, "launcher_gate_pending" ) ;
	DeletePVar ( playerid, "launcher_gate_request" ) ;

	if ( status == HTTP_STATUS_OK )
	{
		printf ( "[LAUNCHER_GATE] accepted playerid=%d", playerid ) ;
		return 1 ;
	}

	printf ( "[LAUNCHER_GATE] rejected playerid=%d status=%d data=%s", playerid, _:status, data ) ;
	SendClientMessage ( playerid, 0xFF4444FF, "{"#cRD"}* {"#cWH"}لازم تدخل السيرفر من اللانشر الرسمي. حمّل آخر تحديث من اللانشر وحاول من جديد." ) ;
	SetTimerEx ( "LauncherGate_Kick", 1000, false, "d", playerid ) ;
	return 1 ;
}

public LauncherGate_Kick ( playerid )
{
	if ( IsPlayerConnected ( playerid ) ) Kick ( playerid ) ;
	return 1 ;
}

public OnRequestFailure ( Request:id, errorCode, errorMessage [ ], len )
{
	if ( _:id < 0 || _:id >= sizeof ( lg_req_player ) ) return 1 ;
	new playerid = lg_req_player [ _:id ] ;
	lg_req_player [ _:id ] = INVALID_PLAYER_ID ;
	if ( playerid == INVALID_PLAYER_ID || ! IsPlayerConnected ( playerid ) ) return 1 ;

	printf ( "[LAUNCHER_GATE] request failed playerid=%d error=%d message=%s", playerid, errorCode, errorMessage ) ;

	new retry = GetPVarInt ( playerid, "launcher_gate_retry" ) ;
	if ( retry < LG_MAX_RETRY )
	{
		SetPVarInt ( playerid, "launcher_gate_retry", retry + 1 ) ;
		printf ( "[LAUNCHER_GATE] retrying playerid=%d after error=%d", playerid, errorCode ) ;
		LauncherGate_SendVerify ( playerid ) ;
		return 1 ;
	}
	// backend unreachable -- fail open so real players are not locked out
	DeletePVar ( playerid, "launcher_gate_pending" ) ;
	DeletePVar ( playerid, "launcher_gate_request" ) ;
	return 1 ;
}
