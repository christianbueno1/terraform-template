variable "aws_region" {
  description = "The AWS region to launch the instance."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.aws_region))
    error_message = "Must be a valid AWS region name (e.g. us-east-1, eu-west-1)"
  }
}
variable "key_pair_name" {
  description = "The name of the key pair to use for the instance."
  type        = string
  sensitive = true
}
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = string
  sensitive   = true
  default     = "0.0.0.0/0"
}
variable "USER" {
  default = "ec2-user"
}