variable "project_id" {
  description = "The ID of the project in which the related secure web gateway resources will be created."
  type        = string
}

variable "location" {
  description = "The resources location."
  type        = string
  default     = "us-central1"
}

variable "proxyonlysubnet_ip_cidr_range" {
  description = "The ip cidr range used by the regional manged proxy subenet."
  type        = string
  default     = "192.168.0.0/23"
}

variable "network" {
  description = "The network where the secure web gateway belongs to."
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork where the secure web gateway belongs to."
  type        = string
}
