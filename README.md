# Overview

Docker images for running Ubiquiti's [UniFi Controller software](https://www.ubnt.com/download/unifi/) on a [Raspberry Pi](https://www.raspberrypi.org/).

# Supported tags and respective `Dockerfile` directory links

- [`5.6.39`, `5.6` (*v5.6.39/5.6*)](https://github.com/ryansch/docker-unifi-rpi/blob/v5.6.39/5.6)
- [`5.8.28`, `5.8`, `5`, `latest` (*v5.8.28/5.8*)](https://github.com/ryansch/docker-unifi-rpi/blob/v5.8.28/5.8)
- [`5.9.24` (*5.9*)](https://github.com/ryansch/docker-unifi-rpi/blob/master/5.9)

## Versions
Ubiquiti releases 'unstable', 'testing', and 'stable candidate' versions as part of its beta group release structure.  These releases are included here.  Only stable releases are tagged with their general version (ex: `5.6` for the `5.6.30` stable release) or with `latest`.

## Supported Architectures
`arm32v7`,`amd64`

# Usage

## Prerequisites

A Raspberry Pi running with [Docker and Docker Compose installed](https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-convenience-script) on it. Guides such as [this](https://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/) or [this](https://blog.hypriot.com/getting-started-with-docker-and-mac-on-the-raspberry-pi/) are available for beginners.

## On rpi:

1. `mkdir unifi && cd unifi`
2. `curl -O https://raw.githubusercontent.com/ryansch/docker-unifi-rpi/master/docker-compose.yml`
3. (Optional) Edit `docker-compose.yml` to point to a different tag if you don't want `latest`.
4. `sudo docker-compose up -d`

## From any computer on your network:

Visit https://raspberrypi.local:8443/ with your browser. Replace `raspberrypi.local` with the actual hostname or local network IP address of your Raspberry Pi.

# Building
- `docker build --pull -t ryansch/unifi-rpi:<version> <version>`

# TLS Support
[TLS with Traefik](https://github.com/ryansch/docker-unifi-rpi/wiki/TLS-with-Traefik)
