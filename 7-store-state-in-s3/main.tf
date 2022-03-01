terraform {
  backend "s3" {
    bucket         = "terraform-state-dev-sample"
    key            = "appstack/dev-env-state"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
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

resource "aws_instance" "app_server" {
  ami           =  var.aws_image_id != "" ? var.aws_image_id : "ami-0c6615d1e95c98aca"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_tags[2]
    second_tag = var.other_tags.type
#    third_tag = var.other_tags.env

  }
}
