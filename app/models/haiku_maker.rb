class HaikuMaker
  attr_accessor :haiku_list, :generated_haiku

  def initialize
  end

  def generate
    @haiku_list = get_haiku_list
    generated_haiku
  end

  def generated_haiku
    description = @haiku_list[0].description.lines[0] + @haiku_list[1].description.lines[1] + @haiku_list[2].description.lines[2]
    @generated_haiku  = Haiku.new(description: description, author: "Happy Haiku Bot")
  end

  def get_haiku_list
    return @haiku_list if @haiku_list.present?
    haiku_list = []
    size = Haiku.count
    while haiku_list.count < 3 do
      haiku = Haiku.not_generated.find(rand(size))
      haiku_list << haiku if haiku && haiku.is_new_line_formatted?
    end
    haiku_list
  end
end
