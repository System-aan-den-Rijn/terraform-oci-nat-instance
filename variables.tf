variable name {
    default = "Nat-Gateway-Instance"
}

variable compartment_id {
}

variable shape {
 default = "VM.Standard.A1.Flex"
}

variable "instance_ocpus" { 
  default = 1 
}

variable "instance_shape_config_memory_in_gbs" { 
  default = 6
}

variable "subnet_id" {    
}

variable "ssh_public_key" {
    default = null
}

variable "lan_ip" {
}

variable "tenancy_id" {
}