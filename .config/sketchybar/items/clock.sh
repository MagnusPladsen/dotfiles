#!/bin/bash

# ── Clock (Right) — opens Notification Center ────

sketchybar --add item clock right \
  --set clock \
    update_freq=10 \
    icon=$ICON_CLOCK \
    icon.color=$CYAN \
    icon.font="$FONT:Bold:14.0" \
    icon.y_offset=1 \
    icon.padding_right=6 \
    label.font="$LABEL_FONT:Semibold:13.0" \
    label.color=$WHITE \
    background.drawing=off \
    script="$PLUGIN_DIR/clock.sh" \
    click_script="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Clock\" of menu bar 1'"
