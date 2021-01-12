

resource "aws_db_subnet_group" "subnetgrp" {
    name = "dbsubnetgrp"
    subnet_ids = [var.private-subnet1-id, var.private-subnet2-id]
}



resource "aws_db_instance" "default" {
  identifier            = "testdb"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.medium"
  name                 = "mydb"

//  username             = jsondecode(aws_secretsmanager_secret_version.RdsAminCred.secret_string)["username"]
//  password             = jsondecode(aws_secretsmanager_secret_version.RdsAminCred.secret_string)["password"]

  //username             = "dbadmin"
  //password             = "dbadmin#01avia"

    username    = var.username
    password    = var.password

  //password             = aws_secretsmanager_secret_version.RdsAdminPwd.
  parameter_group_name = "default.mysql5.7"

  final_snapshot_identifier = "testdbfinalsnapshot"
  snapshot_identifier = null
  skip_final_snapshot = false

  storage_encrypted = true
  kms_key_id = var.rdskeyarn
 // kms_key_id = aws_kms_key.rdskmskey1.arn

  enabled_cloudwatch_logs_exports = [ "audit", "error", "general" , "slowquery"]

  backup_retention_period = 2
  db_subnet_group_name = aws_db_subnet_group.subnetgrp.name
//  vpc_security_group_ids = [aws_security_group.rdssg.id]
vpc_security_group_ids = [var.rdssgid]

  tags = {
   env ="dev"
    appname = "app1"
  }
 

}

resource "aws_sns_topic" "sns_rds" {
  name = "rds-events"
    tags = {
   env ="dev"
    appname = "app1"
  }
}

resource "aws_db_event_subscription" "rds_events_sub" {
  name      = "rds-event-sub"
  sns_topic = aws_sns_topic.sns_rds.arn

  source_type = "db-instance"
  source_ids  = [aws_db_instance.default.id]

  event_categories = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
    tags = {
   env ="dev"
    appname = "app1"
  }
}