# Create AWS Secret for RDS credential

## This will create a secret for RDS database
* set the database credentials as environment variable before running Terraform using command line
* recovery_window_in_days is default value (30 days), i.e. not set in the resource 
* kms key is default ( default CMK aws/secretmanager), ie. not set in the resource

## pending --
 rotation
 name the resource as secrets-rdscred

## example usage

    * export TF_VAR_dbcred='{db_user = "dbadmin", db_password = "dbadminpassword"}'
