// FGTVM instance

resource "aws_network_interface" "fgt3_eth0" {
  description = "FGT3 Port1"
  subnet_id   = aws_subnet.mgmt_public_subnet.id

  tags = {
    Name = "FGT3 NIC0"
  }
}

resource "aws_network_interface" "fgt3_eth1" {
  description       = "FGT3 Port2"
  subnet_id         = aws_subnet.mgmt_private_subnet.id
  source_dest_check = false

  tags = {
    Name = "FGT3 NIC1"
  }
}

resource "aws_network_interface_sg_attachment" "fgt3_nic0_sg_attach" {
  depends_on           = [aws_network_interface.fgt3_eth0]
  security_group_id    = aws_security_group.mgmt_public_allow.id
  network_interface_id = aws_network_interface.fgt3_eth0.id
}

resource "aws_network_interface_sg_attachment" "fgt3_nic1_sg_attach" {
  depends_on           = [aws_network_interface.fgt3_eth1]
  security_group_id    = aws_security_group.mgmt_allow_all.id
  network_interface_id = aws_network_interface.fgt3_eth1.id
}

resource "aws_instance" "fgt_vm3" {
  //it will use region, architect, and license type to decide which ami to use for deployment
  ami               = var.fgtami[local.region][local.arch3][local.license_type3]
  instance_type     = local.size3
  availability_zone = local.az1
  key_name          = local.keyname
  user_data = templatefile("${local.bootstrap_fgt_vm3}", {
    type         = "${local.license_type3}"
    license_file = "${local.license3}"
    adminsport   = "${local.adminsport}"
  })

  root_block_device {
    volume_type = "standard"
    volume_size = "2"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.fgt3_eth0.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.fgt3_eth1.id
    device_index         = 1
  }

  tags = {
    Name = "FGTVM3"
  }
}
