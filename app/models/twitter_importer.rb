class TwitterImporter
  require 'open-uri'

  def self.dummy_results
    [
      {
        "created_at" => "Tue, 12 Feb 2013 03:42:27 +0000",
        "from_user" => "lcpriest",
        "text" => "Scrapers are awkward/But I think I understand/Let's do this thing now",
        "id" => "301283191396909057",
      },
    ].to_json
  end

  def self.latest_tweets
    #filters links and RT
    since_id = 0
    base_url = "https://search.twitter.com/search.json" +
    queries = "?q=%23haikudetat%20-filter%3Alinks%20-RT" +
              #"&since_id=#{Tweet.newest.source_id}"+
              "&result_type=recent"+
              "&rpp=100"+
              "&since_id=#{since_id}"

    url = base_url + queries
    json_data = open(url).read
    data = JSON.parse json_data


    results = data["results"]
    tweets  = results.collect {|r| Tweet.parse(r)}.compact
  end
end

class Tweet

  def self.newest
    Haiku.order("source_id DESC").first
  end

  def self.parse(result)
    return nil if result["text"].match(/(?:f|ht)tps?:\/[^\s]+/)
    Tweet.new({
      created_at: DateTime.parse(result["created_at"]),

      user: result["from_user"],
      tweet: result["text"],
      tweet_id: result["id"],
    })
  end


  def initialize(params)
    @created_at = params[:created_at] || DateTime.now
    @author = params[:user] || ""         # "robramsaynz",
    @text = params[:tweet] || ""       # "#webstock woot!",
    #haikuify the tweet
    @remove_url = @text.gsub(/(?:f|ht)tps?:\/[^\s]+/, '')
    @replace_slash_w_newline = @remove_url.gsub("/", "\r\n")
    @remove_hashtag_mention = @replace_slash_w_newline.gsub( /[@#]\S+/, '' )
    @strip_empty_space = @remove_hashtag_mention.gsub(/^$\n/, '')
    @tweeted_haiku = @strip_empty_space
    @tweet_id = params[:tweet_id] || 0  # "301283191396909057"
  end

  def save_haiku()
    haiku = Haiku.find_or_initialize_by_source_id(@tweet_id)

    haiku.created_at = @created_at
    # haiku.haiku_url_cache = `curl "http://tts-api.com/tts.mp3?q=#{@tweeted_haiku.gsub(/[\n\r]/," ").gsub(";",":").split().join("+")}&return_url=1"`
    haiku.description = "#{@tweeted_haiku}"
    haiku.source_id = @tweet_id
    haiku.author = @author
    haiku.save
  end

  def url
    "https://twitter.com/#{@user}/status/#{@tweet_id}"
  end

  def to_s()
    "@#{@author}: #{@tweeted_haiku}\n" + "  #{self.url}\n"
  end
end
