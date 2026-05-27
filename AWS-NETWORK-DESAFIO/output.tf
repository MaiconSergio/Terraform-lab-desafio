output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "sg_id" {
  description = "ID of the security group"
  value       = aws_security_group.sg.id
}

output "subnet_id" {
  description = "IDs of the subnets"
  value       = aws_subnet.subnet.id
}
output "subnet_id2" {
  description = "IDs of the subnets"
  value       = aws_subnet.subnet2.id
}