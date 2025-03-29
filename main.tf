terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lightsail_instance
resource "aws_lightsail_instance" "server" {
  count             = var.instance_count
  name              = "my-server-${count.index + 1}"
  availability_zone = var.availability_zone
  blueprint_id      = "ubuntu_22_04"
  key_pair_name     = "id_rsa"
  bundle_id         = "micro_3_0"
  tags = {
    environment = "development"
  }
  user_data = <<-EOF
#!/bin/bash
apt-add-repository ppa:ansible/ansible
apt update
apt install ansible -y
EOF
}
