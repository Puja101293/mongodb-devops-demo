terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "${var.name}-vpc" }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = { Name = "${var.name}-subnet" }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.name}-igw" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.name}-rt" }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "ssh_mongo" {
  name        = "${var.name}-sg"
  description = "Allow SSH and MongoDB"
  vpc_id      = aws_vpc.this.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }
  ingress {
    description = "MongoDB"
    from_port   = var.mongo_port
    to_port     = var.mongo_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_mongo_cidr]
  }
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "${var.name}-sg" }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "mongodb" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.this.id
  vpc_security_group_ids = [aws_security_group.ssh_mongo.id]
  key_name               = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  user_data              = file("${path.module}/userdata.sh")
  tags = { Name = "${var.name}-mongodb" }
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance running MongoDB"
  value       = aws_instance.mongodb.public_ip
}

output "instance_id" {
  value = aws_instance.mongodb.id
}
