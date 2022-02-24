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

data "aws_ami" "web" {
  owners      = ["amazon", "self"]
  most_recent = true

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  tags = {
    values = "amzn2-ami-*-x86_64-gp2"
  }
}

resource "aws_instance" "app_server" {
  ami           = var.aws_image_id
  instance_type = "t2.micro"

  tags = {
    Name = var.image_tags
  }
}
