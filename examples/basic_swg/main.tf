resource "random_id" "pre_req_id_suffix" {
  byte_length = 3
}

module "pre_requirements" {
  source                            = "../../modules/pre_requirements"

  project_id                        = var.project_id
  location                          = var.location
  proxyonlysubnet_ip_cidr_range     = var.proxyonlysubnet_ip_cidr_range
  network                           = var.network
  gateway_pem_certificate_file_path = var.gateway_pem_certificate_file_path
  gateway_pem_private_key_file_path = var.gateway_pem_private_key_file_path
}

module basic_policy_and_rule {
  source = "../../modules/basic_policy_and_rule"

  project_id           = var.project_id
  location             = var.location
  session_matcher_rule = var.session_matcher_rule
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
  gateway_security_policy                = module.basic_policy_and_rule.gateway_policy_id
  addresses                              = [var.gateway_address]
  ports                                  = [443]
  delete_swg_autogen_router_on_destroy   = true
  depends_on                             = [module.pre_requirements.proxyonlysubnet]
}
