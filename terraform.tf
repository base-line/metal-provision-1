terraform {

  // backend "remote" {
  //   organization = "popa-org"

  //   workspaces {
  //     name = "metal-provision-1"
  //   }
  // }

  required_providers {
    metal = {
      source  = "equinix/metal"
      version = "~> 3.0"
    }
  }
}