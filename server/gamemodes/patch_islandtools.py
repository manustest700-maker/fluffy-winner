# -*- coding: utf-8 -*-
# CP1256-safe byte-level patch: route the island tool extraction HUD to the
# [!ISLAND_TOOL] dialog channel (old launcher used ~ISLANDTOOL~ ClientMessages
# which would leak into chat on the new Java launcher). Display-only.
PATH = "arabonline.pwn"
with open(PATH, "rb") as f:
    data = f.read()

orig_len = len(data); changes = 0

# 1) enum
a = b"\td_craft_ui,\n"
assert data.count(a) == 1, "d_craft_ui enum anchor=%d" % data.count(a)
data = data.replace(a, b"\td_craft_ui,\n\td_island_tool,\n", 1); changes += 1

# 2) IslandToolPush stock after CraftPush block (anchor on Havana_CraftResponse forward)
anchor = b"forward Havana_CraftResponse ( playerid, response, inputtext [ ] ) ;\n"
assert data.count(anchor) == 1, "craft forward anchor=%d" % data.count(anchor)
block = b"".join([
    b"stock IslandToolPush ( playerid, const body [ ] )\n",
    b"{\n",
    b"\tif ( ! IsPlayerConnected ( playerid ) ) return 0 ;\n",
    b'\tShowPlayerDialog ( playerid, d_island_tool, DIALOG_STYLE_MSGBOX, "[!ISLAND_TOOL]", body, " ", " " ) ;\n',
    b"\treturn 1 ;\n",
    b"}\n\n",
])
data = data.replace(anchor, block + anchor, 1); changes += 1

# 3) hide literal
a = b'SendClientMessage ( playerid, 0xFFFFFFFF, "~ISLANDTOOL~hide" ) ;'
assert data.count(a) == 1
data = data.replace(a, b'IslandToolPush ( playerid, "hide" ) ;', 1); changes += 1

# 4) progress tick block
a = (b'    format ( payload, sizeof payload, "~ISLANDTOOL~progress=%d;name=%s", g_havana_island_tool_progress [ playerid ], item_name ) ;\n'
     b'    SendClientMessage ( playerid, 0xFFFFFFFF, payload ) ;')
assert data.count(a) == 1
data = data.replace(a,
    b'    format ( payload, sizeof payload, "progress=%d;name=%s", g_havana_island_tool_progress [ playerid ], item_name ) ;\n'
    b'    IslandToolPush ( playerid, payload ) ;', 1); changes += 1

# 5) start block
a = (b'    format ( payload, sizeof payload, "~ISLANDTOOL~progress=0;name=%s", item_name ) ;\n'
     b'    SendClientMessage ( playerid, 0xFFFFFFFF, payload ) ;')
assert data.count(a) == 1
data = data.replace(a,
    b'    format ( payload, sizeof payload, "progress=0;name=%s", item_name ) ;\n'
    b'    IslandToolPush ( playerid, payload ) ;', 1); changes += 1

# 6) swallow d_island_tool in OnDialogResponse
resp = b"\tif ( dialogid == d_craft_ui ) return Havana_CraftResponse ( playerid, response, inputtext ) ;\n"
assert data.count(resp) == 1
data = data.replace(resp, resp + b"\tif ( dialogid == d_island_tool ) return 1 ;\n", 1); changes += 1

with open(PATH, "wb") as f:
    f.write(data)
print("changes=%d bytes %d -> %d" % (changes, orig_len, len(data)))
