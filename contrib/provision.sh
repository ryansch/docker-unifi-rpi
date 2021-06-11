#!/bin/bash

set -euo pipefail

echo "Choose arch:"
archs="arm64 armhf amd64"
select system_arch in $archs ; do
  : ${system_arch:?Invalid Selection!}
  echo "Using $system_arch"
  break;
done

echo "Updating packages"
apt-get update
apt-get upgrade -y

echo "Installing docker"
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=${system_arch}] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

groupadd docker || true
usermod -aG docker ubuntu

systemctl enable docker

echo "Installing packages"
apt-get install -y unzip neovim zsh build-essential python3-pip

echo "Installing docker-compose"
pip3 install docker-compose

echo "Setup complete!"
