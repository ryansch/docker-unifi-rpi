# Overview

Docker images for running Ubiquiti's [UniFi Controller software](https://www.ubnt.com/download/unifi/).

# Supported tags and respective `Dockerfile` directory links

- [`7.1.68`, `7.1` (*v7.1.68/7.1*)](https://github.com/ryansch/docker-unifi-rpi/blob/main/v7.1.68/7.1)
- [`7.2.97`, `7.2` (*v7.2.95/7.2*)](https://github.com/ryansch/docker-unifi-rpi/blob/main/v7.2.97/7.2)
- [`7.3.83`, `7.3`, `7`, `latest` (*v7.3.76/7.3*)](https://github.com/ryansch/docker-unifi-rpi/blob/main/v7.3.83/7.3)
- [`7.4.155` (*7.4*)](https://github.com/ryansch/docker-unifi-rpi/blob/main/7.4)

## Versions
⚠️  This project is transitioning from MongoDB 2.4 to 3.6. Direct upgrades are not possible! ⚠️

I've added a check in the entrypoint that will prevent the Network Application (controller) from starting if
the database files are from mongo 2.4 and need to be upgraded. This will allow you to rollback to the container version you were using without issue. You can then schedule the upgrade when it's convenient.

Upgrade instructions are here: https://github.com/ryansch/docker-unifi-rpi/issues/95

Ubiquiti releases 'unstable', 'testing', and 'stable candidate' versions as part of its beta group release structure.  These releases are included here.  Only stable releases are tagged with their general version (ex: `5.6` for the `5.6.30` stable release) or with `latest`.

## Supported Architectures

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| amd64 | ✅ | \<version tag\>-amd64 |
| arm64v8 | ✅ | \<version tag\>-arm64v8 |
| arm32v7 | ❌ | |

Note: arm32v7 is no longer supported due to a lack of upstream support for mongodb <= 3.6 for arm32/armhf

# Usage

Documentation is in the [wiki](https://github.com/ryansch/docker-unifi-rpi/wiki).

# Building
- `./build.sh -v <docker version> -u <unifi version> [-t <additional docker tag> ...]`

Example: `./build.sh -v 5.9.29 -u 5.9.29-04b5d20997 -t 5.9 -t 5 -t latest`

# Publishing
- `./publish.sh -v <docker version> -u <unifi version>`

Example: `./publish.sh -v 5.9.29 -u 5.9.29-04b5d20997`

# Tagging a stable release
- `./tag.sh -v <docker version> -u <unifi version> [-t <additional docker tag> ...]`

Example: `./tag.sh -v 5.9.29 -u 5.9.29-04b5d20997 -t 5.9 -t 5 -t latest`
