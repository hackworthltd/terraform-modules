variable "instance_tenancy" {
  description = "The EC2 instance tenancy for this VPC."
  type        = string
  default     = "default"
}

variable "name" {
  description = "A short name for the VPC."
  type        = string
}

variable "description" {
  description = "A short description of the VPC."
  type        = string
}

variable "cidr_block" {
  description = "The IPv4 RFC 1918 CIDR block assigned to the VPC."
  type        = string
}
