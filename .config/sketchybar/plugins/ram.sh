#!/bin/bash

# Meter = physical memory in use (active + wired + compressed pages).
# Turns red over 85%.

source "$CONFIG_DIR/colors.sh"

USED_PCT=$(vm_stat | awk -v total="$(sysctl -n hw.memsize)" -v page="$(pagesize)" '
  /Pages active/ || /Pages wired/ || /occupied by compressor/ { gsub(/\./, "", $NF); used += $NF }
  END { printf "%d", used * page * 100 / total }')

COLOR=$MUTED
[ "$USED_PCT" -gt 85 ] && COLOR=$RED

sketchybar --set "$NAME" slider.percentage="$USED_PCT" slider.highlight_color=$COLOR
