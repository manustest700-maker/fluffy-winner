# fluffy-winner

SA-MP 0.3.7 gamemode sources are stored in Windows-1256 (CP1256). Do not save
`server/gamemodes/arabonline.pwn` as UTF-8.

## Arabic reports

Arabic reports must be entered directly in chat:

```text
/report أحتاج مساعدة من الإدارة
```

The report path accepts both UTF-8 mobile input and native CP1256 input, then
stores and sends one CP1256 string to administrators. The main-menu report item
also tells players to use this command because SA-MP 0.3.7 input dialogs do not
reliably carry Arabic text.

## Build

Build the 64-bit Pawn 3.10.10 compiler from the pinned upstream tag:

```bash
./scripts/build-pawn-compiler.sh
```

After setting the deployment database password in the local source, compile the
gamemode and verify its header:

```bash
./scripts/build-gamemode.sh
python3 scripts/verify_amx.py server/gamemodes/arabonline.amx
```

The gamemode command deliberately uses `-O1`. Pawn 3.10.10 emits AMX version 9
with `-O2`, while SA-MP 0.3.7 requires both AMX version fields to be 8.
