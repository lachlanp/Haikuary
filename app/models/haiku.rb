class Haiku < ActiveRecord::Base
  attr_accessible :description, :author
  validate :word_count_less_than_18
  after_save :create_audio_file

  def create_audio_file
    `say "#{self.description}" -o #{Rails.root + 'public/haiku_audio' + self.id.to_s }.aiff`
  end

  private
  def word_count_less_than_18
    errors[:widget] << "too many words" if description.split.size > 17
  end
end
