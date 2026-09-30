#!/bin/bash

# ── Focused window: "kitty  ~/git/fraktas" ──────────
# App name in white (lowercase), then the window title in grey, capped at 50
# characters so it never reaches the notch. Updates on app switches, AeroSpace
# focus/workspace changes, and every 3s for titles that change in place
# (terminal cwd, browser tabs). Only drawn on the active display.

sketchybar --add item front_app left \
  --set front_app \
    display=active \
    padding_left=12 \
    label.color=$FG \
    update_freq=3 \
    script="$PLUGIN_DIR/front_app.sh" \
    click_script="open -a 'Mission Control'" \
  --subscribe front_app front_app_switched aerospace_focus_change aerospace_workspace_change \
  --add item front_title left \
  --set front_title \
    display=active \
    label.color=$MUTED \
    label.padding_left=10 \
    label.max_chars=50
