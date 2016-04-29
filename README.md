## Usage

### On mac:
- Insert rasp pi sd card into mac
- `brew install pv`
- `git clone https://github.com/hypriot/flash`
- `cd flash/Darwin`
- `./flash https://github.com/hypriot/image-builder-rpi/releases/download/v0.4.9/sd-card-rpi-v0.4.9.img.zip` (or latest release)
- When complete, install sd card into rpi and power on
- `ssh pirate@black-pearl.local` (default password is hypriot)

### On rpi:

- Install ssh key and disable password logins
- `cd /opt`
- `sudo git clone ryansch/docker-unifi-rpi unifi`
- `sudo cp /opt/unifi/unifi.service /etc/systemd/system/`
- `sudo systemctl enable /etc/systemd/system/unifi.service`
- `sudo systemctl start unifi.service`

### On mac:

- Visit 'http://black-pearl.local:8080' with your browser
