terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.46.0"
    }
  }
}

variable "do_token" {
  type = string
  description = "DigitalOcean token to access the provisioning API."

  sensitive = true
}

variable "grist_ports" {
  type = object({
      http = number
      https = number
  })
  description = "Where to expose the public http port for Grist to be accessible on."

  default = {
    http = 80
    https = 443
  }
}

variable "grist_url" {
  type = string
  description = "Grist needs to know its own URL for the application to work."

  default = "https://cool-beans.example.com"
}

variable "grist_https" {
  type = string
  description = "Should https be enabled? Defaults to auto"

  default = "auto"
}

variable "grist_team" {
  type = string
  description = "TODO: This shouldn't be defaulted"

  default = "cool-beans"
}

variable "grist_email" {
  type = string
  description = "TODO: This shouldn't be defaulted"

  default = "owner@example.com"
}

variable "grist_password" {
  type = string
  description = "TODO: This shouldn't be defaulted"

  default = "topsecret"
  sensitive = true
}

provider "digitalocean" {
  # Configuration options
  token = var.do_token
}

# Create our grist container
resource "digitalocean_app" "grist-dev" {
  spec {
    name = "grist-dev"
    region = "ams"
    service {
      name = "grist-dev"
      instance_count = 1
      instance_size_slug = "apps-s-1vcpu-1gb"

      git {
        repo_clone_url = "https://github.com/gristlabs/grist-omnibus"
        branch = "main"
      }

      // build_command = <<EOF
      // mkdir -p /tmp/grist-test
      // docker run \
      //   -p ${var.grist_ports.http}:${var.grist_ports.http} -p ${var.grist_ports.https}:${var.grist_ports.https} \
      //   -e URL=${var.grist_url} \
      //   -e HTTPS=${var.grist_https} \
      //   -e TEAM=${var.grist_team} \
      //   -e EMAIL=${var.grist_email} \
      //   -e PASSWORD=${var.grist_password} \
      //   -v /tmp/grist-test:/persist \
      //   --name grist --rm \
      //   -it gristlabs/grist-omnibus
      //   EOF
    }
  }
}
