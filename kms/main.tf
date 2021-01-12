resource "aws_kms_key" "rdskmskey1" {
    description = "kms key for rds"
    deletion_window_in_days = 7
         tags = {
        Name = "RDS-KMS-KEY"
                env = var.env
                appname = var.appname
    } 
}

resource "aws_kms_alias" "alias" {
  name          = "alias/rds-key-alias"
  target_key_id = aws_kms_key.rdskmskey1.key_id
}

