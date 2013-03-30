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
    since_id = 0
    base_url = "https://search.twitter.com/search.json" +
    queries = "?q=%23haikudetat" +
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
    return false if result["text"].index("haikudetat.com")
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
    @tweeted_haiku = @text.gsub("/", "\r\n").gsub("@\w*", " ").gsub("#\w*", " ")
    @tweet_id = params[:tweet_id] || 0  # "301283191396909057"

  end

  def save_haiku()
    haiku = Haiku.find_or_initialize_by_source_id(@tweet_id)

    haiku.created_at = @created_at

    haiku.description = "#{@tweeted_haiku}"
    haiku.source_id = @tweet_id
    haiku.author = @author
    haiku.save
  end

  def url
    "https://twitter.com/#{@user}/status/#{@tweet_id}"
  end

  def to_s()
    "@#{@user}: #{@tweet}\n" + "  #{self.url}\n"
  end
end
