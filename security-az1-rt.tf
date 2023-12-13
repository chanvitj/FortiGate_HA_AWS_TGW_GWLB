// AZ1
// Security - Public RT
resource "aws_route_table" "security_public1_rt" {
  vpc_id = aws_vpc.security_vpc.id

  tags = {
    Name = local.security_public1_rt_name
  }
}

resource "aws_route" "security_public1_rt_default" {
  route_table_id         = aws_route_table.security_public1_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.security_igw.id
}

resource "aws_route_table_association" "security_public1_rt_asso" {
  subnet_id      = aws_subnet.security_public1_subnet.id
  route_table_id = aws_route_table.security_public1_rt.id
}

// Security - Private RT
resource "aws_route_table" "security_private1_rt" {
  vpc_id = aws_vpc.security_vpc.id

  tags = {
    Name = local.security_private1_rt_name
  }
}

resource "aws_route_table_association" "security_private1_rt_asso" {
  subnet_id      = aws_subnet.security_private1_subnet.id
  route_table_id = aws_route_table.security_private1_rt.id
}

// Security - TGW1 RT
resource "aws_route_table" "security_tgw1_rt" {
  vpc_id = aws_vpc.security_vpc.id

  tags = {
    Name = local.security_tgw1_rt_name
  }
}

resource "aws_route" "security_tgw1_rt_default" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_tgw1_rt.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route" "security_tgw1_rt_east_west1" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_tgw1_rt.id
  destination_cidr_block = local.security_tgw1_rt_east_west1_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route" "security_tgw1_rt_east_west2" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_tgw1_rt.id
  destination_cidr_block = local.security_tgw1_rt_east_west2_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route_table_association" "security_tgw1_rt_asso" {
  subnet_id      = aws_subnet.security_tgw1_subnet.id
  route_table_id = aws_route_table.security_tgw1_rt.id
}

// Security - GWLB1 RT
resource "aws_route_table" "security_gwlb1_rt" {
  vpc_id = aws_vpc.security_vpc.id
  depends_on = [ aws_nat_gateway.security_natgw ]

  tags = {
    Name = local.security_gwlb1_rt_name
  }
}

resource "aws_route" "security_gwlb1_rt_default" {
  route_table_id         = aws_route_table.security_gwlb1_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.security_natgw.id
}

resource "aws_route" "security_gwlb1_rt_east_west1" {
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach]
  route_table_id         = aws_route_table.security_gwlb1_rt.id
  destination_cidr_block = local.security_gwlb1_rt_east_west1_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "security_gwlb1_rt_east_west2" {
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach]
  route_table_id         = aws_route_table.security_gwlb1_rt.id
  destination_cidr_block = local.security_gwlb1_rt_east_west2_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "security_gwlb1_rt_east_west3" {
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach]
  route_table_id         = aws_route_table.security_gwlb1_rt.id
  destination_cidr_block = local.security_gwlb1_rt_east_west3_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "security_gwlb1_rt_east_west4" {
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach]
  route_table_id         = aws_route_table.security_gwlb1_rt.id
  destination_cidr_block = local.security_gwlb1_rt_east_west4_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "security_gwlb1_rt_east_west5" {
  depends_on             = [aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach]
  route_table_id         = aws_route_table.security_gwlb1_rt.id
  destination_cidr_block = local.security_gwlb1_rt_east_west5_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route_table_association" "security_gwlb1_rt_asso" {
  subnet_id      = aws_subnet.security_gwlb1_subnet.id
  route_table_id = aws_route_table.security_gwlb1_rt.id
}

// Security - Ingress Egress 1 RT
resource "aws_route_table" "security_ingress_egress1_rt" {
  vpc_id = aws_vpc.security_vpc.id

  tags = {
    Name = local.security_ingress_egress1_rt_name
  }
}

resource "aws_route" "security_ingress_egress1_rt_default" {
  route_table_id         = aws_route_table.security_ingress_egress1_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.security_igw.id
}

resource "aws_route" "security_ingress_egress1_rt_east_west1" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_ingress_egress1_rt.id
  destination_cidr_block = local.security_ingress_egress1_rt_east_west1_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route" "security_ingress_egress1_rt_east_west2" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_ingress_egress1_rt.id
  destination_cidr_block = local.security_ingress_egress1_rt_east_west2_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route" "security_ingress_egress1_rt_east_west3" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_ingress_egress1_rt.id
  destination_cidr_block = local.security_ingress_egress1_rt_east_west3_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route" "security_ingress_egress1_rt_east_west4" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_ingress_egress1_rt.id
  destination_cidr_block = local.security_ingress_egress1_rt_east_west4_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route" "security_ingress_egress1_rt_east_west5" {
  depends_on             = [aws_vpc_endpoint.security_gwlb1_endpoint]
  route_table_id         = aws_route_table.security_ingress_egress1_rt.id
  destination_cidr_block = local.security_ingress_egress1_rt_east_west5_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.security_gwlb1_endpoint.id
}

resource "aws_route_table_association" "security_ingress_egress1_rt_asso1" {
  subnet_id      = aws_subnet.security_ingress1_subnet.id
  route_table_id = aws_route_table.security_ingress_egress1_rt.id
}

resource "aws_route_table_association" "security_ingress_egress1_rt_asso2" {
  subnet_id      = aws_subnet.security_egress1_subnet.id
  route_table_id = aws_route_table.security_ingress_egress1_rt.id
}

