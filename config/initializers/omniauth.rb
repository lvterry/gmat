Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, Rails.application.secrets.wx_app_id, Rails.application.secrets.wx_app_secret
end