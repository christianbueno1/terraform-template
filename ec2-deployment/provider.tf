terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~>5.57"
        }
        random = {
            source  = "hashicorp/random"
            version = "~>3.6"
        }
        archive = {
            source  = "hashicorp/archive"
            version = "~>2.4"
        }
    }

    required_version = "~>1.9"
}

provider "aws" {
    region = var.aws_region
}   
