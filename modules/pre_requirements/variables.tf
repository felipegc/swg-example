variable "project_id" {
  description = "The ID of the project in which the related secure web gateway resources will be created."
  type        = string
}

variable "location" {
  description = "The resources location."
  type        = string
  default     = "us-central1"
}

variable "network" {
  description = "The network where the regional managed proxy subnetwork will be created."
  type        = string
}

variable "proxyonlysubnet_ip_cidr_range" {
  description = "The ip cidr range used by the regional manged proxy subnet."
  type        = string
  default     = "192.168.0.0/23"
}

variable "gateway_pem_certificate_file_path" {
  description = "The gateway pem certificate file path to be used by the certificate manager."
  type        = string
}

variable "gateway_pem_private_key_file_path" {
  description = "The gateway pem private key file path to be used by the certificate manager."
  type        = string
}