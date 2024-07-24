
Sidekiq.configure_server do |config|
  config.redis = { url: Rails.env.production? ? Rails.application.credentials.redis[:production] : Rails.application.credentials.redis[:development] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.env.production? ? Rails.application.credentials.redis[:production] : Rails.application.credentials.redis[:development] }
end
