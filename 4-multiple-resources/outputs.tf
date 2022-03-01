output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.myapp-vpc.id
}

output "public_subnet_id" {
  description = "Public subnet id"
  value       = aws_subnet.myapp-public-subnet.id
}

output "private_subnet_id" {
  description = "Public subnet id"
  value       = aws_subnet.myapp-private-subnet.id
}
