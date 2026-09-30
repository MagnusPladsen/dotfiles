#!/bin/bash
# Move PiP windows on the focused monitor to the focused workspace, so PiP
# follows you when switching workspaces. Runs on every workspace change, so it
# uses AeroSpace's env var instead of querying, and makes one aerospace call
# when there is no PiP window.
current_workspace="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

aerospace list-windows --monitor focused | grep -E "(Picture-in-Picture|Picture in Picture)" | awk '{print $1}' | while read -r window_id; do
  aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
done
