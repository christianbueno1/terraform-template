variable "aws_region" {
  description = "The AWS region to launch the instance."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.aws_region))
    error_message = "Must be a valid AWS region name (e.g. us-east-1, eu-west-1)"
  }
}
variable "public_key_path" {
  description = "The path to the public key file."
  type        = string
  default     = "/home/chris/.ssh/id_rsa.pub"

  validation {
    condition     = fileexists(var.public_key_path)
    error_message = "SSH public key file not found. Please check the path."
  }
}
variable "private_key_path" {
  description = "The path to the private key file."
  type        = string
  default     = "/home/chris/.ssh/id_rsa"

  validation {
    condition     = fileexists(var.private_key_path)
    error_message = "SSH private key file not found. Please check the path."
  }
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
