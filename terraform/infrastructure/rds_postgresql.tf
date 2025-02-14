module "db_postgresql" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${local.wl_name}-${local.api_db}"

  engine            = "postgres"
  engine_version    = "15.10"
  instance_class    = "db.t3.small"
  allocated_storage = 5
  storage_encrypted = true
  auto_minor_version_upgrade  = false
  manage_master_user_password = false
  password = resource.random_password.postgresql_password.result

  db_name  = local.api_db # DBName must begin with a letter and contain only alphanumeric characters
  username = local.api_db_username
  port     = "5432"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.postgresql_security_group.security_group_id]

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = [data.aws_subnet.intra_subnet_1a.id, data.aws_subnet.intra_subnet_1b.id, data.aws_subnet.intra_subnet_1c.id]

  # DB parameter group
  family = "postgres15"

  # DB option group
  major_engine_version = "15"

  # Database Deletion Protection
  deletion_protection = false

  tags = {
    Environment = "prod"
  }
}

module "postgresql_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/postgresql"
  version = "~> 5.0"

  name        = "postgresql_security_group"
  description = "Security group for postgresql with TCP port open within VPC"
  vpc_id      = data.aws_vpc.current_vpc.id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = data.aws_security_group.cluster_additional_sg.id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}


resource "random_password" "postgresql_password" {
  length      = 22
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

output "rds_master_password" {
  value       = resource.random_password.postgresql_password.result
  description = "rds master password"
  sensitive   = true
}

output "rds_db_endpoint" {
  value       = module.db_postgresql.db_instance_address
  description = "rds db endpoint"
}

