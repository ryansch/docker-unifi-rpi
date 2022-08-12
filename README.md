# Overview

Docker images for running Ubiquiti's [UniFi Controller software](https://www.ubnt.com/download/unifi/).

# Supported tags and respective `Dockerfile` directory links

- [`7.0.23`, `7.0` (*v7.0.23/7.0*)](https://github.com/ryansch/docker-unifi-rpi/blob/main/v7.0.23/7.0)
- [`7.1.68`, `7.1` (*v7.1.68/7.1*)](https://github.com/ryansch/docker-unifi-rpi/blob/main/v7.1.68/7.1)
- [`7.2.92`, `7.2`, `7`, `latest` (*v7.2.92/7.2*)](https://github.com/ryansch/docker-unifi-rpi/blob/main/v7.2.92/7.2)

## Versions
⚠️  This project is transitioning from MongoDB 2.4 to 3.6. Direct upgrades are not possible! ⚠️

I've added a check in the entrypoint that will prevent the Network Application (controller) from starting if
the database files are from mongo 2.4 and need to be upgraded. This will allow you to rollback to the container version you were using without issue. You can then schedule the upgrade when it's convenient.

Upgrade instruction are here: https://github.com/ryansch/docker-unifi-rpi/issues/95

Ubiquiti releases 'unstable', 'testing', and 'stable candidate' versions as part of its beta group release structure.  These releases are included here.  Only stable releases are tagged with their general version (ex: `5.6` for the `5.6.30` stable release) or with `latest`.

## Supported Architectures

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| amd64 | ✅ | \<version tag\>-amd64 |
| arm64v8 | ✅ | \<version tag\>-arm64v8 |
| arm32v7 | ❌ | |

Note: arm32v7 is no longer supported due to a lack of upstream support for mongodb <= 3.6 for arm32/armhf

# Usage

## Prerequisites

A Raspberry Pi running with [Docker and Docker Compose installed](https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-convenience-script) on it. Guides such as [this](https://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/) or [this](https://blog.hypriot.com/getting-started-with-docker-and-mac-on-the-raspberry-pi/) are available for beginners.

## On rpi:

1. `mkdir unifi && cd unifi`
2. `curl -O https://raw.githubusercontent.com/ryansch/docker-unifi-rpi/main/docker-compose.yml`
3. (Optional) Edit `docker-compose.yml` to point to a different tag if you don't want `latest`.
4. `sudo docker-compose up -d`
5. If using [host networking](https://docs.docker.com/network/host/), you may need to open the appropriate firewall ports on your Docker host (e.g., `8080/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp`) before you can access the web interface.

## From any computer on your network:

Visit https://raspberrypi.local:8443/ with your browser. Replace `raspberrypi.local` with the actual hostname or local network IP address of your Raspberry Pi.

# Building
- `./build.sh -v <docker version> -u <unifi version> [-t <additional docker tag> ...]`

Example: `./build.sh -v 5.9.29 -u 5.9.29-04b5d20997 -t 5.9 -t 5 -t latest`

# Publishing
- `./publish.sh -v <docker version> -u <unifi version>`

Example: `./publish.sh -v 5.9.29 -u 5.9.29-04b5d20997`

# Tagging a stable release
- `./tag.sh -v <docker version> -u <unifi version> [-t <additional docker tag> ...]`

Example: `./tag.sh -v 5.9.29 -u 5.9.29-04b5d20997 -t 5.9 -t 5 -t latest`


# TLS Support
[TLS with Traefik](https://github.com/ryansch/docker-unifi-rpi/wiki/TLS-with-Traefik)
