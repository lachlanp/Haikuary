class Haiku < ActiveRecord::Base
  validate :word_count_less_than_18
  validate :well_formed
  # after_save :create_audio_file
  after_save :audio_file
  validates_presence_of :description
  validates_length_of :description, minimum: 30, message: "Your Haiku is too short! Minimum 30 characters."
  validate :formation
  validates_uniqueness_of :description

  scope :not_generated, -> { where(Haiku.arel_table[:author].not_eq('Happy Haiku Bot')) }

  # def create_audio_file
  #   possible_path = "haiku_audio/#{self.id}.mp4"
  #   local_path = Rails.root + 'public/' + possible_path
  #   `say "#{self.description}" -o #{local_path}`
  #   if File.size(local_path) > 10000
  #     self.update_column(:file_path, possible_path)
  #   end
  # end

  def audio_file
    @audio = `curl "http://tts-api.com/tts.mp3?q=#{self.description.gsub(/[\n\r]/," ").gsub(";",":").split().join("+")}&return_url=1"`
    self.update_column(:haiku_url_cache, @audio)
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
    Syllables.get_syllables(line)
  end

  def well_formed
    framing = [5,7,5]
    description.split("\n").each_with_index do |line, index|
      count = dissect_line(line)
      errors[:description] << "wrong number of syllables on line #{index+1}" if((framing[index] - count).abs > 1)
    end
  end

  def formation
    errors[:description] << "Please use 3 lines." unless description.lines.count >= 3
    errors[:description] << "Please use only 3 lines." unless description.lines.count <= 3

  end
end
