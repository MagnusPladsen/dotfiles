#!/bin/bash

# Nerd Font battery glyph + percentage, grey like the other status items.
# Charging shows as the bolt glyph; both turn red as a low-battery warning
# (<20%, not charging).

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

COLOR=$MUTED
LABEL_COLOR=$MUTED
grep -q 'AC Power' <<<"$BATT" && ICON="󰂄"
if [ "$PERCENTAGE" -lt 20 ] && ! grep -q 'AC Power' <<<"$BATT"; then
  COLOR=$RED
  LABEL_COLOR=$RED
fi

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%" label.color=$LABEL_COLOR
