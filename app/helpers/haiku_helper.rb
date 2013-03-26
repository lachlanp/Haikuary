module HaikuHelper
  def twitter_description(haiku)
    haiku.description.gsub(/\r\n/, "/")
  end
end
