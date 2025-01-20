# check your local environment variables or your systems environment variables for the value of the DigitalOcean API token.

variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}
variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "todo-web-cluster"
}
variable "k8s_version" {
  description = "The version of Kubernetes to use."
  type        = string
  default     = "1.31.1-do.5"
}
variable "region" {
  description = "The region to launch the Kubernetes cluster."
  type        = string
  default     = "nyc3"
  # default     = "nyc1"
}