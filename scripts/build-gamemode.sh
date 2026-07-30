#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
gamemode_dir="$repo_root/server/gamemodes"
compiler="$repo_root/server/pawncc/pawncc"
output="$gamemode_dir/arabonline.amx"
temporary="$gamemode_dir/arabonline.build.amx"
log_file="$(mktemp)"
trap 'rm -f "$temporary" "$log_file"' EXIT

if grep -aq '"CHANGE_ME"' "$gamemode_dir/arabonline.pwn" \
    && [[ "${ALLOW_PLACEHOLDER_DB:-0}" != "1" ]]; then
    echo "Set the deployment database password in arabonline.pwn before building." >&2
    echo "Use ALLOW_PLACEHOLDER_DB=1 only for a non-deployable verification build." >&2
    exit 1
fi

cd "$gamemode_dir"
if ! "$compiler" arabonline.pwn -iinclude -o"$temporary" -d1 -O1 -v1 \
    >"$log_file" 2>&1; then
    grep -E ': (fatal )?error |Compilation aborted' "$log_file" >&2 || tail -100 "$log_file" >&2
    exit 1
fi

python3 "$repo_root/scripts/verify_amx.py" "$temporary"
install -m 0644 "$temporary" "$output"
warnings="$(grep -c ': warning ' "$log_file" || true)"
echo "Compiled $output with Pawn 3.10.10 (-O1 for AMX v8); legacy warnings: $warnings"
