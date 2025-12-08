resource "aws_cognito_user_pool_client" "main" {
  name         = "${var.user_pool_name}-client"
  user_pool_id = aws_cognito_user_pool.main.id

  # クライアントシークレット設定
  generate_secret = false  # SPAアプリ用はfalse

  # 認証フロー設定（メール/パスワード認証のみ）
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",         # ★推奨: SRP認証（パスワードを平文送信しない）
    "ALLOW_REFRESH_TOKEN_AUTH",    # リフレッシュトークン認証
  ]

  # トークン有効期限設定
  access_token_validity  = 60  # 60分
  id_token_validity      = 60  # 60分
  refresh_token_validity = 30  # 30日

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  enable_token_revocation = true  # トークン失効機能

  # セキュリティ設定（存在しないユーザーと存在するがパスワードが間違っているユーザーでエラーメッセージを区別しない）
  prevent_user_existence_errors = "ENABLED"

  # OAuth不使用（Hosted UI不使用の場合）
  allowed_oauth_flows_user_pool_client = false
}
