# x11-test

X11 desktop in Docker, viewable in the browser via noVNC.

Includes Xvfb, Fluxbox, x11vnc, noVNC, xterm and Firefox ESR.

## Build

```sh
docker build -t x11-test .
```

## Run

```sh
docker run --name x11-test -p 6080:6080 x11-test
```

Open <http://localhost:6080/vnc.html>
