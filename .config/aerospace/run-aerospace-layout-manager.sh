#!/bin/bash

# List all layouts using aerospace-layout-manager
layouts=$(aerospace-layout-manager --listLayouts)

# Check if layouts were found
if [ -z "$layouts" ]; then
  echo "No layouts found!"
  exit 1
fi

# Loop through each layout and run it with a conditional sleep delay
for layout in $layouts; do
  echo "Running layout: $layout"
  aerospace-layout-manager "$layout"
done

echo "All layouts applied successfully!"
