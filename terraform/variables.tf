locals {
  vpc_id            = data.terraform_remote_state.terraform-aws-vpc.outputs.vpc_id
  public_subnet_id  = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_public_a_id
  private_subnet_id = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_private_a_id
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI Profile"
  default     = "aws_ssh_hub"
}

variable "terraform_aws_vpc_workspace" {
  type        = string
  description = "Workspace of the terraform-aws-vpc remote state"
  default     = "default"
}
