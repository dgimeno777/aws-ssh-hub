resource "aws_lb" "hub" {
  name               = "ssh-hub-${local.resource_name_suffix}"
  internal           = false
  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  subnets = [
    data.aws_subnet.public.id
  ]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "hub_ssh" {
  load_balancer_arn = aws_lb.hub.arn
  port              = 22
  protocol          = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.instance.arn
  }
}

/*
resource "aws_lb_listener_rule" "hub" {
  listener_arn = aws_lb_listener.hub_ssh.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance.arn
  }
  condition {
    source_ip {
      values = [
        "${local.my_public_ip}/32"
      ]
    }
  }
}
*/
resource "aws_lb_target_group" "instance" {
  name                   = "instance-${local.resource_name_suffix}"
  vpc_id                 = data.aws_vpc.vpc.id
  port                   = 22
  protocol               = "TCP"
  target_type            = "instance"
}

resource "aws_lb_target_group_attachment" "instance" {
  target_group_arn = aws_lb_target_group.instance.arn
  target_id        = aws_instance.instance.id
  port             = 22
}