#!/usr/bin/env bash
set -euo pipefail

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
mo <templates/Dockerfile >"${family}/Dockerfile"
mo <templates/entrypoint.sh >"${family}/entrypoint.sh"
mo <templates/healthcheck.sh >"${family}/healthcheck.sh"
mo <templates/script.sed >"${family}/script.sed"
mo <templates/bake.hcl >"${family}/bake.hcl"
chmod +x "${family}/entrypoint.sh"
chmod +x "${family}/healthcheck.sh"

echo 'Building Images'
pushd "${family}"
docker_version=${docker_version} \
  unifi_version=${unifi_version} \
  unifi_sha256=${unifi_sha256} \
  java_package=${java_package} \
  docker buildx bake --file bake.hcl unifi --builder=container
popd

echo 'Testing Images'
GOSS_PATH="${HOME}/.local/bin/goss-linux-amd64" GOSS_WAIT_OPTS='-r 60s -s 1s > /dev/null' dgoss run --platform linux/amd64 "ryansch/unifi:${docker_version}"
GOSS_PATH="${HOME}/.local/bin/goss-linux-arm64" GOSS_WAIT_OPTS='-r 60s -s 1s > /dev/null' dgoss run --platform linux/arm64v8 "ryansch/unifi:${docker_version}"
