#!/bin/bash

# Not in use anymore. I'm currenlty using aerospace-layout-manager. See run-aerospace-layout-manager.sh

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

  # Messages bottom left
  move_to_workspace "Messages" "$workspace"
  sleep 0.2

  # Discord bottom right
  move_to_workspace "Discord" "$workspace"
  sleep 0.2

  # Messenger top left
  move_to_workspace "Messenger" "$workspace"
  aerospace move --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Messenger" | awk '{print $1}')" left
  aerospace join-with --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Messenger" | awk '{print $1}')" left
  sleep 0.2

  # Slack top right
  move_to_workspace "Slack" "$workspace"
  sleep 0.2

  aerospace join-with --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Messages" | awk '{print $1}')" left
  aerospace join-with --window-id "$(aerospace list-windows --workspace "$workspace" | grep -i "Discord" | awk '{print $1}')" right

  echo "Tiling on workspace $workspace is done "
}

# Setup apps in correct workspaces
move_to_workspace "Zen" "1"
move_to_workspace "Obsidian" "2"
move_to_workspace "Spotify" "2"
move_to_workspace "Ghostty" "4"
move_to_workspace "Docker Desktop" "5"
move_to_workspace "Rider" "5"
move_to_workspace "Windows App" "5"

# Tile windows in Space 3
tile_windows "3"

echo "Workspace setup complete."
