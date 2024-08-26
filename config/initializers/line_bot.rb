require 'line/bot'

LINE_NOTIFY_CLIENT = Line::Bot::Client.new do |config|
  config.channel_id = Rails.application.credentials.dig(:line_notify, :channel_id)
  config.channel_secret = Rails.application.credentials.dig(:line_notify, :channel_secret)
  config.channel_token = Rails.application.credentials.dig(:line_notify, :channel_access_token)
end
