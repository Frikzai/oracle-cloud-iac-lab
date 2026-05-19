resource "oci_core_security_list" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id

  display_name = "${var.project_name}-${var.environment}-public-sl"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }

    description = "SSH vers bastion - a restreindre a ton IP publique"
  }

  freeform_tags = local.common_tags
}

resource "oci_core_security_list" "private" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id

  display_name = "${var.project_name}-${var.environment}-private-sl"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.public_subnet_cidr

    tcp_options {
      min = 22
      max = 22
    }

    description = "SSH depuis subnet public bastion"
  }

  ingress_security_rules {
    protocol = "1"
    source   = var.vcn_cidr

    icmp_options {
      type = 3
      code = 4
    }

    description = "ICMP fragmentation needed"
  }

  freeform_tags = local.common_tags
}

resource "oci_core_security_list" "data" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id

  display_name = "${var.project_name}-${var.environment}-data-sl"

  egress_security_rules {
    protocol    = "6"
    destination = var.private_subnet_cidr

    tcp_options {
      min = 1521
      max = 1521
    }

    description = "Flux DB Oracle vers subnet prive si necessaire"
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.private_subnet_cidr

    tcp_options {
      min = 1521
      max = 1521
    }

    description = "Acces DB depuis subnet applicatif"
  }

  freeform_tags = local.common_tags
}
