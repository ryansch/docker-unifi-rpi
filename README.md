# Overview

Docker images for running Ubiquiti's [UniFi Controller software](https://www.ubnt.com/download/unifi/) on a [Raspberry Pi](https://www.raspberrypi.org/). 

# Supported tags and respective `Dockerfile` links

- [`5.5.24`, (*v5.5.24/5.5/Dockerfile*) (stable 5.5)](https://github.com/ryansch/docker-unifi-rpi/blob/v5.5.24/5.5/Dockerfile)
- [`5.5.27`, (*5.5/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/master/5.5/Dockerfile)
- [`5.6.22`, `v5`, `latest`, (*v5.6.22/5.6/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/v5.6.22/5.6/Dockerfile)
- [`5.6.26`, (*5.6/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/master/5.6/Dockerfile)
- [`5.7.8`, (*5.7/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/master/5.7/Dockerfile)

# Usage

## Prerequisites

A Raspberry Pi running with [Docker and Docker Compose installed](https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-convenience-script) on it. Guides such as [this](https://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/) or [this](https://blog.hypriot.com/getting-started-with-docker-and-mac-on-the-raspberry-pi/) are available for beginners.

## On rpi:

- `sudo git clone https://github.com/ryansch/docker-unifi-rpi /opt/unifi && cd /opt/unifi`
- `sudo docker-compose up -d`

## From any computer on your network:

- Visit https://raspberrypi.local:8443/ with your browser. Replace `raspberrypi.local` with the actual hostname or local network IP address of your Raspberry Pi.

## Building
- `docker build --pull -t ryansch/unifi-rpi:<version> <version>`
