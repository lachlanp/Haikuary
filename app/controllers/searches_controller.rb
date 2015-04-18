class SearchesController < ApplicationController
  def index
    case params[:type]
    when "user"
      @haikus = Haiku.where(Haiku.arel_table[:author].matches("%#{params[:q]}%"))
    when "content"
      @haikus = Haiku.where(Haiku.arel_table[:description].matches("%#{params[:q]}%"))
    else
      @haikus = Haiku.none
    end
    @haikus.page(params[:page]).per_page(20)
  end
end
