class HaikuParser
  attr_accessor :text
  def initialize(text)
    @text = text
    reformat
  end

private

  def reformat
    remove_url
    remove_hashtag_mention
    whitelist_punctuation
    rejoin_lines
    reformat_lines
  end

  def remove_url
    @text = text.gsub(/(?:f|ht)tps?:\/[^\s]+/, '')
  end

  def reformat_lines
    @text = text.gsub("/", "\n").gsub(/^.\n/, "").gsub(/[\r\n]+/, "\n")
  end

  def remove_hashtag_mention
    @text = text.gsub( /[@#]\S+/, '' )
  end

  def whitelist_punctuation
    @text = text.gsub(/[^\w\s',\-!?. ]/i, '')
  end

  def rejoin_lines
    @text = text.lines.map do |line|
      line.strip.capitalize
    end.join "\n"
  end
end
