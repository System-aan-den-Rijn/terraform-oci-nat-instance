resource "oci_core_instance" "instance0" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_id
  display_name        = var.name
  shape               = var.shape

  shape_config {
    ocpus = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = var.name
    skip_source_dest_check = true
  }
  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.ampere_images_ubuntu.images[0], "id")
  }

  metadata = {
    ssh_authorized_keys = (var.ssh_public_key != "") ? var.ssh_public_key : tls_private_key.compute_ssh_key[0].public_key_openssh
    user_data           = base64encode(data.template_file.cloud-config-nat-gw.rendered)
  }
}

resource "oci_core_vnic_attachment" "natgw_lan_vnic_attachment" {
    #Required
    create_vnic_details {
        assign_public_ip = false
        display_name = "Lan interface Nat GW"
        skip_source_dest_check = true
        subnet_id = var.subnet_id
        private_ip = var.lan_ip
    }
    instance_id = oci_core_instance.instance0.id
    depends_on = [
      oci_core_instance.instance0
    ]
}