provider "aws" {
  region=var.region
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.name

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
#  monitoring             = true
  vpc_security_group_ids = [var.security_group_id]
   subnet_id              = var.subnet_id

  tags = {
    Terraform   = var.tag_terraform
    Environment = var.tag_env
  }
}
