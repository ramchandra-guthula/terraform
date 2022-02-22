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

module "vpcModule" {
  source = "./modules/vpc-module/"
}

variable "aws_image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default     = "ami-0c6615d1e95c98aca"
}

variable "app_name" {
  type        = string
  description = "App name to the project"
  default     = "myApp"
}

resource "aws_security_group" "ssh_connection" {
  name        = "${var.app_name}-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpcModule.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #[aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "testInstance" {
  ami                    = var.aws_image_id
  instance_type          = "t2.micro"
  subnet_id              = module.vpcModule.public_subnet_id
  vpc_security_group_ids = aws_security_group.ssh_connection.id
  key_name               = "mumbai"

tags = {
    Name = var.app_name
  }
  
}
