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
    aws_vpc.politicia_vpc
  ]

  tags = {
    Name = "politicia-${var.environment}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.politicia_vpc.id

  depends_on = [
    aws_vpc.politicia_vpc,
    aws_internet_gateway.politicia_internet_gw
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.politicia_internet_gw.id
  }

  tags = {
    Name = "route-table"
    Environment = var.environment
  }
}

resource "aws_route" "IG_route" {

  depends_on = [
    aws_route_table.public_route_table
  ]

  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.politicia_internet_gw.id
}

resource "aws_subnet" "public_subnet" {
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

# resource "aws_subnet" "private_subnet" {
#   vpc_id = aws_vpc.politicia_vpc.id
#   count = length(var.private_subnets_cidr)
#   cidr_block = element(var.private_subnets_cidr, count.index)
#   availability_zone = element(var.availability_zones, count.index)
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "politicia-${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
#     Environment = var.environment
#   }
# }

resource "aws_route_table_association" "public_subnet_association" {

  depends_on = [
    aws_subnet.public_subnet,
    aws_route_table.public_route_table
  ]
  count = length(var.public_subnets_cidr)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "associate_routetable_to_public_subnet" {

  depends_on = [
    aws_subnet.public_subnet,
    aws_route_table.public_route_table
  ]

  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}


# resource "aws_route_table_association" "private_subnet_association" {
#   subnet_id = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.route_table.id
# }

resource "aws_security_group" "politicia_default_sg" {
  name        = "${var.environment}-default-sg"
  description = "Default SG to alllow traffic to/from the VPC"
  vpc_id      = aws_vpc.politicia_vpc.id
  depends_on = [
    aws_vpc.politicia_vpc
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