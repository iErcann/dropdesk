#!/bin/bash
set -e

Xvfb :0 -screen 0 1920x1080x24 &
sleep 1

fluxbox &
x11vnc \
  -display :0 \
  -forever \
  -shared \
  -rfbport 5900 \
  -nopw &

websockify --web=/usr/share/novnc 6080 localhost:5900
