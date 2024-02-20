module "frontend-irsa" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "${local.cluster_name}-${local.wl_name}-frontend-role"

  role_policy_arns = {
    policy = aws_iam_policy.frontend.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = "<CLUSTER_OIDC_PROVIDER_ARN>"
      namespace_service_accounts = [
        "wl-${local.wl_name}-dev:web-client",
        "wl-${local.wl_name}-sta:web-client",
        "wl-${local.wl_name}-prod:web-client",
        "wl-${local.wl_name}-dev:web-tenant-admin",
        "wl-${local.wl_name}-sta:web-tenant-admin",
        "wl-${local.wl_name}-prod:web-tenant-admin"
      ]
    }
  }
}

resource "aws_iam_policy" "frontend" {
  name        = "${local.cluster_name}-${local.wl_name}-frontend-policy"
  description = "${local.cluster_name}-${local.wl_name}-frontend IAM policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "EmptyPolicy",
        "Effect" : "Allow",
        "Action" : "none:null",
        "Resource" : "*"
      }
    ]
  })
}