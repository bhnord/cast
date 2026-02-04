#!/bin/bash

# 1. Kill any existing wayvnc and headless outputs to start fresh
pkill wayvnc
hyprctl monitors -j | jq -r '.[] | select(.name | contains("HEADLESS")) | .name' | xargs -I {} hyprctl output destroy {}

# 2. Create the headless output and capture the assigned name
# This captures the 'ticket' name (e.g., HEADLESS-1)
hyprctl output create headless
NEW_MONITOR=$(hyprctl monitors | grep -o 'HEADLESS-[0-9]\+')

if [ -z "$NEW_MONITOR" ]; then
  echo "Failed to create headless output."
  exit 1
fi

echo "Hyprland assigned name: $NEW_MONITOR"

# 3. Configure the correct monitor using the captured name
# 1920x1080, positioned at 1920x0, Scale 1
hyprctl keyword monitor "$NEW_MONITOR, 1920x1080@60, 1920x0, 1"

# 4. Start wayvnc specifically on that ticket
echo "Starting wayvnc on $NEW_MONITOR..."
wayvnc --output="$NEW_MONITOR" 0.0.0.0
