terraform {
  required_version = ">= 1.7.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 7.0"
    }
  }
}

#provider "oci" {
#  tenancy_ocid     = var.tenancy_ocid
#  user_ocid        = var.user_ocid
#  fingerprint      = var.fingerprint
#  private_key_path = var.private_key_path
#  region           = var.region
#}

provider "oci" {
  config_file_profile = "DEFAULT"
  region              = var.region
}

resource "oci_core_instance" "ollama" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = var.instance_name
  shape               = var.shape

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.oracle_linux.images[0].id
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.ollama.id
    assign_public_ip = var.assign_public_ip
    display_name     = "${var.instance_name}-vnic"
    hostname_label   = var.instance_name
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  freeform_tags = {
    Project   = "ollama-on-oci"
    ManagedBy = "Terraform"
  }
}
