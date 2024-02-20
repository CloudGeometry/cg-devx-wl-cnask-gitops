terraform {
  # Remote backend configuration
  # <TF_WL_HOSTING_REMOTE_BACKEND>
}

# Cloud Provider configuration
# <TF_HOSTING_PROVIDER>

locals {
  region                       = "<CLOUD_REGION>"
  wl_name                      = "<WL_NAME>"
  domain_name                  = "<DOMAIN_NAME>"
  cluster_name                 = "<CLUSTER_NAME>"
  owner_email                  = "<OWNER_EMAIL>"
  api_db                       = "demodb"
  api_db_username              = "demoadmin"
  api_tenant_db                = "cd_devx_tenant"
  api_tenant_db_username       = "demoadmin"
  tags = {
    Workload   = "<WL_NAME>"
    ProvisionedBy = "CGDevX"
  }
}
