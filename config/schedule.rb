# config/schedule.rb
set :environment, 'development'
set :output, 'log/cron_log.log'

# every 1.day, at: '7:00 am' do
#   runner "NotificationService.call"
# end

every 5.minutes do
  runner "NotificationService.call"
end
