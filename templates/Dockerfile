# syntax=docker/dockerfile:1
# hadolint global ignore=DL3008
# hadolint global ignore=DL3003
FROM ubuntu:noble AS tini
ARG TARGETARCH
ENV TINI_VERSION=v0.19.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
      \
      apt-get update -y; \
      apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        gnupg \
        dirmngr \
        apt-transport-https \
      ; \
      apt-get clean; \
      rm -rf /var/lib/apt/lists/*

RUN set -eux; \
      \
      mkdir -p /tmp/build; \
	    cd /tmp/build; \
      \
      wget --progress=dot:giga -O tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-${TARGETARCH}; \
      wget --progress=dot:giga -O tini.asc https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-${TARGETARCH}.asc; \
      gpg --batch --keyserver  keyserver.ubuntu.com --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7; \
      gpg --batch --verify tini.asc tini; \
      cp tini /sbin/; \
      chmod +x /sbin/tini; \
      \
      cd /tmp; \
      rm -rf /tmp/build; \
      rm -rf /root/.gnupg

FROM ubuntu:noble
LABEL maintainer="Ryan Schlesinger <ryan@ryanschlesinger.com>"

ARG TARGETARCH

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=tini /sbin/tini /sbin/tini

ARG JAVA_PACKAGE
# hadolint ignore=SC1083
RUN set -eux; \
      \
      apt-get update -y; \
      apt-get install -y --no-install-recommends \
        wget \
        curl \
        ca-certificates \
        gnupg \
        dirmngr \
        apt-transport-https \
        ${JAVA_PACKAGE} \
      ; \
      apt-get clean; \
      rm -rf /var/lib/apt/lists/*

# Adapted from: https://get.glennr.nl/unifi/install/unifi-8.1.127.sh
ARG LIBSSL_PACKAGE
RUN set -eux; \
      \
      libssl_temp="$(mktemp --tmpdir=/tmp libssl1.1.1_XXXXX.deb)"; \
      case "${TARGETARCH}" in \
        arm64) \
          wget -qO "$libssl_temp" 'http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_arm64.deb'; \
          ;; \
        amd64) \
          wget -qO "$libssl_temp" 'http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb'; \
          ;; \
        *) \
          echo "Unsupported architecture: ${TARGETARCH}"; \
          exit 1; \
          ;; \
      esac; \
      dpkg -i "$libssl_temp"; \
      rm --force "$libssl_temp" 2> /dev/null; \
      \
      curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | \
      gpg -o /usr/share/keyrings/mongodb-server-4.4.gpg \
      --dearmor ; \
      echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list; \
      apt-get update; \
      apt-get -y --no-install-recommends -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install \
        mongodb-org=4.4.18 \
        mongodb-org-server=4.4.18 \
        mongodb-org-mongos=4.4.18 \
        mongodb-org-tools=4.4.18 \
        mongodb-org-shell=4.4.18 \
      ; \
      apt-get clean; \
      rm -rf /var/lib/apt/lists/*

# Install any version from deb download
ARG UNIFI_VERSION
ENV UNIFI_VERSION=${UNIFI_VERSION}

ARG UNIFI_DOCKER_VERSION
ENV UNIFI_DOCKER_VERSION=${UNIFI_DOCKER_VERSION}

ARG UNIFI_SHA256
ENV UNIFI_SHA256=${UNIFI_SHA256}

RUN set -eux; \
      \
      mkdir -p /usr/share/man/man1; \
      mkdir -p /tmp/build; \
      cd /tmp/build; \
      \
      wget -qO /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg; \
      wget -qO unifi_sysvinit_all.deb https://dl.ui.com/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb; \
      echo "${UNIFI_SHA256}  unifi_sysvinit_all.deb" | sha256sum --check; \
      apt-get update -y; \
      apt-get install -y --no-install-recommends \
        ./unifi_sysvinit_all.deb \
        procps \
      ; \
      apt-get clean; \
      rm -rf /var/lib/apt/lists/*; \
      rm -rf /tmp/build

COPY script.sed /tmp/script.sed
RUN set -eux; \
      \
      cd /usr/sbin; \
      sed -E -i.bak -f /tmp/script.sed unifi-network-service-helper; \
      rm -f /tmp/script.sed

EXPOSE 8080/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp

WORKDIR /usr/lib/unifi

COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
CMD ["start"]

COPY healthcheck.sh /healthcheck.sh
HEALTHCHECK --start-period=300s --timeout=30s --interval=30s \
  CMD /healthcheck.sh || exit 1
