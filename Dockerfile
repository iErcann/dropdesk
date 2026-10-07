FROM debian:trixie

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    fluxbox \
    x11vnc \
    novnc \
    websockify \
    xterm \
    firefox-esr \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:0
ENV HOME=/root

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
