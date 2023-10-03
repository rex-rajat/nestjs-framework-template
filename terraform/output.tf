# Output the VPC ID, public subnet ID, and private subnet ID
output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}