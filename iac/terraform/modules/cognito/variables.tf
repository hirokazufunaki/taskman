variable "aws_region" {
  description = "AWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "user_pool_name" {
  description = "Cognito User Pool名"
  type        = string
  default     = "admin-only-user-pool"
}

variable "env" {
  description = "環境名"
  type        = string
  default     = "production"

  validation {
    condition     = contains(["development", "staging", "production"], var.env)
    error_message = "environmentは development, staging, production のいずれかである必要があります。"
  }
}

variable "mfa_configuration" {
  description = "MFA設定 (OFF, OPTIONAL, ON)"
  type        = string
  default     = "OPTIONAL"

  validation {
    condition     = contains(["OFF", "OPTIONAL", "ON"], var.mfa_configuration)
    error_message = "mfa_configurationは OFF, OPTIONAL, ON のいずれかである必要があります。"
  }
}
