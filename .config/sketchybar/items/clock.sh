#!/bin/bash

# ── Date + time: "wed 30 sep  14:32" — opens Notification Center ──
# Two items so the date can be light grey and the time peach; the clock
# script updates both. Kept at 11pt (rest of the bar is 10pt) by choice.

CLOCK_CLICK="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Clock\" of menu bar 1'"

sketchybar --add item clock right \
  --set clock \
    update_freq=10 \
    label.color=$PEACH \
    label.font="$FONT:Std Rg:11.0" \
    script="$PLUGIN_DIR/clock.sh" \
    click_script="$CLOCK_CLICK" \
  --add item date right \
  --set date \
    padding_right=10 \
    label.color=$OCCUPIED \
    label.font="$FONT:Std Rg:11.0" \
    click_script="$CLOCK_CLICK"
