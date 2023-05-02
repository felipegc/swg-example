variable "project_id" {
  description = "The ID of the project in which the related network resources will be created."
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