#!/bin/bash
# Snap the Emberward (Wine) window to the top-right corner of the secondary
# monitor, just under SketchyBar. The game resizes its window on every
# resolution change, so the current size is read on each run.
BAR_HEIGHT=30

window_id=$(aerospace list-windows --all --format '%{window-id}|%{app-name}' |
  awk -F'|' '$2 == "Emberward.exe" {print $1; exit}')
[ -z "$window_id" ] && exit 0
[ "$(aerospace list-monitors --count)" -lt 2 ] && exit 0

aerospace layout --window-id "$window_id" floating
aerospace move-node-to-monitor --window-id "$window_id" 2

# NSScreen frames use a bottom-left origin; window positions use top-left
# relative to the main screen, so flip y against the main screen height.
read -r screen_right screen_top < <(osascript -l JavaScript -e '
  ObjC.import("AppKit");
  const screens = $.NSScreen.screens.js;
  const mainHeight = screens[0].frame.size.height;
  const frame = screens[screens.length - 1].frame;
  `${frame.origin.x + frame.size.width} ${mainHeight - (frame.origin.y + frame.size.height)}`;
')

osascript -e "
  tell application \"System Events\" to tell process \"Emberward.exe\"
    set targetWindow to first window whose name is \"Emberward\"
    set windowWidth to item 1 of (get size of targetWindow)
    set position of targetWindow to {$screen_right - windowWidth, $screen_top + $BAR_HEIGHT}
  end tell"

# Moving alone leaves a floating window behind the tiled ones, so focus it to
# raise it to the front.
aerospace focus --window-id "$window_id"
