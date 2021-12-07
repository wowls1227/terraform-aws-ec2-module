provider "aws" {
  region=var.region
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "my-aws-practice"
    workspaces = {
      name = "terraform-vcp-my-module"
    }
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.name

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
#  monitoring             = true
#  vpc_security_group_ids = [var.vpc_security_group_ids]
   subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnets[0]
}
