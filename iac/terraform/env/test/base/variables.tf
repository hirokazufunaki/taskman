variable "aws_profile" {
  description = "AWSプロファイル"
  type = string
}

variable "aws_region" {
  description = "AWSリージョン"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
  default     = "test"

  validation {
    condition     = contains(["test", "stag", "prod"], var.env)
    error_message = "envは test, stag, prod のいずれかである必要があります。"
  }
}

variable "application_name" {
  description = "アプリケーション名"
  type = string
}

variable "owner" {
  description = "AWSユーザーID"
  type = string
}
