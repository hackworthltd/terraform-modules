#### Create a VPC subnet.
#
# Additionally, a custom route table and network ACL are created for
# (and associated with) the subnet.

provider "aws" {}


### The subnet.

resource "aws_subnet" "this" {
  vpc_id                          = var.vpc_id
  availability_zone               = var.az
  cidr_block                      = var.cidr_block
  ipv6_cidr_block                 = var.ipv6_cidr_block
  map_public_ip_on_launch         = var.auto_public_ip
  assign_ipv6_address_on_creation = true

  tags = {
    Name        = var.name
    Description = var.description
  }
}


## A custom route table for the subnet.
#
# The route table has no inline routes defined, so routes must be
# created separately and then associated with the route table.
#
# By default, the route table contains only routes to other hosts in
# the same VPC (note: not just hosts in this subnet).

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = {
    Description = "The custom route table for the ${var.name} subnet."
  }
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}


## A custom network ACL for the subnet.
#
# The ACL has no inline rules defined, so rules must be created
# separately and then associated with the ACL.
#
# By default, the ACL blocks all traffic to and from this subnet;
# i.e., unless you add additional rules, hosts in this subnet will
# only be permitted to communicate with each other.

resource "aws_network_acl" "this" {
  vpc_id     = var.vpc_id
  subnet_ids = [aws_subnet.this.id]

  tags = {
    Description = "The network ACL for the ${var.name} subnet."
  }
}
