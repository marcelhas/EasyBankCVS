#!/usr/bin/env bash

set -eo pipefail
IFS=$'\n\t'
THIS_DIR="$(dirname "$0")"

[[ ! -f $1 ]] && echo "usage: $0 path/to/csv" && exit 1
CSV="$1"

TMP="$(mktemp -d)"

[[ -f "$THIS_DIR/filtered.csv" ]] && tail -n1 "$THIS_DIR/filtered.csv"
python "$THIS_DIR/easybank_csv_add_header.py" "$CSV" "$TMP/headered.csv"
python "$THIS_DIR/easybank_csv_filter.py" "$TMP/headered.csv" "$THIS_DIR/filtered.csv"

echo "Output in $THIS_DIR/filtered.csv"
echo "🤙 DONE"
