#!/bin/bash

sketchybar --set "$NAME" label="$(date '+%H:%M')" \
  --set date label="$(date '+%a %d %b' | tr '[:upper:]' '[:lower:]')"
