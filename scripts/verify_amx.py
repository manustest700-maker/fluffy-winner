#!/usr/bin/env python3
"""Verify that an AMX is compatible with SA-MP 0.3.7."""

from pathlib import Path
import struct
import sys


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {Path(sys.argv[0]).name} <file.amx>", file=sys.stderr)
        return 2

    path = Path(sys.argv[1])
    actual_size = path.stat().st_size
    declared_size, magic, file_version, amx_version, flags, defsize = struct.unpack(
        "<I H B B h h", path.read_bytes()[:12]
    )

    problems = []
    if magic != 0xF1E0:
        problems.append(f"invalid AMX magic: 0x{magic:04x}")
    if file_version != 8 or amx_version != 8:
        problems.append(
            f"SA-MP 0.3.7 requires version 8/8, got {file_version}/{amx_version}"
        )
    if declared_size != actual_size:
        problems.append(
            f"size mismatch: header={declared_size}, file={actual_size}"
        )
    if defsize != 8:
        problems.append(f"unexpected definition size: {defsize}")

    if problems:
        print("\n".join(problems), file=sys.stderr)
        return 1

    print(
        f"AMX OK: version={file_version}/{amx_version} "
        f"size={actual_size} flags=0x{flags & 0xFFFF:04x}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
