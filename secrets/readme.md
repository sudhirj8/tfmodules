# Create AWS Secret

This will create a secret
set the database credentials as environment variable before running Terraform plan

example

    export TF_VAR_dbcred='{db_user = "dbadmin2", db_password = "dbadmin#04avia"}'
