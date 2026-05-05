output "droplet_id" {
  description = "The ID of the created droplet"
  value       = digitalocean_droplet.this.id
}

output "droplet_ip" {
  description = "The public IPv4 address of the droplet"
  value       = digitalocean_droplet.this.ipv4_address
}

# generate inventory file for Ansible
# output "ansible_inventory" {
#   description = "Ansible inventory file content for the created droplet"
#   value = <<EOT
# [droplets]
# ${digitalocean_droplet.this.ipv4_address} ansible_user=root ansible_ssh_private_key_file=${var.ssh_private_key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no'
# EOT
# }
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible-setup/inventory.ini"
  content  = <<EOF
[droplet]
${digitalocean_droplet.this.ipv4_address}

[droplet:vars]
ansible_user=root
ansible_ssh_private_key_file=~/.ssh/id_ed25519_do
EOF
}
output "ansible_inventory_path" {
  description = "Path to the generated Ansible inventory file"
  value       = local_file.ansible_inventory.filename
}