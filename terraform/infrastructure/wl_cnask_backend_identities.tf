module "backend-dev-irsa" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "${local.cluster_name}-${local.wl_name}-backend-dev-role"

  role_policy_arns = {
    policy = aws_iam_policy.backend-dev.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = "<CLUSTER_OIDC_PROVIDER_ARN>"
      namespace_service_accounts = [
        "wl-${local.wl_name}-dev:api",
        "wl-${local.wl_name}-dev:api-tenant"
      ]
    }
  }
}

module "backend-sta-irsa" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "${local.cluster_name}-${local.wl_name}-backend-sta-role"

  role_policy_arns = {
    policy = aws_iam_policy.backend-sta.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = "<CLUSTER_OIDC_PROVIDER_ARN>"
      namespace_service_accounts = [
        "wl-${local.wl_name}-sta:api",
        "wl-${local.wl_name}-sta:api-tenant"
      ]
    }
  }
}

module "backend-prod-irsa" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "${local.cluster_name}-${local.wl_name}-backend-prod-role"

  role_policy_arns = {
    policy = aws_iam_policy.backend-prod.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = "<CLUSTER_OIDC_PROVIDER_ARN>"
      namespace_service_accounts = [
        "wl-${local.wl_name}-prod:api",
        "wl-${local.wl_name}-prod:api-tenant"
      ]
    }
  }
}

resource "aws_iam_policy" "backend-dev" {
  name        = "${local.cluster_name}-${local.wl_name}-backend-dev-policy"
  description = "${local.cluster_name}-${local.wl_name}-backend-dev IAM policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement":[
        {
          "Effect":"Allow",
          "Action": "s3:ListAllMyBuckets",
          "Resource":"*"
        },
        {
          "Effect":"Allow",
          "Action":["s3:ListBucket","s3:GetBucketLocation"],
          "Resource":module.s3_bucket_dev.s3_bucket_arn
        },
        {
          "Effect":"Allow",
          "Action":[
              "s3:PutObject",
              "s3:PutObjectAcl",
              "s3:GetObject",
              "s3:GetObjectAcl",
              "s3:DeleteObject"
          ],
          "Resource":"${module.s3_bucket_dev.s3_bucket_arn}/*"
        },
        {
          "Effect":"Allow",
          "Action":[
            "ses:SendEmail",
            "ses:SendRawEmail"
          ],
          "Resource":"*"
        }
    ]
  })
}

resource "aws_iam_policy" "backend-sta" {
  name        = "${local.cluster_name}-${local.wl_name}-backend-sta-policy"
  description = "${local.cluster_name}-${local.wl_name}-sta IAM policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement":[
        {
          "Effect":"Allow",
          "Action": "s3:ListAllMyBuckets",
          "Resource":"*"
        },
        {
          "Effect":"Allow",
          "Action":["s3:ListBucket","s3:GetBucketLocation"],
          "Resource":module.s3_bucket_sta.s3_bucket_arn
        },
        {
          "Effect":"Allow",
          "Action":[
              "s3:PutObject",
              "s3:PutObjectAcl",
              "s3:GetObject",
              "s3:GetObjectAcl",
              "s3:DeleteObject"
          ],
          "Resource":"${module.s3_bucket_sta.s3_bucket_arn}/*"
        },
        {
          "Effect":"Allow",
          "Action":[
            "ses:SendEmail",
            "ses:SendRawEmail"
          ],
          "Resource":"*"
        }
    ]
  })
}

resource "aws_iam_policy" "backend-prod" {
  name        = "${local.cluster_name}-${local.wl_name}-backend-prod-policy"
  description = "${local.cluster_name}-${local.wl_name}-backend-prod IAM policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement":[
        {
          "Effect":"Allow",
          "Action": "s3:ListAllMyBuckets",
          "Resource":"*"
        },
        {
          "Effect":"Allow",
          "Action":["s3:ListBucket","s3:GetBucketLocation"],
          "Resource":module.s3_bucket_prod.s3_bucket_arn
        },
        {
          "Effect":"Allow",
          "Action":[
              "s3:PutObject",
              "s3:PutObjectAcl",
              "s3:GetObject",
              "s3:GetObjectAcl",
              "s3:DeleteObject"
          ],
          "Resource":"${module.s3_bucket_prod.s3_bucket_arn}/*"
        },
        {
          "Effect":"Allow",
          "Action":[
            "ses:SendEmail",
            "ses:SendRawEmail"
          ],
          "Resource":"*"
        }
    ]
  })
}