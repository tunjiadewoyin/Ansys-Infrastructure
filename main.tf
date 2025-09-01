terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr                = var.vpc_cidr
  availability_zones      = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  environment            = var.environment
  project_name           = var.project_name
}

module "security_groups" {
  source = "./modules/security-groups"
  
  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
  project_name = var.project_name
}

module "ec2" {
  source = "./modules/ec2"
  
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_groups.web_security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  environment       = var.environment
  project_name      = var.project_name
}