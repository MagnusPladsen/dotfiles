#!/bin/bash

# Nerd Font battery glyph + percentage: mint while charging, red under 20%

source "$CONFIG_DIR/colors.sh"

BATT="$(pmset -g batt)"
PERCENTAGE="$(grep -Eo '[0-9]+%' <<<"$BATT" | cut -d% -f1)"
[ -z "$PERCENTAGE" ] && exit 0

case "$PERCENTAGE" in
  9[0-9]|100) ICON="󰁹" ;;
  [6-8][0-9]) ICON="󰂁" ;;
  [3-5][0-9]) ICON="󰁾" ;;
  [1-2][0-9]) ICON="󰁻" ;;
  *)          ICON="󰂎" ;;
esac

if grep -q 'AC Power' <<<"$BATT"; then ICON="󰂄"; COLOR=$MINT
elif [ "$PERCENTAGE" -lt 20 ]; then COLOR=$RED
else COLOR=$MUTED
fi

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"
