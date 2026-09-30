#!/bin/bash
# Open a plain kitty window in the currently focused AeroSpace workspace.
#
# usage: new-kitty-window.sh [directory] [command args...]
#   new-kitty-window.sh ~                       # plain shell in ~
#   new-kitty-window.sh ~ zsh -ic 'claude-op'   # run a command, keep the shell
#
# Unlike popup-kitty.sh this spawns an ordinary tiled window every time: no
# pidfile, no floating geometry, no 'popup' in the title (which is what the
# on-window-detected float rule keys off).
set -u

WORKDIR="${1:-$HOME}"
shift || true

# AeroSpace's exec-and-forget PATH is /opt/homebrew/{bin,sbin}:/usr/{bin,sbin}:
# /bin:/sbin, which does NOT contain kitty. Resolve it explicitly.
KITTY="$(command -v kitty || true)"
[[ -x "$KITTY" ]] || KITTY="/Applications/kitty.app/Contents/MacOS/kitty"

# Check before launching: the activate step below must only run when an instance
# already existed.
KITTY_WAS_RUNNING=0
pgrep -xq kitty && KITTY_WAS_RUNNING=1

# --single-instance reuses the running kitty process, so the new OS window lands
# on the current workspace instead of spawning a second app instance.
# Trailing "$@" (if any) is the program to run inside the new window.
"$KITTY" --single-instance --directory "$WORKDIR" "$@" &

# Bring kitty to the front: the CLI above returns immediately when an instance
# already exists, and the new window would otherwise open behind the focused app.
# Don't use `open -a` here - it sends a reopen event, which makes kitty spawn a
# second window of its own.
# Skip on a cold start: the kitty just launched isn't registered with
# LaunchServices yet, so `activate` would start (or reopen) kitty a second time
# and you'd get two windows. A freshly launched kitty takes focus on its own.
if [[ $KITTY_WAS_RUNNING -eq 1 ]]; then
  osascript -e 'tell application id "net.kovidgoyal.kitty" to activate' >/dev/null 2>&1
fi
