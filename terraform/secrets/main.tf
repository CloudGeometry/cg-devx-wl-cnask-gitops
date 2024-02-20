terraform {
  # Remote backend configuration
  # <TF_WL_SECRETS_REMOTE_BACKEND>

  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
  }
}

# Vault configuration
provider "vault" {
}

locals {
  region                       = "<CLOUD_REGION>"
  wl_name                      = "<WL_NAME>"
  domain_name                  = "<DOMAIN_NAME>"
  cluster_name                 = "<PRIMARY_CLUSTER_NAME>"
  owner_email                  = "<OWNER_EMAIL>"
  tf_backend_storage_name      = "<TF_BACKEND_STORAGE_NAME>" ###+ check
  default_db_host              = "postgres"
  api_db                       = "demodb"
  api_db_default_schema        = "cg_devx_cnask"
  api_db_username              = "demoadmin"
  api_tenant_db                = "cd_devx_tenant"
  api_tenant_db_default_schema = "cd_devx_tenant"
  api_tenant_db_username       = "demoadmin"
}