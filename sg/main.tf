resource "aws_security_group" "ec2sg" {
    name = "ec2sg"
    vpc_id =  var.vpc-id

    # ingress {
    #     from_port = 80
    #     to_port = 80
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }
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

    tags = {
      env = var.env
      appname = var.appname
    }
}

resource "aws_security_group" "rdsmysqlsg" {
    name = "rdsmysqlsg"
    vpc_id =  var.vpc-id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.ec2sg.id]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
   tags = {
      env = var.env
      appname = var.appname
    }
}
