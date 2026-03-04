#!/bin/bash
# Toggle a floating popup Kitty terminal window
# alt-t opens it, alt-t again closes it

PIDFILE="/tmp/kitty-popup.pid"

# If popup is running, kill it
if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  kill "$(cat "$PIDFILE")"
  rm -f "$PIDFILE"
  exit 0
fi

# Otherwise, launch a new popup
kitty \
  --title "popup" \
  --session none \
  --directory "$HOME" \
  -o remember_window_size=no \
  -o initial_window_width=800 \
  -o initial_window_height=500 \
  -o background_opacity=0.85 \
  -o background_blur=30 \
  -o hide_window_decorations=yes \
  -o placement_strategy=center \
  -o confirm_os_window_close=0 \
  &

echo $! > "$PIDFILE"
