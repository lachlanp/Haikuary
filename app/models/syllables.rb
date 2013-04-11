module Syllables
  def self.get_syllables(string)
    words = string.split()
    count = 0
    words.each do |word|
      word =~ /[^td]ed$/ ? word.sub!(/ed$/,"") : word
      word =~ /(s||z||sh||dg||[aeiouy]g||ch)es$/ ? word.sub!(/ed$/,"") : word
      word =~ /[aeiouy][aeiouy]/ ? word.sub!(/[aeiouy][aeiouy]/,"a") : word
      word =~ /e$/ ? word.sub!(/e$/,"") : word
      vowel_count = word.scan(/[aeiouy]/).count
      if vowel_count == 0
        vowel_count = 1
      end
      count = count + vowel_count
    end
    return count
  end
end
