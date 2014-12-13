module HaikuMaker
  class Themed < Base
    attr_accessor :word

    def initialize(word)
      @word = word
      @result = build_haiku
    end

  private

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
