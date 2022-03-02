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

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keystore" {
  key_name   = var.app_name
  public_key = tls_private_key.private_key.public_key_openssh

#  provisioner "local-exec" {          # Create "myKey.pem" to your computer!!
#    command = "echo tls_private_key.private_key.private_key_pem > ./myKey.pem"
#  }
}

resource "local_file" "pem_file" {
  filename = pathexpand("~/.ssh/${var.app_name}.pem")
  file_permission = "400"
  directory_permission = "700"
  sensitive_content = tls_private_key.private_key.private_key_pem
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

  ingress {
    description = "HTTP access from any where"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_instance" "myapp_instance" {
  ami                    = var.aws_image_id
  instance_type          = "t2.micro"
  subnet_id              = module.vpcModule.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ssh_connection.id]
  key_name               = aws_key_pair.keystore.key_name
  tags = {
    Name = var.app_name
  }

  provisioner "file" {
    source      = "html_file/index.html"
    destination = "/tmp/index.html"

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("~/.ssh/${var.app_name}.pem")
      host     = aws_instance.myapp_instance.public_ip
    }
  }
 
  provisioner "remote-exec" {
  
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("~/.ssh/${var.app_name}.pem")
      host     = aws_instance.myapp_instance.public_ip
    }
    inline = [
      "sudo yum install httpd -y",
      "sudo cp /tmp/index.html /var/www/html/",
      "sudo service httpd start",
    ]
  }

}