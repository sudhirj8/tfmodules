variable "region" {
    default = "us-east-1"
    description = "AWS Region"
}

variable "vpc_cidr" {
    description = "VPC CIDR BLOCK"
}

variable "vpc_name" {

}

variable "env" {

}
variable "appname" {
    
}
// Public subnets

variable "public_subnet_1_cidr" {
    description = "Public Subnet1 CIDR"
//    default = "10.0.0.0/24"
}

variable "public_subnet_2_cidr" {
    description = "Public Subnet2 CIDR"
 //   default = "10.0.1.0/24"
}

// Private subnets
variable "private_subnet_1_cidr" {
    description = "Private Subnet1 CIDR"
//    default = "10.0.4.0/24"
}

variable "private_subnet_2_cidr" {
    description = "Private Subnet2 CIDR"
  //  default = "10.0.5.0/24"
}






