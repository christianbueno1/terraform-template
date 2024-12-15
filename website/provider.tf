terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~>5.81"
        }
        random = {
            source  = "hashicorp/random"
            version = "~>3.6"
        }
        archive = {
            source  = "hashicorp/archive"
            version = "~>2.7"
        }
    }

    required_version = "~>1.10"
}

provider "aws" {
    region = var.aws_region
}   