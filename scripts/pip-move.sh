#!/bin/bash
# Get current workspace
current_workspace=$(aerospace list-workspaces --focused)

# Move PiP windows to current workspace, only if PiP window is on the same monitor as the new active workspace
aerospace list-windows --monitor focused | grep -E "(Picture-in-Picture|Picture in Picture)" | awk '{print $1}' | while read window_id; do
  if [ -n "$window_id" ]; then
    aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
  fi
done
