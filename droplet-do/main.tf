resource "digitalocean_droplet" "this" {
  image  = var.image
  name   = var.droplet_name
  region = var.region
  size   = var.size
  # Prefer explicit list of SSH key IDs if provided; otherwise import the local public key
  # When the ssh key resource is conditionally created with `count`, its attributes
  # must be accessed by index (e.g. [0]).
  ssh_keys = length(var.ssh_key_ids) > 0 ? var.ssh_key_ids : [digitalocean_ssh_key.this[0].id]

  tags = var.tags

  # Optional: add a simple cloud-init user_data if you want to bootstrap
  # user_data = file("cloud_init.yml")
}

# If no ssh key ids are provided, import the public key file into DigitalOcean
resource "digitalocean_ssh_key" "this" {
  count      = length(var.ssh_key_ids) > 0 ? 0 : 1
  name       = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}

