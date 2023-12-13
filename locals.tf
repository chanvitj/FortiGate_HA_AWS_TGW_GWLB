locals {
  # Region
  region = "ap-northeast-3"
  az1    = "ap-northeast-3a"
  az2    = "ap-northeast-3b"

  # VPC
  security_vpc_name = "Security VPC"
  security_vpc_cidr = "10.1.0.0/16"

  prod_vpc_name = "Prod VPC"
  prod_vpc_cidr = "10.11.0.0/16"

  dev_vpc_name = "Dev VPC"
  dev_vpc_cidr = "10.12.0.0/16"

  shared_vpc_name = "Shared VPC"
  shared_vpc_cidr = "10.13.0.0/16"

  mgmt_vpc_name = "Mgmt VPC"
  mgmt_vpc_cidr = "10.2.0.0/16"

  # Subnet
  # Subnets of Security VPC AZ1
  security_public1_name = "Security Public1"
  security_public1_cidr = "10.1.1.0/24"

  security_private1_name = "Security Private1"
  security_private1_cidr = "10.1.64.0/24"

  security_ingress1_name = "Security Ingress1"
  security_ingress1_cidr = "10.1.3.0/24"

  security_egress1_name = "Security Egress1"
  security_egress1_cidr = "10.1.5.0/24"

  security_tgw1_name = "Security TGW1"
  security_tgw1_cidr = "10.1.128.0/24"

  security_gwlb1_name = "Security GWLB1"
  security_gwlb1_cidr = "10.1.66.0/24"

  # Subnets of Security VPC AZ2
  security_public2_name = "Security Public2"
  security_public2_cidr = "10.1.2.0/24"

  security_private2_name = "Security Private2"
  security_private2_cidr = "10.1.65.0/24"

  security_ingress2_name = "Security Ingress2"
  security_ingress2_cidr = "10.1.4.0/24"

  security_egress2_name = "Security Egress2"
  security_egress2_cidr = "10.1.6.0/24"

  security_tgw2_name = "Security TGW2"
  security_tgw2_cidr = "10.1.129.0/24"

  security_gwlb2_name = "Security GWLB2"
  security_gwlb2_cidr = "10.1.67.0/24"

  # Subnets of Prod VPC
  prod_tgw1_name = "Prod TGW1"
  prod_tgw1_cidr = "10.11.128.0/24"

  prod_gwlb1_name = "Prod GWLB1"
  prod_gwlb1_cidr = "10.11.129.0/24"

  prod_web1_name = "Prod Web1"
  prod_web1_cidr = "10.11.1.0/24"

  prod_app1_name = "Prod App1"
  prod_app1_cidr = "10.11.2.0/24"

  # Subnets of Dev VPC
  dev_tgw1_name = "Dev TGW1"
  dev_tgw1_cidr = "10.12.128.0/24"

  dev_gwlb1_name = "Dev GWLB1"
  dev_gwlb1_cidr = "10.12.129.0/24"

  dev_web1_name = "Dev Web1"
  dev_web1_cidr = "10.12.1.0/24"

  dev_app1_name = "Dev App1"
  dev_app1_cidr = "10.12.2.0/24"

  # Subnets of Shared VPC
  shared_tgw1_name = "Shared TGW1"
  shared_tgw1_cidr = "10.13.128.0/24"

  shared_gwlb1_name = "Shared GWLB1"
  shared_gwlb1_cidr = "10.13.129.0/24"

  shared_web1_name = "Shared Web1"
  shared_web1_cidr = "10.13.1.0/24"

  shared_app1_name = "Shared App1"
  shared_app1_cidr = "10.13.2.0/24"

  # Subnets of Mgmt VPC
  mgmt_public_name = "Mgmt Public"
  mgmt_public_cidr = "10.2.1.0/24"

  mgmt_private_name = "Mgmt Private"
  mgmt_private_cidr = "10.2.64.0/24"

  mgmt_jump_name = "Mgmt Jump"
  mgmt_jump_cidr = "10.2.65.0/24"

  mgmt_tgw_name = "Mgmt TGW"
  mgmt_tgw_cidr = "10.2.128.0/24"

  # Routing Table
  # Routing Tables of Security VPC
  # Route of Security VPC AZ1
  security_public1_rt_name  = "Security Public 1 RT"
  security_private1_rt_name = "Security Private 1 RT"

  # security_egress_ingress1_rt_name = "Security Ingress Egress 1 RT"
  security_tgw1_rt_name            = "Security TGW 1 RT"
  security_tgw1_rt_east_west1_cidr = "10.1.3.0/24"
  security_tgw1_rt_east_west2_cidr = "10.1.5.0/24"

  security_gwlb1_rt_name            = "Security GWLB 1 RT"
  security_gwlb1_rt_east_west1_cidr = "10.2.0.0/16"
  security_gwlb1_rt_east_west2_cidr = "10.3.0.0/16"
  security_gwlb1_rt_east_west3_cidr = "10.11.0.0/16"
  security_gwlb1_rt_east_west4_cidr = "10.12.0.0/16"
  security_gwlb1_rt_east_west5_cidr = "10.13.0.0/16"

  security_ingress_egress1_rt_name            = "Security Ingress Egress 1 RT"
  security_ingress_egress1_rt_east_west1_cidr = "10.2.0.0/16"
  security_ingress_egress1_rt_east_west2_cidr = "10.3.0.0/16"
  security_ingress_egress1_rt_east_west3_cidr = "10.11.0.0/16"
  security_ingress_egress1_rt_east_west4_cidr = "10.12.0.0/16"
  security_ingress_egress1_rt_east_west5_cidr = "10.13.0.0/16"

  # Route of Security VPC AZ2
  security_public2_rt_name         = "Security Public 2 RT"
  security_private2_rt_name        = "Security Private 2 RT"
  security_tgw2_rt_name            = "Security TGW 2 RT"
  security_egress_ingress2_rt_name = "Security Ingress Egress 2 RT"
  security_tgw2_rt_east_west1_cidr = "10.1.3.0/24"
  security_tgw2_rt_east_west2_cidr = "10.1.5.0/24"

  security_gwlb2_rt_name            = "Security GWLB 2 RT"
  security_gwlb2_rt_east_west1_cidr = "10.2.0.0/16"
  security_gwlb2_rt_east_west2_cidr = "10.3.0.0/16"
  security_gwlb2_rt_east_west3_cidr = "10.11.0.0/16"
  security_gwlb2_rt_east_west4_cidr = "10.12.0.0/16"
  security_gwlb2_rt_east_west5_cidr = "10.13.0.0/16"

  security_ingress_egress2_rt_name            = "Security Ingress Egress 2 RT"
  security_ingress_egress2_rt_east_west1_cidr = "10.2.0.0/16"
  security_ingress_egress2_rt_east_west2_cidr = "10.3.0.0/16"
  security_ingress_egress2_rt_east_west3_cidr = "10.11.0.0/16"
  security_ingress_egress2_rt_east_west4_cidr = "10.12.0.0/16"
  security_ingress_egress2_rt_east_west5_cidr = "10.13.0.0/16"

  # Routing Tables of Prod VPC
  prod_rt_name            = "Prod RT"
  prod_rt_east_west1_cidr = "10.11.1.0/24"
  prod_rt_east_west2_cidr = "10.11.2.0/24"
  prod_tgw_gwlb_rt_name   = "Prod TGW GWLB RT"

  # Routing Tables of Dev VPC
  dev_rt_name            = "Dev RT"
  dev_rt_east_west1_cidr = "10.12.1.0/24"
  dev_rt_east_west2_cidr = "10.12.2.0/24"
  dev_tgw_gwlb_rt_name   = "Dev TGW GWLB RT"

  # Routing Tables of Shared VPC
  shared_rt_name            = "Shared RT"
  shared_rt_east_west1_cidr = "10.13.1.0/24"
  shared_rt_east_west2_cidr = "10.13.2.0/24"
  shared_tgw_gwlb_rt_name   = "Shared TGW GWLB RT"

  # Routing Tables of Mgmt VPC
  mgmt_public_rt_name  = "Mgmt_Public_RT"
  mgmt_private_rt_name = "Mgmt_Private_RT"
  mgmt_jump_rt_name    = "Mgmt_Jump_RT"
  mgmt_tgw_rt_name     = "Mgmt_TGW_RT"

  # IGW
  security_igw_name = "Security IGW"
  mgmt_igw_name     = "Mgmt IGW"

  # EIP
  security_eip_natgw_name  = "EIP for NAT GW in Security VPC"
  security_eip_fgtvm1_name = "EIP of FGT-VM1 in Security VPC"
  security_eip_fgtvm2_name = "EIP of FGT-VM2 in Security VPC"
  security_eip_fgtvm3_name = "EIP of FGT-VM3 in Mgmt VPC"

  # NAT Gateway
  security_natgw_name = "Security NATGW"

  # TGW
  tgw_name        = "TGW"
  tgw_description = "Transit Gateway with 6 VPCs"

  security_tgw_attach_name = "Security - TGW Attachment"
  prod_tgw_attach_name     = "Prod - TGW Attachment"
  dev_tgw_attach_name      = "Dev - TGW Attachment"
  shared_tgw_attach_name   = "Shared - TGW Attachment"
  mgmt_tgw_attach_name     = "Mgmt - TGW Attachment"
  sdwan_tgw_attach_name    = "SDWAN - TGW Attachment"

  all_tgw_attach_rt_name      = "All - TGWAttach RT"
  security_tgw_attach_rt_name = "Security - TGWAttach RT"

  # Gateway Load Balancer
  gateway_lb_name           = "SecurityGWLB"
  security_fortigate_target = "SecurityGWLBFortiGateTarget"

  gwlb_service_name = "GWLBService"

  security_gwlb1_endpoint_name = "Security1GWLBEndpoint"
  security_gwlb2_endpoint_name = "Security2GWLBEndpoint"
  prod_gwlb_endpoint_name      = "ProdGWLBEndpoint"
  dev_gwlb_endpoint_name       = "DevGWLBEndpoint"
  shared_gwlb_endpoint_name    = "SharedGWLBEndpoint"

  # All FortiGates
  adminsport = "443"
  keyname    = "<key name>"

  # FGT1, FGT2
  # Either arm or x86
  arch = "x86"
  # c5.xlarge is x86_64
  # c6g.xlarge is arm
  size = "c5.large"
  # license_type = "byol" or "payg"
  license_type      = "byol"
  bootstrap_fgt_vm1 = "security-fgt-vm1.conf"
  bootstrap_fgt_vm2 = "security-fgt-vm2.conf"
  license1          = "license1.lic"
  license2          = "license2.lic"

  # FGT3
  # Either arm or x86
  arch3 = "x86"
  # c5.xlarge is x86_64
  # c6g.xlarge is arm
  size3 = "c5.xlarge"
  # license_type = "byol" or "payg"
  license_type3     = "byol"
  license3          = "license3.lic"
  bootstrap_fgt_vm3 = "mgmt-fgt-vm3.conf"
}
