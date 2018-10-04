#!/usr/bin/env bash
set -e

docker_version=''
unifi_version=''
declare -a docker_tags

. "lib/init_vars"

echo 'Tagging and Pushing to Git'
git add .
git commit -m "Adding ${docker_version}"
git tag -m "Version ${docker_version}" "v${docker_version}"
git push
git push --tags

echo 'Pushing'
docker push ryansch/unifi-rpi:${docker_version}-amd64
docker push ryansch/unifi-rpi:${docker_version}-arm32v7

echo 'Pushing Manifest'
manifest-tool push from-spec ${family}/manifest.yml
