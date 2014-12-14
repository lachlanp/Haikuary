class Tweet
  def self.parse(result)
    return nil if result["text"].match(/(?:f|ht)tps?:\/[^\s]+/)
    return nil if result["text"].match(/^RT /)
    Tweet.new({
      user: result.from_user,
      tweet: result.text,
      tweet_id: result.id,
    })
  end

  attr_accessor :text, :params

  def initialize(params)
    @params = params
  end

  def save_haiku()
    haiku = Haiku.where(source_id: "#{@tweet_id}").first_or_initialize
    haiku.update_attributes(
      description: "#{text}",
      created_at: created_at,
      source_id: tweet_id.to_s,
      author: author
    )
  end

private

  def reformat_text(text)
    HaikuParser.new(text).text
  end

  def url
    "https://twitter.com/#{@user}/status/#{@tweet_id}"
  end

  def author
    params[:user] || ""
  end

  def tweet_id
    params[:tweet_id] || 0
  end
end
