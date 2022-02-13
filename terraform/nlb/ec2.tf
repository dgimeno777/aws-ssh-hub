data "aws_ec2_instance_type" "t2_micro" {
  instance_type = "t2.micro"
}

data "aws_network_interface" "hub" {
  filter {
    name   = "description"
    values = ["ELB ${aws_lb.hub.arn_suffix}"]
  }

  filter {
    name = "subnet-id"
    values = [
      data.aws_subnet.public.id
    ]
  }
}

resource "aws_security_group" "instance" {
  vpc_id = data.aws_vpc.vpc.id
  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = [
      "${local.my_public_ip}/32"
    ]
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_instance" "instance" {
  ami                         = data.aws_ami.amazon_linux.id
  subnet_id                   = data.aws_subnet.private.id
  instance_type               = data.aws_ec2_instance_type.t2_micro.instance_type
  key_name                    = data.aws_key_pair.key.key_name
  associate_public_ip_address = false
  vpc_security_group_ids = [
    aws_security_group.instance.id
  ]
  tags = {
    Name : "instance-${local.resource_name_suffix}"
  }
}
