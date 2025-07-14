#!/bin/bash

# Function to move a window to a workspace
move_to_workspace() {
  local window_name="$1"
  local workspace="$2"
  window_id=$(aerospace list-windows --all | grep -i "$window_name" | head -n 1 | awk '{print $1}' | tr -d '\n')
  if [ -n "$window_id" ]; then
    aerospace move-node-to-workspace --window-id "$window_id" "$workspace"
  fi
}

# Function to tile windows in a specific layout
tile_windows() {
  local workspace="$1"
  aerospace layout horizontal
  aerospace move --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Messenger" | awk '{print $1}')" "left"
  aerospace focus --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Messages" | awk '{print $1}')"
  aerospace join-with left
  aerospace move --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Slack" | awk '{print $1}')" "right"
  aerospace focus --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Discord" | awk '{print $1}')"
  aerospace join-with right
  echo "Tiling on workspace $1 is done "
}

# Move Space 5 to the non-built-in monitor
non_built_in_monitor=$(aerospace list-monitors | grep -v "Built-In" | awk '{print $1}')
if [ -n "$non_built_in_monitor" ]; then
  aerospace move-workspace-to-monitor --wrap-around --workspace "5" next
else
  echo "Non-built-in monitor not found. Space 5 will remain on the current monitor."
fi

# Clean workspace names (no spaces)
move_to_workspace "Zen" "1"
move_to_workspace "Ghostty" "2"
move_to_workspace "Obsidian" "2"
move_to_workspace "Docker Desktop" "2"
move_to_workspace "Discord" "3"
move_to_workspace "Messenger" "3"
move_to_workspace "Slack" "3"
move_to_workspace "Messages" "3"
move_to_workspace "Spotify" "4"
move_to_workspace "Rider" "5"
move_to_workspace "Windows App" "5"

# Tile windows in Space 3
tile_windows "3"

echo "Workspace setup complete."
