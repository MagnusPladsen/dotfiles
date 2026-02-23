#!/bin/bash

# ── AeroSpace Workspace Indicators ─────────────────
# Dynamic workspace items with app icons

for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
  for sid in $(aerospace list-workspaces --monitor "$monitor"); do
    # Map workspaces to displays
    display_id="1"
    if [ "$sid" -ge 6 ] && [ "$sid" -le 7 ]; then
      display_id="2"
    fi

    sketchybar --add item space.$sid left \
      --subscribe space.$sid aerospace_workspace_change \
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
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
  done
done

# Load workspace app icons on startup
for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
  for sid in $(aerospace list-workspaces --monitor "$monitor"); do
    apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    icon_strip=" "
    if [ "${apps}" != "" ]; then
      while read -r app; do
        icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
      done <<<"${apps}"
    else
      icon_strip=""
    fi
    sketchybar --set space.$sid label="$icon_strip"
  done
done
