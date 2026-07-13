#!/usr/bin/env bash
#
# Runs QUIPS scoring (step 2: md -> json) for all study subdirs in data_md_converted/.
# Individual MD files that already have a corresponding JSON in outputs/ are skipped
# by 01__run_quips_scoring.py itself.
#

set -euo pipefail

SCRIPT="01__run_quips_scoring.py"
DATA_DIR="data_md_converted"
OUTPUTS_DIR="outputs"

for study_dir in "$DATA_DIR"/*/; do
    study=$(basename "$study_dir")

    # Skip test sample directories
    if [[ "$study" == TEST_SAMPLE* ]]; then
        echo "Skipping test dir: $study"
        continue
    fi

    echo "=== $study ==="
    python3 "$SCRIPT" -i "$DATA_DIR/$study" -o "$OUTPUTS_DIR/$study"
done

echo "All done."
