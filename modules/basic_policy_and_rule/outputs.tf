output "gateway_policy_id" {
  description = "The gateway policy id."
  value       = google_network_security_gateway_security_policy.gateway_security_policy.id
}
