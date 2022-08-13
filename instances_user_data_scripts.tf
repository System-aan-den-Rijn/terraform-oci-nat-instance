data "template_file" "cloud-config-nat-gw" {
  template = <<YAML
#cloud-config
write_files:
  - path: /etc/sysctl.d/98-ip-forward.conf
    content: |
      net.ipv4.ip_forward = 1
  - path: /etc/rc.local
    content: |
      #!/bin/bash     
      sleep 10s # This is necessary to give time to the secondary VNIC to show up in the OS
      ip addr add ${var.lan_ip}/24 dev enp1s0
      iptables -D FORWARD 1
      iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
    permissions: '0755'

runcmd:
  - echo 'This instance was provisioned by Terraform.' >> /etc/motd
  - echo '-------------------------------------------' >> /etc/motd
  - sleep 20s # This is necessary to give time to the secondary VNIC to show up in the OS
  - /etc/rc.local # Run it for the initial setup
YAML
}