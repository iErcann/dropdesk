# x11-test

X11 desktop in Docker, viewable in the browser via noVNC.

Includes [Xvfb](https://linux.die.net/man/1/xvfb), Fluxbox, x11vnc, noVNC and xterm.

```
Xvfb  ->  fluxbox  ->  x11vnc  ->  websockify + noVNC  ->  your browser
(screen)  (windows)    (stream it)  (make it web-friendly)
```

## Build

```sh
docker build -t x11-test .
```

## Run

```sh
docker run --name x11-test -p 6080:6080 x11-test
```

Open <http://localhost:6080/vnc.html>
