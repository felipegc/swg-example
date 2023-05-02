resource "random_id" "net_id_suffix" {
  byte_length = 3
}

resource "google_compute_network" "network" {
  provider                = google-beta

  name                    = "tf-network-for-swg-${random_id.net_id_suffix.hex}"
  project                 = var.project_id
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  provider        = google-beta

  name            = "tf-subnetwork-for-swg-${random_id.net_id_suffix.hex}"
  project         = var.project_id
  region          = var.location
  ip_cidr_range   = var.subnet_ip_cidr_range
  network         = google_compute_network.default.id
  purpose         = "PRIVATE"
  role            = "ACTIVE"
  stack_type      = "IPV4_ONLY"
}