module HaikuMaker
  class Themed < Base
    attr_accessor :word

    def initialize(word)
      @word = word
      @result = build_haiku
    end

  private

    def description
      haikus = find_three_haiku
      lines = [0,1,2].map do |index|
        lines = haikus.map{ |haiku| haiku.description.lines[index] }
        resolve_line(lines)
      end.flatten
      reformat(lines)
    end

    def reformat(lines)
      lines.map do |line|
        line.strip.gsub("\n", "").gsub("\r\n", "").gsub("\"", "")
      end.join("\r\n")
    end


    def resolve_line(lines)
      lines.select{ |line| line.downcase.include?(word) }.sample || lines.sample
    end

    def all_ids
      @all_ids = scope.pluck(:id)
    end

    def random_haiku
      Haiku.not_generated.find(random_id)
    end

    def random_ids
      all_ids.sample(5)
    end

    def scope
      Haiku.where("? = ANY(tags)", word)
    end
  end
end
