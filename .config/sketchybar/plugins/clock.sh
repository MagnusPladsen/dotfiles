#!/bin/bash

# Clock update + popup calendar
sketchybar --set $NAME label="$(date '+%a %d %b   %H:%M')"

# Update popup items
FULL_DATE=$(date '+%A, %B %d, %Y')
WEEK=$(date '+Week %V')

sketchybar --set clock.details label="$FULL_DATE  ·  $WEEK"

# Mini calendar (current month)
CAL=$(cal | sed '1d')
sketchybar --set clock.calendar label="$CAL"
