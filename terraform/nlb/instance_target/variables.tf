locals {
  resource_name_suffix = terraform.workspace
}

variable "ec2_subnet_id" {
  type        = string
  description = "ID of the Subnet of EC2 instance"
}

variable "nlb_arn" {
  type        = string
  description = "ARN of the Network Load Balancer"
}

variable "listener_port" {
  type        = number
  description = "Port for instance"
}

variable "ec2_key_name" {
  type        = string
  description = "Key Name of the Key Pair"
}

variable "security_group_id" {
  type        = string
  description = "ID of the EC2 instance Security Group"
}

variable "ami_id" {
  type        = string
  description = "ID of the AMI to use for the EC2 instance"
}

variable "instance_profile_name" {
  type        = string
  description = "Name of the Instance Profile for the EC2 instance"
}
