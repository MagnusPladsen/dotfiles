#!/bin/bash

# Glyph for how the Mac reaches the internet, from the default route:
#   Wi-Fi 󰖩 / ethernet 󰈀 in grey, no route 󰖪 in red

source "$CONFIG_DIR/colors.sh"

iface=$(route -n get default 2>/dev/null | awk '/interface:/ {print $2}')
wifi_dev=$(networksetup -listallhardwareports | awk '/Wi-Fi/ {getline; print $2}')

if [ -z "$iface" ]; then
  sketchybar --set "$NAME" icon="󰖪" icon.color=$RED
elif [ "$iface" = "$wifi_dev" ]; then
  sketchybar --set "$NAME" icon="󰖩" icon.color=$MUTED
else
  sketchybar --set "$NAME" icon="󰈀" icon.color=$MUTED
fi
