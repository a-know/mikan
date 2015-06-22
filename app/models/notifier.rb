class Notifier
  def initialize
    @slack_notifier ||= Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'], channel: '#mikanz-notification'
  end

  def post(str)
    @slack_notifier.ping([ '[', Rails.env, '] ' ].join + str) unless Rails.env == 'test'
  end
end
