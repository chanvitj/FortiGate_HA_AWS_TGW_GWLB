// Route Table of Mgmt VPC
// Route Tables
// - Public
// - Private
// - Jump
resource "aws_route_table" "mgmt_public_rt" {
  vpc_id = aws_vpc.mgmt_vpc.id

  tags = {
    Name = local.mgmt_public_rt_name
  }
}

resource "aws_route_table" "mgmt_private_rt" {
  vpc_id = aws_vpc.mgmt_vpc.id

  tags = {
    Name = local.mgmt_private_rt_name
  }
}

resource "aws_route_table" "mgmt_jump_rt" {
  vpc_id = aws_vpc.mgmt_vpc.id

  tags = {
    Name = local.mgmt_jump_rt_name
  }
}

resource "aws_route_table" "mgmt_tgw_rt" {
  vpc_id = aws_vpc.mgmt_vpc.id

  tags = {
    Name = local.mgmt_tgw_rt_name
  }
}

// Routes
// Routes of Mgmt Public
resource "aws_route" "mgmt_public_rt_route_default" {
  route_table_id         = aws_route_table.mgmt_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mgmt_igw.id
}

// Routes of Mgmt Private
resource "aws_route" "mgmt_private_rt_route_default" {
  depends_on             = [aws_instance.fgt_vm3]
  route_table_id         = aws_route_table.mgmt_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.fgt3_eth1.id
}

// Routes of Mgmt Jump - Default
resource "aws_route" "mgmt_jump_rt_route_default" {
  depends_on             = [aws_instance.fgt_vm3]
  route_table_id         = aws_route_table.mgmt_jump_rt.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.fgt3_eth1.id
}

// Route of Mgmt Jump - 10.2.64.0/24
resource "aws_route" "mgmt_jump_rt_route_1" {
  depends_on             = [aws_instance.fgt_vm3]
  route_table_id         = aws_route_table.mgmt_jump_rt.id
  destination_cidr_block = "10.2.64.0/24"
  network_interface_id   = aws_network_interface.fgt3_eth1.id
}

// Route of Mgmt Jump - 10.2.128.0/24
resource "aws_route" "mgmt_jump_rt_route_2" {
  depends_on             = [aws_instance.fgt_vm3]
  route_table_id         = aws_route_table.mgmt_jump_rt.id
  destination_cidr_block = "10.2.128.0/24"
  network_interface_id   = aws_network_interface.fgt3_eth1.id
}

// Route of Mgmt Jump - 10.11.0.0/16 > TGW
resource "aws_route" "mgmt_jump_rt_route_3" {
  # depends_on             = [aws_instance.fgt_vm3]
  route_table_id         = aws_route_table.mgmt_jump_rt.id
  destination_cidr_block = "10.11.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  # network_interface_id   = aws_network_interface.mgmt_tgw <<<
}

// Route of Mgmt Jump - 10.12.0.0/16 > TGW
resource "aws_route" "mgmt_jump_rt_route_4" {
  route_table_id         = aws_route_table.mgmt_jump_rt.id
  destination_cidr_block = "10.12.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

// Route of Mgmt Jump - 10.13.0.0/16 > TGW
resource "aws_route" "mgmt_jump_rt_route_5" {
  route_table_id         = aws_route_table.mgmt_jump_rt.id
  destination_cidr_block = "10.13.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

// Route of Mgmt Jump - 10.1.0.0/16 > TGW
resource "aws_route" "mgmt_jump_rt_route_6" {
  route_table_id         = aws_route_table.mgmt_jump_rt.id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}

// Route of Mgmt TGW - 10.2.64.0/24
resource "aws_route" "mgmt_tgw_rt_route_1" {
  depends_on             = [aws_instance.fgt_vm3]
  route_table_id         = aws_route_table.mgmt_tgw_rt.id
  destination_cidr_block = "10.2.1.0/24"
  network_interface_id   = aws_network_interface.fgt3_eth1.id
}

// Route Table Association
// Associate - Mgmt Public Subnet
resource "aws_route_table_association" "mgmt_public_rt_asso" {
  subnet_id      = aws_subnet.mgmt_public_subnet.id
  route_table_id = aws_route_table.mgmt_public_rt.id
}

// Associate - Mgmt Private Subnet
resource "aws_route_table_association" "mgmt_private_rt_asso" {
  subnet_id      = aws_subnet.mgmt_private_subnet.id
  route_table_id = aws_route_table.mgmt_private_rt.id
}

// Associate - Mgmt Jump Subnet
resource "aws_route_table_association" "mgmt_jump_rt_asso" {
  subnet_id      = aws_subnet.mgmt_jump_subnet.id
  route_table_id = aws_route_table.mgmt_jump_rt.id
}

// Associate - Mgmt TGW Subnet
resource "aws_route_table_association" "mgmt_tgw_rt_asso" {
  subnet_id      = aws_subnet.mgmt_tgw_subnet.id
  route_table_id = aws_route_table.mgmt_tgw_rt.id
}
