variable "project_id" {
  description = "The ID of the project in which the related secure web gateway resources will be created."
  type        = string
}

variable "location" {
  description = "The resources location."
  type        = string
  default     = "us-central1"
}

variable "project_apis_to_enable" {
  description = "The necessary apis related to swg resources that will be enabled in the project."
  type        = list(string)
  // TODO(felipegc) check the necessary ones.
  default     = []
}

variable "network" {
  description = "The network where the regional managed proxy subnetwork will be created."
  type        = string
}

variable "proxyonlysubnet_ip_cidr_range" {
  description = "The ip cidr range used by the regional manged proxy subenet."
  type        = string
  default     = "192.168.0.0/23"
}