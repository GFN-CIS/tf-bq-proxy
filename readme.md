# Terraform-BigQuery Proxy

The purpose of this module is to execute queries in BigQuery using Terraform.

This can be useful for running stored procedures during the apply phase, or to dynamically generate the BigQuery schema basing on values from some tables.

Usage example:
```terraform
# setup appropriate credentials 
data "google_service_account" "impersonatee" {
  account_id = "service_account@project.iam.gserviceaccount.com"
}
resource "google_service_account_iam_member" "impersonatee-iam" {
  service_account_id = data.google_service_account.impersonatee.id
  role               = "roles/iam.serviceAccountTokenCreator"

  member = "your@email.com"
}
# obtain access token with appropriate scopes
data "google_service_account_access_token" "impersonatee" {
  target_service_account = data.google_service_account.impersonatee.id
  scopes                 = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/drive",
  ]
}
# perform query
module "bq_users" {
  source       = "git::https://github.com/GFN-CIS/tf-bq-proxy.git//tf-module"
  project_id   = var.project_id
  location     = var.location
  access_token = data.google_service_account_access_token.impersonatee.access_token
  query        = "SELECT users from datasets.users"

}

output "debug" {
  value = module.bq_proxy.result
}
```
