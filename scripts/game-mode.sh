#!/bin/zsh

# Game Mode — kill all apps and background services, then launch Steam

KEEP=("Finder" "loginwindow" "WindowServer" "SystemUIServer" "Dock" "Spotlight" "coreaudiod")

echo "🎮 Entering Game Mode..."
echo ""

# Kill background services
for svc in sketchybar AeroSpace borders; do
    if pgrep -xq "$svc"; then
        echo "Stopping $svc..."
        pkill -x "$svc"
    fi
done

# Quit all visible apps via AppleScript (graceful)
osascript -e '
tell application "System Events"
    set appList to name of every application process whose background only is false
end tell
repeat with appName in appList
    if appName as text is not in {"Finder", "Steam"} then
        try
            tell application (appName as text) to quit
        end try
    end if
end repeat
'

# Wait briefly for graceful quits, then force-kill stragglers
sleep 2

# Build keep pattern for pgrep exclusion
running_apps=$(osascript -e '
tell application "System Events"
    set appList to name of every application process whose background only is false
    set output to ""
    repeat with appName in appList
        if appName as text is not in {"Finder", "Steam"} then
            set output to output & (appName as text) & linefeed
        end if
    end repeat
    return output
end tell
')

if [ -n "$running_apps" ]; then
    echo "Force-killing remaining apps..."
    echo "$running_apps" | while IFS= read -r app; do
        [ -z "$app" ] && continue
        pkill -x "$app" 2>/dev/null
    done
fi

echo ""
echo "Launching Steam..."
open -a "Steam"

echo "All apps closed. Game on! 🕹️"
