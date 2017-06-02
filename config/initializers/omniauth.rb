require 'omniauth/strategies/open_wechat'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_wechat, Rails.application.secrets.wx_app_id, Rails.application.secrets.wx_app_secret
end