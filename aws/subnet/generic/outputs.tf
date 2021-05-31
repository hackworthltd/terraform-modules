output "subnet" {
  description = "The instantiated subnet."
  value       = aws_subnet.this
}

output "route-table" {
  description = "The subnet's custom route table."
  value       = aws_route_table.this
}

output "network-acl" {
  description = "The subnet's custom network ACL."
  value       = aws_network_acl.this
}
