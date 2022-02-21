resource "aws_lb" "hub" {
  name               = "ssh-hub-${local.resource_name_suffix}"
  internal           = false
  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  subnets = [
    data.aws_subnet.public.id
  ]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = false
}

module "instance_1" {
  source                = "./instance_target"
  listener_port         = 5000
  nlb_arn               = aws_lb.hub.arn
  ec2_subnet_id         = data.aws_subnet.private.id
  security_group_id     = aws_security_group.instance.id
  ec2_key_name          = var.key_name
  ami_id                = data.aws_ami.amazon_linux.id
  instance_profile_name = aws_iam_instance_profile.hub.name
}
