variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "The region to launch the Kubernetes cluster."
  type        = string
  default     = "nyc3"
  # default     = "nyc1"
}
variable "ssh_key_ids" {
  description = "The SSH key IDs to use for the droplet."
  type        = list(string)
  # Leave empty to create/import from a public key file (see `ssh_public_key_path`).
  # example: [123456, 234567]
  default = []
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key file to import into DigitalOcean (used when `ssh_key_ids` is empty). Use an absolute path; '~' may not be expanded automatically." 
  type        = string
  default     = "/home/chris/.ssh/id_ed25519_do.pub"
}

variable "ssh_key_name" {
  description = "Name to give the imported SSH key in DigitalOcean"
  type        = string
  default     = "repo-do-key"
}

variable "droplet_name" {
  description = "Name for the DigitalOcean droplet"
  type        = string
  default     = "fedora-droplet"
}

variable "size" {
  description = "Droplet size slug (from doctl compute size list)"
  type        = string
  # for demanding workloads, 4vCPU, 8GB RAM, disk 160GB, $48/mo
  # default     = "s-4vcpu-8gb"
  # for testing/light workloads, 1vCPU, 2GB RAM, disk 50GB, $12/mo
  default     = "s-1vcpu-2gb"
  # for production/light workloads, 2vCPU, 4GB RAM, disk 80GB, $24/mo
  # default     = "s-2vcpu-4gb"
}

variable "image" {
  description = "Droplet image slug"
  type        = string
  default     = "fedora-42-x64"
}

variable "tags" {
  description = "List of tags to apply to the droplet"
  type        = list(string)
  default     = ["web", "env:dev"]
}