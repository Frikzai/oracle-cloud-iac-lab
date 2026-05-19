data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}
##Récupérer l’image Ubuntu automatiquement##
data "oci_core_images" "ubuntu" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"

  shape = var.app_shape

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}
##Bastion public##
resource "oci_core_instance" "bastion" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  display_name = "${var.project_name}-${var.environment}-bastion"
  shape        = var.bastion_shape

  dynamic "shape_config" {
    for_each = var.bastion_shape == "VM.Standard.A1.Flex" ? [1] : []

    content {
      ocpus         = var.bastion_ocpus
      memory_in_gbs = var.bastion_memory_gb
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    display_name     = "${var.project_name}-${var.environment}-bastion-vnic"
    assign_public_ip = true
    hostname_label   = "bastion"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  freeform_tags = merge(local.common_tags, {
    role = "bastion"
    tier = "public"
  })
}
##VM applicative privée##
resource "oci_core_instance" "app" {
  count = var.app_instance_count

  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  display_name = "${var.project_name}-${var.environment}-app-${count.index + 1}"
  shape        = var.app_shape

  dynamic "shape_config" {
    for_each = var.app_shape == "VM.Standard.A1.Flex" ? [1] : []

    content {
      ocpus         = var.app_ocpus
      memory_in_gbs = var.app_memory_gb
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.private.id
    display_name     = "${var.project_name}-${var.environment}-app-${count.index + 1}-vnic"
    assign_public_ip = false
    hostname_label   = "app-${count.index + 1}"
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu.images[0].id
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }

  freeform_tags = merge(local.common_tags, {
    role = "app"
    tier = "private"
  })
}
