#!/bin/bash

# ── Memory: "mem" + grey meter ─────────────────────

sketchybar --add slider ram right 34 \
  --set ram \
    padding_right=18 \
    update_freq=10 \
    icon.drawing=on \
    icon="mem" \
    icon.padding_right=8 \
    slider.highlight_color=$MUTED \
    slider.background.color=$TRACK \
    slider.background.height=5 \
    slider.background.corner_radius=3 \
    slider.knob.drawing=off \
    script="$PLUGIN_DIR/ram.sh"
