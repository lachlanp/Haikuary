class Haiku < ActiveRecord::Base
  validate :word_count_less_than_18
  validate :well_formed
  validates :description, presence: true, uniqueness: true
  validate :formation
  validates_uniqueness_of :description
  before_save :tag_haiku
  scope :not_generated, -> { where.not(author: 'Happy Haiku Bot') }

  def self.get_random
    scope = Haiku.not_generated
    random_id = rand(scope.count).to_i
    haiku = scope.find_by(id: random_id)
    haiku ? haiku : get_random
  end

private

  def tag_haiku
    HaikuTagger.new(self).tag_haiku
  end

  def word_count_less_than_18
    errors[:description] << "too many words" if description.split.size > 17
  end

  def dissect_line(line)
    SyllableCounter::Count.new.get_syllables(line)
  end

  def well_formed
    description.lines.each_with_index do |line, index|
      count = dissect_line(line)
      if ((valid_syllables_for_line(index) - count).abs > 1)
        errors[:description] << "wrong number of syllables on line #{index+1}"
      end
    end
  end

  def formation
    errors[:description] << "Please use 3 lines." unless description.lines.count == 3
  end

  def valid_syllables_for_line(index)
    framing = [5,7,5]
    framing[index] || 0
  end
end
