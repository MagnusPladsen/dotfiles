#!/bin/bash

# ── Apple logo (far left) — opens the native Apple menu ──
# Clicks menu bar item 1 (the Apple menu) of the frontmost app via System
# Events, the same way the clock/battery/wifi items open their native menus.

sketchybar --add item apple left \
  --set apple \
    padding_right=14 \
    icon.drawing=on \
    icon=$'' \
    icon.font="$ICON_FONT:Regular:15.0" \
    icon.color=$FG \
    label.drawing=off \
    click_script="osascript -e 'tell application \"System Events\" to tell (first process whose frontmost is true) to click menu bar item 1 of menu bar 1'"
