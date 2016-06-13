## Usage

### On mac:
- Insert rasp pi sd card into mac
- `brew install pv`
- `git clone https://github.com/hypriot/flash`
- `cd flash/Darwin`
- `./flash https://github.com/hypriot/image-builder-rpi/releases/download/v0.8.0/hypriotos-rpi-v0.8.0.img.zip` (or latest release)
- When complete, install sd card into rpi and power on
- `ssh pirate@black-pearl.local` (default password is hypriot)

### On rpi:

- Install ssh key and disable password logins
- `cd /opt`
- `sudo git clone https://github.com/ryansch/docker-unifi-rpi unifi`
- `sudo cp /opt/unifi/unifi.service /etc/systemd/system/`
- `sudo systemctl enable /etc/systemd/system/unifi.service`
- `docker pull ryansch/unifi-rpi:v5` (For download and extract progress)
- `sudo systemctl start unifi.service`

### On mac:

- Visit 'http://black-pearl.local:8080' with your browser

## Building
- `docker build -t ryansch/unifi-rpi:version -f Dockerfile.version .`
- `docker run -it --rm ryansch/unifi-rpi:version`
- Update Dockerfile with version number from previous step
- `docker build -t ryansch/unifi-rpi:v5 .`
