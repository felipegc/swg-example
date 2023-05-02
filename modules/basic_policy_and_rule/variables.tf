variable "project_id" {
  description = "The ID of the project in which the related secure web gateway resources will be created."
  type        = string
}

variable "location" {
  description = "The resources location."
  type        = string
  default     = "us-central1"
}

variable "session_matcher_rule" {
  description = "The session matcher policy rule in CEL format."
  type        = string
}