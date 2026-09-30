#!/bin/bash

# ── CPU: "cpu" + mint meter ─────────────────────────

sketchybar --add slider cpu right 34 \
  --set cpu \
    padding_right=18 \
    update_freq=3 \
    icon.drawing=on \
    icon="cpu" \
    icon.padding_right=8 \
    slider.highlight_color=$MINT \
    slider.background.color=$TRACK \
    slider.background.height=5 \
    slider.background.corner_radius=3 \
    slider.knob.drawing=off \
    script="$PLUGIN_DIR/cpu.sh"
