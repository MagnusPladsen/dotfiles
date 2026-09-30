#!/bin/bash

# Updates every workspace item in one pass — Tokyo Night colors.
# Replaces aerospace.sh (ran once per item, one aerospace call each) and
# update_workspace_icons.sh (one aerospace call per workspace). This does two
# aerospace calls and one sketchybar call per event, so the AeroSpace server is
# not flooded with queries on every workspace switch.

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

# Load icon_map() without running the file's trailing `icon_map "$1"`, so each
# app lookup is a function call instead of a new process
eval "$(sed -n '/START-OF-ICON-MAP/,/END-OF-ICON-MAP/p' "$CONFIG_DIR/plugins/icon_map_fn.sh")"

focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
windows=$(aerospace list-windows --all --format '%{workspace}|%{app-name}')

args=()
# Numeric filter keeps the stash workspace out of the bar. See items/spaces.sh.
for sid in $(aerospace list-workspaces --all | grep -E '^[0-9]+$'); do
  icon_strip=""
  while IFS='|' read -r ws app; do
    [ "$ws" = "$sid" ] || continue
    icon_map "$app"
    icon_strip+=" $icon_result"
  done <<<"$windows"
  [ -n "$icon_strip" ] && icon_strip=" $icon_strip"

  if [ "$sid" = "$focused" ]; then
    colors=(background.color=$SPACE_ACTIVE icon.color=0xff1a1b26 label.color=$WHITE)
  elif [ -n "$icon_strip" ]; then
    colors=(background.color=$SPACE_OCCUPIED icon.color=$WHITE label.color=$DIM)
  else
    colors=(background.color=$SPACE_EMPTY icon.color=$DIM label.color=$DIM)
  fi

  args+=(--set space.$sid drawing=on background.border_width=0 "${colors[@]}" label="$icon_strip")
done

sketchybar "${args[@]}"
