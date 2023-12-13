# Introduction  
This will guide how to deploy FortiGate HA on AWS using Transit Gateway and Gateway Load Balancer.

<img title="FortiGate HA on AWS using Transit Gateway and Gateway Load Balancer" alt="231213_FortiGate_HA_AWS_TGW_GWLB_architecture_design_v1" src="231213_FortiGate_HA_AWS_TGW_GWLB_architecture_design_v1.png">

## Configuration Files  
The most important file is terraform.tfvars . You have to enter AWS' access key and secret key into this file. Please <MARK >DO NOT</MARK> upload this file back to your repository such as GitHub/GitLab/BitBucket.  

