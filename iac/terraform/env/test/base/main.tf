module "cognito" {
  source = "../../../modules/cognito"

  user_pool_name = local.user_pool_name
}
