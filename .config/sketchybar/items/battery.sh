#!/bin/bash

# ── Battery — opens native Battery menu ──────────

sketchybar --add item battery right \
  --set battery \
    update_freq=60 \
    icon.font="$FONT:Bold:16.0" \
    icon.padding_right=4 \
    label.font="$LABEL_FONT:Semibold:12.0" \
    label.color=$WHITE \
    background.drawing=off \
    script="$PLUGIN_DIR/battery.sh" \
    click_script="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Battery\" of menu bar 1'" \
  --subscribe battery system_woke power_source_change
