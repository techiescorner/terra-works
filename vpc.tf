resource "aws_vpc" "terraform-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
       Name = "TC-vpc" 
    }    
}

resource "aws_internet_gateway" "terraform-IG" {
     vpc_id = "${aws_vpc.terraform-vpc.id}"
     tags = {
 	Name = "TC-ig"
     }
}

resource "aws_subnet" "terraform-PubSN" {
     vpc_id = "${aws_vpc.terraform-vpc.id}"
     cidr_block = "10.0.1.0/24"
     availability_zone = "us-east-1a"
     tags = {
         Name = "TC-PublicSN"
     }
}      

resource "aws_subnet" "terraform-PriSN" {
     vpc_id = "${aws_vpc.terraform-vpc.id}"
     cidr_block = "10.0.2.0/24"
     availability_zone = "us-east-1a"
     tags = {
         Name = "TC-PrivSN"
     }
}     

resource "aws_route_table" "terraform-Route-Pub" {
      vpc_id = "${aws_vpc.terraform-vpc.id}"
      route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.terraform-IG.id}"
      }
      tags = {
           Name = "TC-PubRT"
    }
}

resource "aws_route_table_association" "terraform-PubSN_Route" {
    subnet_id = "${aws_subnet.terraform-PubSN.id}"
    route_table_id = "${aws_route_table.terraform-Route-Pub.id}"
    }

resource "aws_route_table" "terraform-Route-Pri" {
     vpc_id = "${aws_vpc.terraform-vpc.id}"
     route {
     cidr_block = "0.0.0.0/0"
     nat_gateway_id = "${aws_nat_gateway.nat.id}"
}
    tags = {
         Name = "TC-PriRT"
     }
   }  
     resource "aws_route_table_association" "terraform-PriSN-Route" {
     subnet_id = "${aws_subnet.terraform-PriSN.id}"
     route_table_id = "${aws_route_table.terraform-Route-Pri.id}"    
}

resource "aws_nat_gateway" "nat" {
subnet_id     = "${aws_subnet.terraform-PubSN.id}"
allocation_id = "${aws_eip.ip_nat.id}"
tags = {
Name = "TC-NAT"
}
}
resource "aws_eip" "ip_nat" {
#instance = "${aws_nat_gateway.nat.id}"
vpc = true
tags = {
Name = "TC-NAT-IP"
}
}
