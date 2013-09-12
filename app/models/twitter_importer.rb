class TwitterImporter
  require 'open-uri'

  def self.dummy_results
    tweets = Twitter.search('twitter', since_id: "0")
  end

  def self.latest_tweets
    #filters links and RT
    since_id = Haiku.where("source_id IS NOT NULL").last
    results = Twitter.search("#haiku", since_id: since_id, lang: "en", count: 70, result_type: "recent").statuses
    tweets  = results.collect {|r| Tweet.parse(r)}.compact!
  end

  def self.latest_coups
    #filters links and RT
    since_id = Haiku.where("source_id IS NOT NULL").last
    results = Twitter.search("#haikudetat", since_id: since_id, lang: "en", count: 50, result_type: "recent").statuses
    tweets  = results.collect {|r| Tweet.parse(r)}.compact!
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
    replace_slash_w_newline = remove_url.gsub("/", "\r\n")
    remove_hashtag_mention = replace_slash_w_newline.gsub( /[@#]\S+/, '' )
    replacing_newlines = remove_hashtag_mention.gsub(/[\r\n]+/, "\n")
    @tweeted_haiku = replacing_newlines.split("\n").reject do |line|
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
    bad = BadHaiku.create(description: haiku.description, author: haiku.author) unless haiku.save
  end

  def url
    "https://twitter.com/#{@user}/status/#{@tweet_id}"
  end

  def to_s()
    "@#{@author}: #{@tweeted_haiku}\n" + "  #{self.url}\n"
  end
end
