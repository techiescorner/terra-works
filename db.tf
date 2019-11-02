resource "aws_instance" "terraform-db" {
	ami = "ami-0b69ea66ff7391e80"
	availability_zone = "us-east-1a"
	instance_type = "t2.micro"
	key_name = "aws_key-jas"
vpc_security_group_ids = ["${aws_security_group.terraform-dbSG.id}"]
        subnet_id = "${aws_subnet.terraform-PriSN.id}"
	associate_public_ip_address = false
	source_dest_check = false

tags = {
	Name = "TC-DB"
	}
}
resource "aws_security_group" "terraform-dbSG" {
description = "Accept incoming connections."

ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["10.0.1.0/24"]
   }

ingress {
   from_port = 3306
   to_port = 3306
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
    Name = "DB-SG"
   }
}

