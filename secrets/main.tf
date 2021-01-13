# variable "RdsAminCred" {
#     default = {
#         username = "dbadmin1"
#         password = "dbadmin#03avia"
#         //password = var.dbpassword
 
#     }
#     type = map(string)
# }


resource "aws_secretsmanager_secret" "RdsAminCred" {
  name = "${var.appname}-${var.env}-RdsAminCred"
  tags = {
            Name = "RDS-Cred"
                env = var.env
                appname = var.appname
  }
}
resource "aws_secretsmanager_secret_version" "RdsAminCred" {
  secret_id     = aws_secretsmanager_secret.RdsAminCred.id
  secret_string = jsonencode(var.db_cred)
}