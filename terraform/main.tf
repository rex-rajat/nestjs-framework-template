provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

terraform {
  required_version = ">= 0.12"  # Specify the minimum required version here
}


# Create a VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  #map_public_ip_on_launch = true  # Enable auto-assigning public IPs to instances
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

# Create an internet gateway to enable communication with the internet
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.dev_vpc.id
}

# Attach the internet gateway to the VPC
#resource "aws_vpc_attachment" "dev_vpc_attachment" {
#  vpc_id             = aws_vpc.dev_vpc.id
#  internet_gateway_id = aws_internet_gateway.my_igw.id
#}

# Create a route table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
}

# Create a default route to the internet via the internet gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a route table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
}

# Associate the private subnet with the private route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Example: Security groups and other resources can be added here


