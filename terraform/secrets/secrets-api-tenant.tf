# dev environment secrets template
resource "vault_generic_secret" "api-tenant-dev" {
  path      = "workloads/${local.wl_name}/dev/api-tenant"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = jsonencode(
    {
      APP_DEFAULT_SCHEMA = local.api_db_default_schema,
      APP_GRAPHQL_URL = "https://dev-web-client.${local.wl_name}.${local.domain_name}/api/graphql",
      DATABASE_URL = "postgresql://${local.api_tenant_db_username}:${resource.random_password.postgresql_password_dev.result}@${local.default_db_host}:5432/${local.api_tenant_db}?schema=${local.api_tenant_db_default_schema}&sslmode=prefer",
      DB_DEFAULT_SCHEMA = local.api_tenant_db_default_schema,
      DB_HOST = local.default_db_host,
      DB_PORT = 5432,
      EMAIL_CONFIRMATION_URL = "https://dev-web-tenant-admin.${local.wl_name}.${local.domain_name}/confirm-email",
      EMAIL_PASSWORD = "",
      EMAIL_SENDER = "cg-devx-no-reply@${local.domain_name}",
      INIT_ADMIN_PASSWORD = resource.random_password.tenant_init_admin_dev.result,
      JWT_ACCESS_SECRET = resource.random_password.tenant_jwt_access_dev.result,
      JWT_REFRESH_SECRET = resource.random_password.tenant_jwt_refresh_dev.result,
      JWT_VERIFICATION_TOKEN_EXPIRATION_TIME = 604800,
      JWT_VERIFICATION_TOKEN_SECRET = resource.random_password.tenant_jwt_verification_dev.result,
      PORT = 3000,
      POSTGRES_DEFAULT_DB = local.api_tenant_db,
      POSTGRES_PASSWORD = resource.random_password.postgresql_password_dev.result,
      POSTGRES_USER = local.api_tenant_db_username,
      secret_key = "dev env secret value placeholder"
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "random_password" "tenant_jwt_access_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_jwt_refresh_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_jwt_verification_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_init_admin_dev" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

# staging environment secrets template
resource "vault_generic_secret" "api-tenant-sta" {
  path      = "workloads/${local.wl_name}/sta/api-tenant"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = jsonencode(
    {
      APP_DEFAULT_SCHEMA = local.api_db_default_schema,
      APP_GRAPHQL_URL = "https://sta-web-client.${local.wl_name}.${local.domain_name}/api/graphql",
      DATABASE_URL = "postgresql://${local.api_tenant_db_username}:${resource.random_password.postgresql_password_sta.result}@${local.default_db_host}:5432/${local.api_tenant_db}?schema=${local.api_tenant_db_default_schema}&sslmode=prefer",
      DB_DEFAULT_SCHEMA = local.api_tenant_db_default_schema,
      DB_HOST = local.default_db_host,
      DB_PORT = 5432,
      EMAIL_CONFIRMATION_URL = "https://sta-web-tenant-admin.${local.wl_name}.${local.domain_name}/confirm-email",
      EMAIL_PASSWORD = "",
      EMAIL_SENDER = "cg-devx-no-reply@${local.domain_name}",
      INIT_ADMIN_PASSWORD = resource.random_password.tenant_init_admin_sta.result,
      JWT_ACCESS_SECRET = resource.random_password.tenant_jwt_access_sta.result,
      JWT_REFRESH_SECRET = resource.random_password.tenant_jwt_refresh_sta.result,
      JWT_VERIFICATION_TOKEN_EXPIRATION_TIME = 604800,
      JWT_VERIFICATION_TOKEN_SECRET = resource.random_password.tenant_jwt_verification_sta.result,
      PORT = 3000,
      POSTGRES_DEFAULT_DB = local.api_tenant_db,
      POSTGRES_PASSWORD = resource.random_password.postgresql_password_sta.result,
      POSTGRES_USER = local.api_tenant_db_username,
      secret_key = "sta env secret value placeholder"
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "random_password" "tenant_jwt_access_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_jwt_refresh_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_jwt_verification_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_init_admin_sta" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}


# prod environment secrets template
resource "vault_generic_secret" "api-tenant-prod" {
  path      = "workloads/${local.wl_name}/prod/api-tenant"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = jsonencode(
    {
      APP_DEFAULT_SCHEMA = local.api_db_default_schema,
      APP_GRAPHQL_URL = "https://web-client.${local.wl_name}.${local.domain_name}/api/graphql",
      DATABASE_URL = "postgresql://${local.api_tenant_db_username}:${local.rds_master_password}@${local.rds_db_endpoint}:5432/${local.api_tenant_db}?schema=${local.api_tenant_db_default_schema}&sslmode=prefer",
      DB_DEFAULT_SCHEMA = local.api_tenant_db_default_schema,
      DB_HOST = local.rds_db_endpoint,
      DB_PORT = 5432,
      EMAIL_CONFIRMATION_URL = "https://web-tenant-admin.${local.wl_name}.${local.domain_name}/confirm-email",
      EMAIL_PASSWORD = "",
      EMAIL_SENDER = "cg-devx-no-reply@${local.domain_name}",
      INIT_ADMIN_PASSWORD = resource.random_password.tenant_init_admin_prod.result,
      JWT_ACCESS_SECRET = resource.random_password.tenant_jwt_access_prod.result,
      JWT_REFRESH_SECRET = resource.random_password.tenant_jwt_refresh_prod.result,
      JWT_VERIFICATION_TOKEN_EXPIRATION_TIME = 604800,
      JWT_VERIFICATION_TOKEN_SECRET = resource.random_password.tenant_jwt_verification_prod.result,
      PORT = 3000,
      POSTGRES_DEFAULT_DB = local.api_tenant_db,
      POSTGRES_PASSWORD = local.rds_master_password,
      POSTGRES_USER = local.api_tenant_db_username,
      secret_key = "prod env secret value placeholder"
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "random_password" "tenant_jwt_access_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_jwt_refresh_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_jwt_verification_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "random_password" "tenant_init_admin_prod" {
  length      = 10
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}