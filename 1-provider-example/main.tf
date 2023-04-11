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
  region  = "us-west-2"
}

provider "aws" {
  region = "us-west-2"
  alias  = "target"
  assume_role {
    role_arn     = var.target_assume # Update var target_assume
    session_name = "automation"
  }
}

resource "aws_instance" "app_server" {
  providers = { aws = aws.target } # we are calling alias name
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

