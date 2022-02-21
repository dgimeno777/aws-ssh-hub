output "ssh_command" {
  value = "ssh ec2-user@${data.aws_lb.nlb.dns_name} -p ${var.listener_port}"
}
