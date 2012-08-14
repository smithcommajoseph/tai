Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, APP_CONFIG[:twitter][:consumer_key], APP_CONFIG[:twitter][:consumer_secret]
  provider :facebook, APP_CONFIG[:facebook][:consumer_key], APP_CONFIG[:facebook][:consumer_secret], {:scope => "status_update"}
end