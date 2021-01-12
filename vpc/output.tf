output "vpc-id" {
    description = "Id of the VPC"
    value = concat(aws_vpc.vpc.*.id, [""])[0]
}

output "public-subnet1-id" {
    description = "Public Subnet1 Id"
    value = aws_subnet.public-subnet-1.id
}

output "public-subnet2-id" {
    description = "Public Subnet2 Id"
    value = aws_subnet.public-subnet-2.id
}


output "private-subnet1-id" {
    description = "Private Subnet1 Id"
    value = aws_subnet.private-subnet-1.id
}

output "private-subnet2-id" {
    description = "Private Subnet2 Id"
    value = aws_subnet.private-subnet-2.id
}

output "eip" {
    value = aws_eip.elastic-ip-for-nat-gw.public_ip
}

