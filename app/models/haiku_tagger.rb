class HaikuTagger
  attr_accessor :haiku

  def initialize(haiku)
    @haiku = haiku
  end

  def tag_haiku
    haiku.update_column(:tags, get_tags) if get_tags.any?
  end

private

  def get_tags
    @tags ||= get_nouns.any? ? get_nouns : get_adjectives
  end

  def get_nouns
    @nouns ||= tagger.get_nouns(text).keys
  end

  def get_adjectives
    tagger.get_adjectives(text).keys
  end

  def tagger
    @tagger ||= EngTagger.new
  end

  def text
    text = tagger.add_tags(haiku.description.downcase)
  end
end
