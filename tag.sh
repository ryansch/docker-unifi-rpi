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
mo < templates/manifest.yml > "${family}/manifest.yml"

echo 'Pushing Manifest'
manifest-tool push from-spec ${family}/manifest.yml
