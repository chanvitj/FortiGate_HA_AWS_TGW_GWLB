resource "aws_route_table" "shared_rt" {
  vpc_id = aws_vpc.shared_vpc.id

  tags = {
    Name = local.shared_rt_name
  }
}

resource "aws_route" "shared_rt_default" {
  route_table_id         = aws_route_table.shared_rt.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "shared_rt_east_west1" {
  depends_on             = [aws_vpc_endpoint.shared_gwlb_endpoint]
  route_table_id         = aws_route_table.shared_rt.id
  destination_cidr_block = local.shared_rt_east_west1_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.shared_gwlb_endpoint.id
}

resource "aws_route" "shared_rt_east_west2" {
  depends_on             = [aws_vpc_endpoint.shared_gwlb_endpoint]
  route_table_id         = aws_route_table.shared_rt.id
  destination_cidr_block = local.shared_rt_east_west2_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.shared_gwlb_endpoint.id
}

resource "aws_route_table_association" "shared_rt_east_west_association1" {
  subnet_id      = aws_subnet.shared_web1_subnet.id
  route_table_id = aws_route_table.shared_rt.id
}

resource "aws_route_table_association" "shared_rt_east_west_association2" {
  subnet_id      = aws_subnet.shared_app1_subnet.id
  route_table_id = aws_route_table.shared_rt.id
}

resource "aws_route_table" "shared_tgw_gwlb_rt" {
  vpc_id = aws_vpc.shared_vpc.id

  tags = {
    Name = local.shared_tgw_gwlb_rt_name
  }
}

resource "aws_route_table_association" "shared_tgw_gwlb_rt_asso1" {
  subnet_id      = aws_subnet.shared_tgw1_subnet.id
  route_table_id = aws_route_table.shared_tgw_gwlb_rt.id
}

resource "aws_route_table_association" "shared_tgw_gwlb_rt_asso2" {
  subnet_id      = aws_subnet.shared_gwlb1_subnet.id
  route_table_id = aws_route_table.shared_tgw_gwlb_rt.id
}
