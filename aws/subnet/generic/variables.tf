variable "name" {
  description = "A short name for the subnet. It will be assigned to the subnet's Name tag."
  type        = string
}

variable "description" {
  description = "A short string describing the subnet's purpose. It will be assigned to the subnet's Description tag."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the subnet."
  type        = string
}

variable "az" {
  description = "The name of the Availability Zone in which to create the subnet. Must belong to the implicit AWS Region to which the VPC belongs."
  type        = string
}

variable "cidr_block" {
  description = "The IPv4 RFC 1918 CIDR block that will be assigned to the subnet. Must be a subset of the VPC's IPv4 RFC 1918 CIDR block."
  type        = string
}

variable "ipv6_cidr_block" {
  description = "The IPv6 CIDR block that will be assigned to the subnet. Must be a /64 and must be a subset of the VPC's /56 IPv6 CIDR block."
  type        = string
}

variable "auto_public_ip" {
  description = "If true, an ephemeral public IPv4 address will be assigned to EC2 instances that are launched in this subnet."
  default     = false
}
