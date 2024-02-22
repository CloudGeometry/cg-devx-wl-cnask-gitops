resource "random_password" "postgresql_password_dev" {
  length      = 22
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "vault_generic_secret" "postgresql_dev" {
  path = "workloads/${local.wl_name}/dev/init_postgresql"

  data_json = jsonencode(
    {
      POSTGRES_DB       = local.api_db
      POSTGRES_USER     = local.api_db_username
      POSTGRES_PASSWORD = resource.random_password.postgresql_password_dev.result
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "random_password" "postgresql_password_sta" {
  length      = 22
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "vault_generic_secret" "postgresql_sta" {
  path = "workloads/${local.wl_name}/sta/init_postgresql"

  data_json = jsonencode(
    {
      POSTGRES_DB       = local.api_db
      POSTGRES_USER     = local.api_db_username
      POSTGRES_PASSWORD = resource.random_password.postgresql_password_sta.result
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

resource "vault_generic_secret" "postgresql_prod" {
  path = "workloads/${local.wl_name}/prod/init_postgresql"

  data_json = jsonencode(
    {
      POSTGRES_DB       = local.api_db
      POSTGRES_USER     = local.api_db_username
      POSTGRES_PASSWORD = local.rds_master_password
    }
  )
  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}