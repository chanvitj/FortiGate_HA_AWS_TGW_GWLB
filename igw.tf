resource "aws_internet_gateway" "security_igw" {
  vpc_id = aws_vpc.security_vpc.id
  tags = {
    Name = local.security_igw_name
  }
}

resource "aws_internet_gateway" "mgmt_igw" {
  vpc_id = aws_vpc.mgmt_vpc.id
  tags = {
    Name = local.mgmt_igw_name
  }
}
