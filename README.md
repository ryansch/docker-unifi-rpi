# Supported tags and respective `Dockerfile` links

- [`5.5.24`, (*v5.5.24/5.5/Dockerfile*) (stable 5.5)](https://github.com/ryansch/docker-unifi-rpi/blob/v5.5.24/5.5/Dockerfile)
- [`5.5.27`, (*5.5/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/master/5.5/Dockerfile)
- [`5.6.22`, `v5`, `latest`, (*v5.6.22/5.6/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/v5.6.22/5.6/Dockerfile)
- [`5.6.26`, (*5.6/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/master/5.6/Dockerfile)
- [`5.7.8`, (*5.7/Dockerfile*)](https://github.com/ryansch/docker-unifi-rpi/blob/master/5.7/Dockerfile)

## Usage

### On mac (or any computer really):

- Insert rasp pi sd card into mac
- `brew install pv ssh-copy-id`
- `git clone https://github.com/hypriot/flash`
- `cd flash/Darwin`
- `./flash https://github.com/hypriot/image-builder-rpi/releases/download/v1.1.1/hypriotos-rpi-v1.1.1.img.zip` (or latest release)
- When complete, install sd card into rpi and power on
- `ssh-copy-id -i .ssh/id_rsa.pub pirate@black-pearl.local` (default password is hypriot)
- Disable password logins: `PasswordAuthentication no` in /etc/ssh/sshd_config

Note: You may have to enable password logins on your mac os client temporarily to complete these steps.
- `systemctl restart ssh.service`

### On rpi:

- `sudo git clone https://github.com/ryansch/docker-unifi-rpi /opt/unifi && cd /opt/unifi`
- `sudo docker-compose up -d`

### On mac:

- Visit 'http://black-pearl.local:8080' with your browser

## Hypriot Upgrade

- `docker run -it --rm -v unifi_config:/config -v $(pwd):/backup --name=copy -w /config resin/rpi-raspbian:latest tar -zcf /backup/unifi_config.tar.gz .`
- Copy the tarball from the pi to another system
- Run the flash and setup instructions above stopping before starting unifi.
- Copy the tarball from another system back to the pi
- `docker volume create --name unifi_config`
- `docker run -it --rm -v unifi_config:/config -v $(pwd):/backup --name=copy -w /config resin/rpi-raspbian:latest tar -zxf /backup/unifi_config.tar.gz .`
- Volume is now populated from backup.  Continue with starting unifi.

## Building
- `docker build --pull -t ryansch/unifi-rpi:<version> <version>`
