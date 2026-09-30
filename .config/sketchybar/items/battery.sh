#!/bin/bash

# ── Battery: " 82%" — opens native Battery menu ──

sketchybar --add item battery right \
  --set battery \
    padding_right=18 \
    update_freq=60 \
    icon.drawing=on \
    icon.font="$ICON_FONT:Regular:13.0" \
    icon.padding_right=6 \
    label.color=$MUTED \
    script="$PLUGIN_DIR/battery.sh" \
    click_script="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Battery\" of menu bar 1'" \
  --subscribe battery system_woke power_source_change
