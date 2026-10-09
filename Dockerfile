FROM debian:trixie-slim

# more apt packages on top, e.g. --build-arg EXTRA_PACKAGES=firefox-esr
ARG EXTRA_PACKAGES=""

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    fluxbox \
    x11vnc \
    novnc \
    websockify \
    xterm \
    $EXTRA_PACKAGES \
    && rm -rf /var/lib/apt/lists/*

# chromium won't start as root without --no-sandbox
RUN if [ -d /etc/chromium.d ]; then \
      echo 'export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --no-sandbox"' > /etc/chromium.d/no-sandbox; \
    fi

COPY fluxbox-menu /root/.fluxbox/menu
RUN command -v x-www-browser >/dev/null || sed -i '/x-www-browser/d' /root/.fluxbox/menu

# open the desktop directly 
RUN ln -s vnc.html /usr/share/novnc/index.html \
    && echo '{"autoconnect": true, "resize": "scale", "reconnect": true}' > /usr/share/novnc/defaults.json

ENV DISPLAY=:0
ENV RESOLUTION=1920x1080

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
