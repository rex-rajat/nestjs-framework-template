resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  //enable_dns_support = true
  //enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zone = ["us-east-1a", "us-east-1b"]
//  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zone = ["us-east-1a", "us-east-1b"]

  tags = {
    Name = "private-subnet"
  }
}