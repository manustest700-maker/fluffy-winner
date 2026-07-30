/*
    [CEF] Police statistics admin panel (SA:MP Mobile CEF)
    Command: /cefpolice  (admin only) - toggles a CEF browser window
    showing live police statistics (online cops, on-duty, wanted players).
*/

#define CEF_POLICE_URL "https://manustest534h-dev.github.io/havana-cef-ui/police.html"

new g_cef_police_state   [ MAX_PLAYERS char ] ; // 0 = no browser, 1 = init requested, 2 = browser ready
new g_cef_police_visible [ MAX_PLAYERS char ] ;

stock CefPolice_Reset ( playerid )
{
    g_cef_police_state   { playerid } = 0 ;
    g_cef_police_visible { playerid } = 0 ;
}

stock CefPolice_BuildStats ( dest [ ], size = sizeof dest )
{
    new cop_total = 0, cop_duty = 0, wanted_count = 0 ;
    new entry [ 96 ] ;
    new bool:first = true ;

    dest [ 0 ] = EOS ;
    strcat ( dest, "{\"cops\":[", size ) ;

    foreach(new i : logged_players)
    {
        if ( p_info [ i ] [ wanted ] > 0 ) wanted_count ++ ;

        if ( ! cop_player ( i ) && ! fbi_player ( i ) ) continue ;

        cop_total ++ ;
        if ( is_fraction_duty { i } ) cop_duty ++ ;

        format ( entry, sizeof entry, "%s{\"n\":\"%s\",\"i\":%d,\"f\":%d,\"r\":%d,\"d\":%d}",
            first ? ( "" ) : ( "," ),
            p_info [ i ] [ name ], i,
            p_info [ i ] [ member ],
            p_info [ i ] [ rank ],
            is_fraction_duty { i } ? 1 : 0 ) ;
        strcat ( dest, entry, size ) ;
        first = false ;
    }

    format ( entry, sizeof entry, "],\"total\":%d,\"duty\":%d,\"wanted\":%d}", cop_total, cop_duty, wanted_count ) ;
    strcat ( dest, entry, size ) ;
}

stock CefPolice_Show ( playerid )
{
    new cef_stats_json [ CEF_MAX_EVENT_DATA_LENGTH ] ;
    CefPolice_BuildStats ( cef_stats_json ) ;

    CefSendEvent ( playerid, "police:stats", cef_stats_json ) ;
    CefShowBrowser ( playerid ) ;
    CefChangeBrowserFocus ( playerid, true ) ;
    g_cef_police_visible { playerid } = 1 ;
}

stock CefPolice_Hide ( playerid )
{
    CefSendEvent ( playerid, "police:hide", "[]" ) ;
    CefChangeBrowserFocus ( playerid, false ) ;
    CefHideBrowser ( playerid ) ;
    g_cef_police_visible { playerid } = 0 ;
}

CMD:cefpolice ( playerid )
{
    if ( p_info [ playerid ] [ admin ] < 1 ) return 1 ;

    if ( ! CefIsPlayerHasLibrary ( playerid ) )
        return SendClientMessage ( playerid, col_gray, "{"#cRD"}* {"#cGR"}جهازك لا يدعم CEF - حدث اللعبة الى نسخة تدعم CEF" ) ;

    if ( g_cef_police_visible { playerid } )
    {
        CefPolice_Hide ( playerid ) ;
        return 1 ;
    }

    switch ( g_cef_police_state { playerid } )
    {
        case 0 :
        {
            g_cef_police_state { playerid } = 1 ;
            CefInitBrowser ( playerid, CEF_POLICE_URL ) ;
            SendClientMessage ( playerid, col_gray, "{"#cBL"}* {"#cWH"}جاري تحميل واجهة CEF ..." ) ;
        }
        case 1 : SendClientMessage ( playerid, col_gray, "{"#cBL"}* {"#cWH"}الواجهة قيد التحميل، انتظر قليلا" ) ;
        case 2 : CefPolice_Show ( playerid ) ;
    }
    return 1 ;
}

forward OnCefBrowserInit ( playerid, is_init, error_code ) ;
public OnCefBrowserInit ( playerid, is_init, error_code )
{
    if ( ! is_init )
    {
        g_cef_police_state { playerid } = 0 ;
        new err_msg [ 96 ] ;
        format ( err_msg, sizeof err_msg, "{"#cRD"}* {"#cGR"}فشل تحميل متصفح CEF ( خطأ: %d )", error_code ) ;
        SendClientMessage ( playerid, col_gray, err_msg ) ;
        return 1 ;
    }

    if ( g_cef_police_state { playerid } == 1 )
    {
        g_cef_police_state { playerid } = 2 ;
        CefPolice_Show ( playerid ) ;
    }
    else g_cef_police_state { playerid } = 2 ;

    return 1 ;
}

forward OnCefPoliceClose ( playerid, event_data [ ] ) ;
public OnCefPoliceClose ( playerid, event_data [ ] )
{
    CefChangeBrowserFocus ( playerid, false ) ;
    CefHideBrowser ( playerid ) ;
    g_cef_police_visible { playerid } = 0 ;
    return 1 ;
}
