locals {
  instance_ocpus = 2
  memory_in_gbs  = 23
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_core_vnic_attachments" "app_vnics" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domain.ad.name
  instance_id         = oci_core_instance.github_runner_instance.id
}

data "oci_core_images" "github_runner_image" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "github_runner_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  shape               = var.instance_shape

  shape_config {
    ocpus         = local.instance_ocpus
    memory_in_gbs = local.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.github_runner_subnet.id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.github_runner_image.images[0], "id")
  }

  metadata = {
    user_data = base64encode(templatefile("${path.module}/github_runner.sh.tpl", {
      github_runner_token = var.github_runner_token
      github_runner_url   = var.github_runner_repo
    }))
  }
}
