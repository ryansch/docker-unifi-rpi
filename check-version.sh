#!/bin/sh
set -e

apt-get update
apt-cache madison oracle-java8-installer unifi
