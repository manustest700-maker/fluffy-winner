# -*- coding: utf-8 -*-
# CP1256-safe byte-level patch: wire the weapon-crafting table overlay to the
# [!CRAFT_UI] dialog channel (old launcher used ~CRAFT_UI~ ClientMessages which
# would leak into chat on the new Java launcher).
PATH = "arabonline.pwn"
with open(PATH, "rb") as f:
    data = f.read()

def cp(s): return s.encode("cp1256")

orig_len = len(data)
changes = 0

# 1) add d_craft_ui to the dialog enum (after d_loan_ui,)
a = b"\td_loan_ui,\n"
assert data.count(a) == 1, "d_loan_ui enum anchor count=%d" % data.count(a)
data = data.replace(a, b"\td_loan_ui,\n\td_craft_ui,\n", 1); changes += 1

# 2) add CraftPush stock + Havana_CraftResponse dispatcher after LoanPush
anchor = (b'\tShowPlayerDialog ( playerid, d_loan_ui, DIALOG_STYLE_MSGBOX, "[!LOAN_UI]", payload, " ", " " ) ;\n'
          b'\treturn 1 ;\n'
          b'}\n')
assert data.count(anchor) == 1, "LoanPush anchor count=%d" % data.count(anchor)

block = b"".join([
    b"\n",
    b"forward Havana_CraftResponse ( playerid, response, inputtext [ ] ) ;\n",
    b"\n",
    b"stock CraftPush ( playerid, const body [ ] )\n",
    b"{\n",
    b"\tif ( ! IsPlayerConnected ( playerid ) ) return 0 ;\n",
    b'\tShowPlayerDialog ( playerid, d_craft_ui, DIALOG_STYLE_MSGBOX, "[!CRAFT_UI]", body, " ", " " ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
    b"\n",
    b"public Havana_CraftResponse ( playerid, response, inputtext [ ] )\n",
    b"{\n",
    b"\tif ( ! response ) return pc_cmd_craft_close ( playerid, \"\" ) ;\n",
    b"\tnew idx = 0 ;\n",
    b"\twhile ( inputtext [ idx ] && inputtext [ idx ] != ' ' ) idx ++ ;\n",
    b"\tnew ccmd [ 16 ] ;\n",
    b"\tstrmid ( ccmd, inputtext, 0, idx, sizeof ( ccmd ) ) ;\n",
    b"\tnew rpos = idx ;\n",
    b"\tif ( inputtext [ rpos ] == ' ' ) rpos ++ ;\n",
    b"\tnew crest [ 32 ] ;\n",
    b"\tstrmid ( crest, inputtext, rpos, strlen ( inputtext ), sizeof ( crest ) ) ;\n",
    b'\tif ( ! strcmp ( ccmd, "DONE", true ) ) return pc_cmd_craft_done ( playerid, crest ) ;\n',
    b'\tif ( ! strcmp ( ccmd, "PICK", true ) ) return pc_cmd_craft_pick ( playerid, crest ) ;\n',
    b'\tif ( ! strcmp ( ccmd, "BULLET", true ) ) return pc_cmd_craft_bullet ( playerid, "" ) ;\n',
    b'\tif ( ! strcmp ( ccmd, "CLOSE", true ) ) return pc_cmd_craft_close ( playerid, "" ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
])
data = data.replace(anchor, anchor + block, 1); changes += 1

# 3) convert all literal ~CRAFT_UI~ ClientMessages to CraftPush (13 sites)
lit = b'SendClientMessage ( playerid, 0xFFFFFFFF, "~CRAFT_UI~'
n = data.count(lit)
assert n == 13, "literal CRAFT SCM count=%d" % n
data = data.replace(lit, b'CraftPush ( playerid, "'); changes += n

# 4) OPEN payload (formatted into mat_string)
a = b'"~CRAFT_UI~OPEN|'
assert data.count(a) == 1, "OPEN fmt count=%d" % data.count(a)
data = data.replace(a, b'"OPEN|', 1); changes += 1
a = b"SendClientMessage ( playerid, 0xFFFFFFFF, mat_string ) ;"
assert data.count(a) == 1, "mat_string SCM count=%d" % data.count(a)
data = data.replace(a, b"CraftPush ( playerid, mat_string ) ;", 1); changes += 1

# 5) PROG payload (formatted into buf inside CraftTable_TickProgress)
a = (b'    format ( buf, sizeof buf, "~CRAFT_UI~PROG|%d", pct ) ;\n'
     b'    SendClientMessage ( playerid, 0xFFFFFFFF, buf ) ;\n')
assert data.count(a) == 1, "PROG block count=%d" % data.count(a)
data = data.replace(a,
    b'    format ( buf, sizeof buf, "PROG|%d", pct ) ;\n'
    b'    CraftPush ( playerid, buf ) ;\n', 1); changes += 1

# 6) route d_craft_ui responses in OnDialogResponse
resp = b"\tif ( dialogid == d_loan_ui ) return Havana_LoanResponse ( playerid, response, inputtext ) ;\n"
assert data.count(resp) == 1, "loan response anchor count=%d" % data.count(resp)
data = data.replace(resp,
    resp + b"\tif ( dialogid == d_craft_ui ) return Havana_CraftResponse ( playerid, response, inputtext ) ;\n",
    1); changes += 1

with open(PATH, "wb") as f:
    f.write(data)

print("changes=%d  bytes %d -> %d" % (changes, orig_len, len(data)))
