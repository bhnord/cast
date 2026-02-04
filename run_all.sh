#!/bin/bash

./source-script.sh &

# adjust 'wlan0' as needed
IP=$(ip -4 addr show wlan0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# adjust ssh location as needed
ssh bhnord@tv-link "sudo bash -s" < ./sink-script.sh "$IP" 
