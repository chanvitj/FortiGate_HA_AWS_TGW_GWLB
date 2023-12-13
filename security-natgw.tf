resource "aws_nat_gateway" "security_natgw" {
  allocation_id = aws_eip.security_eip_natgw.id
  subnet_id     = aws_subnet.security_egress1_subnet.id

  tags = {
    Name = local.security_natgw_name
  }
}