provider "aws" {
  region = "ap-south-1"
}


resource "aws_key_pair" "my_key" {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}

resource "aws_default_vpc" "default" {
  
}


resource "aws_security_group" "my_security_group" {
  name = "automate-sg"
  description = "this will add a tf generated security group"
  vpc_id = aws_default_vpc.default.id

  #inbound rule
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }


  #outbound rule

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "All access outbound"
  }
  
  tags = {
    Name="automate-sg"
  }
   
}


resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [ aws_security_group.my_security_group.name ]
    instance_type = var.aws_ec2_instance_type
    ami = var.aws_ubuntu_ami_id #ubuntu
    root_block_device {
      volume_size = var.aws_ec2_root_storage_size
      volume_type = "gp3"
    }
  tags = {
    Name="my-first-ec2-with-tf"
  }
}