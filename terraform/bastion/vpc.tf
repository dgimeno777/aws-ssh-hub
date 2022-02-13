data "aws_vpc" "vpc" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.vpc_id
}

data "aws_route_table" "public" {
  route_table_id = data.terraform_remote_state.terraform-aws-vpc.outputs.route_table_public_id
}

data "aws_route_table" "private" {
  route_table_id = data.terraform_remote_state.terraform-aws-vpc.outputs.route_table_private_id
}

data "aws_subnet" "public" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_public_a_id
}

data "aws_subnet" "private" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_private_a_id
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "hub" {
  subnet_id     = data.aws_subnet.public.id
  allocation_id = aws_eip.nat_gateway.id
  tags = {
    Name : "ssh-hub-${local.resource_name_suffix}"
  }
}

resource "aws_route" "nat_gateway" {
  route_table_id         = data.aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.hub.id
}
