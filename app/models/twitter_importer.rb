class TwitterImporter
  require 'open-uri'
  attr_accessor :client

  def initialize
    @client = Twitter::Session.new.client
  end

  def latest_tweets
    fetch_tweets_by_hashtag("#haiku")
  end

  def latest_coups
    fetch_tweets_by_hashtag("#haikudetat")
  end

private
  def fetch_tweets_by_hashtag(hashtag)
    results = client.search(hashtag, since_id: since_id, lang: "en", result_type: "recent").take(100).map(&:text)
    tweets  = results.collect {|r| Tweet.parse(r)}.compact!
  end

  def since_id
    Haiku.where("source_id IS NOT NULL").last
  end
end

