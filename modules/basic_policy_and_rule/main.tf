resource "random_id" "policy_id_suffix" {
  byte_length = 3
}

resource "google_network_security_gateway_security_policy" "gateway_security_policy" {
  provider    = google-beta

  project     = var.project_id
  location    = var.location
  name        = "tf-gsp-for-swg-${random_id.policy_id_suffix.hex}"
}

resource "google_network_security_gateway_security_policy_rule" "default" {
  provider                = google-beta

  project                 = var.project_id
  location                = var.location
  name                    = "gateway-gsp-rule-for-swg-${random_id.policy_id_suffix.hex}"
  gateway_security_policy = google_network_security_gateway_security_policy.gateway_security_policy.name
  enabled                 = true  
  priority                = 1
  session_matcher         = var.session_matcher_rule
  basic_profile           = "ALLOW"
}