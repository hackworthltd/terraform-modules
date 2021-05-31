resource "aws_security_group" "this" {
  vpc_id                 = var.vpc_id
  name                   = var.name
  description            = "RDS security group for ${var.name}."
  revoke_rules_on_delete = true
}

resource "aws_security_group_rule" "this" {
  count                    = length(var.sg_ids)

  security_group_id        = aws_security_group.this
  type                     = "ingress"
  from_port                = var.rds_port
  to_port                  = var.rds_port
  protocol                 = "tcp"
  source_security_group_id = var.sg_ids[count.index]
}


# Allow RDS port on self.

resource "aws_security_group_rule" "this" {
  security_group_id = aws_security_group.this
  type              = "ingress"
  from_port         = var.rds_port
  to_port           = var.rds_port
  protocol          = "tcp"
  self              = true
}


# All egress.

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.this
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
