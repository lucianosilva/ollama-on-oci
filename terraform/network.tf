resource "oci_core_vcn" "ollama" {
  compartment_id = var.compartment_ocid
  cidr_block     = "10.10.0.0/16"
  display_name   = "${var.instance_name}-vcn"
  dns_label      = "ollamavcn"

  freeform_tags = {
    Project   = "ollama-on-oci"
    ManagedBy = "Terraform"
  }
}

resource "oci_core_internet_gateway" "ollama" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.ollama.id
  display_name   = "${var.instance_name}-igw"
  enabled        = true
}

resource "oci_core_route_table" "ollama" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.ollama.id
  display_name   = "${var.instance_name}-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ollama.id
  }
}

resource "oci_core_security_list" "ollama" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.ollama.id
  display_name   = "${var.instance_name}-security-list"

  ingress_security_rules {
    protocol = "6"
    source   = var.ssh_ingress_cidr

    tcp_options {
      min = 22
      max = 22
    }

    description = "SSH administration"
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.https_ingress_cidr

    tcp_options {
      min = 443
      max = 443
    }

    description = "Ollama API HTTPS"
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "ollama" {
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.ollama.id
  cidr_block        = "10.10.1.0/24"
  display_name      = "${var.instance_name}-public-subnet"
  dns_label         = "ollamasubnet"
  route_table_id    = oci_core_route_table.ollama.id
  security_list_ids = [oci_core_security_list.ollama.id]

  prohibit_public_ip_on_vnic = false
}
