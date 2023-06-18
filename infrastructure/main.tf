terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.122.0"
    }
  }

  # backend terraform cloud -> change to your org and workspace
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "{{your-org-name}}"
    workspaces {
      name = "{{your-workspace-name}}"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  private_key      = file(var.private_key_path)
  region           = var.region
}
