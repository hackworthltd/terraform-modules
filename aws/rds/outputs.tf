output subnet_group {
  description = "A list of subnets that comprise the RDS instance's DB subnet group."
  value = module.subnet
}

output sg {
  description = "The security group of the RDS instance."
  value = aws_security_group.this
}
