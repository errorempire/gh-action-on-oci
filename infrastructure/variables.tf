variable "compartment_ocid" {
  type        = string
  sensitive   = true
  description = "OCI Comparment ID"
}

variable "user_ocid" {
  type        = string
  description = "OCI User ocid"
}

variable "fingerprint" {
  type        = string
  sensitive   = true
  description = "Fingerprint of the key for OCI API access"
}

variable "private_key_path" {
  type = string
  validation {
    condition     = can(regex(".*.pem", var.private_key_path))
    error_message = "The key file path must end with .pem"
  }
  description = "(optional) OCI API private key path"
}

variable "tenancy_ocid" {
  type        = string
  description = "OCI Tenancy ocid"
  sensitive   = true
  validation {
    condition     = can(regex("^ocid1.tenancy.*$", var.tenancy_ocid))
    error_message = "The tenancy ocid must start with ocid1.tenancy character hex string"
  }
}

variable "region" {
  type        = string
  description = "OCI Region"
  default     = "eu-frankfurt-1"
}

variable "instance_shape" {
  type        = string
  default     = "VM.Standard.A1.Flex"
  description = "OCI Instance shape for the github runner lookup free tier"
}

variable "github_runner_token" {
  type        = string
  description = "GitHub runner token for the repo/organiation"
  sensitive   = true
}

variable "github_runner_repo" {
  type        = string
  description = "Github runner repo or organisation string"
  sensitive   = true
}
