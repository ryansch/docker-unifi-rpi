#!/usr/bin/env bash
set -e

docker_version=''
unifi_version=''
unifi_sha256=''
family=''
java_package=''
declare -a docker_tags

. "lib/init_vars"

# Source mo for templates
. "lib/mo"

echo 'Emitting Templates'
mo <templates/manifest.yml >"${family}/manifest.yml"
mo <templates/Dockerfile.amd64 >"${family}/Dockerfile.amd64"
mo <templates/Dockerfile.arm64v8 >"${family}/Dockerfile.arm64v8"
mo <templates/entrypoint.sh >"${family}/entrypoint.sh"
mo <templates/healthcheck.sh >"${family}/healthcheck.sh"
mo <templates/script.sed >"${family}/script.sed"
chmod +x "${family}/entrypoint.sh"
chmod +x "${family}/healthcheck.sh"

echo 'Building Images'
docker build --platform linux/amd64 --pull -t ryansch/unifi-rpi:${docker_version}-amd64 -f ${family}/Dockerfile.amd64 ${family}
docker build --platform linux/arm64v8 --pull -t ryansch/unifi-rpi:${docker_version}-arm64v8 -f ${family}/Dockerfile.arm64v8 ${family}

echo 'Testing Images'
GOSS_PATH="${HOME}/.local/bin/goss-linux-amd64" GOSS_WAIT_OPTS='-r 60s -s 1s > /dev/null' dgoss run --platform linux/amd64 ryansch/unifi-rpi:${docker_version}-amd64
GOSS_PATH="${HOME}/.local/bin/goss-linux-arm64" GOSS_WAIT_OPTS='-r 60s -s 1s > /dev/null' dgoss run --platform linux/arm64v8 ryansch/unifi-rpi:${docker_version}-arm64v8
