# dev environment secrets template
resource "vault_generic_secret" "web-client-dev" {
  path      = "workloads/${local.wl_name}/dev/web-client"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = <<EOT
{
  "secret_key": "dev env secret value placeholder"
}
EOT

  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

# staging environment secrets template
resource "vault_generic_secret" "web-client-sta" {
  path      = "workloads/${local.wl_name}/sta/web-client"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = <<EOT
{
  "secret_key": "sta env secret value placeholder"
}
EOT

  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

# prod environment secrets template
resource "vault_generic_secret" "web-client-prod" {
  path      = "workloads/${local.wl_name}/prod/web-client"
  # note: do not hardcode passwords in git under normal circumstances.
  data_json = <<EOT
{
  "secret_key": "prod env secret value placeholder"
}
EOT

  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}

