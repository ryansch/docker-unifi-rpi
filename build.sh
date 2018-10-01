#!/usr/bin/env bash
set -e

docker_version=''
unifi_version=''
declare -a docker_tags

. "lib/init_vars"

# Source mo for templates
. "lib/mo"

echo 'Emitting Templates'
mo < templates/manifest.yml > "${family}/manifest.yml"
mo < templates/Dockerfile.amd64 > "${family}/Dockerfile.amd64"
mo < templates/Dockerfile.arm32v7 > "${family}/Dockerfile.arm32v7"

echo 'Building Images'
docker build --pull -t ryansch/unifi-rpi:${docker_version}-amd64 -f ${family}/Dockerfile.amd64 ${family}
docker build --pull -t ryansch/unifi-rpi:${docker_version}-arm32v7 -f ${family}/Dockerfile.arm32v7 ${family}

echo 'Testing Images'

