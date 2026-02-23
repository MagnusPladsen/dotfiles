#!/bin/bash

# AeroSpace workspace focus handler — Tokyo Night colors
source "$CONFIG_DIR/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME \
    background.color=$SPACE_ACTIVE \
    background.border_width=0 \
    icon.color=0xff1a1b26 \
    label.color=$WHITE
else
  # Check if workspace has windows
  apps=$(aerospace list-windows --workspace "$1" 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  if [ -n "$apps" ]; then
    sketchybar --set $NAME \
      background.color=$SPACE_OCCUPIED \
      background.border_width=0 \
      icon.color=$WHITE \
      label.color=$DIM
  else
    sketchybar --set $NAME \
      background.color=$SPACE_EMPTY \
      background.border_width=0 \
      icon.color=$DIM \
      label.color=$DIM
  fi
fi
