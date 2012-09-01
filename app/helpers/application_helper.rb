module ApplicationHelper
  def twitterized_type(type)
    case type
      when :alert
        "alert-block"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end

  def auth_twitter
    Twitter.configure do |config|
      raise 'No auth information in ENV' unless
        ENV.key?('CONSUMER_KEY') && ENV.key?('CONSUMER_SECRET') &&
        ENV.key?('OAUTH_TOKEN') && ENV.key?('OAUTH_TOKEN_SECRET')

      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.oauth_token = ENV['OAUTH_TOKEN']
      config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
    end
  end
end
