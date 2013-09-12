class BadHaiku < ActiveRecord::Base
  before_save :how_many_syllables

  def how_many_syllables
    self.syllable_estimate = SyllableCounter::Count.new.get_syllables(self.description)
    return true
  end
end
