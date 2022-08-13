# Terraform Module for Nat Instance in OCI

This little module can be used to deploy a Compute Instance that can be used as a Nat Gateway in the Oracle Cloud, for example, when you're using the Always Free Resources which do not include the standard Nat Gateway.

## Notes

A reboot of the instance after it's fully deployed might be necessary, due to how the attachment of VNICs work in OCI. You should be able to access the instance with the user "ubuntu" - as in: "ubuntu@public-ip". 

## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | OCID of the Compartment in which the instance will be deployed | `any` | n/a | yes |
| <a name="input_lan_ip"></a> [lan\_ip](#input\_lan\_ip) | IP Address that will be used as a default gateway for private instances | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | OCID of the subnet in which the instance will be deployed. It has to be a PUBLIC subnet | `any` | n/a | yes |
| <a name="input_tenancy_id"></a> [tenancy\_id](#input\_tenancy\_id) | OCID of the tenant | `any` | n/a | yes |
| <a name="input_instance_ocpus"></a> [instance\_ocpus](#input\_instance\_ocpus) | Number of CPUs of the instance | `number` | `1` | no |
| <a name="input_instance_shape_config_memory_in_gbs"></a> [instance\_shape\_config\_memory\_in\_gbs](#input\_instance\_shape\_config\_memory\_in\_gbs) | GBs of memory assigned to the instance | `number` | `6` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the instance | `string` | `"Nat-Gateway-Instance"` | no |
| <a name="input_shape"></a> [shape](#input\_shape) | Instance shape to be used | `string` | `"VM.Standard.A1.Flex"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Public key that will have access to the instance. If none is specified, one will be generated | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_entity_id"></a> [network\_entity\_id](#output\_network\_entity\_id) | OCID of the Private IP address - You'll need specifically this value to create the route rules in your route table |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | That. |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_core_instance.instance0](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance) | resource |
| [oci_core_vnic_attachment.natgw_lan_vnic_attachment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vnic_attachment) | resource |
| [tls_private_key.compute_ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [oci_core_images.ampere_images_ubuntu](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_images) | data source |
| [oci_core_private_ips.nat_gw_vnic](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_private_ips) | data source| [oci_identity_availability_domain.ad](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domain) | data source |
| [template_file.cloud-config-nat-gw](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |