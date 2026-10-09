#!/bin/bash

# leftovers from a previous run (restart / reboot) block xvfb from starting
rm -f /tmp/.X0-lock /tmp/.X11-unix/X0

Xvfb :0 -screen 0 "${RESOLUTION:-1920x1080}x24" & # background fake monitor (memory).
while [ ! -e /tmp/.X11-unix/X0 ]; do sleep 0.1; done 

fluxbox & 
 
# default port :5900
x11vnc \
  -display :0 \
  -forever \
  -shared \
  -nopw &


# browser websocket :6080 <-> x11vnc tcp :5900
# also serves the novnc web client (vnc.html)
exec websockify --web=/usr/share/novnc 6080 localhost:5900
