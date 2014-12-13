module HaikuMaker
  class Base
    attr_accessor :result
    def initialize
      @result = build_haiku
    end

  private

    def build_haiku
      Haiku.new(description: description, author: "Happy Haiku Bot")
    end

    def find_three_haiku
      haikus = random_haikus.first(3)
      fill_quota(haikus)
    end

    def description
      haikus = find_three_haiku
      description = haikus[0].description.lines[0] + haikus[1].description.lines[1] + haikus[2].description.lines[2]
    end

    def total
      @total ||= scope.count
    end

    def random_id
      rand(total).to_i
    end

    def random_ids
      @ids = []
      5.times do
        @ids << random_id
      end
    end

    def random_haikus
      @random_haikus ||= begin
        scope.where(id: random_ids).limit(10)
             .select{ |h| h.is_new_line_formatted? }
      end
    end

    def random_haiku
      scope.find_by(id: random_id)
    end

    def fill_quota(haikus)
      if haikus.length == 3
        haikus
      else
        haikus << random_haiku
        fill_quota(haikus)
      end
    end

    def scope
      Haiku.not_generated
    end
  end
end
