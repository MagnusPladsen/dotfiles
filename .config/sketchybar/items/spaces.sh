#!/bin/bash

# ── Workspaces ──────────────────────────────────────
# Number per workspace. The focused one is a peach pill with a black number;
# occupied ones are light grey, empty ones faint. Every item shows on every
# display. plugins/spaces_update.sh redraws them all on each AeroSpace
# workspace change.
# Numeric filter keeps aerospace-layout-manager's stash workspace ("S") out.

for sid in $(aerospace list-workspaces --all | grep -E '^[0-9]+$'); do
  sketchybar --add item space.$sid left \
    --set space.$sid \
      icon.drawing=on \
      icon="$sid" \
      icon.color=$FAINT \
      icon.padding_left=6 \
      icon.padding_right=6 \
      label.drawing=off \
      background.color=$PEACH \
      background.corner_radius=5 \
      background.height=20 \
      background.drawing=off \
      click_script="aerospace workspace $sid"
done

# One hidden item updates all workspace items per event (two aerospace calls
# total). `sketchybar --update` at the end of sketchybarrc runs it on startup.
sketchybar --add item spaces_updater left \
  --set spaces_updater drawing=off updates=on \
    script="$CONFIG_DIR/plugins/spaces_update.sh" \
  --subscribe spaces_updater aerospace_workspace_change
