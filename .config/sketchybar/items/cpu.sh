#!/bin/bash

# ── CPU Graph + Popup ──────────────────────────────

sketchybar --add graph cpu right 30 \
  --set cpu \
    update_freq=3 \
    icon=$ICON_CPU \
    icon.color=$CYAN \
    icon.font="$FONT:Bold:16.0" \
    icon.padding_right=4 \
    label.font="$LABEL_FONT:Semibold:12.0" \
    label.color=$WHITE \
    label.width=42 \
    graph.color=$CYAN \
    graph.fill_color=0x333d59a1 \
    graph.line_width=1.5 \
    background.drawing=off \
    background.height=28 \
    script="$PLUGIN_DIR/cpu.sh" \
    click_script="sketchybar --set cpu popup.drawing=toggle" \
  --add item cpu.p1 popup.cpu \
  --set cpu.p1 icon.drawing=off label.font="Hack Nerd Font Mono:Regular:11.0" label.color=$WHITE label.padding_left=12 label.padding_right=12 \
  --add item cpu.p2 popup.cpu \
  --set cpu.p2 icon.drawing=off label.font="Hack Nerd Font Mono:Regular:11.0" label.color=$WHITE label.padding_left=12 label.padding_right=12 \
  --add item cpu.p3 popup.cpu \
  --set cpu.p3 icon.drawing=off label.font="Hack Nerd Font Mono:Regular:11.0" label.color=$WHITE label.padding_left=12 label.padding_right=12 \
  --add item cpu.p4 popup.cpu \
  --set cpu.p4 icon.drawing=off label.font="Hack Nerd Font Mono:Regular:11.0" label.color=$DIM label.padding_left=12 label.padding_right=12 \
  --add item cpu.p5 popup.cpu \
  --set cpu.p5 icon.drawing=off label.font="Hack Nerd Font Mono:Regular:11.0" label.color=$DIM label.padding_left=12 label.padding_right=12
