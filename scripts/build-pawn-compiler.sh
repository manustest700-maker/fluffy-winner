#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="${PAWN_SOURCE_DIR:-/tmp/pawn-compiler-v3.10.10}"
build_dir="$source_dir/source/compiler/build"

if [[ ! -d "$source_dir/.git" ]]; then
    git clone --depth 1 --branch v3.10.10 \
        https://github.com/pawn-lang/compiler.git "$source_dir"
fi

cmake -S "$source_dir/source/compiler" -B "$build_dir" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_BUILD_RPATH_USE_ORIGIN=TRUE \
    -DCMAKE_INSTALL_RPATH='$ORIGIN'
cmake --build "$build_dir" --target pawncc --parallel "$(nproc)"

install -m 0755 "$build_dir/pawncc" "$repo_root/server/pawncc/pawncc"
install -m 0755 "$build_dir/libpawnc.so" "$repo_root/server/pawncc/libpawnc.so"
"$repo_root/server/pawncc/pawncc" 2>&1 | head -1
