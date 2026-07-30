# -*- coding: utf-8 -*-
# CP1256-safe byte-level patch: wire the Mastercard/ATM verification overlay
# to the [!CARD_UI] dialog channel (replaces the missing atm_card filterscript).
import io, sys

PATH = "arabonline.pwn"
with open(PATH, "rb") as f:
    data = f.read()

def cp(s):
    return s.encode("cp1256")

orig_len = len(data)
changes = 0

# 1) add d_card_ui to the dialog enum (right after d_phone_ui,)
a = b"\td_phone_ui,\n"
b = b"\td_phone_ui,\n\td_card_ui,\n"
assert data.count(a) == 1, "d_phone_ui enum anchor count=%d" % data.count(a)
data = data.replace(a, b, 1); changes += 1

# 2) insert CardPush + ATM verification flow after the PhonePush stock
anchor = (b'\tShowPlayerDialog ( playerid, d_phone_ui, DIALOG_STYLE_MSGBOX, "[!PHONE_UI]", payload, " ", " " ) ;\n'
          b'\treturn 1 ;\n'
          b'}\n')
assert data.count(anchor) == 1, "PhonePush anchor count=%d" % data.count(anchor)

block = b"".join([
    b"\n",
    b"forward havana_atm_card_cb ( playerid ) ;\n",
    b"forward HavanaCardApprove ( playerid ) ;\n",
    b"forward HavanaAtmOpen ( playerid ) ;\n",
    b"\n",
    b"stock CardPush ( playerid, const body [ ] )\n",
    b"{\n",
    b"\tif ( ! IsPlayerConnected ( playerid ) ) return 0 ;\n",
    b'\tShowPlayerDialog ( playerid, d_card_ui, DIALOG_STYLE_MSGBOX, "[!CARD_UI]", body, " ", " " ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
    b"\n",
    b"stock HavanaAtmCardRequest ( playerid )\n",
    b"{\n",
    b"\tnew q_card_chk [ 128 ] ;\n",
    b'\tformat ( q_card_chk, sizeof ( q_card_chk ), "SELECT `u_has_card` FROM `users` WHERE `u_id` = \'%d\' LIMIT 1", p_info [ playerid ] [ id ] ) ;\n',
    b'\tmysql_tquery ( sql_connection, q_card_chk, "havana_atm_card_cb", "i", playerid ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
    b"\n",
    b"public havana_atm_card_cb ( playerid )\n",
    b"{\n",
    b"\tif ( ! IsPlayerConnected ( playerid ) ) return 1 ;\n",
    b"\tnew rows, fields ;\n",
    b"\tcache_get_data ( rows, fields ) ;\n",
    b"\tnew has_card = 0 ;\n",
    b'\tif ( rows > 0 ) has_card = cache_get_field_content_int ( 0, "u_has_card", sql_connection ) ;\n',
    b"\tif ( ! has_card )\n",
    b"\t{\n",
    b'\t\tCardPush ( playerid, "NEEDCARD|' + cp("تحتاج بطاقة Mastercard من البنك المركزي — السعر: $50,000") + b'" ) ;\n',
    b"\t\treturn 1 ;\n",
    b"\t}\n",
    b'\tCardPush ( playerid, "VERIFY" ) ;\n',
    b'\tSetTimerEx ( "HavanaCardApprove", 2600, false, "i", playerid ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
    b"\n",
    b"public HavanaCardApprove ( playerid )\n",
    b"{\n",
    b"\tif ( ! IsPlayerConnected ( playerid ) ) return 1 ;\n",
    b'\tCardPush ( playerid, "APPROVED|' + cp("تم التحقق — جاري فتح الصراف") + b'" ) ;\n',
    b'\tSetTimerEx ( "HavanaAtmOpen", 1500, false, "i", playerid ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n",
    b"\n",
    b"public HavanaAtmOpen ( playerid )\n",
    b"{\n",
    b"\tif ( ! IsPlayerConnected ( playerid ) ) return 1 ;\n",
    b"\tGamemodeAtmShowDialog ( playerid ) ;\n",
    b"\treturn 1 ;\n",
    b"}\n",
])
data = data.replace(anchor, anchor + block, 1); changes += 1

# 3) replace the ATM gate call (missing filterscript) with the inline flow
gate = b'CallRemoteFunction ( "AtmCard_GamemodeRequest", "i", playerid ) ;'
assert data.count(gate) == 1, "ATM gate anchor count=%d" % data.count(gate)
data = data.replace(gate, b"HavanaAtmCardRequest ( playerid ) ;", 1); changes += 1

# 4) swallow the d_card_ui dialog response (no-op) in OnDialogResponse
resp = b"\tif ( dialogid == d_phone_ui ) return Havana_PhoneResponse ( playerid, response, inputtext ) ;\n"
assert data.count(resp) == 1, "phone response anchor count=%d" % data.count(resp)
data = data.replace(resp, resp + b"\tif ( dialogid == d_card_ui ) return 1 ;\n", 1); changes += 1

with open(PATH, "wb") as f:
    f.write(data)

print("changes=%d  bytes %d -> %d" % (changes, orig_len, len(data)))
