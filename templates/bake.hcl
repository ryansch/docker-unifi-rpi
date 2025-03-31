variable "docker_version" {
}

variable "unifi_version" {
}

variable "unifi_docker_version" {
}

variable "unifi_sha256" {
}

variable "java_package" {
}

target "unifi" {
  context    = "."
  dockerfile = "Dockerfile"

  args = {
    UNIFI_VERSION        = unifi_version
    UNIFI_DOCKER_VERSION = unifi_docker_version
    UNIFI_SHA256         = unifi_sha256
    JAVA_PACKAGE         = java_package
  }

  tags = ["ryansch/unifi-rpi:${docker_version}", "ryansch/unifi:${docker_version}"]

  platforms = ["linux/arm64", "linux/amd64"]
}

target "unifi-arm" {
  inherits = ["unifi"]

  platforms = ["linux/arm64"]
}

target "unifi-amd" {
  inherits = ["unifi"]

  platforms = ["linux/amd64"]
}
