FROM debian:trixie-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    fluxbox \
    x11vnc \
    novnc \
    websockify \
    xterm \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY=:0

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
