#!/bin/bash

# ── Internet: Wi-Fi / ethernet / offline glyph — opens native Wi-Fi menu ──

sketchybar --add item wifi right \
  --set wifi \
    padding_right=18 \
    update_freq=30 \
    icon.drawing=on \
    icon.font="$ICON_FONT:Regular:14.0" \
    label.drawing=off \
    script="$PLUGIN_DIR/wifi.sh" \
    click_script="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Wi‑Fi\" of menu bar 1'" \
  --subscribe wifi wifi_change system_woke
