variable "project_id" {
  type = string
}
variable "location" {
  type = string
}
variable "query" {
  type = string
}
variable "service_account_json_contents" {
  type      = string
  sensitive = true
}
data "external" "docker_bq_proxy" {
  program = ["python3", "~/PycharmProjects/tf-bq-proxy/main.py"]
  query   = {
    service_account = var.service_account_json_contents
    project_id      = var.project_id
    location        = var.location
    query           = var.query
  }
}
output "result" {
  value = jsondecode(jsondecode(data.external.docker_bq_proxy.result.result))
}
