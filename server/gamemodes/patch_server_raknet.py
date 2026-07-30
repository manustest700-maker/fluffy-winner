import sys

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

# 1) Drop the post-cuff re-arm dialog. The launcher keeps the button on screen
#    on its own and answers every signal dialog immediately (to keep the on-foot
#    controls visible), so re-showing [!POLICE_HUD_ON] here only causes a brief
#    "dialog mode" freeze after each cuff.
data = repl(data,
    'if ( g_police_hud_state { playerid } ) ShowPlayerDialog ( playerid, d_police_hud, DIALOG_STYLE_MSGBOX, "[!POLICE_HUD_ON]", " ", " ", " " ) ;',
    '/* no re-arm: launcher keeps the button; taps arrive via the RakNet catch below */')

# 2) Add a RakNet incoming-RPC catch for DialogResponse (RPC 62). Because the
#    launcher answers (and thus closes/unfreezes) every [!POLICE_HUD_*] signal
#    dialog right away, there is no pending server-side dialog when the officer
#    taps the cuff button, so SA-MP core silently drops that DialogResponse.
#    Here we intercept RPC 62, and for our own dialog id route the payload
#    straight to Havana_HudResponse, independent of the core's dialog gating.
handler = (
    '// =============================================================================\n'
    '// [HAVANA] RakNet catch for the police-HUD (cuff) button. See notes above.\n'
    '// =============================================================================\n'
    'const DIALOG_RESPONSE_RPC = 62;\n'
    'IRPC:DIALOG_RESPONSE_RPC(playerid, BitStream:bs)\n'
    '{\n'
    '    new hud_dialogid;\n'
    '    BS_ReadValue(bs, PR_UINT16, hud_dialogid);\n'
    '    if (hud_dialogid != d_police_hud)\n'
    '    {\n'
    '        BS_SetReadOffset(bs, 0);\n'
    '        return 1; // not our dialog: hand the packet back to the core untouched\n'
    '    }\n'
    '    // Recover the ASCII payload ("CUFF" / "HUD x y ...") from the rest of the\n'
    '    // packet. We scan printable bytes so we do not depend on the exact width of\n'
    '    // the response / listitem / length fields.\n'
    '    new unread; BS_GetNumberOfUnreadBits(bs, unread);\n'
    '    new nbytes = unread / 8;\n'
    '    new tail[192], ch, cnt = 0;\n'
    '    for (new i = 0; i < nbytes && cnt < sizeof(tail) - 1; i++)\n'
    '    {\n'
    '        BS_ReadValue(bs, PR_UINT8, ch);\n'
    '        if (ch >= 32 && ch <= 126) tail[cnt++] = ch;\n'
    '    }\n'
    '    tail[cnt] = EOS;\n'
    '\n'
    '    if (strfind(tail, "CUFF", true) != -1)\n'
    '    {\n'
    '        Havana_HudResponse(playerid, 1, 0, "CUFF");\n'
    '        return 0;\n'
    '    }\n'
    '    new idx = strfind(tail, "HUD ", true);\n'
    '    if (idx != -1)\n'
    '    {\n'
    '        new payload[160];\n'
    '        strmid(payload, tail, idx, strlen(tail), sizeof(payload));\n'
    '        Havana_HudResponse(playerid, 1, 0, payload);\n'
    '        return 0;\n'
    '    }\n'
    '    return 0; // PONG or any other consumed signal-dialog answer: swallow\n'
    '}\n'
    '\n'
)
data = repl(data,
    'CMD:wantedrefresh ( playerid )',
    handler + 'CMD:wantedrefresh ( playerid )')

with open(PATH, "wb") as f:
    f.write(data)
print("server RakNet patch applied OK")
