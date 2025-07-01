variable "aws_region" {
  description = "Value of the aws region"
  type        = string
  default     = "us-east-1"
}

variable "aws_availability_zone_1a" {
    description = "Availability zone"
    default = "us-east-1a"
  
}

variable "aws_availability_zone_1b" {
    description = "Availability zone"
    default = "us-east-1b"
  
}

variable "aws_availability_zone_1c" {
    description = "Availability zone"
    default = "us-east-1c"
  
}

variable "cidr_public_subnet" {
    description = "Public subnet CIDR"
    default = "10.0.1.0/24"
  
}

variable "cidr_public_subnet_2" {
    description = "Public subnet CIDR"
    default = "10.0.2.0/24"
  
}
variable "cidr_private_subnet" {
    description = "Private subnet CIDR"
    default = "10.0.3.0/24"
  
}

variable "ec2_instance_type" {
    description = "AWS Instance Type"
    default = "t3.medium"
  
}

variable "aws_key" {
    description = "Pem key for SSH"
    default = "webserver.key"
  
}
