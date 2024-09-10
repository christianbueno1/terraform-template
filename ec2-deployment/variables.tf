variable "aws_region" {
    type    = string
    # default = "us-east-1"
    default = "sa-east-1" 
}

variable "ami_id_fedora40" {
    description = "AMI ID of fedora 40"
    type = string
    default = "ami-069a2aee38def4c51"
}

variable "ami_id_rocky9" {
    description = "AMI ID of rocky 9"
    type = string
    default = "ami-09fb459fad4613d55"
}