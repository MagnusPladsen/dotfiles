#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
TIME_LEFT="$(pmset -g batt | grep -Eo "\d+:\d+" | head -1)"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=$ICON_BATTERY_100; COLOR=$GREEN ;;
  [6-8][0-9])  ICON=$ICON_BATTERY_75;  COLOR=$GREEN ;;
  [3-5][0-9])  ICON=$ICON_BATTERY_50;  COLOR=$WHITE ;;
  [1-2][0-9])  ICON=$ICON_BATTERY_25;  COLOR=$YELLOW ;;
  *)           ICON=$ICON_BATTERY_0;    COLOR=$RED ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=$ICON_BATTERY_CHARGING
  COLOR=$YELLOW
fi

sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"

# Popup details
SOURCE="Battery"
[[ "$CHARGING" != "" ]] && SOURCE="AC Power (Charging)"
DETAIL="$SOURCE"
[[ -n "$TIME_LEFT" ]] && DETAIL="$SOURCE · ${TIME_LEFT} remaining"

sketchybar --set battery.details label="$DETAIL"
