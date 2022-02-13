output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "instance_private_ip" {
  value = aws_instance.instance.private_ip
}
