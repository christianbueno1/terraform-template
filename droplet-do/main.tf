resource "digitalocean_droplet" "fedora_droplet" {
    image  = "fedora-41-x64"
    name   = "fedora-droplet"
    region = "nyc3"
    size   = "s-1vcpu-1gb"
    ssh_keys = var.ssh_key_ids

    tags = ["web", "env:dev"]
}