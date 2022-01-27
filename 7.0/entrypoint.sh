#!/bin/sh

exec /usr/bin/java ${JAVA_OPTS} -jar /usr/lib/unifi/lib/ace.jar "$@"
