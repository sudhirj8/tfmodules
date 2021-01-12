# provider "aws" {
#     region = var.region
# }

# terraform {
#   backend "s3"  {}
# }

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
        env = var.env
                        appname = var.appname
    }
}

// Public Subnets
resource "aws_subnet" "public-subnet-1" {
    cidr_block = var.public_subnet_1_cidr
    vpc_id = aws_vpc.vpc.id
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet-1"
                env = var.env
                appname = var.appname
    }
}

resource "aws_subnet" "public-subnet-2" {
    cidr_block = var.public_subnet_2_cidr
    vpc_id = aws_vpc.vpc.id
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet-2"
        env = var.env
                appname = var.appname
    }
}


// Private Subnets
resource "aws_subnet" "private-subnet-1" {
    cidr_block = var.private_subnet_1_cidr
    vpc_id = aws_vpc.vpc.id
    availability_zone = "us-east-1a"
    tags = {
        Name = "Private-Subnet-1"
        env = var.env
                appname = var.appname
    }
}

resource "aws_subnet" "private-subnet-2" {
    cidr_block = var.private_subnet_2_cidr
    vpc_id = aws_vpc.vpc.id
    availability_zone = "us-east-1b"
    tags = {
        Name = "Private-Subnet-2"
                env = var.env
                appname = var.appname
    }
}

// Route tables
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.vpc.id
     tags = {
        Name = "Public-Route-Table"
                env = var.env
                appname = var.appname
    }  
}


resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.vpc.id
     tags = {
        Name = "Private-Route-Table"
                env = var.env
                appname = var.appname
    }  
}

// Public Route table associations

resource "aws_route_table_association" "public-subnet-1-association" {
    route_table_id = aws_route_table.public-route-table.id
    subnet_id= aws_subnet.public-subnet-1.id


}

resource "aws_route_table_association" "public-subnet-2-association" {
    route_table_id = aws_route_table.public-route-table.id
    subnet_id= aws_subnet.public-subnet-2.id

}

// Private Route table associations

resource "aws_route_table_association" "private-subnet-1-association" {
    route_table_id = aws_route_table.private-route-table.id
    subnet_id= aws_subnet.private-subnet-1.id


}

resource "aws_route_table_association" "private-subnet-2-association" {
     route_table_id = aws_route_table.private-route-table.id
     subnet_id= aws_subnet.private-subnet-2.id
 }


// IGW

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "igw"
                env = var.env
                appname = var.appname
    }
}

resource "aws_route" "public-internet-gw-route" {
    route_table_id = aws_route_table.public-route-table.id
    gateway_id = aws_internet_gateway.igw.id
    destination_cidr_block = "0.0.0.0/0"


}


// NAT Gateway (IGW needs to be created before NAT Gateway,else NAT fails)

resource "aws_eip" "elastic-ip-for-nat-gw" {
    vpc = true
    associate_with_private_ip = "10.0.0.5"

}


resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.elastic-ip-for-nat-gw.id
    subnet_id = aws_subnet.public-subnet-1.id
    tags = {
        Name = "NAT-GW"
                env = var.env
                appname = var.appname
    }
    depends_on = [aws_eip.elastic-ip-for-nat-gw]

}

resource "aws_route" "nat-gw-route" {
    route_table_id = aws_route_table.private-route-table.id
    nat_gateway_id = aws_nat_gateway.nat-gw.id
    destination_cidr_block = "0.0.0.0/0"
 

}

