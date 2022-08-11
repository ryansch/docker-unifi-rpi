#!/bin/bash

set -euo pipefail

if [ -d /var/lib/unifi/db ]; then
  pushd /var/lib/unifi/db

  # Check for WiredTiger version 3.x.x
  major_version=$(cat WiredTiger.turtle | egrep 'major=.+,minor=.+,patch=.+' | cut -d ',' -f 1 | cut -d '=' -f 2)

  if [ "${major_version}" != 3 ]; then
    echo "Older mongodb files detected!"
    echo "We've been forced to upgrade mongodb to version 3.6."
    echo "You must back up your unifi network application, remove all docker volumes,"
    echo "start up unifi, and restore from backup during setup."
    exit 1
  fi

  popd
fi

exec /usr/bin/java ${JAVA_OPTS} -jar /usr/lib/unifi/lib/ace.jar "$@"
