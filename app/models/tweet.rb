class Tweet
  def self.parse(tweet)
    return nil if tweet.text.match(/(?:f|ht)tps?:\/[^\s]+/)
    return nil if tweet.text.match(/^RT /)
    Tweet.new({
      user: tweet.user.name,
      tweet: tweet.text,
      tweet_id: tweet.id,
    })
  end

  attr_accessor :text, :params

  def initialize(params)
    @params = params
    @text = params[:tweet]
  end

  def save_haiku
    Haiku.create(
      description: reformat_text(text),
      source_id: tweet_id.to_s,
      author: author
    )
  end

private

  def reformat_text(text)
    HaikuParser.new(text).text
  end

  def author
    params[:user] || ""
  end

  def tweet_id
    params[:tweet_id] || 0
  end

end
