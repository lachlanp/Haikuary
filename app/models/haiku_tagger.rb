class HaikuTagger
  attr_accessor :haiku

  def initialize(haiku, force = nil)
    @haiku = haiku
    @force = force
  end

  def tag_haiku
    if get_tags.any?
      if @force
        haiku.update_column(:tags, get_tags)
      else
        haiku.tags = get_tags
      end
    end
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
    text = tagger.add_tags(clean_text)
  end

  def clean_text
    haiku.description.downcase.gsub(/[^\w\s',\-!?. ]/i, '')
  end
end
