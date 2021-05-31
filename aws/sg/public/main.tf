#### Security group rules for default public Internet.
#
# Ingress:
# - Ping, path MTU, TTL expired.
#
# Egress:
# - All traffic.
#
# XXX dhess TODO - IPv6 ICMP rules.

resource "aws_security_group_rule" "ipv4-path-mtu" {
  security_group_id = var.sg_id
  type              = "ingress"
  from_port         = 3                                       # ICMP type
  to_port           = 4                                       # ICMP code
  protocol          = "icmp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ipv4-ping" {
  security_group_id = var.sg_id
  type              = "ingress"
  from_port         = 8                                       # ICMP type
  to_port           = 0                                       # ICMP code
  protocol          = "icmp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ipv4-ttl-expired" {
  security_group_id = var.sg_id
  type              = "ingress"
  from_port         = 11                                      # ICMP type
  to_port           = 0                                       # ICMP code
  protocol          = "icmp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ipv6-icmp" {
  security_group_id = var.sg_id
  type              = "ingress"
  from_port         = -1                                      # ICMP type
  to_port           = -1                                      # ICMP code
  protocol          = "icmpv6"

  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = var.sg_id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
