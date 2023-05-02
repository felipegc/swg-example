output "network_id" {
  description = "Network id created."
  value       = google_compute_network.network.id
}

output "network_name" {
  description = "Network created."
  value       = google_compute_network.network.name
}

output "subnetwork_id" {
  description = "Subnetwork id created for the network."
  value       = google_compute_subnetwork.subnetwork.id
}

output "subnetwork_name" {
  description = "Subnetwork created for the network."
  value       = google_compute_subnetwork.subnetwork.name
}