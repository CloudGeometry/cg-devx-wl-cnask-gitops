resource "random_string" "random_suffix" {
  length  = 6
  lower   = true
  upper   = false
  special = false
}

# s3 buckets
module "s3_bucket_dev" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${local.wl_name}-dev-${random_string.random_suffix.id}"

  versioning = {
    enabled = true
  }

  attach_policy            = true
  policy                   = data.aws_iam_policy_document.allow_access_for_avatars_bucket_dev.json
  block_public_acls        = true
  block_public_policy      = false
  ignore_public_acls       = true
  restrict_public_buckets  = false
  control_object_ownership = false

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule = [
    {
      allowed_methods = ["PUT", "POST", "GET"]
      allowed_origins = ["https://dev-web-client.${local.wl_name}.${local.domain_name}", "https://dev-web-tenant-admin.${local.wl_name}.${local.domain_name}"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]

  tags = merge(local.tags, {
    Name        = "${local.wl_name}-dev",
    Environment = "dev"
  })
}

data "aws_iam_policy_document" "allow_access_for_avatars_bucket_dev" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.s3_bucket_dev.s3_bucket_arn}/files/*",
    ]
  }
  statement {
    principals {
      type        = "AWS"
      identifiers = [module.backend-dev-irsa.iam_role_arn]
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      module.s3_bucket_dev.s3_bucket_arn,
      "${module.s3_bucket_dev.s3_bucket_arn}/*",
    ]
  }
}

module "s3_bucket_sta" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${local.wl_name}-sta-${random_string.random_suffix.id}"

  versioning = {
    enabled = true
  }

  attach_policy            = true
  policy                   = data.aws_iam_policy_document.allow_access_for_avatars_bucket_sta.json
  block_public_acls        = true
  block_public_policy      = false
  ignore_public_acls       = true
  restrict_public_buckets  = false
  control_object_ownership = false

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule = [
    {
      allowed_methods = ["PUT", "POST", "GET"]
      allowed_origins = ["https://sta-web-client.${local.wl_name}.${local.domain_name}", "https://sta-web-tenant-admin.${local.wl_name}.${local.domain_name}"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]

  tags = merge(local.tags, {
    Name        = "${local.wl_name}-sta",
    Environment = "dsta"
  })
}

data "aws_iam_policy_document" "allow_access_for_avatars_bucket_sta" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.s3_bucket_sta.s3_bucket_arn}/files/*",
    ]
  }
  statement {
    principals {
      type        = "AWS"
      identifiers = [module.backend-sta-irsa.iam_role_arn]
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      module.s3_bucket_sta.s3_bucket_arn,
      "${module.s3_bucket_sta.s3_bucket_arn}/*",
    ]
  }
}

module "s3_bucket_prod" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${local.wl_name}-prod-${random_string.random_suffix.id}"

  versioning = {
    enabled = true
  }

  attach_policy            = true
  policy                   = data.aws_iam_policy_document.allow_access_for_avatars_bucket_prod.json
  block_public_acls        = true
  block_public_policy      = false
  ignore_public_acls       = true
  restrict_public_buckets  = false
  control_object_ownership = false

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule = [
    {
      allowed_methods = ["PUT", "POST", "GET"]
      allowed_origins = ["https://web-client.${local.wl_name}.${local.domain_name}", "https://web-tenant-admin.${local.wl_name}.${local.domain_name}"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]

  tags = merge(local.tags, {
    Name        = "${local.wl_name}-prod",
    Environment = "prod"
  })
}

data "aws_iam_policy_document" "allow_access_for_avatars_bucket_prod" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${module.s3_bucket_prod.s3_bucket_arn}/files/*",
    ]
  }
  statement {
    principals {
      type        = "AWS"
      identifiers = [module.backend-prod-irsa.iam_role_arn]
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      module.s3_bucket_prod.s3_bucket_arn,
      "${module.s3_bucket_prod.s3_bucket_arn}/*",
    ]
  }
}

output "s3_dev" {
  value       = module.s3_bucket_dev.s3_bucket_id
  description = "s3 dev bucket name"
}

output "s3_sta" {
  value       = module.s3_bucket_sta.s3_bucket_id
  description = "s3 sta bucket name"
}

output "s3_prod" {
  value       = module.s3_bucket_prod.s3_bucket_id
  description = "s3 prod bucket name"
}
