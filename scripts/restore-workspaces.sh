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

# Moves don't fire exec-on-workspace-change, so refresh the bar's app icons
[ "$moved" -gt 0 ] && sketchybar --trigger aerospace_workspace_change

echo "Moved $moved window(s)"
