#!/bin/bash
# Restore app → workspace placement from ~/.config/aerospace/layouts.json.
#
# Replaces aerospace-layout-manager, which stashed and re-added every window
# and flipped between workspaces on every step. This one reads all windows
# once, moves only the ones on the wrong workspace, and never changes focus.

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

CONFIG_FILE="${1:-$HOME/.config/aerospace/layouts.json}"

# One "<workspace> <bundleId>" line per app, including nested window groups
targets=$(jq -r '.layouts[] | .workspace as $ws | .windows | .. | objects
  | select(has("bundleId")) | "\($ws) \(.bundleId)"' "$CONFIG_FILE")

list_bundles() { aerospace list-windows --all --format '%{app-bundle-id}'; }

# Launch apps that have no window yet, in the background
running=$(list_bundles)
missing=()
while read -r _ bundle; do
  if ! grep -qxF "$bundle" <<<"$running"; then
    open -g -b "$bundle" 2>/dev/null && missing+=("$bundle")
  fi
done <<<"$targets"

# Wait up to ~5s for launched apps to open a window
for _ in $(seq 25); do
  [ ${#missing[@]} -eq 0 ] && break
  sleep 0.2
  running=$(list_bundles)
  still=()
  for bundle in "${missing[@]}"; do
    grep -qxF "$bundle" <<<"$running" || still+=("$bundle")
  done
  missing=("${still[@]}")
done

# Move only misplaced windows. PiP windows are left alone: pip-move.sh keeps
# them on the focused workspace.
windows=$(aerospace list-windows --all --format '%{window-id}|%{app-bundle-id}|%{workspace}|%{window-title}')
moved=0
while read -r ws bundle; do
  while IFS='|' read -r id app_bundle current_ws title; do
    [ "$app_bundle" = "$bundle" ] && [ "$current_ws" != "$ws" ] || continue
    case "$title" in *Picture-in-Picture* | *PictureInPicture* | *"Picture in Picture"*) continue ;; esac
    aerospace move-node-to-workspace --window-id "$id" "$ws" && moved=$((moved + 1))
  done <<<"$windows"
done <<<"$targets"

# Apply each workspace's root layout (no-op when already set)
jq -r '.layouts[] | "\(.workspace) \(.layout)"' "$CONFIG_FILE" |
  while read -r ws layout; do
    aerospace layout --workspace "$ws" --root "$layout" 2>/dev/null
  done

# Apply optional window widths, given as percent of the workspace's monitor
# width so they hold on both the built-in display and the external one
screen_widths=$(osascript -l JavaScript -e 'ObjC.import("AppKit");
  var s = $.NSScreen.screens, o = [];
  for (var i = 0; i < s.count; i++) {
    var x = s.objectAtIndex(i);
    o.push(x.localizedName.js + "|" + x.frame.size.width);
  }
  o.join("\n")')
ws_monitors=$(aerospace list-workspaces --all --format '%{workspace}|%{monitor-name}')
jq -r '.layouts[] | .workspace as $ws | .windows | .. | objects
  | select(has("bundleId") and has("width")) | "\($ws) \(.bundleId) \(.width)"' "$CONFIG_FILE" |
  while read -r ws bundle pct; do
    monitor=$(awk -F'|' -v ws="$ws" '$1 == ws { print $2 }' <<<"$ws_monitors")
    screen_w=$(awk -F'|' -v m="$monitor" '$1 == m { print $2 }' <<<"$screen_widths")
    [ -n "$screen_w" ] || continue
    px=$(awk -v w="$screen_w" -v p="$pct" 'BEGIN { printf "%d", w * p / 100 }')
    id=$(aerospace list-windows --workspace "$ws" --format '%{window-id}|%{app-bundle-id}' |
      awk -F'|' -v b="$bundle" '$2 == b { print $1; exit }')
    [ -n "$id" ] && aerospace resize --window-id "$id" width "$px"
  done

# Moves don't fire exec-on-workspace-change, so refresh the bar's app icons
[ "$moved" -gt 0 ] && sketchybar --trigger aerospace_workspace_change

echo "Moved $moved window(s)"
