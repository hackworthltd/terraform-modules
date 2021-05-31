#### A secure VPC.
#
# When a VPC is created, AWS also creates a default security group and
# network ACL. This module clears out those resources so that they
# will permit no traffic by default. This is per the following
# sources:
#
# https://d0.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf
#   (Note: Networking section only.)
#
# This module also imports the default route into the Terraform
# managed state. Upon first import, Terraform removes any existing
# routes from this table (except for the local routes, which cannot be
# removed), so that new routes can be established by other Terraform
# modules. (Do not try to define a new main table for this VPC, or
# else it will conflict with the imported default route table.0

provider "aws" {}


### The VPC.

resource "aws_vpc" "this" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name        = var.name
    Description = var.description
  }
}


### Secure the defaults.

## Default route table.
#
# Addresses AWS CIS: 4.4.

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = {
    Description = "Main route table for the ${var.name} VPC."
  }
}

## Default security group.
#
# Addresses AWS CIS: 4.1, 4.2, 4.3.

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id

  tags = {
    Description = "Default security group for the ${var.name} VPC. DO NOT USE."
  }
}

## Default network ACL.
#
# Addresses AWS CIS: 4.1, 4.2, 4.3.

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  lifecycle {
    ignore_changes = [subnet_ids]
  }

  tags = {
    Description = "Default network ACL for the ${var.name} VPC. DO NOT USE."
  }
}
