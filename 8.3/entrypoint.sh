#!/bin/bash

set -euo pipefail

function get_unifi_property() {
	if [ -f /var/lib/unifi/system.properties ]; then
		property_name=$1
		cut -d "=" -f2 <<<$(grep "^[^#;]" /var/lib/unifi/system.properties | grep "$property_name")
	fi
}

function verify_unifi_port() {
	local property_name=$1
	local required_port=$2

	local actual_port
	actual_port=$(get_unifi_property "$property_name")

	if [ "${actual_port:-$required_port}" != "$required_port" ]; then
		echo
		echo "Unifi system property '$property_name' is set to something other than '$required_port'!"
		echo "This docker image does not support changing the default ports inside the container."
		echo "If you want a different port, use docker port mapping to do it."
		exit 1
	fi
}

if [ -d /var/lib/unifi/db ]; then
	pushd /var/lib/unifi/db >/dev/null

	if [ -f /var/lib/unifi/db/WiredTiger.turtle ]; then
		major_version=$(cat /var/lib/unifi/db/WiredTiger.turtle | grep -E 'major=.+,minor=.+,patch=.+' | cut -d ',' -f 1 | cut -d '=' -f 2)

		if (("${major_version}" < 10)); then
			echo "Older mongodb files detected!"
			echo "We've been forced to upgrade mongodb to version 4.4."
			echo "You must back up your unifi network application, remove all docker volumes,"
			echo "start up unifi, and restore from backup during setup."
			exit 1
		fi
	fi

	popd >/dev/null
fi

# Setting defaults
UNIFI_CORE_ENABLED=false
UNIFI_MONGODB_SERVICE_ENABLED=false
UNIFI_JVM_OPTS="-Xmx1024M -XX:+UseParallelGC"
: ${UNIFI_JVM_EXTRA_OPTS:=${JAVA_OPTS:-}}

/usr/sbin/unifi-network-service-helper init

echo "Loading /usr/lib/unifi/data/system_env"
source /usr/lib/unifi/data/system_env

verify_unifi_port 'unifi.http.port' '8080'
verify_unifi_port 'unifi.https.port' '8443'
verify_unifi_port 'portal.http.port' '8880'
verify_unifi_port 'portal.https.port' '8843'
verify_unifi_port 'unifi.stun.port' '3478'

exec /usr/bin/java \
	-Dfile.encoding=UTF-8 \
	-Djava.awt.headless=true \
	-Dapple.awt.UIElement=true \
	-Dunifi.core.enabled=${UNIFI_CORE_ENABLED} \
	-Dunifi.mongodb.service.enabled=${UNIFI_MONGODB_SERVICE_ENABLED} \
	$UNIFI_JVM_OPTS \
	-XX:+ExitOnOutOfMemoryError \
	-XX:+CrashOnOutOfMemoryError \
	-XX:ErrorFile=/usr/lib/unifi/logs/hs_err_pid%p.log \
	-Xlog:gc:logs/gc.log:time:filecount=2,filesize=5M \
	--add-opens java.base/java.lang=ALL-UNNAMED \
	--add-opens java.base/java.time=ALL-UNNAMED \
	--add-opens java.base/sun.security.util=ALL-UNNAMED \
	--add-opens java.base/java.io=ALL-UNNAMED \
	--add-opens java.rmi/sun.rmi.transport=ALL-UNNAMED \
	-jar /usr/lib/unifi/lib/ace.jar start
