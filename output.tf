
output "FGTVM1-PublicIP" {
  value = aws_eip.FGTVM1_PublicIP.public_ip
}

output "FGTVM2-PublicIP" {
  value = aws_eip.FGTVM2_PublicIP.public_ip
}

output "Username" {
  value = "admin"
}

output "FGT1-Password" {
  value = aws_instance.fgt_vm1.id
}

output "FGT2-Password" {
  value = aws_instance.fgt_vm2.id
}

output "FGT3-Password" {
  value = aws_instance.fgt_vm3.id
}

output "FGT3-NIC0-IP" {
  value = aws_network_interface.fgt3_eth0.private_ip
}

output "FGTVM3-PublicIP" {
  value = aws_eip.mgmt_fgt3_pip.public_ip
}

output "Mgmt-Win1-IP" {
  value = aws_instance.win1.private_ip
}

output "Prod-Win2-IP" {
  value = aws_instance.win2.private_ip
}

output "Prod-Win3-IP" {
  value = aws_instance.win3.private_ip
}

output "Dev-Win4-IP" {
  value = aws_instance.win4.private_ip
}

output "Dev-Web1-IP" {
  value = aws_instance.dev_web1.private_ip
}
