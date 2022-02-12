terraform {
  backend "s3" {
    # Variables not allowed so hardcode
    bucket = "dgimeno-repos"
    key = "terraform-aws-vpc/vpc/terraform.tfstate"
    region = "us-east-1"
    profile = "aws_ssh_hub"
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}