locals {
  application_name = "taskman"
  user_pool_name   = "${var.env}-${local.application_name}-user-pool"
}
