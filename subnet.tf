resource "aws_subnet" "security_public1_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_public1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.security_public1_name
  }
}

resource "aws_subnet" "security_private1_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_private1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.security_private1_name
  }
}

resource "aws_subnet" "security_ingress1_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_ingress1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.security_ingress1_name
  }
}

resource "aws_subnet" "security_egress1_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_egress1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.security_egress1_name
  }
}

resource "aws_subnet" "security_tgw1_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_tgw1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.security_tgw1_name
  }
}

resource "aws_subnet" "security_gwlb1_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_gwlb1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.security_gwlb1_name
  }
}

//
resource "aws_subnet" "security_public2_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_public2_cidr
  availability_zone = local.az2
  tags = {
    Name = local.security_public2_name
  }
}

resource "aws_subnet" "security_private2_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_private2_cidr
  availability_zone = local.az2
  tags = {
    Name = local.security_private2_name
  }
}

resource "aws_subnet" "security_ingress2_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_ingress2_cidr
  availability_zone = local.az2
  tags = {
    Name = local.security_ingress2_name
  }
}

resource "aws_subnet" "security_egress2_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_egress2_cidr
  availability_zone = local.az2
  tags = {
    Name = local.security_egress2_name
  }
}

resource "aws_subnet" "security_tgw2_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_tgw2_cidr
  availability_zone = local.az2
  tags = {
    Name = local.security_tgw2_name
  }
}

resource "aws_subnet" "security_gwlb2_subnet" {
  vpc_id            = aws_vpc.security_vpc.id
  cidr_block        = local.security_gwlb2_cidr
  availability_zone = local.az2
  tags = {
    Name = local.security_gwlb2_name
  }
}

// Prod - subnet
resource "aws_subnet" "prod_tgw1_subnet" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = local.prod_tgw1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.prod_tgw1_name
  }
}

resource "aws_subnet" "prod_gwlb1_subnet" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = local.prod_gwlb1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.prod_gwlb1_name
  }
}

resource "aws_subnet" "prod_web1_subnet" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = local.prod_web1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.prod_web1_name
  }
}

resource "aws_subnet" "prod_app1_subnet" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = local.prod_app1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.prod_app1_name
  }
}

resource "aws_subnet" "dev_tgw1_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = local.dev_tgw1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.dev_tgw1_name
  }
}

resource "aws_subnet" "dev_gwlb1_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = local.dev_gwlb1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.dev_gwlb1_name
  }
}

resource "aws_subnet" "dev_web1_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = local.dev_web1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.dev_web1_name
  }
}

resource "aws_subnet" "dev_app1_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = local.dev_app1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.dev_app1_name
  }
}

resource "aws_subnet" "shared_tgw1_subnet" {
  vpc_id            = aws_vpc.shared_vpc.id
  cidr_block        = local.shared_tgw1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.shared_tgw1_name
  }
}

resource "aws_subnet" "shared_gwlb1_subnet" {
  vpc_id            = aws_vpc.shared_vpc.id
  cidr_block        = local.shared_gwlb1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.shared_gwlb1_name
  }
}

resource "aws_subnet" "shared_web1_subnet" {
  vpc_id            = aws_vpc.shared_vpc.id
  cidr_block        = local.shared_web1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.shared_web1_name
  }
}

resource "aws_subnet" "shared_app1_subnet" {
  vpc_id            = aws_vpc.shared_vpc.id
  cidr_block        = local.shared_app1_cidr
  availability_zone = local.az1
  tags = {
    Name = local.shared_app1_name
  }
}

resource "aws_subnet" "mgmt_public_subnet" {
  vpc_id            = aws_vpc.mgmt_vpc.id
  cidr_block        = local.mgmt_public_cidr
  availability_zone = local.az1
  tags = {
    Name = local.mgmt_public_name
  }
}

resource "aws_subnet" "mgmt_private_subnet" {
  vpc_id            = aws_vpc.mgmt_vpc.id
  cidr_block        = local.mgmt_private_cidr
  availability_zone = local.az1
  tags = {
    Name = local.mgmt_private_name
  }
}

resource "aws_subnet" "mgmt_jump_subnet" {
  vpc_id            = aws_vpc.mgmt_vpc.id
  cidr_block        = local.mgmt_jump_cidr
  availability_zone = local.az1
  tags = {
    Name = local.mgmt_jump_name
  }
}

resource "aws_subnet" "mgmt_tgw_subnet" {
  vpc_id            = aws_vpc.mgmt_vpc.id
  cidr_block        = local.mgmt_tgw_cidr
  availability_zone = local.az1
  tags = {
    Name = local.mgmt_tgw_name
  }
}