#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100) ICON=$ICON_VOLUME_HIGH; COLOR=$WHITE ;;
    [3-5][0-9])     ICON=$ICON_VOLUME_MED;  COLOR=$WHITE ;;
    [1-9]|[1-2][0-9]) ICON=$ICON_VOLUME_LOW; COLOR=$DIM ;;
    *)              ICON=$ICON_VOLUME_MUTE; COLOR=$RED ;;
  esac

  sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${VOLUME}%"

  # Popup detail
  OUTPUT=$(system_profiler SPAudioDataType 2>/dev/null | grep "Default Output" -A1 | tail -1 | xargs)
  sketchybar --set volume.details label="Output: ${OUTPUT:-Built-in Speakers}"
fi
