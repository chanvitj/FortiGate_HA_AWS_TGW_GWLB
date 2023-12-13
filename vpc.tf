resource "aws_vpc" "security_vpc" {
  cidr_block           = local.security_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = local.security_vpc_name
  }
}

resource "aws_vpc" "prod_vpc" {
  cidr_block           = local.prod_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = local.prod_vpc_name
  }
}

resource "aws_vpc" "dev_vpc" {
  cidr_block           = local.dev_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = local.dev_vpc_name
  }
}

resource "aws_vpc" "shared_vpc" {
  cidr_block           = local.shared_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = local.shared_vpc_name
  }
}

resource "aws_vpc" "mgmt_vpc" {
  cidr_block           = local.mgmt_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = local.mgmt_vpc_name
  }
}

