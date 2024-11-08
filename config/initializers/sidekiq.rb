Sidekiq.configure_server do |config|
  config.redis = { url: Rails.env.production? ? ENV.fetch('REDIS_URL_PRODUCTION', nil) : ENV.fetch('REDIS_URL_DEVELOPMENT') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.env.production? ? ENV.fetch('REDIS_URL_PRODUCTION', nil) : ENV.fetch('REDIS_URL_DEVELOPMENT') }
end
