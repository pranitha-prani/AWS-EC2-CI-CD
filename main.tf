terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source to get default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get public subnets in default VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Data source to get available free-tier eligible instance types
data "aws_ec2_instance_types" "free_tier" {
  filter {
    name   = "free-tier-eligible"
    values = ["true"]
  }

  filter {
    name   = "current-generation"
    values = ["true"]
  }
}

# Local value to select first available free-tier instance type
locals {
  instance_type = length(data.aws_ec2_instance_types.free_tier.instance_types) > 0 ? data.aws_ec2_instance_types.free_tier.instance_types[0] : var.instance_type
}

# Security Group - Allow all TCP ports from anywhere
resource "aws_security_group" "allow_all_tcp" {
  name        = "allow-all-tcp-from-internet"
  description = "Allow all TCP inbound traffic from internet"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "All TCP from anywhere"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all-tcp-sg"
  }
}

# EC2 Instance - server-1
resource "aws_instance" "server_1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = local.instance_type
  subnet_id              = data.aws_subnets.public.ids[0]
  vpc_security_group_ids = [aws_security_group.allow_all_tcp.id]

  tags = {
    Name = "server-1"
  }
}

# EC2 Instance - server-2
resource "aws_instance" "server_2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = local.instance_type
  subnet_id              = data.aws_subnets.public.ids[0]
  vpc_security_group_ids = [aws_security_group.allow_all_tcp.id]

  tags = {
    Name = "server-2"
  }
}

# EC2 Instance - server-3
resource "aws_instance" "server_3" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = local.instance_type
  subnet_id              = data.aws_subnets.public.ids[0]
  vpc_security_group_ids = [aws_security_group.allow_all_tcp.id]

  tags = {
    Name = "server-3"
  }
}
