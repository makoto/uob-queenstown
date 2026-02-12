#!/usr/bin/env bash
set -euo pipefail

echo "=== Regenerating processed layers ==="

if [ -d data/data-gov-sg ]; then
  echo "Running generate_subzone_summary.py..."
  python3 generate_subzone_summary.py

  echo ""
  echo "Running filter_queenstown_layers.py..."
  python3 filter_queenstown_layers.py
else
  echo "WARNING: data/data-gov-sg/ not found, skipping data regeneration"
  echo "  Committed files in docs/geo/ will be used as-is"
fi

echo ""
echo "Running generate_3dtiles.py..."
python3 generate_3dtiles.py

echo ""
echo "=== Pushing to main ==="
git push origin main
echo "=== Done ==="
