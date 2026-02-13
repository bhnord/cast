#!/bin/bash

./cleanup.sh

# Create the headless output and capture the assigned name
# This captures the 'ticket' name (e.g., HEADLESS-1)
hyprctl output create headless
NEW_MONITOR=$(hyprctl monitors | grep -o 'HEADLESS-[0-9]\+')

if [ -z "$NEW_MONITOR" ]; then
  echo "Failed to create headless output."
  exit 1
fi

# Configure the correct monitor using the captured name
# 1920x1080, positioned at 1920x0, Scale 1
hyprctl keyword monitor "$NEW_MONITOR, 1024x768@30, 1920x0, 1" >/dev/null

# 4. Start wayvnc specifically on that ticket
echo "Started wayvnc on $NEW_MONITOR."
echo "Press CTRL+C to exit"
wayvnc --output="$NEW_MONITOR" 0.0.0.0

./cleanup.sh
