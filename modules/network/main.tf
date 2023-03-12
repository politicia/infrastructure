resource "aws_vpc" "politicia_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "policitia-${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "politicia_internet_gw" {
  vpc_id = aws_vpc.politicia_vpc.id

  depends_on = [
    aws_vpc.policitia_vpc
  ]

  tags = {
    Name = "politicia-${var.environment}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.politicia_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route-table"
    Environment = var.environment
  }
}

resource "aws_subnet" "politicia_public_subnet" {
  vpc_id = aws_vpc.politicia_vpc.id
  count = length(var.public_subnets_cidr)
  cidr_block = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "politicia-${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
    Environment = var.environment
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.politicia_vpc.id
  count = length(var.private_subnets_cidr)
  cidr_block = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "politicia-${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "subnet_1_association" {
  subnet_id = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_2_association" {
  subnet_id = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "politicia_default_sg" {
  name        = "${var.environment}-default-sg"
  description = "Default SG to alllow traffic to/from the VPC"
  vpc_id      = aws_vpc.policitia_vpc.id
  depends_on = [
    aws_vpc.policitia_vpc
  ]

  ingress {
    description = "all incoming traffic"
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    description = "all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "politicia-${var.environment}-default-sg"
    Environment = var.environment
  }
}