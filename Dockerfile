FROM debian:trixie-slim

# more apt packages on top, e.g. --build-arg EXTRA_PACKAGES=firefox-esr
ARG EXTRA_PACKAGES=""

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    fluxbox \
    x11vnc \
    websockify \
    xterm \
    $EXTRA_PACKAGES \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf \
    # drop unused stuff (~310MB): 3d rendering (llvm/mesa), numpy, wallpaper formats (ghostscript, svg, heif...), tcl/tk, docs
    /usr/lib/*/libLLVM* /usr/lib/*/libgallium* /usr/lib/*/libz3* \
    /usr/lib/python3/dist-packages/numpy /usr/lib/*/lapack /usr/lib/*/blas /usr/lib/*/libgfortran* \
    /usr/lib/*/libgs.so* /usr/share/ghostscript /usr/share/fonts/*/urw-base35 /usr/share/fonts/X11/Type1 \
    /usr/share/fonts/cmap /usr/share/fonts/cMap /usr/share/poppler \
    /usr/lib/*/imlib2/loaders/heif.so /usr/lib/*/imlib2/loaders/jxl.so /usr/lib/*/imlib2/loaders/svg.so \
    /usr/lib/*/imlib2/loaders/ps.so /usr/lib/*/imlib2/loaders/j2k.so \
    /usr/lib/*/libheif* /usr/lib/*/libjxl* /usr/lib/*/libhwy* /usr/lib/*/libspectre* \
    /usr/lib/*/libtcl* /usr/lib/*/libtk* /usr/share/tcltk \
    /usr/share/doc

# chromium won't start as root without --no-sandbox
RUN if [ -d /etc/chromium.d ]; then \
      echo 'export CHROMIUM_FLAGS="$CHROMIUM_FLAGS --no-sandbox"' > /etc/chromium.d/no-sandbox; \
    fi

COPY fluxbox-menu /root/.fluxbox/menu
RUN command -v x-www-browser >/dev/null || sed -i '/x-www-browser/d' /root/.fluxbox/menu

RUN ln -sf /bin/true /usr/bin/fbsetbg

# github = smaller than apt.
ADD https://github.com/novnc/noVNC.git#v1.7.0 /usr/share/novnc

# open the desktop directly 
RUN ln -s vnc.html /usr/share/novnc/index.html \
    && echo '{"autoconnect": true, "resize": "scale", "reconnect": true}' > /usr/share/novnc/defaults.json

ENV DISPLAY=:0
ENV RESOLUTION=1280x720

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
