// FGTVM instance AZ2

resource "aws_network_interface" "fgt2_eth0" {
  description = "fgtvm2-port1"
  subnet_id   = aws_subnet.security_public2_subnet.id

  tags = {
    Name = "FGT2 NIC0"
  }
}

resource "aws_network_interface" "fgt2_eth1" {
  description       = "fgtvm2-port2"
  subnet_id         = aws_subnet.security_private2_subnet.id
  source_dest_check = false

  tags = {
    Name = "FGT2 NIC1"
  }
}

data "aws_network_interface" "fgt2_eth1" {
  id = aws_network_interface.fgt2_eth1.id
}

//
data "aws_network_interface" "gwlb1_endpoint" {
  depends_on = [aws_vpc_endpoint.security_gwlb1_endpoint]
  filter {
    name   = "vpc-id"
    values = ["${aws_vpc.security_vpc.id}"]
  }
  filter {
    name   = "status"
    values = ["in-use"]
  }
  filter {
    name   = "description"
    values = ["*ELB gwy*"]
  }
  //  Using AZ1's endpoint ip
  filter {
    name   = "availability-zone"
    values = ["${local.az1}"]
  }
}

data "aws_network_interface" "gwlb2_endpoint" {
  depends_on = [aws_vpc_endpoint.security_gwlb2_endpoint]
  filter {
    name   = "vpc-id"
    values = ["${aws_vpc.security_vpc.id}"]
  }
  filter {
    name   = "status"
    values = ["in-use"]
  }
  filter {
    name   = "description"
    values = ["*ELB gwy*"]
  }
  //  Using AZ1's endpoint ip
  filter {
    name   = "availability-zone"
    values = ["${local.az2}"]
  }
}

resource "aws_network_interface_sg_attachment" "fgt2_publicattachment" {
  depends_on           = [aws_network_interface.fgt2_eth0]
  security_group_id    = aws_security_group.security_public_allow.id
  network_interface_id = aws_network_interface.fgt2_eth0.id
}

resource "aws_network_interface_sg_attachment" "fgt2_internalattachment" {
  depends_on           = [aws_network_interface.fgt2_eth1]
  security_group_id    = aws_security_group.security_allow_all.id
  network_interface_id = aws_network_interface.fgt2_eth1.id
}


resource "aws_instance" "fgt_vm2" {
  //it will use region, architect, and license type to decide which ami to use for deployment
  ami               = var.fgtami[local.region][local.arch][local.license_type]
  instance_type     = local.size
  availability_zone = local.az2
  key_name          = local.keyname
  user_data = chomp(templatefile("${local.bootstrap_fgt_vm2}", {
    type         = "${local.license_type}"
    license_file = "${local.license2}"
    adminsport   = "${local.adminsport}"
    cidr         = "${local.security_private1_cidr}"
    gateway      = cidrhost(local.security_private2_cidr, 1)
    endpointip1   = "${data.aws_network_interface.gwlb1_endpoint.private_ip}"
    endpointip2   = "${data.aws_network_interface.gwlb2_endpoint.private_ip}"
  }))

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
    network_interface_id = aws_network_interface.fgt2_eth0.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.fgt2_eth1.id
    device_index         = 1
  }

  tags = {
    Name = "FGTVM2"
  }
}
