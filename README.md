# dropdesk

Tiny Linux desktop in your browser. Drop it into Proxmox (LXC) or Docker.

Includes [Xvfb](https://linux.die.net/man/1/xvfb), Fluxbox, x11vnc, noVNC and xterm.

```
Xvfb  ->  fluxbox  ->  x11vnc  ->  websockify + noVNC  ->  your browser
(screen)  (windows)    (stream it)  (make it web-friendly)
```

## Images

| Image | What's in it |
|---|---|
| `ghcr.io/iercann/dropdesk:latest` | desktop + terminal |
| `ghcr.io/iercann/dropdesk:firefox` | + Firefox |
| `ghcr.io/iercann/dropdesk:chromium` | + Chromium |

For amd64 and arm64.

## Proxmox (9.1+)

1. Your storage (e.g. `local`) -> CT Templates -> Pull from OCI Registry
2. Reference `ghcr.io/iercann/dropdesk`, tag `latest` (or `firefox` / `chromium`)
3. Create CT, pick the image as template, network on DHCP
4. Start it and open `http://<container-ip>:6080`

## Docker

```sh
docker run -d --name dropdesk -p 6080:6080 ghcr.io/iercann/dropdesk
```

Open <http://localhost:6080>

Or with compose:

```yaml
services:
  dropdesk:
    image: ghcr.io/iercann/dropdesk:firefox
    ports:
      - "6080:6080"
    restart: unless-stopped
```

## Usage

Right-click the desktop for the menu (terminal, browser).

## Settings

| Env | Default | |
|---|---|---|
| `RESOLUTION` | `1920x1080` | screen size |

Docker: `-e RESOLUTION=1280x720`. Proxmox: in the container's environment variables.

## Security

No password. Anyone who can reach port 6080 gets the desktop.
Keep it on your LAN, don't port forward it.

## FAQ

**Where are my files?**
Docker: gone when you remove the container, keep them with `-v dropdesk-home:/root`.
Proxmox: the container disk keeps them.

**How do I add apps?**
`apt update && apt install <app>` in the terminal, or build your own image:

```sh
docker build -t my-desk --build-arg EXTRA_PACKAGES="gimp vlc" .
```

**Browser tabs crash in Docker?**
Docker's `/dev/shm` is only 64MB. Add `--shm-size=1g`.

## Build

```sh
docker build -t dropdesk .
docker build -t dropdesk:firefox --build-arg EXTRA_PACKAGES=firefox-esr .
```
