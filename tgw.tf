# TGW
resource "aws_ec2_transit_gateway" "tgw" {
  description                     = local.tgw_description
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    Name = local.tgw_name
  }
}

# TGW Attachment
# > 6 attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "security_tgw_attach" {
  appliance_mode_support                          = "enable"
  subnet_ids                                      = [aws_subnet.security_tgw1_subnet.id, aws_subnet.security_tgw2_subnet.id]
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  vpc_id                                          = aws_vpc.security_vpc.id

  tags = {
    Name = local.security_tgw_attach_name
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "prod_tgw_attach" {
  appliance_mode_support                          = "enable"
  subnet_ids                                      = [aws_subnet.prod_tgw1_subnet.id]
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  vpc_id                                          = aws_vpc.prod_vpc.id

  tags = {
    Name = local.prod_tgw_attach_name
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "dev_tgw_attach" {
  appliance_mode_support                          = "enable"
  subnet_ids                                      = [aws_subnet.dev_tgw1_subnet.id]
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  vpc_id                                          = aws_vpc.dev_vpc.id

  tags = {
    Name = local.dev_tgw_attach_name
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "shared_tgw_attach" {
  appliance_mode_support                          = "enable"
  subnet_ids                                      = [aws_subnet.shared_tgw1_subnet.id]
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  vpc_id                                          = aws_vpc.shared_vpc.id

  tags = {
    Name = local.shared_tgw_attach_name
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "mgmt_tgw_attach" {
  appliance_mode_support                          = "enable"
  subnet_ids                                      = [aws_subnet.mgmt_tgw_subnet.id]
  transit_gateway_id                              = aws_ec2_transit_gateway.tgw.id
  vpc_id                                          = aws_vpc.mgmt_vpc.id

  tags = {
    Name = local.mgmt_tgw_attach_name
  }
  depends_on = [aws_ec2_transit_gateway.tgw]
}

# Route Table
resource "aws_ec2_transit_gateway_route_table" "all_tgw_attach_rt" {
  depends_on         = [aws_ec2_transit_gateway.tgw]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags = {
    Name = local.all_tgw_attach_rt_name
  }
}

resource "aws_ec2_transit_gateway_route_table" "security_tgw_attach_rt" {
  depends_on         = [aws_ec2_transit_gateway.tgw]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags = {
    Name = local.security_tgw_attach_rt_name
  }
}

# Route Tables Propagations - security_tgw_attach_rt
resource "aws_ec2_transit_gateway_route_table_propagation" "security_tgw_attach_rt_propagation_security" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.security_tgw_attach_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "security_tgw_attach_rt_propagation_prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.prod_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.security_tgw_attach_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "security_tgw_attach_rt_propagation_dev" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.dev_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.security_tgw_attach_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "security_tgw_attach_rt_propagation_shared" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.security_tgw_attach_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "security_tgw_attach_rt_propagation_mgmt" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.mgmt_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.security_tgw_attach_rt.id
}

# Route Tables Propagations - all_tgw_attach_rt
resource "aws_ec2_transit_gateway_route" "all_tgw_attach_rt-default-route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.all_tgw_attach_rt.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "all_tgw_attach_rt-propagation_security" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.all_tgw_attach_rt.id
}

# Route Tables Associations
# Route Tables Associations - security > security_tgw_attach_rt
resource "aws_ec2_transit_gateway_route_table_association" "security_tgw_attach_rt_association_security" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.security_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.security_tgw_attach_rt.id
}

# Route Tables Associations - prod > all_tgw_attach_rt
resource "aws_ec2_transit_gateway_route_table_association" "all_tgw_attach_rt_association_prod" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.prod_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.all_tgw_attach_rt.id
}

# Route Tables Associations - dev > all_tgw_attach_rt
resource "aws_ec2_transit_gateway_route_table_association" "all_tgw_attach_rt_association_dev" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.dev_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.all_tgw_attach_rt.id
}

# Route Tables Associations - shared > all_tgw_attach_rt
resource "aws_ec2_transit_gateway_route_table_association" "all_tgw_attach_rt_association_shared" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.all_tgw_attach_rt.id
}

# Route Tables Associations - Mgmt > all_tgw_attach_rt
resource "aws_ec2_transit_gateway_route_table_association" "all_tgw_attach_rt_association_mgmt" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.mgmt_tgw_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.all_tgw_attach_rt.id
}
