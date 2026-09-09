#!/bin/bash
# Open a plain kitty window in the currently focused AeroSpace workspace.
#
# usage: new-kitty-window.sh [directory]
#
# Unlike popup-kitty.sh this spawns an ordinary tiled window every time: no
# pidfile, no floating geometry, no 'popup' in the title (which is what the
# on-window-detected float rule keys off).
set -u

WORKDIR="${1:-$HOME}"

# AeroSpace's exec-and-forget PATH is /opt/homebrew/{bin,sbin}:/usr/{bin,sbin}:
# /bin:/sbin, which does NOT contain kitty. Resolve it explicitly.
KITTY="$(command -v kitty || true)"
[[ -x "$KITTY" ]] || KITTY="/Applications/kitty.app/Contents/MacOS/kitty"

# --single-instance reuses the running kitty process, so the new OS window lands
# on the current workspace instead of spawning a second app instance.
"$KITTY" --single-instance --directory "$WORKDIR" &

# LaunchServices activation: the CLI above returns immediately when an instance
# already exists, and the new window would otherwise open behind the focused app.
open -a "/Applications/kitty.app" >/dev/null 2>&1
