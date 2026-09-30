#!/bin/bash

# Redraws every workspace item in one pass: two aerospace calls and one
# sketchybar call per event, so the AeroSpace server is not flooded with
# queries on every workspace switch.
#   focused  → peach pill, black bold number
#   occupied → light grey number
#   empty    → faint number

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

REGULAR="Martian Mono:Std Rg:10.0"
BOLD="Martian Mono:Std Bd:10.0"

focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
occupied=$(aerospace list-windows --all --format '%{workspace}' | sort -u)

args=()
for sid in $(aerospace list-workspaces --all | grep -E '^[0-9]+$'); do
  if [ "$sid" = "$focused" ]; then
    args+=(--set space.$sid icon.color=0xff000000 icon.font="$BOLD" background.drawing=on)
  elif grep -qx "$sid" <<<"$occupied"; then
    args+=(--set space.$sid icon.color=$OCCUPIED icon.font="$REGULAR" background.drawing=off)
  else
    args+=(--set space.$sid icon.color=$FAINT icon.font="$REGULAR" background.drawing=off)
  fi
done

sketchybar "${args[@]}"
