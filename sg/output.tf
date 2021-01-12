output "ec2sg" {
    value = aws_security_group.ec2sg.id
}

output "rdsmysqlsg" {
    value = aws_security_group.rdsmysqlsg.id
}


