data "aws_lb" "nlb" {
  arn = var.nlb_arn
}

resource "aws_lb_listener" "hub_ssh" {
  load_balancer_arn = var.nlb_arn
  port              = var.listener_port
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance.arn
  }
}

resource "aws_lb_target_group" "instance" {
  name        = "instance-${var.listener_port}-${local.resource_name_suffix}"
  vpc_id      = data.aws_lb.nlb.vpc_id
  port        = 22
  protocol    = "TCP"
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "instance" {
  target_group_arn = aws_lb_target_group.instance.arn
  target_id        = aws_instance.instance.id
  port             = 22
}
