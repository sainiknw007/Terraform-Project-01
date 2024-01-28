    # Create VPC
resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

    # Create subnet in the vpc
resource "aws_subnet" "myapp-subnet-1" {
    vpc_id = aws_vpc.myapp-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.avail_zone 
    tags = {
        Name = "${var.env_prefix}-subnet-1"
    } 
}

    # Create Internet gateway
resource "aws_internet_gateway" "myapp-igw" {
    vpc_id = aws_vpc.myapp-vpc.id
    tags = {
        Name = "${var.env_prefix}-igw"
    }
}

    # Create default route table for vpc
resource "aws_default_route_table" "main-rtb" {
    default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id   
        }
    tags = {
      Name = "${var.env_prefix}-main-rtable"
    }
}

    # Create Security group
resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.myapp-vpc.id
  
  # Inbound rules for the security group
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Outbound rules for security group
  egress {
    from_port = 0
    to_port = 0
    protocol =-1
    cidr_blocks = ["0.0.0./0"]
  }

   #security group name
  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}