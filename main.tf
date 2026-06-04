terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
  backend "gcs" {
    bucket = "cloud1-terraform-state"
    prefix = "state"
  }
}

variable "ssh_public_key" {
  sensitive = true
}

variable "project_id" {
  type = string
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

data "google_compute_address" "static" {
  count = 2
  name  = "static-ip-${count.index}"  # static-ip-0, static-ip-1
}

resource "google_compute_instance" "vm" {
  count        = 2
  name         = "wordpress-prod-${count.index}"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12-bookworm-v20260513"
      size  = 10  
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = data.google_compute_address.static[count.index].address
      network_tier = "PREMIUM"
    }
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/sqlservice.admin",
    ]
  }

  metadata = {
    ssh-keys = "deploy:${var.ssh_public_key}"
  }
}

resource "local_file" "inventory" {
  content = templatefile("inventory.tpl", {
    ips   = data.google_compute_address.static[*].address
    user = "deploy"
  })
  filename = "inventory.ini"
}