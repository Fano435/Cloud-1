terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

variable "ssh_public_key" {}

provider "google" {
  project = "cloud-1"
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

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12-bookworm-v20260513"
      size  = 10  
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static[count.index].address
    }
  }

  # Accès Cloud SQL Proxy
  service_account {
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/sqlservice.admin",
    ]
  }

  # Clé SSH
  metadata = {
    ssh-keys = "deploy:${var.ssh_public_key}"
  }

  tags = ["http-server", "https-server"]
}

# Firewall — same config que ton ufw
resource "google_compute_firewall" "default" {
  name    = "wordpress-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "443"]
  }

  target_tags   = ["https-server"]
  source_ranges = ["0.0.0.0/0"]
}

# Génère l'inventaire Ansible
resource "local_file" "inventory" {
  content = templatefile("inventory.tpl", {
    ip   = data.google_compute_address.static[*].address
    user = "deploy"
  })
  filename = "inventory.ini"
}