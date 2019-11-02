# terra-works
Terraform tutorial code
Complete code to provisoin AWS resource using terraform
Contains following file 
# connect.tf
# vpc.tf
# web.tf
# db.tf

Connect.tf : Used to confirm the the Terraform can connect to the AWS cloud

vpc.tf : This file contains the code to provisoin AWS resources like VPC, subnet, NAT, IP address and Internet gateway.

web.tf :  It provision an EC2 instance and public IP address in public subnet and associate security group rules

db.tf : It provision an EC2 subnet in private subnet and associate a security group rules.
