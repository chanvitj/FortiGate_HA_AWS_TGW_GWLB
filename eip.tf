resource "aws_eip" "security_eip_natgw" {
  domain = "vpc"

  tags = {
    Name = local.security_eip_natgw_name
  }
}

resource "aws_eip" "FGTVM1_PublicIP" {
  depends_on        = [aws_instance.fgt_vm1]
  domain            = "vpc"
  network_interface = aws_network_interface.fgt1_eth0.id

  tags = {
    Name = local.security_eip_fgtvm1_name
  }
}

resource "aws_eip" "FGTVM2_PublicIP" {
  depends_on        = [aws_instance.fgt_vm2]
  domain            = "vpc"
  network_interface = aws_network_interface.fgt2_eth0.id

  tags = {
    Name = local.security_eip_fgtvm2_name
  }
}

resource "aws_eip" "mgmt_fgt3_pip" {
  depends_on        = [aws_instance.fgt_vm3]
  domain            = "vpc"
  network_interface = aws_network_interface.fgt3_eth0.id

  tags = {
    Name = local.security_eip_fgtvm3_name
  }
}

