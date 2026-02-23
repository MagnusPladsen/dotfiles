#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get CPU usage percentage
CPU=$(ps -A -o %cpu | awk '{sum+=$1} END {printf "%.0f", sum/8}')

# Graph expects a value between 0.0 and 1.0
GRAPH_VAL=$(echo "scale=2; ${CPU:-0} / 100" | bc)

# Push to graph and update label
sketchybar --push cpu "$GRAPH_VAL" --set cpu label="${CPU}%"

# Color based on load
if [ "$CPU" -gt 80 ]; then
  sketchybar --set cpu icon.color=$RED graph.color=$RED
elif [ "$CPU" -gt 50 ]; then
  sketchybar --set cpu icon.color=$YELLOW graph.color=$YELLOW
else
  sketchybar --set cpu icon.color=$CYAN graph.color=$CYAN
fi

# Update popup with top 5 processes
TOP=$(ps -Arco pid,%cpu,comm | head -6 | tail -5)
i=1
while IFS= read -r line; do
  pid=$(echo "$line" | awk '{print $1}')
  pct=$(echo "$line" | awk '{print $2}')
  cmd=$(echo "$line" | awk '{for(i=3;i<=NF;i++) printf "%s ", $i; print ""}' | xargs)
  sketchybar --set cpu.p$i label="$(printf '%-5s %5s%%  %s' "$pid" "$pct" "$cmd")"
  i=$((i + 1))
done <<< "$TOP"
