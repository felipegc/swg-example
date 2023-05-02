resource "random_id" "pre_req_id_suffix" {
  byte_length = 3
}

resource "google_certificate_manager_certificate" "certificate" {
  provider    = google-beta
  
  project     = var.project_id
  location    = var.location
  name        = "tf-cert-for-swg-${random_id.pre_req_id_suffix.hex}"
  description = "Necessary certificate for swg gateway usage"
  scope       = "DEFAULT"
  self_managed {
    pem_certificate = file(var.gateway_pem_certificate_file_path)
    pem_private_key = file(var.gateway_pem_private_key_file_path)
  }
}

resource "google_compute_subnetwork" "proxyonlysubnet" {
  provider      = google-beta
  
  project       = var.project_id
  region        = var.location
  name          = "tf-reserved-proxy-only-subnetwork-${random_id.pre_req_id_suffix.hex}"
  purpose       = "REGIONAL_MANAGED_PROXY"
  ip_cidr_range = var.proxyonlysubnet_ip_cidr_range
  network       = var.network
  role          = "ACTIVE"
}
