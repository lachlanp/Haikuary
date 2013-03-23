class Haiku < ActiveRecord::Base
  attr_accessible :description, :author

  after_save :create_audio_file

  def create_audio_file
    `say "#{self.description}" -o #{Rails.root + 'public/haiku_audio' + self.id.to_s }.aiff`
  end

end
