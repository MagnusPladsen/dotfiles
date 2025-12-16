#!/bin/bash

# Add homebrew to PATH so aerospace command can be found
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Use absolute path for config file
CONFIG_FILE="/Users/magnuspladsen/.config/aerospace/layouts.json"

# List all layouts using aerospace-layout-manager
layouts=$(aerospace-layout-manager --configFile "$CONFIG_FILE" --listLayouts)

# Check if layouts were found
if [ -z "$layouts" ]; then
  echo "No layouts found!"
  exit 1
fi

# Loop through each layout and run it with a conditional sleep delay
for layout in $layouts; do
  echo "Running layout: $layout"
  aerospace-layout-manager --configFile "$CONFIG_FILE" "$layout"
done

echo "All layouts applied successfully!"
