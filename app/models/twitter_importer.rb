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

class Tweet

  def self.newest
    Haiku.order("source_id DESC").first
  end

  def self.parse(result)
    return nil if result["text"].match(/(?:f|ht)tps?:\/[^\s]+/)
    return nil if result["text"].match(/^RT /)
    Tweet.new({
      created_at: result[:created_at],
      user: result.from_user,
      tweet: result.text,
      tweet_id: result.id,
    })
  end

  def initialize(params)
    @created_at = params[:created_at] || DateTime.now
    @author = params[:user] || ""         # "robramsaynz",
    @text = params[:tweet] || ""       # "#webstock woot!",
    #haikuify the tweet
    remove_url = @text.gsub(/(?:f|ht)tps?:\/[^\s]+/, '')
    replace_slash_w_newline = remove_url.gsub("/", "\r\n").gsub(/^.\n/, "")
    remove_hashtag_mention = replace_slash_w_newline.gsub( /[@#]\S+/, '' )
    replacing_newlines = remove_hashtag_mention.gsub(/[\r\n]+/, "\n")
    removing_tildes = replacing_newlines.gsub(/^~ /, "").gsub(/^ /, "")
    @tweeted_haiku = removing_tildes.split("\n").reject do |line|
      line =~ /\A\s+\z/
    end.join "\n"
    @tweet_id = params[:tweet_id] || 0  # "301283191396909057"
  end

  def save_haiku()
    haiku = Haiku.find_or_initialize_by(source_id: "#{@tweet_id}")

    haiku.created_at = @created_at
    # haiku.haiku_url_cache = `curl "http://tts-api.com/tts.mp3?q=#{@tweeted_haiku.gsub(/[\n\r]/," ").gsub(";",":").split().join("+")}&return_url=1"`
    haiku.description = "#{@tweeted_haiku}"
    haiku.source_id = "#{@tweet_id}"
    haiku.author = @author
  end

  def url
    "https://twitter.com/#{@user}/status/#{@tweet_id}"
  end

  def to_s()
    "@#{@author}: #{@tweeted_haiku}\n" + "  #{self.url}\n"
  end
end
