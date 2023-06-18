resource "oci_core_vcn" "github_runner_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
}

resource "oci_core_subnet" "github_runner_subnet" {
  cidr_block        = "10.0.0.0/24"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.github_runner_vcn.id
  display_name      = "github_runner_subnet"
  security_list_ids = [oci_core_security_list.github_runner_security_list.id]
  route_table_id    = oci_core_route_table.github_runner_route_table.id
  dhcp_options_id   = oci_core_vcn.github_runner_vcn.default_dhcp_options_id
}


resource "oci_core_security_list" "github_runner_security_list" {
  display_name   = "github_runner_security_list"
  vcn_id         = oci_core_vcn.github_runner_vcn.id
  compartment_id = var.compartment_ocid

  // allow all outbound traffic (required for github runner) : TODO: restrict to github.com later 
  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = "1"
      max = "65535"
    }
  }
}

resource "oci_core_route_table" "github_runner_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.github_runner_vcn.id
  display_name   = "github_runner_route_table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.github_runner_internet_gateway.id
  }
}

resource "oci_core_internet_gateway" "github_runner_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "github_runner_gateway"
  vcn_id         = oci_core_vcn.github_runner_vcn.id
}
