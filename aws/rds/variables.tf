variable "name" {
  description = "A short name for the RDS instance."
  type        = string
}

variable "description" {
  description = "A short string describing the RDS instance."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the RDS instance."
  type        = string
}

variable "az" {
  description = "The name of the Availability Zone in which to create the RDS instance. Must belong to the implicit AWS Region to which the VPC belongs."
  type        = string
}

variable "rds_port" {
  description = "The TCP port on which clients will communicate with the RDS instance."
}

variable "cidr_blocks" {
  description = "The IPv4 RFC 1918 CIDR blocks that will be assigned to the subnets created for the RDS instance. Each must be a subset of the VPC's IPv4 RFC 1918 CIDR block, and there should be at least as many of these as there are regions in the given Availability Zone."
  type        = list(string)
}

variable "ipv6_cidr_blocks" {
  description = "The IPv6 CIDR blocks that will be assigned to the subnets created for the RDS instance. Each must be a /64 and must be a subset of the VPC's /56 IPv6 CIDR block. There should be at least as many of these as there are regions in the given Availability Zone."
  type        = list(string)
}

variable "allow_cidr_block" {
  description = "IPv4 addresses within this IPv4 RFC 1918 CIDR block will be allowed to communicate with the RDS instance on the given port."
  type        = string
}

variable "allow_ipv6_cidr_block" {
  description = "IPv6 addresses within this IPv6 CIDR block will be allowed to communicate with the RDS instance on the given port."
  type        = string
}

variable "acl_base_rule_number" {
  description = "The starting rule number from which ACLs will be created for each RDS subnet. This module will create 4 ACLs for each RDS subnet."
}

variable "sg_ids" {
  description = "A list of security groups that will be granted access to the RDS instance over the RDS TCP port."
  type = list(string)
}
