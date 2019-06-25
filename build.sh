#!/usr/bin/env bash
set -e

docker_version=''
unifi_version=''
family=''
declare -a docker_tags

. "lib/init_vars"

# Source mo for templates
. "lib/mo"

echo 'Emitting Templates'
mo < templates/manifest.yml > "${family}/manifest.yml"
mo < templates/Dockerfile.amd64 > "${family}/Dockerfile.amd64"
mo < templates/Dockerfile.arm32v7 > "${family}/Dockerfile.arm32v7"
mo < templates/Dockerfile.arm64v8 > "${family}/Dockerfile.arm64v8"
mo < templates/entrypoint.sh > "${family}/entrypoint.sh"
chmod +x "${family}/entrypoint.sh"

echo 'Building Images'
docker build --pull -t ryansch/unifi-rpi:${docker_version}-amd64 -f ${family}/Dockerfile.amd64 ${family}
docker build --pull -t ryansch/unifi-rpi:${docker_version}-arm32v7 -f ${family}/Dockerfile.arm32v7 ${family}
docker build --pull -t ryansch/unifi-rpi:${docker_version}-arm64v8 -f ${family}/Dockerfile.arm64v8 ${family}

echo 'Testing Images'
dgoss run ryansch/unifi-rpi:${docker_version}-amd64
GOSS_PATH='/usr/local/bin/goss-linux-arm' GOSS_WAIT_OPTS='-r 70s -s 1s > /dev/null' dgoss run ryansch/unifi-rpi:${docker_version}-arm32v7
# Testing arm64v8 is blocked on cross compiling goss for arm64
# GOSS_PATH='/usr/local/bin/goss-linux-arm' GOSS_WAIT_OPTS='-r 70s -s 1s > /dev/null' dgoss run ryansch/unifi-rpi:${docker_version}-arm64v8
