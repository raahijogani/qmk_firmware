#!/usr/bin/env bash
# Build both halves without flashing; run this script from any directory.
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
qmk_root="$(cd -- "$script_dir/../../.." && pwd)"
command -v qmk >/dev/null || { echo 'Error: qmk is not on PATH.' >&2; exit 1; }
cd -- "$qmk_root"

# Stage both outputs so a failed build leaves the existing pair untouched.
stage_dir="$(mktemp -d)"
trap 'rm -rf -- "$stage_dir"' EXIT
for half in left right; do
    echo "Building KLOR raahi ($half)..."
    # PROGRAM_CMD overrides deployment, while the split target sets handedness.
    qmk compile -c -kb geigeigeist/klor -km raahi \
        -t "uf2-split-$half" -e PROGRAM_CMD=true
    cp -- .build/geigeigeist_klor_raahi.uf2 "$stage_dir/klor_raahi_$half.uf2"
done

for half in left right; do
    cp -- "$stage_dir/klor_raahi_$half.uf2" "$script_dir/klor_raahi_$half.uf2"
    echo "Saved $script_dir/klor_raahi_$half.uf2"
done
