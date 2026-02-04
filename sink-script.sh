#!/bin/bash
ARCH_IP=$1

# Start X, the manager, and the viewer
sudo xinit /usr/bin/sh -c "matchbox-window-manager -use_titlebar no & vncviewer $ARCH_IP::5900 -Fullscreen RemoteResize=0" -- :0 -br vt1
