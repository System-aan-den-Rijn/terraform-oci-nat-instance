resource "tls_private_key" "compute_ssh_key" {
  count = ( var.ssh_public_key != "" ? 0 : 1 )
  algorithm = "RSA"
  rsa_bits  = 2048
}