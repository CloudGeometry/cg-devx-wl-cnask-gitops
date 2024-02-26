locals {
  rds_db_endpoint     = data.terraform_remote_state.infrastructure_configuration.outputs.rds_db_endpoint
  rds_master_password = data.terraform_remote_state.infrastructure_configuration.outputs.rds_master_password
}

# dev environment secrets template
resource "vault_generic_secret" "api-dev" {
  path      = "workloads/${local.wl_name}/dev/api"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = jsonencode(
    {
      AWS_REGION = local.region,
      AWS_S3_FILES_FOLDER = "files",
      AWS_S3_IMAGES_BUCKET = data.terraform_remote_state.infrastructure_configuration.outputs.s3_dev,
      BASE_FQDN = "dev-web-client.${local.wl_name}.${local.domain_name}",
      DATABASE_URL = "postgresql://${local.api_db_username}:${resource.random_password.postgresql_password_dev.result}@${local.default_db_host}:5432/${local.api_db}?schema=${local.api_db_default_schema}&sslmode=prefer",
      DB_DEFAULT_SCHEMA = local.api_db_default_schema,
      DB_HOST = local.default_db_host,
      DB_PORT = 5432,
      EMAIL_CONFIRMATION_URL = "https://dev-web-client.${local.wl_name}.${local.domain_name}/confirm-invite",
      EMAIL_PASSWORD = "",
      EMAIL_SENDER = "cg-devx-no-reply@${local.domain_name}",
      INIT_ADMIN_PASSWORD = resource.random_password.init_admin_dev.result,
      JWT_ACCESS_SECRET = resource.random_password.jwt_access_dev.result,
      JWT_REFRESH_SECRET = resource.random_password.jwt_refresh_dev.result,
      JWT_VERIFICATION_TOKEN_EXPIRATION_TIME = 604800,
      JWT_VERIFICATION_TOKEN_SECRET = resource.random_password.jwt_verification_dev.result,
      PORT = 3000,
      POSTGRES_DEFAULT_DB = local.api_db,
      POSTGRES_PASSWORD = resource.random_password.postgresql_password_dev.result,
      POSTGRES_USER = local.api_db_username,
      secret_key = "dev env secret value placeholder"
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "random_password" "jwt_access_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "jwt_refresh_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "jwt_verification_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "init_admin_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

# staging environment secrets template
resource "vault_generic_secret" "api-sta" {
  path      = "workloads/${local.wl_name}/sta/api"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = jsonencode(
    {
      AWS_REGION = local.region,
      AWS_S3_FILES_FOLDER = "files",
      AWS_S3_IMAGES_BUCKET = data.terraform_remote_state.infrastructure_configuration.outputs.s3_sta,
      BASE_FQDN = "sta-web-client.${local.wl_name}.${local.domain_name}",
      DATABASE_URL = "postgresql://${local.api_db_username}:${resource.random_password.postgresql_password_sta.result}@${local.default_db_host}:5432/${local.api_db}?schema=${local.api_db_default_schema}&sslmode=prefer",
      DB_DEFAULT_SCHEMA = local.api_db_default_schema,
      DB_HOST = local.default_db_host,
      DB_PORT = 5432,
      EMAIL_CONFIRMATION_URL = "https://sta-web-client.${local.wl_name}.${local.domain_name}/confirm-invite",
      EMAIL_PASSWORD = "",
      EMAIL_SENDER = "cg-devx-no-reply@${local.domain_name}",
      INIT_ADMIN_PASSWORD = resource.random_password.init_admin_sta.result,
      JWT_ACCESS_SECRET = resource.random_password.jwt_access_sta.result,
      JWT_REFRESH_SECRET = resource.random_password.jwt_refresh_sta.result,
      JWT_VERIFICATION_TOKEN_EXPIRATION_TIME = 604800,
      JWT_VERIFICATION_TOKEN_SECRET = resource.random_password.jwt_verification_prod.result,
      PORT = 3000,
      POSTGRES_DEFAULT_DB = local.api_db,
      POSTGRES_PASSWORD = resource.random_password.postgresql_password_sta.result,
      POSTGRES_USER = local.api_db_username,
      secret_key = "sta env secret value placeholder"
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "random_password" "jwt_access_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "jwt_refresh_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "jwt_verification_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "init_admin_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

# prod environment secrets template
resource "vault_generic_secret" "api-prod" {
  path      = "workloads/${local.wl_name}/prod/api"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = jsonencode(
    {
      AWS_REGION = local.region,
      AWS_S3_FILES_FOLDER = "files",
      AWS_S3_IMAGES_BUCKET = data.terraform_remote_state.infrastructure_configuration.outputs.s3_prod,
      BASE_FQDN = "web-client.${local.wl_name}.${local.domain_name}",
      DATABASE_URL = "postgresql://${local.api_db_username}:${local.rds_master_password}@${local.rds_db_endpoint}:5432/${local.api_db}?schema=${local.api_db_default_schema}&sslmode=prefer",
      DB_DEFAULT_SCHEMA = local.api_db_default_schema,
      DB_HOST = local.rds_db_endpoint,
      DB_PORT = 5432,
      EMAIL_CONFIRMATION_URL = "https://web-client.${local.wl_name}.${local.domain_name}/confirm-invite",
      EMAIL_PASSWORD = "",
      EMAIL_SENDER = "cg-devx-no-reply@${local.domain_name}",
      INIT_ADMIN_PASSWORD = resource.random_password.init_admin_prod.result,
      JWT_ACCESS_SECRET = resource.random_password.jwt_access_prod.result,
      JWT_REFRESH_SECRET = resource.random_password.jwt_refresh_prod.result,
      JWT_VERIFICATION_TOKEN_EXPIRATION_TIME = 604800,
      JWT_VERIFICATION_TOKEN_SECRET = resource.random_password.jwt_verification_prod.result,
      PORT = 3000,
      POSTGRES_DEFAULT_DB = local.api_db,
      POSTGRES_PASSWORD = local.rds_master_password,
      POSTGRES_USER = local.api_db_username,
      secret_key = "prod env secret value placeholder"
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "random_password" "jwt_access_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "jwt_refresh_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "jwt_verification_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "init_admin_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}