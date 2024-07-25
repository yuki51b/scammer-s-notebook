
Sidekiq.configure_server do |config|
  config.redis = { url: Rails.env.production? ? ENV['REDIS_URL_PRODUCTION'] : Rails.application.credentials.redis[:development] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.env.production? ? ENV['REDIS_URL_PRODUCTION'] : Rails.application.credentials.redis[:development] }
end

