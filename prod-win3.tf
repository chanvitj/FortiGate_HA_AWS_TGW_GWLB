resource "aws_network_interface" "win3_nic1" {
  subnet_id = aws_subnet.prod_app1_subnet.id
  tags = {
    Name = "Win3 NIC1"
  }
}

resource "aws_network_interface_sg_attachment" "win3_nic1_sg_attach" {
  depends_on = [ aws_network_interface.win3_nic1 ]
  security_group_id = aws_security_group.prod_allow_all.id
  network_interface_id = aws_network_interface.win3_nic1.id
}

resource "aws_instance" "win3" {
  ami = "ami-093d40b2cdd742a31"
  instance_type = "t2.medium"
  key_name = local.keyname

  network_interface {
    network_interface_id = aws_network_interface.win3_nic1.id
    device_index = 0
  }

  tags = {
    Name = "Prod Win3"
  }
}
