terraform {
  backend "s3" {
    # Variables not allowed so hardcode
    bucket  = "dgimeno-repos"
    key     = "aws-ssh-hub/nlb/terraform.tfstate"
    region  = "us-east-1"
    profile = "aws_ssh_hub"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "terraform_remote_state" "terraform-aws-vpc" {
  backend   = "s3"
  workspace = var.terraform_aws_vpc_workspace
  config = {
    bucket  = "dgimeno-repos"
    key     = "terraform-aws-vpc/vpc/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}
