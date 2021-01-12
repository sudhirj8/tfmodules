
resource aws_key_pair aws_key_pair {
     key_name = "ec2keypair2"
     public_key = file("mykey1.pem.pub")
 }

resource aws_instance myec2 {
  ami = "ami-0be2609ba883822ec"
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.ec2sg-id]
  subnet_id = var.subnet-id
  key_name = aws_key_pair.aws_key_pair.key_name
  tags = {
    name = "rds_client"
      env = var.env
      appname = var.appname
  }
}

