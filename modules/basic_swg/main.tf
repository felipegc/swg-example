resource "random_id" "pre_req_id_suffix" {
  byte_length = 3
}

module "pre_requirements" {
  source                        = "../../modules/pre_requirements"

  project_id                    = var.project_id
  location                      = var.location
  proxyonlysubnet_ip_cidr_range = var.proxyonlysubnet_ip_cidr_range
  // TODO(felipegc) make sure to pass only the necessary apis to enable
  project_apis_to_enable        = []
  // TODO(felipegc) check if the entire id of the following resource can be imported and passed through.
  network                       = var.network
}

resource "google_network_security_gateway_security_policy" "gateway_security_policy" {
  provider    = google-beta

  project     = var.project_id
  location    = var.location
  name        = "tf-gsp-for-swg-${random_id.pre_req_id_suffix.hex}"
}

resource "google_network_security_gateway_security_policy_rule" "default" {
  provider                = google-beta

  project                 = var.project_id
  location                = var.location
  name                    = "gateway-gsp-rule-for-swg-${random_id.pre_req_id_suffix.hex}"
  gateway_security_policy = google_network_security_gateway_security_policy.gateway_security_policy.name
  enabled                 = true  
  priority                = 1
  // TODO(felipegc) consider parametrize the following values
  session_matcher         = "host() == 'example.com'"
  basic_profile           = "ALLOW"
}

resource "google_network_services_gateway" "default" {
  provider                               = google-beta

  project                                = var.project_id
  location                               = var.location
  name                                   = "tf-basic-swg-${random_id.pre_req_id_suffix.hex}"
  type                                   = "SECURE_WEB_GATEWAY"
  scope                                  = "scope-basic-swg-${random_id.pre_req_id_suffix.hex}"
  certificate_urls                       = [module.pre_requirements.certificate_id]
  network                                = "projects/${var.project_id}/global/networks/${var.network}"
  subnetwork                             = "projects/${var.project_id}/regions/${var.location}/subnetworks/${var.subnetwork}"
  gateway_security_policy                = google_network_security_gateway_security_policy.gateway_security_policy.id
  // TODO(felipegc) consider parametrize the following values
  addresses                              = ["10.128.0.99"]
  ports                                  = [443]
  delete_swg_autogen_router_on_destroy   = true
  depends_on                             = [module.pre_requirements.proxyonlysubnet]
}
