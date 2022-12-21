provider "aws" {
  region = "us-east-1"
}

variable vpc_cidr_block {}
variable  subnet_cidr_block {}
variable avali_zone {}
variable "env_prefix" {}

#create vpc = my-app-vpc
resource "aws_vpc" "my-app-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
      Name:"${var.env_prefix}-vpc"
  }
}
#create subnet myapp-subnet-1

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id     = aws_vpc.my-app-vpc.id
  cidr_block = var.vpc_cidr_block
  availability_zone = var.avali_zone
  tags = {
     Name = "${var.env_prefix}-subnet-1"
  }
}

# create route_route_table = my-app-route-table
resource "aws_route_table" "my-app-route-table" {
  vpc_id = aws_vpc.my-app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
     Name: "${var.env_prefix}-rtb"
  } 
}
#create internet_gateway = myapp-igw
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.my-app-vpc.id
  tags = {
    "Name" = "${var.env_prefix}-igw"
  }
  
}
#create aws_route_table_association = a-rtb-subnet-1
resource "aws_route_table_association" "a-rtb-subnet-1" {
  subnet_id      = aws_subnet.myapp-subnet-1.id
  route_table_id = aws_route_table.my-app-route-table.id
}
