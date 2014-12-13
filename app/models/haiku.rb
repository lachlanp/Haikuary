class Haiku < ActiveRecord::Base
  validate :word_count_less_than_18
  validate :well_formed
  validates :description, presence: true, uniqueness: true
  validate :formation
  validates_uniqueness_of :description
  before_save :tag_haiku
  scope :not_generated, -> { where.not(author: 'Happy Haiku Bot') }

  def self.get_random
    Haiku.not_generated.sample
  end

  def dissect
    description.split("\n").each_with_index.map do |line, index|
      dissect_line(line)
    end
  end

  def is_new_line_formatted?
    self.description.lines.count >= 3
  end

private

  def tag_haiku
    HaikuTagger.new(self).tag_haiku
  end

  def word_count_less_than_18
    errors[:description] << "too many words" if description.split.size > 17
  end

  def word_check(word)
    word.downcase!
    return 1 if word.length <= 3
    word.sub!(/(?:[^laeiouy]es|[^t]ed|[^laeiouy]e)$/, '')
    word.sub!(/^y/, '')
    word.scan(/[aeiouy]{1,2}/).size
  end

  def dissect_line(line)
    SyllableCounter::Count.new.get_syllables(line)
  end

  def well_formed
    description.split("\n").each_with_index do |line, index|
      count = dissect_line(line)
      if ((valid_syllables_for_line(index) - count).abs > 1)
        errors[:description] << "wrong number of syllables on line #{index+1}"
      end
    end
  end

  def formation
    errors[:description] << "Please use 3 lines." unless description.lines.count >= 3
    errors[:description] << "Please use only 3 lines." unless description.lines.count <= 3
  end

  def valid_syllables_for_line(index)
    framing = [5,7,5]
    framing[index] || 0
  end
end
