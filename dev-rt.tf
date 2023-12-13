
resource "aws_route_table" "dev_rt" {
  vpc_id = aws_vpc.dev_vpc.id
  depends_on = [ aws_ec2_transit_gateway_vpc_attachment.dev_tgw_attach ]

  tags = {
    Name = local.dev_rt_name
  }
}

resource "aws_route" "dev_rt_default" {
  route_table_id         = aws_route_table.dev_rt.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "dev_rt_east_west1" {
  depends_on             = [aws_vpc_endpoint.dev_gwlb_endpoint]
  route_table_id         = aws_route_table.dev_rt.id
  destination_cidr_block = local.dev_rt_east_west1_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.dev_gwlb_endpoint.id
}

resource "aws_route" "dev_rt_east_west2" {
  depends_on             = [aws_vpc_endpoint.dev_gwlb_endpoint]
  route_table_id         = aws_route_table.dev_rt.id
  destination_cidr_block = local.dev_rt_east_west2_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.dev_gwlb_endpoint.id
}

resource "aws_route_table_association" "dev_rt_east_west_association1" {
  subnet_id      = aws_subnet.dev_web1_subnet.id
  route_table_id = aws_route_table.dev_rt.id
}

resource "aws_route_table_association" "dev_rt_east_west_association2" {
  subnet_id      = aws_subnet.dev_app1_subnet.id
  route_table_id = aws_route_table.dev_rt.id
}

resource "aws_route_table" "dev_tgw_gwlb_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = local.dev_tgw_gwlb_rt_name
  }
}

resource "aws_route_table_association" "dev_tgw_gwlb_rt_association1" {
  subnet_id      = aws_subnet.dev_tgw1_subnet.id
  route_table_id = aws_route_table.dev_tgw_gwlb_rt.id
}

resource "aws_route_table_association" "dev_tgw_gwlb_rt_association2" {
  subnet_id      = aws_subnet.dev_gwlb1_subnet.id
  route_table_id = aws_route_table.dev_tgw_gwlb_rt.id
}
