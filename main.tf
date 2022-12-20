provider "aws" {
  region = "us-east-1"
}

variable vpc_cidr_block {}
variable  subnet_cidr_block {}
variable avali_zone {}
variable "env_prefix" {}


resource "aws_vpc" "my-app-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
      Name:"${var.env_prefix}-vpc"
  }
}


resource "aws_subnet" "myapp-subnet-1" {
  vpc_id     = aws_vpc.my-app-vpc.id
  cidr_block = var.vpc_cidr_block
  availability_zone = var.avali_zone
  tags = {
     Name = "${var.env_prefix}-subnet-1"
  }
}
 