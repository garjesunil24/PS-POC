# VPC
resource "aws_vpc" "ps_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ps-vpc"
  }
}

# Subnet 1
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.ps_vpc.id
  cidr_block        = var.cidr_public_subnet
  availability_zone = var.aws_availability_zone_1a
  tags = {
    Name = "Public Subnet"
  }
}

# Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_public_subnet_2
  availability_zone = var.aws_availability_zone_1b
  tags = {
    Name = "Public subnet-2"
  }
}
  # Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ps_vpc.id
  tags = {
    Name = "main-igw"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ps_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with Public Subnet 
resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Route Table with Subnet 2
resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

##private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.ps_vpc.id
  cidr_block              = var.cidr_private_subnet
  availability_zone       = var.aws_availability_zone_1c
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-1"
  }
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.ps_vpc.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private1_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}



