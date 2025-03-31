#!/usr/bin/env bash
set -euo pipefail

. "lib/init_vars"

echo 'Tagging and Pushing to Git'
git add .
git commit -m "Adding ${docker_version}"
# TODO: Only tag if tag doesn't exist
git tag -m "Version ${docker_version}" "v${docker_version}"
git push
git push --tags

echo 'Pushing images/manifest'
pushd "${family}"
docker_version=${docker_version} \
  unifi_version=${unifi_version} \
  unifi_sha256=${unifi_sha256} \
  java_package=${java_package} \
  docker buildx bake --file bake.hcl unifi --builder=container --push

docker_version=${docker_version} \
  unifi_version=${unifi_version} \
  unifi_sha256=${unifi_sha256} \
  java_package=${java_package} \
  docker buildx bake --file bake.hcl unifi --builder=container --push \
  ${docker_tags}
popd
