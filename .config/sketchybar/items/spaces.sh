#!/bin/bash

# ── AeroSpace Workspace Indicators ─────────────────
# Dynamic workspace items with app icons.
# Numeric filter: aerospace-layout-manager parks windows on the stash workspace
# ("stashWorkspace" in layouts.json, default "S") while it arranges layouts. If
# the bar is (re)loaded during that window, the stash gets baked in as a
# permanent space.S item. Only the persistent numeric workspaces belong here.
ws_list() { aerospace list-workspaces --monitor "$1" | grep -E '^[0-9]+$'; }

for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
  for sid in $(ws_list "$monitor"); do
    # Map workspaces to displays
    display_id="1"
    if [ "$sid" -ge 6 ] && [ "$sid" -le 7 ]; then
      display_id="2"
    fi

    sketchybar --add item space.$sid left \
      --set space.$sid \
        display="$display_id" \
        drawing=on \
        background.color=$SPACE_OCCUPIED \
        background.corner_radius=6 \
        background.drawing=on \
        background.border_color=$BLUE \
        background.border_width=0 \
        background.height=26 \
        icon="$sid" \
        icon.font="$FONT:Bold:13.0" \
        icon.color=$DIM \
        icon.padding_left=8 \
        icon.padding_right=2 \
        label.font="sketchybar-app-font:Regular:14.0" \
        label.padding_right=20 \
        label.padding_left=0 \
        label.y_offset=-1 \
        label.color=$WHITE \
        click_script="aerospace workspace $sid"
  done
done

# One hidden item updates all workspace items per event (two aerospace calls
# total). `sketchybar --update` at the end of sketchybarrc runs it on startup.
sketchybar --add item spaces_updater left \
  --set spaces_updater drawing=off updates=on \
    script="$CONFIG_DIR/plugins/spaces_update.sh" \
  --subscribe spaces_updater aerospace_workspace_change
