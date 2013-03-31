class HaikuController < ApplicationController
  before_filter :lets_init_haiku, only: [ :show ]

  def index
    @list_many_haiku = Haiku.order('id DESC').page(params[:page]).per_page(20)
    # @github_location = "http://github.rc/lachypoo/Haikuary/raw/master/public/haiku_audio/"

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
    @haiku = Haiku.new(haiku_params)
    respond_to do |format|
      if @haiku.save
        format.html {redirect_to root_path, notice: Haiku.all.sample.description}
        format.json {render json: @haiku}
      else
        format.html do
          flash.now[:error] = Haiku.all.sample.description
          render :new
        end
        format.json { render json: @haiku }
      end
    end
  end

  def random
    @haiku = HaikuMaker.new.generate
  end

  private

  def lets_init_haiku
    @single_haiku = Haiku.find_by_id(params[:id])
  end

  def haiku_params
    params.require(:haiku).permit(:description, :author)
  end
end
