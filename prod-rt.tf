
resource "aws_route_table" "prod_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  # route {
  #   cidr_block         = "0.0.0.0/0"
  #   transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  # }

  tags = {
    Name = local.prod_rt_name
  }
}

resource "aws_route" "prod_rt_default" {
  route_table_id         = aws_route_table.prod_rt.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "prod_rt_east_west1" {
  depends_on             = [aws_vpc_endpoint.prod_gwlb_endpoint]
  route_table_id         = aws_route_table.prod_rt.id
  destination_cidr_block = local.prod_rt_east_west1_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.prod_gwlb_endpoint.id
}

resource "aws_route" "prod_rt_east_west2" {
  depends_on             = [aws_vpc_endpoint.prod_gwlb_endpoint]
  route_table_id         = aws_route_table.prod_rt.id
  destination_cidr_block = local.prod_rt_east_west2_cidr
  vpc_endpoint_id        = aws_vpc_endpoint.prod_gwlb_endpoint.id
}

# resource "aws_route" "prod_rt_east_west" {
#   # for_each               = toset(local.prod_rt_east_west_cidr)
#   depends_on             = [aws_vpc_endpoint.prod_gwlb_endpoint]
#   route_table_id         = aws_route_table.prod_rt.id
#   destination_cidr_block = each.value
#   vpc_endpoint_id        = aws_vpc_endpoint.prod_gwlb_endpoint.id
# }

resource "aws_route_table_association" "prod_rt_east_west_asso1" {
  subnet_id      = aws_subnet.prod_web1_subnet.id
  route_table_id = aws_route_table.prod_rt.id
}

resource "aws_route_table_association" "prod_rt_east_west_asso2" {
  subnet_id      = aws_subnet.prod_app1_subnet.id
  route_table_id = aws_route_table.prod_rt.id
}

//
resource "aws_route_table" "prod_tgw_gwlb_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = local.prod_tgw_gwlb_rt_name
  }
}

resource "aws_route_table_association" "prod_tgw_gwlb_rt_asso1" {
  subnet_id      = aws_subnet.prod_tgw1_subnet.id
  route_table_id = aws_route_table.prod_tgw_gwlb_rt.id
}

resource "aws_route_table_association" "prod_tgw_gwlb_rt_asso2" {
  subnet_id      = aws_subnet.prod_gwlb1_subnet.id
  route_table_id = aws_route_table.prod_tgw_gwlb_rt.id
}
