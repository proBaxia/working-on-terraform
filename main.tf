provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "headoffice" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "head-branch"
  }
}


resource "aws_subnet" "branch-1" {
  vpc_id     = aws_vpc.headoffice.id
  cidr_block = "10.0.1.0/24"



  tags = {
    Name = "public"
  }
}


data "aws_vpc" "headoffice" {
  id = aws_vpc.headoffice.id
}

resource "aws_subnet" "main2" {
  vpc_id     = data.aws_vpc.headoffice.id
  cidr_block = "10.0.2.0/24"


  tags = {
    Name = "private"
  }

}


