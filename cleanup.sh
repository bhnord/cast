#!/bin/bash

# Kill any existing wayvnc and headless outputs to start fresh
echo "Cleaning up old monitors..."

pkill wayvnc > /dev/null
hyprctl monitors -j | jq -r '.[] | select(.name | contains("HEADLESS")) | .name' | xargs -I {} hyprctl output destroy {} > /dev/null

echo "Monitors cleaned."
