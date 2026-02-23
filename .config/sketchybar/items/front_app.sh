#!/bin/bash

# ── Front App Indicator ────────────────────────────
# Shows active app icon + name with purple accent

sketchybar --add item front_app left \
  --set front_app \
    display=active \
    icon.drawing=off \
    label.font="$LABEL_FONT:Bold:13.0" \
    label.color=$PURPLE \
    label.padding_left=6 \
    background.drawing=off \
    script="$PLUGIN_DIR/front_app.sh" \
    click_script="open -a 'Mission Control'" \
  --subscribe front_app front_app_switched
