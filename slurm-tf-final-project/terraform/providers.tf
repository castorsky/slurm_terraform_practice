terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }

    # TLS provider used to generate SSH pair if not defined in variables
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
  }
  required_version = ">= 0.13"
}

# These parameters can be defined in environment (YC_*) or input variables
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}
