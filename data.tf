data "oci_core_images" "ampere_images_ubuntu" {
  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = var.shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_id
  ad_number      = 1
}

data "oci_core_private_ips" "nat_gw_vnic" {
    vnic_id = oci_core_vnic_attachment.natgw_lan_vnic_attachment.vnic_id
}