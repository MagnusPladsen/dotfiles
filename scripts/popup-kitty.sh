#!/bin/bash
# Floating popup kitty window: open once, focus thereafter.
#
# usage: popup-kitty.sh <name> [program args...]
#   popup-kitty.sh omp zsh -ic omp        # alt-c, starts in $HOME/ai-sandbox
#   POPUP_DIR="$HOME" popup-kitty.sh term # alt-t, plain shell in ~
#
# Pressing the binding again focuses the existing window instead of spawning a
# second one or killing it. Close the popup normally: exit the shell or cmd+w.
set -u

NAME="${1:?usage: popup-kitty.sh <name> [program...]}"
shift

PIDFILE="/tmp/kitty-popup-$NAME.pid"
SOCKET="/tmp/kitty-popup-$NAME.sock"
WORKDIR="${POPUP_DIR:-$HOME/ai-sandbox}"

# AeroSpace's exec-and-forget PATH is /opt/homebrew/{bin,sbin}:/usr/{bin,sbin}:
# /bin:/sbin, which does NOT contain kitty. Resolve it explicitly.
KITTY="$(command -v kitty || true)"
[[ -x "$KITTY" ]] || KITTY="/Applications/kitty.app/Contents/MacOS/kitty"
KITTY_APP="/Applications/kitty.app"

# Window id owned by $1, via AeroSpace's app-pid. Immune to title rewrites by
# whatever program runs inside the terminal.
window_id_for_pid() {
  command -v aerospace >/dev/null 2>&1 || return 1
  aerospace list-windows --all --format '%{window-id}|%{app-pid}' 2>/dev/null |
    awk -F'|' -v p="$1" '$2 == p { print $1; exit }'
}

# Raising a window needs three cooperating pieces, so do all of them:
#   1. AeroSpace switches to the popup's workspace (nothing else can - AeroSpace
#      parks hidden workspaces off-screen, so app-level activation alone cannot
#      reach a popup sitting on one).
#   2. kitty raises its own OS window among its siblings.
#   3. LaunchServices activates the app, which macOS denies to a caller that is
#      not already frontmost - fine under a real keypress, where AeroSpace is
#      the one invoking us.
raise_popup() {
  local wid=$1
  [[ -n "$wid" ]] && aerospace focus --window-id "$wid" >/dev/null 2>&1
  [[ -S "$SOCKET" ]] && "$KITTY" @ --to "unix:$SOCKET" focus-window >/dev/null 2>&1
  open -a "$KITTY_APP" >/dev/null 2>&1
  return 0
}

if [[ -f "$PIDFILE" ]]; then
  pid=$(cat "$PIDFILE")
  if kill -0 "$pid" 2>/dev/null; then
    wid=$(window_id_for_pid "$pid")
    if [[ -n "$wid" || -S "$SOCKET" ]]; then
      raise_popup "$wid"
      exit 0
    fi
    # Alive but neither AeroSpace nor kitty can see it: wedged. Drop it and fall
    # through to a fresh launch rather than leaving the key dead.
    kill "$pid" 2>/dev/null
  fi
  rm -f "$PIDFILE"
fi

mkdir -p "$WORKDIR"
rm -f "$SOCKET"

"$KITTY" \
  --title "popup-$NAME" \
  --session none \
  --directory "$WORKDIR" \
  --listen-on "unix:$SOCKET" \
  -o allow_remote_control=yes \
  -o remember_window_size=no \
  -o initial_window_width=800 \
  -o initial_window_height=500 \
  -o background_opacity=0.85 \
  -o background_blur=30 \
  -o hide_window_decorations=yes \
  -o placement_strategy=center \
  -o confirm_os_window_close=0 \
  "$@" \
  &

echo $! > "$PIDFILE"
