output network_entity_id {
    value = data.oci_core_private_ips.nat_gw_vnic.private_ips[0].id
}

output public_ip {
    value = oci_core_instance.instance0.public_ip
}

output "auto_generated_ssh_key" {
    value       = (var.ssh_public_key != "") ? null : tls_private_key.compute_ssh_key[0].public_key_openssh
    sensitive   = true
}