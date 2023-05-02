variable "project_id" {
  description = "The ID of the project in which the related secure web gateway resources will be created."
  type        = string
}

variable "location" {
  description = "The resources location."
  type        = string
  default     = "us-central1"
}

variable "subnet_ip_cidr_range" {
  description = "The ip cidr range used by the subnet."
  type        = string
  default     = "10.128.0.0/20"
}

variable "gateway_pem_certificate_file_path" {
  description = "The gateway pem certificate file path to be used by the certificate manager."
  type        = string
}

variable "gateway_pem_private_key_file_path" {
  description = "The gateway pem private key file path to be used by the certificate manager."
  type        = string
}

variable "proxyonlysubnet_ip_cidr_range" {
  description = "The ip cidr range used by the regional manged proxy subenet."
  type        = string
  default     = "192.168.0.0/23"
}

variable "session_matcher_rule" {
  description = "The session matcher policy rule in CEL format."
  type        = string
}

variable "gateway_address" {
  description = "The gateway addess."
  type        = string
  default     = "10.128.0.99"
}