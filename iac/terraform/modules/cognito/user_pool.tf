resource "aws_cognito_user_pool" "main" {
  name = var.user_pool_name

  # ユーザー名属性: emailをユーザー名として使用
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  username_configuration {
    case_sensitive = false  # 大文字小文字を区別しない（推奨）
  }

  # パスワードポリシー（強力な設定）
  password_policy {
    minimum_length                   = 12     # 最小12文字
    require_lowercase                = true   # 小文字必須
    require_uppercase                = true   # 大文字必須
    require_numbers                  = true   # 数字必須
    require_symbols                  = true   # 記号必須
    temporary_password_validity_days = 7      # 一時パスワード有効期限
  }

  # 管理者作成ユーザー設定
  admin_create_user_config {
    allow_admin_create_user_only = true  #  ユーザーによるサインアップを許可しない

    invite_message_template {
      email_subject = "【重要】アカウント作成のご案内"
      email_message = <<-EOT
        {username} 様

        アカウントが作成されました。
        
        ユーザー名: {username}
        一時パスワード: {####}
        
        初回ログイン後、必ずパスワードを変更してください。
      EOT
      sms_message   = "ユーザー名: {username} 一時パスワード: {####}"
    }
  }

  # MFA設定
  mfa_configuration = "OPTIONAL"  # OFF, OPTIONAL, ON

  software_token_mfa_configuration {
    enabled = true
  }

  # アカウント復旧設定
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  # メール設定
  email_configuration {
    # 使用するメール配信方法。
    # Cognitoに組み込まれたデフォルトのメール機能を使用する場合は`COGNITO_DEFAULT`、
    # Amazon SES設定を使用する場合は`DEVELOPER`を指定。
    # COGNITO_DEFAULT のままだと送信数やカスタマイズに制限があるため、
    # 本番環境では Amazon SES を利用する(DEVELOPER を指定する)ことを推奨。
    # 参考：https://docs.aws.amazon.com/ja_jp/cognito/latest/developerguide/user-pool-email.html
    email_sending_account = "COGNITO_DEFAULT"
  }

  # 検証メッセージテンプレート
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "メールアドレスの確認"
    email_message        = "確認コード: {####}"
  }

  # 高度なセキュリティ機能（オプション: 追加料金発生）
  user_pool_add_ons {
    advanced_security_mode = "OFF"  # OFF, AUDIT, ENFORCED
  }

  # スキーマ属性
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true

    string_attribute_constraints {
      min_length = 7
      max_length = 256
    }
  }

  deletion_protection = "INACTIVE"
}
