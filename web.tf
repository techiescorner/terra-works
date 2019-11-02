resource "aws_instance" "terraform-web" {
	ami = "ami-0b69ea66ff7391e80"
	availability_zone = "us-east-1a"
	instance_type = "t2.micro"
	key_name = "aws_key-jas"
        vpc_security_group_ids = ["${aws_security_group.terraform-webSG.id}"]
        subnet_id = "${aws_subnet.terraform-PubSN.id}"
	associate_public_ip_address = true
	source_dest_check = false
tags = {
	Name = "TC-webserver"
	}
}

resource "aws_security_group" "terraform-webSG" {
description = "Accept incoming connections."

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
 }

ingress {
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
 }

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
   }
vpc_id = "${aws_vpc.terraform-vpc.id}"

tags = {
     Name = "web-SG"
    }   
}
