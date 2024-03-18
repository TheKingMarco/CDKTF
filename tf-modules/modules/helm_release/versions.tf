terraform {
  required_version = ">= 1.3.5"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}