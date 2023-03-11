variable "project_id" {
  type = string
}
variable "location" {
  type = string
}
variable "query" {
  type  = string
  value = "SELECT 1"
}
variable "access_token" {
  type      = string
  sensitive = true
}

data "external" "docker_bq_proxy" {
  program = ["docker", "run", "--pull=always", "--rm", "-i", "gfncis/tf-bq-proxy:latest"]
  query   = {
    access_token = var.access_token
    project_id      = var.project_id
    location        = var.location
    query           = var.query
  }
}
output "result" {
  value = jsondecode(jsondecode(data.external.docker_bq_proxy.result.result))
}

