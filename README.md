# spotconnect-upnp-docker

A docker image for [SpotConnect (upnp)](https://github.com/philippe44/SpotConnect).

## References

This is based on [this project](https://github.com/philippe44/SpotConnect) by [philippe44](https://github.com/philippe44).  
It will let you use your upnp/dlna renderers (including those created with [upmpdcli](https://github.com/GioF71/upmpdcli-docker) and [mpd](https://github.com/giof71/mpd-alsa-docker)) as Spotify Connect devices.  

## Links

REPOSITORY|DESCRIPTION
:---|:---
Source code|[GitHub](https://github.com/GioF71/spotconnect-upnp-docker)
Docker images|[Docker Hub](https://hub.docker.com/r/giof71/spotconnect-upnp)

## Build

Simply build using the following:

```
docker build . -t giof71/spotconnect-upnp:latest
```

## Configuration

Configuration is available through a set of environment variables.  
There are currently just a few variables available to set, but more will come as soon as possible.  

VARIABLE|DESCRIPTION
:---|:---
PUID|Group used to run the application, defaults to `1000`
PGID|Group used to run the application, defaults to `1000`
PREFER_STATIC|Prefer `-static` version of the executable, defaults to `no`

## Run

Simple docker-compose file:

```
---
version: "3"

volumes:
  config:

services:
  spotconnect-upnp:
    image: giof71/spotconnect-upnp:latest
    container_name: spotconnect-upnp
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - config:/config
    restart: unless-stopped
```

## Changelog

DATE|DESCRIPTION
:---|:---
2023-10-08|Docker images avaialable
2023-10-07|First code release (no images)