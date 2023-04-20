module "basic_swg" {
  source                        = "./modules/basic_swg"

  project_id                    = var.project_id
  location                      = var.location
  proxyonlysubnet_ip_cidr_range = var.proxyonlysubnet_ip_cidr_range
  network                       = var.network
  subnetwork                    = var.subnetwork
}
