client = Twitter::Stream.new.client

params = Hash.new;
params[:track] = "haiku, haikudetat"

client.filter(params) do |object|
  if object.is_a?(Twitter::Tweet)
    tweet = Tweet.parse(object)
    tweet.try(:save_haiku)
  end
end
