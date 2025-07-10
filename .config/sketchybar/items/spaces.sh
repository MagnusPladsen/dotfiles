#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change
RED=0xffed8796
for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item "space.$sid" left \
    --subscribe "space.$sid" aerospace_workspace_change \
    --set "space.$sid" \
    icon="$sid" \
    icon.padding_left=10 \
    icon.padding_right=10 \
    label.padding_right=10 \
    icon.highlight_color=$RED \
    background.color=0x44ffffff \
    background.corner_radius=100 \
    background.height=25 \
    background.drawing=off \
    label.font="sketchybar-app-font:Regular:16.0" \
    label.background.height=30 \
    label.background.drawing=on \
    label.background.color=0xff494d64 \
    label.background.corner_radius=9 \
    label.drawing=off \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospacer.sh $sid"
done
