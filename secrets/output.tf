
output "username" {
       value = jsondecode(aws_secretsmanager_secret_version.RdsAminCred.secret_string)["db_user"]
}

output "password" {
    value = jsondecode(aws_secretsmanager_secret_version.RdsAminCred.secret_string)["db_password"]
}

output "dbcred" {
    value = var.db_cred
}
//username             = jsondecode(aws_secretsmanager_secret_version.RdsAminCred.secret_string)["username"]
 // password             = jsondecode(aws_secretsmanager_secret_version.RdsAminCred.secret_string)["password"]
