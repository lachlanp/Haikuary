class HaikuController < ApplicationController
  before_filter :lets_init_haiku, except: [ :index, :new ]

  def index
    @list_many_haiku = Haiku.all
  end

  def show
  end

  def new
    @haiku = Haiku.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @haiku }
    end
  end

  def create
    @haiku = Haiku.new(params[:haiku])
    respond_to do |format|
      if @haiku.save
        format.html {redirect_to root_path, notice: "Nice Haiku right there/ I can't believe it's butter/ I mean really, what?"}
        format.json {render json: @haiku}
      else

  end

  private

  def lets_init_haiku
    @haiku = Haiku.find(:id)
  end
end
