class SendLineMessageJob < ApplicationJob
  queue_as :default

  def perform
    NotificationService.call
  end
end
