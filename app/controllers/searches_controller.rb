class SearchesController < ApplicationController
  def index
    @list_many_haiku = Haiku.all
    case params[:type]
    when "user"
      @list_many_haiku = @list_many_haiku.where(Haiku.arel_table[:author].matches("%#{params[:q]}%"))
    when "content"
      @list_many_haiku = @list_many_haiku.where(Haiku.arel_table[:description].matches("%#{params[:q]}%"))
    else
      @list_many_haiku = @list_many_haiku.none
    end
    @list_many_haiku.page(params[:page]).per_page(20)
  end
end
