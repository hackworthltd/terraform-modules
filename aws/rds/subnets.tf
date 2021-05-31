### Subnets.

module "subnet" {
  count  = length(local.az-names)
  source = "../subnet/generic"

  name        = "rds-${var.name}-${local.az-names[count.index]}"
  description = "RDS subnet for ${var.name} in ${local.az-names[count.index]}"
  vpc_id      = var.vpc_id
  az          = local.az-names[count.index]

  cidr_block      = var.cidr_blocks[count.index]
  ipv6_cidr_block = var.ipv6_cidr_blocks[count.index]

  providers = {
    aws = aws
  }
}


### ACLs.

resource "aws_network_acl_rule" "ipv4_rds" {
  count          = length(module.subnet)
  network_acl_id = module.subnet[count.index].network-acl.id
  rule_number    = var.acl_base_rule_number
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.allow_cidr_block
  from_port      = var.rds_port
  to_port        = var.rds_port
}

resource "aws_network_acl_rule" "ipv6_rds" {
  count           = length(module.subnet)
  network_acl_id  = module.subnet[count.index].network-acl.id
  rule_number     = var.acl_base_rule_number + 1
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  ipv6_cidr_block = var.allow_ipv6_cidr_block
  from_port       = var.rds_port
  to_port         = var.rds_port
}

resource "aws_network_acl_rule" "ipv4_egress" {
  count          = length(module.subnet)
  network_acl_id = module.subnet[count.index].network-acl.id
  rule_number    = var.acl_base_rule_number + 2
  egress         = true
  protocol       = "all"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "ipv6_egress" {
  count          = length(module.subnet)
  network_acl_id = module.subnet[count.index].network-acl.id
  rule_number    = var.acl_base_rule_number + 3
  egress          = true
  protocol        = "all"
  rule_action     = "allow"
  ipv6_cidr_block = "::/0"
  from_port       = 0
  to_port         = 0
}
