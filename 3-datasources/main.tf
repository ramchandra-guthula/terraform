terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

data "aws_ami" "ami_id" {
  owners      = ["amazon", "self"]
  most_recent = true
  
  filter {
       name   = "name"
       values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-ebs"]  
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  tags = {
    values = "amzn2-ami-kernel-5.10-hvm-*"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

 resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ami_id.id
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.image_tags
  } 
} 

