terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

resource "docker_container" "contenedor" {
  image = docker_image.ubuntu.image_id
  name = "contenedor_auto"
  attach = false
  must_run = true
  command = ["sleep", "600"]

}