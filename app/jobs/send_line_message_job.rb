class SendLineMessageJob < ApplicationJob
  queue_as :default

  sidekiq_options retry: 1
  # Sidekiqはジョブの実行に失敗した場合、デフォルトで25回リトライするため、
  # 何度も通知が送られないよう、リトライ回数を1回に指定

  sidekiq_retry_in do |_count|
    60
  end
  # ジョブのリトライ間隔を60秒に設定

  def perform
    NotificationService.call
  end
end
