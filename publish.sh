#!/usr/bin/env bash
set -e

docker_version=''
unifi_version=''
family=''

. "lib/init_vars"

echo 'Tagging and Pushing to Git'
git add .
git commit -m "Adding ${docker_version}"
# TODO: Only tag if tag doesn't exist
git tag -m "Version ${docker_version}" "v${docker_version}"
git push
git push --tags

echo 'Pushing'
docker push ryansch/unifi-rpi:${docker_version}-amd64
docker push ryansch/unifi-rpi:${docker_version}-arm32v7
docker push ryansch/unifi-rpi:${docker_version}-arm64v8

echo 'Pushing Manifest'
manifest-tool push from-spec ${family}/manifest.yml
