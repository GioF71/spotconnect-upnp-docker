# spotconnect-upnp-docker

A docker image for [SpotConnect (upnp)](https://github.com/philippe44/SpotConnect).  
The image includes version [0.5.2](https://github.com/philippe44/SpotConnect/releases/tag/0.5.2).  

## Notice

This repository has been replaced by [this other one](https://github.com/GioF71/spotconnect-docker).  
There will not be updates on this repository. Please migrate to the newer one (it's super-easy).

## References

This is based on [this project](https://github.com/philippe44/SpotConnect) by [philippe44](https://github.com/philippe44).  
It will let you use your upnp renderers (including those created with [upmpdcli](https://github.com/GioF71/upmpdcli-docker) and [mpd](https://github.com/giof71/mpd-alsa-docker)) as Spotify Connect devices.  
A container image for the AirPlay version is available [here](https://github.com/GioF71/spotconnect-airplay-docker).  

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
VORBIS_BITRATE|Set the vorbis bitrate to `320`, `160` or `96`, defaults to `320`

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
2023-11-23|Bump to release [0.5.2](https://github.com/philippe44/SpotConnect/releases/tag/0.5.2)
2023-11-22|Add `local-build.sh` for easier building
2023-11-22|Bump to release [0.5.1](https://github.com/philippe44/SpotConnect/releases/tag/0.5.1)
2023-11-11|Bump to release [0.5.0](https://github.com/philippe44/SpotConnect/releases/tag/0.5.0)
2023-11-05|Bump to release [0.4.1](https://github.com/philippe44/SpotConnect/releases/tag/0.4.1)
2023-11-02|Bump to release [0.3.3](https://github.com/philippe44/SpotConnect/releases/tag/0.3.3)
2023-10-19|Bump to release [0.3.2](https://github.com/philippe44/SpotConnect/releases/tag/0.3.2)
2023-10-15|Bump to release [0.3.0](https://github.com/philippe44/SpotConnect/releases/tag/0.3.0)
2023-10-09|Add support for VORBIS_BITRATE variable
2023-10-09|Bump to release [0.2.7](https://github.com/philippe44/SpotConnect/releases/tag/0.2.7)
2023-10-08|Docker images available
2023-10-07|First code release (no images)
