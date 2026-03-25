#!/bin/zsh

# Game Mode — quit all open apps except essentials for gaming
# Keeps: Finder (can't quit), Steam

KEEP_APPS="Finder|Steam"

echo "🎮 Entering Game Mode..."
echo ""

# Get all running apps and quit non-essential ones
osascript -e '
tell application "System Events"
    set appList to name of every application process whose background only is false
end tell

set keepApps to {"Finder", "Steam"}

repeat with appName in appList
    set shouldKeep to false
    repeat with kept in keepApps
        if appName as text is equal to kept as text then
            set shouldKeep to true
        end if
    end repeat

    if not shouldKeep then
        try
            tell application (appName as text) to quit
        end try
    end if
end repeat
'

echo "All apps closed. Game on! 🕹️"
