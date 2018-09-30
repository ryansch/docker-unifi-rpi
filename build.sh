#!/usr/bin/env bash
set -e

docker_version=''
unifi_version=''
declare -a docker_tags

print_usage() {
  echo "Usage: build.sh -v -u [-t]"
}

while getopts ":hv:u:t:" opt; do
  case $opt in
    v ) docker_version=$OPTARG
      ;;
    u ) unifi_version=$OPTARG
      ;;
    t ) docker_tags+=( "$OPTARG" )
      ;;
    h) print_usage
      ;;
    \? ) "Invalid Option: -$OPTARG" 1>&2
      print_usage
      exit 1
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      print_usage
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

: "${docker_version:?-v required}"
: "${unifi_version:?-u required}"

# Parse unifi family from docker_version
IFS='.' read -ra version_ary <<< "$docker_version"
family="${version_ary[0]}.${version_ary[1]}"

if [ ${#version_ary[@]} -le 2 ]; then
  echo "Invalid version specified for -v"
  exit 1
fi

# Source mo for templates
. "lib/mo"

mo < templates/manifest.yml > "${family}/manifest.yml"
mo < templates/Dockerfile.amd64 > "${family}/Dockerfile.amd64"
mo < templates/Dockerfile.arm32v7 > "${family}/Dockerfile.arm32v7"
