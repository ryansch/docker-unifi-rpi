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
docker push ryansch/unifi-rpi:${docker_version}-arm64v8

echo 'Pushing Manifest'
# TODO: detect and use pass only if enabled
# username=$(basename $(ls ~/.password-store/docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv/) .gpg)
# password=$(pass show docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv/${username})
# manifest-tool --username=${username} --password=${password} push from-spec ${family}/manifest.yml
manifest-tool push from-spec "${family}/manifest.yml"
