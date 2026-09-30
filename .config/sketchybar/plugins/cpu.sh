#!/bin/bash

# Meter = CPU averaged over all cores. Turns red over 80%.

source "$CONFIG_DIR/colors.sh"

CPU=$(ps -A -o %cpu | awk -v cores="$(sysctl -n hw.ncpu)" '{ sum += $1 } END { printf "%d", sum / cores }')

COLOR=$MUTED
[ "$CPU" -gt 80 ] && COLOR=$RED

sketchybar --set "$NAME" slider.percentage="$CPU" slider.highlight_color=$COLOR
