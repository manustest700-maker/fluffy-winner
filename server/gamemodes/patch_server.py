import io, sys

PATH = "/home/ubuntu/samp-server/gamemodes/arabonline.pwn"
with open(PATH, "rb") as f:
    data = f.read()

def repl(data, old, new, required=True):
    o = old.encode("ascii")
    n = new.encode("ascii")
    c = data.count(o)
    if c != 1:
        if required:
            raise SystemExit("anchor count %d for: %r" % (c, old))
        return data
    return data.replace(o, n)

# 1) enable the HUD tick timer
data = repl(data,
    '//[HUD REMOVED] SetTimer("PoliceHUD_Tick", 1500, true);',
    'SetTimer("PoliceHUD_Tick", 1500, true);')

# 2) remove the early-return that disabled PoliceHUD_Tick
data = repl(data,
    'return 1; //[HUD REMOVED] police HUD disabled',
    '/* [HUD] enabled */')

# 3) forward declarations before OnDialogResponse
fwd = (
    'forward Havana_CuffNearest ( playerid, params [ ] ) ;\n'
    'forward Havana_HudSetApply ( playerid, params [ ] ) ;\n'
    'forward Havana_HudResponse ( playerid, response, listitem, inputtext [ ] ) ;\n'
)
data = repl(data,
    'public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])',
    fwd + 'public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])')

# 4) early dispatch inside OnDialogResponse (before the p_dialog guard)
data = repl(data,
    'LostGifts_OnDialogResponse(playerid, dialogid, response, listitem)) return 1;',
    'LostGifts_OnDialogResponse(playerid, dialogid, response, listitem)) return 1;\n'
    '\tif ( dialogid == d_police_hud ) return Havana_HudResponse ( playerid, response, listitem, inputtext ) ;')

# 5) turn CMD:cuffnear into a thin wrapper + rename original body to Havana_CuffNearest
data = repl(data,
    'CMD:cuffnear(playerid, params[])',
    'CMD:cuffnear(playerid, params[]) { #pragma unused params return Havana_CuffNearest ( playerid, "" ) ; }\n'
    'Havana_CuffNearest(playerid, params[])')

# 6) turn CMD:hudset into a thin wrapper + rename original body to Havana_HudSetApply
data = repl(data,
    'CMD:hudset(playerid, params[])',
    'CMD:hudset(playerid, params[]) return Havana_HudSetApply ( playerid, params ) ;\n'
    'Havana_HudSetApply(playerid, params[])')

# 7) define Havana_HudResponse just before CMD:wantedrefresh (all callees defined earlier)
resp = (
    'Havana_HudResponse ( playerid, response, listitem, inputtext [ ] )\n'
    '{\n'
    '    #pragma unused response\n'
    '    #pragma unused listitem\n'
    '    if ( ! cop_player ( playerid ) && ! fbi_player ( playerid ) ) return 1 ;\n'
    '    if ( ! strcmp ( inputtext, "CUFF", true, 4 ) )\n'
    '    {\n'
    '        Havana_CuffNearest ( playerid, "" ) ;\n'
    '        if ( g_police_hud_state { playerid } ) Havana_PushWantedList ( playerid ) ;\n'
    '        return 1 ;\n'
    '    }\n'
    '    if ( ! strcmp ( inputtext, "HUD ", true, 4 ) )\n'
    '    {\n'
    '        new _p2 [ 128 ] ;\n'
    '        strmid ( _p2, inputtext, 4, strlen ( inputtext ), sizeof ( _p2 ) ) ;\n'
    '        Havana_HudSetApply ( playerid, _p2 ) ;\n'
    '        return 1 ;\n'
    '    }\n'
    '    return 1 ;\n'
    '}\n\n'
)
data = repl(data,
    'CMD:wantedrefresh ( playerid )',
    resp + 'CMD:wantedrefresh ( playerid )')

with open(PATH, "wb") as f:
    f.write(data)
print("server patched OK")
