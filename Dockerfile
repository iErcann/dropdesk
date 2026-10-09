FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    fluxbox \
    x11vnc \
    novnc \
    websockify \
    xterm \
    && rm -rf /var/lib/apt/lists/*

# open the desktop directly 
RUN ln -s vnc.html /usr/share/novnc/index.html \
    && echo '{"autoconnect": true, "resize": "scale", "reconnect": true}' > /usr/share/novnc/defaults.json

ENV DISPLAY=:0
ENV RESOLUTION=1920x1080

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
