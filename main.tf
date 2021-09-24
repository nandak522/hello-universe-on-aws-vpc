provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.app_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = [var.public_subnet_cidr]

  tags = {
    Name   = var.app_name
    Terraform   = "true"
  }
}

module "hello_universe_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.app_name
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = var.app_port
      to_port     = var.app_port
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = -1
      to_port     = -1
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name   = var.app_name
    Terraform   = "true"
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.app_name
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type
  key_name               = var.app_name
  monitoring             = false
  vpc_security_group_ids = [module.hello_universe_security_group.security_group_id]
  subnet_id              = module.vpc.public_subnets.0
  associate_public_ip_address = true
  user_data = base64encode(file("user_data.sh"))

  tags = {
    Terraform   = "true"
    Name   = var.app_name
  }
}
