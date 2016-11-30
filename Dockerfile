FROM resin/rpi-raspbian:latest
MAINTAINER Ryan Schlesinger <ryan@ryanschlesinger.com>

RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" \
    > /etc/apt/sources.list.d/20ubiquiti.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50

# Install java before unifi so a controller update doesn't force
# a rebuild/redownload of java
ENV JAVA_VERSION 8u65
RUN apt-get update && apt-get install -y --no-install-recommends \
    oracle-java8-jdk=${JAVA_VERSION} \
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
