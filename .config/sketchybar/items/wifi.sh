#!/bin/bash

# ── WiFi — opens native WiFi menu ────────────────

sketchybar --add item wifi right \
  --set wifi \
    update_freq=30 \
    icon=$ICON_WIFI \
    icon.color=$BLUE \
    icon.font="$FONT:Bold:16.0" \
    icon.padding_right=4 \
    padding_right=6 \
    label.drawing=off \
    background.drawing=off \
    script="$PLUGIN_DIR/wifi.sh" \
    click_script="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Wi‑Fi\" of menu bar 1'" \
  --subscribe wifi wifi_change
