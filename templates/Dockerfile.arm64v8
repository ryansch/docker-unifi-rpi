FROM multiarch/qemu-user-static:aarch64 as qemu

FROM arm64v8/openjdk:8-slim-stretch
LABEL maintainer="Ryan Schlesinger <ryan@ryanschlesinger.com>"

COPY --from=qemu /usr/bin/qemu-aarch64-static /usr/bin/qemu-aarch64-static

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      gnupg \
      dirmngr \
    && rm -rf /var/lib/apt/lists/*

# Install any version from deb download
# Use dpkg to mark the package for install (expect it to fail to complete the installation)
# Use apt-get install -f to complete the installation with dependencies
ENV UNIFI_VERSION {{ unifi_version }}
ENV UNIFI_DOCKER_VERSION {{ docker_version }}
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
