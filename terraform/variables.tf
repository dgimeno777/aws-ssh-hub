variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-1"
}

variable "aws_profile" {
  type = string
  description = "AWS CLI Profile"
  default = "aws_ssh_hub"
}
