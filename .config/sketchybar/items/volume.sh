#!/bin/bash

# ── Volume — opens native Sound menu ─────────────

sketchybar --add item volume right \
  --set volume \
    icon.font="$FONT:Bold:16.0" \
    icon.padding_right=4 \
    label.font="$LABEL_FONT:Semibold:12.0" \
    label.color=$WHITE \
    background.drawing=off \
    script="$PLUGIN_DIR/volume.sh" \
    click_script="osascript -e 'tell application \"System Events\" to tell process \"ControlCenter\" to click menu bar item \"Sound\" of menu bar 1'" \
  --subscribe volume volume_change
