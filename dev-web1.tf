resource "aws_network_interface" "web1_nic1" {
  subnet_id = aws_subnet.dev_web1_subnet.id
  tags = {
    Name = "Web1 NIC1"
  }
}

resource "aws_network_interface_sg_attachment" "web1_nic1_sg_attach" {
  depends_on           = [aws_network_interface.web1_nic1]
  security_group_id    = aws_security_group.dev_allow_all.id
  network_interface_id = aws_network_interface.web1_nic1.id
}

resource "aws_instance" "dev_web1" {
  ami           = "ami-035322b237ca6d47a"
  instance_type = "t2.micro"
  key_name = local.keyname

  network_interface {
    network_interface_id = aws_network_interface.web1_nic1.id
    device_index         = 0
  }

  user_data = <<-EOL
  #!/bin/bash -xe
  yum update -y
  yum install -y httpd.x86_64
  systemctl start httpd.service
  systemctl enable httpd.service
  echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  EOL

  tags = {
    Name = "Dev - Web1"
  }
}
