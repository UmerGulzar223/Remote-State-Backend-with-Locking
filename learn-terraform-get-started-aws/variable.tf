variable "aws_ec2_instance_type" {
    default = "t2.micro"
    type = string
}

variable "aws_ec2_root_storage_size" {
    default = 15
    type = number
}

variable "aws_ubuntu_ami_id" {
    default = "ami-0f918f7e67a3323f0"
    type = string
}

