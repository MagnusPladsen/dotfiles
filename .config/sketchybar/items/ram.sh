#!/bin/bash

# ── RAM Usage + Popup ──────────────────────────────

sketchybar --add item ram right \
  --set ram \
    update_freq=10 \
    icon=$ICON_RAM \
    icon.color=$GREEN \
    icon.font="$FONT:Bold:16.0" \
    icon.padding_right=4 \
    label.font="$LABEL_FONT:Semibold:12.0" \
    label.color=$WHITE \
    label.width=50 \
    background.drawing=off \
    script="$PLUGIN_DIR/ram.sh" \
    click_script="sketchybar --set ram popup.drawing=toggle" \
  --add item ram.details popup.ram \
  --set ram.details \
    icon.drawing=off \
    label.font="Hack Nerd Font Mono:Regular:11.0" \
    label.color=$WHITE \
    label.padding_left=12 \
    label.padding_right=12 \
  --add item ram.swap popup.ram \
  --set ram.swap \
    icon.drawing=off \
    label.font="Hack Nerd Font Mono:Regular:11.0" \
    label.color=$DIM \
    label.padding_left=12 \
    label.padding_right=12
