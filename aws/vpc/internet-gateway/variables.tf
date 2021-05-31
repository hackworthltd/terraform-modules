variable "vpc_id" {
  description = "The VPC ID in which to create the Internet gateway."
  type = string
}

variable "description" {
  description = "A short description that will saved in the gateway's 'Description' tag."
  type = string
}
