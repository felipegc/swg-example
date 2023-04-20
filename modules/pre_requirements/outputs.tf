output "certificate_id" {
  description = "Certificate manager certificate id."
  value       = google_certificate_manager_certificate.certificate.id
}

output "proxyonlysubnet" {
  description = "Regional manged proxy subnetwork created for the network."
  value       = google_certificate_manager_certificate.certificate.id
}