#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get WiFi info (modern macOS — airport binary was removed)
SSID=$(ipconfig getsummary en0 2>/dev/null | grep '  SSID' | awk -F': ' '{print $2}' | xargs)
IP=$(ipconfig getifaddr en0 2>/dev/null)

if [ -n "$SSID" ]; then
  sketchybar --set "$NAME" icon=$ICON_WIFI icon.color=$BLUE
  sketchybar --set wifi.ssid label="$SSID"
  sketchybar --set wifi.ip label="IP: ${IP:-No IP}"
else
  sketchybar --set "$NAME" icon=$ICON_WIFI_OFF icon.color=$DIM
  sketchybar --set wifi.ssid label="Not connected"
  sketchybar --set wifi.ip label=""
fi
