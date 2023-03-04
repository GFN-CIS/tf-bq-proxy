# Terraform-BigQuery Proxy

The purpose of this module is to execute queries in BigQuery using Terraform.

This can be useful for running stored procedures during the apply phase, or to dynamically generate the BigQuery schema basing on values from some tables.

Usage example:
```terraform
module "bq_users" {
  source                        = "git::git@github.com:GFN-CIS/tf-bq-proxy.git//tf-module"
  project_id                    = var.project_id
  location                      = var.location
  service_account_json_contents = file(var.credentials)
  query                         = "SELECT users from datasets.users"

}

output "debug" {
  value = module.bq_proxy.result
}
```
