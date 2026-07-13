#!/usr/bin/env bash
#
# Converts QUIPS JSON scores to TSV for all studies in data_md_converted/.
# Skips studies that already have a quips_summary.tsv in outputs/.
# Skips studies whose outputs/ directory does not yet exist (step 01 not run).
#

set -euo pipefail

SCRIPT="02__convert_scores_to_tsv.py"
DATA_DIR="data_md_converted"
OUTPUTS_DIR="outputs"

for study_dir in "$DATA_DIR"/*/; do
    study=$(basename "$study_dir")

    # Skip test sample directories
    if [[ "$study" == TEST_SAMPLE* ]]; then
        echo "Skipping test dir: $study"
        continue
    fi

    output_dir="$OUTPUTS_DIR/$study"
    tsv_file="$output_dir/quips_summary.tsv"

    # Skip if outputs dir doesn't exist yet (step 01 not run for this study)
    if [[ ! -d "$output_dir" ]]; then
        echo "No outputs dir for: $study (step 01 not yet run) — skipping"
        continue
    fi

    # Skip if TSV already exists
    if [[ -f "$tsv_file" ]]; then
        echo "Already done: $study"
        continue
    fi

    echo "Converting: $study"
    python3 "$SCRIPT" -i "$output_dir" -o "$tsv_file"
done

echo "Done."
