#!/bin/bash
# Toggle the focused workspace's floating windows into the background.
# Floating windows go to a per-workspace stash ("bg-<ws>"); pressing again
# brings them back. Stash names are non-numeric, so SketchyBar's spaces items
# ignore them. PiP windows are left alone: pip-move.sh keeps them on the
# focused workspace and would just pull them back out of the stash.
ws=$(aerospace list-workspaces --focused)
stash="bg-$ws"

floating=$(aerospace list-windows --workspace focused --format '%{window-id}|%{window-layout}|%{window-title}' |
  awk -F'|' '$2 == "floating" && $3 !~ /Picture-in-Picture|PictureInPicture|Picture in Picture/ {print $1}')

if [ -n "$floating" ]; then
  for id in $floating; do
    aerospace move-node-to-workspace --window-id "$id" "$stash"
  done
else
  # list-windows errors when the stash workspace doesn't exist yet
  for id in $(aerospace list-windows --workspace "$stash" --format '%{window-id}' 2>/dev/null); do
    aerospace move-node-to-workspace --window-id "$id" "$ws"
  done
fi
