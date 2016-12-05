## Usage

### On mac:
- Insert rasp pi sd card into mac
- `brew install pv ssh-copy-id`
- `git clone https://github.com/hypriot/flash`
- `cd flash/Darwin`
- `./flash https://downloads.hypriot.com/hypriotos-rpi-v1.0.0.img.zip` (or latest release)
- When complete, install sd card into rpi and power on
- `ssh-copy-id -i .ssh/id_rsa.pub pirate@black-pearl.local` (default password is hypriot)
- Disable password logins: `PasswordAuthentication no` in /etc/ssh/sshd_config

Note: You may have to enable password logins on your mac os client temporarily to complete these steps.
- `systemctl restart ssh.service`

### On rpi:

Note: I've renamed the docker volumes to remove the double 'unifi'.  If you're upgrading then you'll need to rename your volumes.

- `cd /opt`
- `sudo git clone https://github.com/ryansch/docker-unifi-rpi unifi`
- `sudo cp /opt/unifi/unifi.service /etc/systemd/system/`
- `sudo systemctl enable /etc/systemd/system/unifi.service`
- `docker pull ryansch/unifi-rpi:v5` (For download and extract progress)
- `sudo systemctl start unifi.service`

### On mac:

- Visit 'http://black-pearl.local:8080' with your browser

## Unifi Image Upgrade

- `docker pull ryansch/unifi-rpi:v5`
- `sudo systemctl stop unifi.service`
- `sudo systemctl start unifi.service`

## Hypriot Upgrade

- `docker run -it --rm -v unifi_config:/config -v $(pwd):/backup --name=copy -w /config resin/rpi-raspbian:latest tar -zcf /backup/unifi_config.tar.gz .`
- Copy the tarball from the pi to another system
- Run the flash and setup instructions above stopping before starting unifi.
- Copy the tarball from another system back to the pi
- `docker volume create --name unifi_config`
- `docker run -it --rm -v unifi_config:/config -v $(pwd):/backup --name=copy -w /config resin/rpi-raspbian:latest tar -zxf /backup/unifi_config.tar.gz .`
- Volume is now populated from backup.  Continue with starting unifi.

## Building
- `docker build -t ryansch/unifi-rpi:version -f Dockerfile.version .`
- `docker run -it --rm ryansch/unifi-rpi:version`
- Update Dockerfile with version number from previous step
- `docker build -t ryansch/unifi-rpi:v5 .`
