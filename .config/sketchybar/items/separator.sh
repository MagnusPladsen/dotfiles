#!/bin/bash

# ── Middle-dot separator between right-side readouts ──
# Usage (sourced): source separator.sh <item-name>

sketchybar --add item "$1" right \
  --set "$1" label="·" label.color=$FAINT label.padding_left=6 label.padding_right=6
