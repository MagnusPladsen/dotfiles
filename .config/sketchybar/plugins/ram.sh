#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get memory info via vm_stat — use last field (NF) for robust parsing
PAGESIZE=$(pagesize)
STATS=$(vm_stat)

# Parse pages (grab last field, strip trailing period)
PAGES_FREE=$(echo "$STATS" | awk '/Pages free/ {gsub(/\./, "", $NF); print $NF}')
PAGES_ACTIVE=$(echo "$STATS" | awk '/Pages active/ {gsub(/\./, "", $NF); print $NF}')
PAGES_WIRED=$(echo "$STATS" | awk '/Pages wired/ {gsub(/\./, "", $NF); print $NF}')
PAGES_COMPRESSED=$(echo "$STATS" | awk '/Pages occupied by compressor/ {gsub(/\./, "", $NF); print $NF}')

# Fallback if parsing fails
PAGES_FREE=${PAGES_FREE:-0}
PAGES_ACTIVE=${PAGES_ACTIVE:-0}
PAGES_WIRED=${PAGES_WIRED:-0}
PAGES_COMPRESSED=${PAGES_COMPRESSED:-0}

# Calculate in GB
USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED))
USED_GB=$(echo "scale=1; $USED_PAGES * $PAGESIZE / 1073741824" | bc)

# Total RAM
TOTAL_GB=$(sysctl -n hw.memsize | awk '{printf "%.0f", $1/1073741824}')

# Update label
sketchybar --set "$NAME" label="${USED_GB}G"

# Color based on usage ratio
USED_PCT=$(echo "scale=0; $USED_PAGES * $PAGESIZE * 100 / ($TOTAL_GB * 1073741824)" | bc 2>/dev/null || echo "50")
if [ "${USED_PCT:-0}" -gt 85 ] 2>/dev/null; then
  sketchybar --set "$NAME" icon.color=$RED
elif [ "${USED_PCT:-0}" -gt 70 ] 2>/dev/null; then
  sketchybar --set "$NAME" icon.color=$YELLOW
else
  sketchybar --set "$NAME" icon.color=$GREEN
fi

# Popup details
sketchybar --set ram.details label="Used: ${USED_GB}G / ${TOTAL_GB}G  (${USED_PCT:-?}%)"

# Swap info
SWAP=$(sysctl -n vm.swapusage 2>/dev/null | awk '{print $3 " used / " $1 " total"}' | sed 's/M//g')
sketchybar --set ram.swap label="Swap: ${SWAP:-0}"
