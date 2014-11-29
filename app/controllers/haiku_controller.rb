class HaikuController < ApplicationController
  before_filter :lets_init_haiku, only: [ :show ]

  def index
    @list_many_haiku = begin
      Haiku.not_generated
           .order(id: :desc)
           .page(params[:page])
           .per_page(20)
    end
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
        format.html {redirect_to root_path, notice: Haiku.get_random.description}
        format.json {render json: @haiku}
      else
        BadHaiku.create(description: @haiku.description, author: @haiku.author)
        format.html do
          flash.now[:error] = Haiku.get_random.description
          render :new
        end
        format.json { render json: @haiku }
      end
    end
  end

  def random
    @haiku = HaikuMaker.new.generate
  end

  def veto
    haiku = Haiku.find(params[:id])
    haiku.veto!
    render "shared/success", locals: {notice: "Haiku vetoed successfully", id: haiku.id}
  end

private

  def lets_init_haiku
    @single_haiku = Haiku.find_by(id: params[:id])
  end

  def haiku_params
    params.require(:haiku).permit(:description, :author)
  end
end
