#!/bin/bash

# Function to move a window to a workspace
move_to_workspace() {
  local window_name="$1"
  local workspace="$2"

  # Find the window ID by name (remove newlines)
  window_id=$(aerospace list-windows --all | grep -i "$window_name" | head -n 1 | awk '{print $1}' | tr -d '\n')

  if [ -n "$window_id" ]; then
    echo "Moving '$window_name' (ID: $window_id) to workspace '$workspace'"
    aerospace move-node-to-workspace --window-id "$window_id" "$workspace"
  else
    echo "Window '$window_name' not found"
  fi
}

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

echo "Workspace setup complete."
