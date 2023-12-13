# aws_lb
resource "aws_lb" "security_gwlb" {
  name                             = local.gateway_lb_name
  load_balancer_type               = "gateway"
  enable_cross_zone_load_balancing = true

  subnet_mapping {
    subnet_id = aws_subnet.security_private1_subnet.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.security_private2_subnet.id
  }
}

# aws_lb_target_group
resource "aws_lb_target_group" "security_gwlb_fortigate_target" {
  name        = local.security_fortigate_target
  port        = 6081
  protocol    = "GENEVE"
  target_type = "ip"
  vpc_id      = aws_vpc.security_vpc.id

  health_check {
    port     = 8008
    protocol = "TCP"
  }
}

# aws_lb_listener
resource "aws_lb_listener" "security_gwlb_fortigate_listener" {
  load_balancer_arn = aws_lb.security_gwlb.arn

  default_action {
    target_group_arn = aws_lb_target_group.security_gwlb_fortigate_target.arn
    type             = "forward"
  }
}

# aws_lb_target_group_attachment
resource "aws_lb_target_group_attachment" "security_gwlb1_attachment" {
  depends_on       = [aws_instance.fgt_vm1]
  target_group_arn = aws_lb_target_group.security_gwlb_fortigate_target.arn
  target_id        = data.aws_network_interface.fgt1_eth1.private_ip
  port             = 6081
}

resource "aws_lb_target_group_attachment" "security_gwlb2_attachment" {
  depends_on       = [aws_instance.fgt_vm2]
  target_group_arn = aws_lb_target_group.security_gwlb_fortigate_target.arn
  target_id        = data.aws_network_interface.fgt2_eth1.private_ip
  port             = 6081
}

# aws_vpc_endpoint_service
resource "aws_vpc_endpoint_service" "gwlb_service" {
  acceptance_required        = false
  gateway_load_balancer_arns = [aws_lb.security_gwlb.arn]
  tags = {
    Name = local.gwlb_service_name
  }
}

# aws_vpc_endpoint
// GWLB Endpoint1 - Security VPC
resource "aws_vpc_endpoint" "security_gwlb1_endpoint" {
  service_name      = aws_vpc_endpoint_service.gwlb_service.service_name
  subnet_ids        = [aws_subnet.security_gwlb1_subnet.id]
  vpc_endpoint_type = aws_vpc_endpoint_service.gwlb_service.service_type
  vpc_id            = aws_vpc.security_vpc.id
  tags = {
    Name = local.security_gwlb1_endpoint_name
  }
}

// GWLB Endpoint2 - Security VPC
resource "aws_vpc_endpoint" "security_gwlb2_endpoint" {
  service_name      = aws_vpc_endpoint_service.gwlb_service.service_name
  subnet_ids        = [aws_subnet.security_gwlb2_subnet.id]
  vpc_endpoint_type = aws_vpc_endpoint_service.gwlb_service.service_type
  vpc_id            = aws_vpc.security_vpc.id
  tags = {
    Name = local.security_gwlb2_endpoint_name
  }
}

// GWLB Endpoint - Prod VPC
resource "aws_vpc_endpoint" "prod_gwlb_endpoint" {
  service_name      = aws_vpc_endpoint_service.gwlb_service.service_name
  subnet_ids        = [aws_subnet.prod_gwlb1_subnet.id]
  vpc_endpoint_type = aws_vpc_endpoint_service.gwlb_service.service_type
  vpc_id            = aws_vpc.prod_vpc.id
  tags = {
    Name = local.prod_gwlb_endpoint_name
  }
}

# // GWLB Endpoint - Dev VPC
resource "aws_vpc_endpoint" "dev_gwlb_endpoint" {
  service_name      = aws_vpc_endpoint_service.gwlb_service.service_name
  subnet_ids        = [aws_subnet.dev_gwlb1_subnet.id]
  vpc_endpoint_type = aws_vpc_endpoint_service.gwlb_service.service_type
  vpc_id            = aws_vpc.dev_vpc.id
  tags = {
    Name = local.dev_gwlb_endpoint_name
  }
}

# // GWLB Endpoint - Shared VPC
resource "aws_vpc_endpoint" "shared_gwlb_endpoint" {
  service_name      = aws_vpc_endpoint_service.gwlb_service.service_name
  subnet_ids        = [aws_subnet.shared_gwlb1_subnet.id]
  vpc_endpoint_type = aws_vpc_endpoint_service.gwlb_service.service_type
  vpc_id            = aws_vpc.shared_vpc.id
  tags = {
    Name = local.shared_gwlb_endpoint_name
  }
}