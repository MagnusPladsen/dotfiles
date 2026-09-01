#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"

update_space_icons() {
    local sid=$1
    local apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    sketchybar --set space.$sid drawing=on

    if [ "${apps}" != "" ]; then
        icon_strip=" "
        while read -r app; do
            icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
        done <<<"${apps}"
    else
        icon_strip=""
    fi
    sketchybar --set space.$sid label="$icon_strip"
}

# Update all workspaces to ensure clean state.
# Numeric filter keeps the layout-manager stash workspace (layouts.json
# "stashWorkspace", default "S") out of the bar. See items/spaces.sh.
for monitor in $(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}"); do
    for sid in $(aerospace list-workspaces --monitor "$monitor" | grep -E '^[0-9]+$'); do
        update_space_icons "$sid"
    done
done
