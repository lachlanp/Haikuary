module Twitter
  class Session
    attr_accessor :client
  	def initialize
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = Rails.application.secrets.twitter_consumer_key
        config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
        config.access_token        = Rails.application.secrets.twitter_oauth_token
        config.access_token_secret = Rails.application.secrets.twitter_oauth_token_secret
      end
    end
  end

  class Stream
    attr_accessor :client
    def initialize
      @client ||= Twitter::Streaming::Client.new do |config|
        config.consumer_key        = Rails.application.secrets.twitter_consumer_key
        config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
        config.access_token        = Rails.application.secrets.twitter_oauth_token
        config.access_token_secret = Rails.application.secrets.twitter_oauth_token_secret
      end
    end
  end
end
