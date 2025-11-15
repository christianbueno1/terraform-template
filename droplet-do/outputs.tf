output "droplet_id" {
  description = "The ID of the created droplet"
  value       = digitalocean_droplet.this.id
}

output "droplet_ip" {
  description = "The public IPv4 address of the droplet"
  value       = digitalocean_droplet.this.ipv4_address
}
