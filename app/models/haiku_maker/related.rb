class RelatedHaiku
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def associated_haiku
  end

private

  def wordnik_search(word)
    Wordnik.words.get_related_words(word)
  end

  def word_list(word)
    wordnik_search(word).each do |hash|
      hash["words"]
    end.flatten.compact.uniq
  end
end
