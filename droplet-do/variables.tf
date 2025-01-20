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
  default = [ "44557016" ]
}