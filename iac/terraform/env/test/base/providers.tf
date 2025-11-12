provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      Env             = var.prefix
      Owner           = var.owner
      ApplicationName = "taskman"
    }
  }
}
