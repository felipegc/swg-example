output "network_name" {
  description = "Network name created."
  value       = module.basic_network.network_name
}

output "subnetwork_name" {
  description = "Subnetwork name created for the network."
  value       = module.basic_network.subnetwork_name
}