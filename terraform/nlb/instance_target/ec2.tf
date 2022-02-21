data "aws_ec2_instance_type" "t2_micro" {
  instance_type = "t2.micro"
}

resource "aws_instance" "instance" {
  ami                         = var.ami_id
  subnet_id                   = var.ec2_subnet_id
  instance_type               = data.aws_ec2_instance_type.t2_micro.instance_type
  key_name                    = var.ec2_key_name
  associate_public_ip_address = false
  iam_instance_profile        = var.instance_profile_name
  vpc_security_group_ids = [
    var.security_group_id
  ]
  tags = {
    Name : "instance-${var.listener_port}-${local.resource_name_suffix}"
  }
}
