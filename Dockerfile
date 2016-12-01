FROM resin/rpi-raspbian:latest
MAINTAINER Ryan Schlesinger <ryan@ryanschlesinger.com>

RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" \
    > /etc/apt/sources.list.d/20ubiquiti.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    > /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    >> /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Install java before unifi so a controller update doesn't force
# a rebuild/redownload of java
ENV JAVA_INSTALLER_VERSION 8u111+8u111arm-1~webupd8~0
RUN apt-get update && apt-get install -y --no-install-recommends \
    oracle-java8-installer=${JAVA_INSTALER_VERSION} \
    oracle-java8-set-default \
    && rm -rf /var/lib/apt/lists/*

ENV UNIFI_VERSION 5.2.9-8748

RUN apt-get update && apt-get install -y --no-install-recommends \
    unifi=${UNIFI_VERSION} \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /var/lib/unifi /usr/lib/unifi/data
EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
