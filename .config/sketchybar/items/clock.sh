#!/bin/bash

# ── Clock: "14:32" in peach — opens Notification Center ──

sketchybar --add item clock right \
  --set clock \
    update_freq=10 \
    label.color=$PEACH \
    script="$PLUGIN_DIR/clock.sh" \
    click_script="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Clock\" of menu bar 1'"
