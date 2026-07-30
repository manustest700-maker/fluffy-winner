# -*- coding: utf-8 -*-
# CP1256-safe byte-level patch: route the bank-loan overlay through the
# [!LOAN_UI] dialog channel (phone-style command loop) instead of the old
# ~LOAN_UI~ ClientMessage that the new launcher cannot intercept.
PATH = "arabonline.pwn"
with open(PATH, "rb") as f:
    data = f.read()

orig_len = len(data)
changes = 0

# 1) new dialog id in the enum (after d_card_ui, added by patch_card.py)
a = b"\td_card_ui,\n"
assert data.count(a) == 1, "d_card_ui enum anchor count=%d" % data.count(a)
data = data.replace(a, a + b"\td_loan_ui,\n", 1); changes += 1

# 2) build the payload without the ~LOAN_UI~ chat prefix
a = b'"~LOAN_UI~OPEN|'
assert data.count(a) == 1, "loan format anchor count=%d" % data.count(a)
data = data.replace(a, b'"OPEN|', 1); changes += 1

# 3) push over the dialog channel instead of SendClientMessage(chat)
a = b"SendClientMessage ( playerid, 0xFFFFFFFF, s ) ;"
assert data.count(a) == 1, "loan send anchor count=%d" % data.count(a)
data = data.replace(a, b"LoanPush ( playerid, s ) ;", 1); changes += 1

# 4) LoanPush + response handler, inserted before Havana_PhoneResponse
anchor = b"stock Havana_PhoneResponse ( playerid, response, inputtext [ ] )\n"
assert data.count(anchor) == 1, "phone response stock anchor count=%d" % data.count(anchor)
block = b"".join([
    b"forward Havana_LoanResponse ( playerid, response, inputtext [ ] ) ;\n",
    b"\n",
    b"stock LoanPush ( playerid, const payload [ ] )\n",
    b"{\n",
    b"\tif ( ! IsPlayerConnected ( playerid ) ) return 0 ;\n",
    b'\tShowPlayerDialog ( playerid, d_loan_ui, DIALOG_STYLE_MSGBOX, "[!LOAN_UI]", payload, " ", " " ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
    b"\n",
    b"public Havana_LoanResponse ( playerid, response, inputtext [ ] )\n",
    b"{\n",
    b"\tif ( response != 1 ) return 1 ;\n",
    b"\tnew idx = 0 ;\n",
    b"\twhile ( inputtext [ idx ] && inputtext [ idx ] != ' ' ) idx ++ ;\n",
    b"\tnew lcmd [ 16 ] ;\n",
    b"\tstrmid ( lcmd, inputtext, 0, idx, sizeof ( lcmd ) ) ;\n",
    b"\tnew rpos = idx ;\n",
    b"\tif ( inputtext [ rpos ] == ' ' ) rpos ++ ;\n",
    b"\tnew lrest [ 128 ] ;\n",
    b"\tstrmid ( lrest, inputtext, rpos, strlen ( inputtext ), sizeof ( lrest ) ) ;\n",
    b'\tif ( ! strcmp ( lcmd, "take", true ) ) return pc_cmd_loan_take ( playerid, lrest ) ;\n',
    b'\tif ( ! strcmp ( lcmd, "repay", true ) ) return pc_cmd_loan_repay ( playerid, lrest ) ;\n',
    b'\tif ( ! strcmp ( lcmd, "refresh", true ) ) return Loan_OpenForPlayer ( playerid ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
    b"\n",
])
data = data.replace(anchor, block + anchor, 1); changes += 1

# 5) route the dialog response (after the card no-op line added by patch_card.py)
a = b"\tif ( dialogid == d_card_ui ) return 1 ;\n"
assert data.count(a) == 1, "card response route anchor count=%d" % data.count(a)
data = data.replace(a, a + b"\tif ( dialogid == d_loan_ui ) return Havana_LoanResponse ( playerid, response, inputtext ) ;\n", 1); changes += 1

with open(PATH, "wb") as f:
    f.write(data)
print("changes=%d  bytes %d -> %d" % (changes, orig_len, len(data)))
