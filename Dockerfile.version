FROM resin/rpi-raspbian:latest
MAINTAINER Ryan Schlesinger <ryan@ryanschlesinger.com>

RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" \
    > /etc/apt/sources.list.d/20ubiquiti.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    > /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    >> /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

COPY check-version.sh /usr/bin/check-version.sh
CMD ["check-version.sh"]
