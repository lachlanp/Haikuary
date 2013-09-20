class BadHaiku < ActiveRecord::Base
  before_save :how_many_syllables
  after_update :attempt_resubmit

  def how_many_syllables
    self.syllable_estimate = SyllableCounter::Count.new.get_syllables(self.description)
    return true
  end

  def attempt_resubmit
    haiku = Haiku.new(author: author, description: description)
    self.destroy
  end
end
