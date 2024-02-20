data "terraform_remote_state" "infrastructure_configuration" {
  backend = "s3"

  config = {
    bucket = local.tf_backend_storage_name
    key    = "terraform/workloads/${local.wl_name}/hosting_provider/terraform.tfstate"
    region = local.region
  }
}
