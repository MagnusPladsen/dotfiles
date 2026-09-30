#!/bin/bash

# Sets front_app (app name) and front_title (window title) from AeroSpace's
# focused window. Hides both on an empty workspace.

IFS='|' read -r app title <<<"$(aerospace list-windows --focused --format '%{app-name}|%{window-title}' 2>/dev/null)"

if [ -z "$app" ]; then
  sketchybar --set front_app drawing=off --set front_title drawing=off
  exit 0
fi

# Drop the " - App" / " — App" suffix many apps add to their titles
for sep in " - " " — " " – "; do title="${title%"$sep$app"}"; done
[ "$title" = "$app" ] && title=""

title_drawing=on
[ -z "$title" ] && title_drawing=off

sketchybar --set front_app drawing=on label="$(tr '[:upper:]' '[:lower:]' <<<"$app")" \
  --set front_title drawing=$title_drawing label="$title"
