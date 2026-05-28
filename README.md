# Overview

Docker images for running Ubiquiti's [UniFi Controller software](https://www.ubnt.com/download/unifi/).

# Supported tags and respective `Dockerfile` directory links

- [`10.1.89`, `10.1` (v10.1.89/10.1)](https://github.com/ryansch/docker-unifi-rpi/tree/v10.1.89/10.1)
- [`10.2.105`, `10.2` (v10.2.105/10.2)](https://github.com/ryansch/docker-unifi-rpi/tree/v10.2.105/10.2)
- [`10.3.58`, `10.3` (v10.3.58/10.3)](https://github.com/ryansch/docker-unifi-rpi/tree/v10.3.58/10.3)
- [`10.4.57`, `10.4`, `10`, `latest` (v10.4.57/10.4)](https://github.com/ryansch/docker-unifi-rpi/tree/v10.4.57/10.4)

## Versions

Ubiquiti releases 'unstable', 'testing', and 'stable candidate' versions as part of its beta group release structure.  These releases are included here.  Only stable releases are tagged with their general version (ex: `5.6` for the `5.6.30` stable release) or with `latest`.

## Supported Architectures

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| amd64 | ✅ | \<version tag\>-amd64 |
| arm64v8 | ✅ | \<version tag\>-arm64v8 |
| arm32v7 | ❌ | |

Note: arm32v7 is no longer supported due to a lack of upstream support for mongodb <= 3.6 for arm32/armhf

# Configuration

As of 7.5.x, this container image supports unifi's standard configuration utilities.

You can supply a system.properties file at `/var/lib/unifi/system.properies` (in the container) or set any of the following environment variables:

| Environment Variable | Description | Default |
| --- | --- | --- |
| JVM_INIT_HEAP_SIZE | Initial Java heap size in MiB | None |
| JVM_MAX_HEAP_SIZE | Maximum Java heap size in MiB | 1024 |
| JAVA_ENTROPY_GATHER_DEVICE | Path to entropy gathering device | None |
| UNIFI_JVM_EXTRA_OPTS | Additional JVM options | $JAVA_OPTS |

Additionally, `-XX:+UseParallelGC` is used by default but can be changed with the unifi property `unifi.G1GC.enabled`.

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
