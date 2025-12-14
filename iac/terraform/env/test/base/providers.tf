provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      Env             = var.env
      Owner           = var.owner
      ApplicationName = local.application_name
    }
  }
}
