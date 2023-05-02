output "network" {
  description = "Network created."
  value       = google_compute_subnetwork.certificate.id
}

output "subnetwork" {
  description = "Subnetwork created for the network."
  value       = google_compute_subnetwork.certificate.id
}