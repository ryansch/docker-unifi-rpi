FROM multiarch/qemu-user-static:arm as qemu

FROM arm32v7/openjdk:8-slim-stretch
LABEL maintainer="Ryan Schlesinger <ryan@ryanschlesinger.com>"

COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      gnupg \
      dirmngr \
    && rm -rf /var/lib/apt/lists/* && \
    wget https://archive.raspbian.org/raspbian.public.key -O - | apt-key add - && \
    echo 'deb http://archive.raspbian.org/raspbian stretch main contrib non-free' >> /etc/apt/sources.list

# Install any version from deb download
# Use dpkg to mark the package for install (expect it to fail to complete the installation)
# Use apt-get install -f to complete the installation with dependencies
ENV UNIFI_VERSION 5.10.25
ENV UNIFI_DOCKER_VERSION 5.10.25
RUN mkdir -p /usr/share/man/man1 && \
      mkdir -p /tmp/build && \
      cd /tmp/build && \
      wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg && \
      wget https://www.ubnt.com/downloads/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb && \
      apt-get update && apt-get install -y --no-install-recommends \
        ./unifi_sysvinit_all.deb \
        procps && \
      rm -rf /var/lib/apt/lists/* && \
      rm -rf /tmp/build

RUN ln -s /var/lib/unifi /usr/lib/unifi/data
EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
