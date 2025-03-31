#!/usr/bin/env bash
set -euo pipefail

. "lib/init_vars"

# Source mo for templates
. "lib/mo"

echo 'Pushing images/manifest'
pushd "${family}"
docker_version=${docker_version} \
  unifi_version=${unifi_version} \
  unifi_sha256=${unifi_sha256} \
  java_package=${java_package} \
  docker buildx bake --file bake.hcl unifi --builder=container --push

# shellcheck disable=SC2086
docker_version=${docker_version} \
  unifi_version=${unifi_version} \
  unifi_sha256=${unifi_sha256} \
  java_package=${java_package} \
  docker buildx bake --file bake.hcl unifi --builder=container --push \
  ${docker_tags}
popd
