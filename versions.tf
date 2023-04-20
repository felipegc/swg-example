terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      // TODO(gfelipe) make sure to have the right version once all resources are released.
      // For instance we are building locally and replacing the provider.
      version = "4.61.0"
    }
  }
}