class Haiku < ActiveRecord::Base
  validate :word_count_less_than_18
  after_save :create_audio_file

  def create_audio_file
    possible_path = "haiku_audio/#{self.id}.mp4"
    local_path = Rails.root + 'public/' + possible_path
    `say "#{self.description}" -o #{local_path}`
    if File.size(local_path) > 10000
      self.update_column(:file_path, possible_path)
    end
  end

  private
  def word_count_less_than_18
    errors[:widget] << "too many words" if description.split.size > 17
  end
end
