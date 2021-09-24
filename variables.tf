variable "region" {
  default = "us-east-1"
}

variable "availability_zones" {
  default = [
    "us-east-1a",
  ]
}

variable "public_subnet_cidr" {
  default = "10.0.101.0/26"
}

variable "vpc_cidr" {
  default = "10.0.101.0/25"
}

variable "app_name" {
  default = "hello-universe"
}

variable "app_port" {
  default = "1323"
}

variable "ubuntu_ami" {
  default = "ami-09e67e426f25ce0d7"
}

variable "instance_type" {
  default = "t2.micro"
}
