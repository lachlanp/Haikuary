class Haiku < ActiveRecord::Base
  validate :word_count_less_than_18
  validate :well_formed
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
  
  def word_check(word)
    word.downcase!
    return 1 if word.length <= 3
    word.sub!(/(?:[^laeiouy]es|[^t]ed|[^laeiouy]e)$/, '')
    word.sub!(/^y/, '')
    word.scan(/[aeiouy]{1,2}/).size
  end
  
  def well_formed
    framing = [5,7,5]
    haiku.split("\n").each_with_index do |line, index|
      count = line.split(" ").map do |w|
      word_check(w.gsub(/[^\w+\s]/, ''))
    end.inject(&:+)
    errors[:widget] << "is invalid on line #{index+1}" if framing[index] != count
  end
end
