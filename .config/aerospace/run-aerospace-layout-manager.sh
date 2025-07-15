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

  # Conditional sleep delay, chat layout takes long to complete
  if [ "$layout" == "chat" ]; then
    echo "Applying 'chat' layout, sleeping for 3 seconds..."
    sleep 3
  else
    echo "Applying other layout, sleeping for 0.5 seconds..."
    sleep 0.5
  fi
done

echo "All layouts applied successfully!"
