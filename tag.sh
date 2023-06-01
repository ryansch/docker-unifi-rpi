#!/usr/bin/env bash
set -e

docker_version=''
unifi_version=''
family=''
declare -a docker_tags

. "lib/init_vars"

# Source mo for templates
. "lib/mo"

echo 'Emitting Manifest from Template'
mo <templates/manifest.yml >"${family}/manifest.yml"

echo 'Pushing Manifest'
# TODO: detect and use pass only if enabled
# username=$(basename $(ls ~/.password-store/docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv/) .gpg)
# password=$(pass show docker-credential-helpers/aHR0cHM6Ly9pbmRleC5kb2NrZXIuaW8vdjEv/${username})
# manifest-tool --username=${username} --password=${password} push from-spec ${family}/manifest.yml
manifest-tool push from-spec "${family}/manifest.yml"
