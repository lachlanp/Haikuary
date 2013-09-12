class HaikuController < ApplicationController
  before_filter :lets_init_haiku, only: [ :show ]

  def index
    if (params[:haiku] && Haiku.all.collect(&:author).include?(params[:haiku][:author]))
      @list_many_haiku = Haiku.where(author: params[:haiku][:author]).order('id DESC').page(params[:page]).per_page(20)
    else
      @list_many_haiku = Haiku.not_generated.order('id DESC').page(params[:page]).per_page(20)
    end
    # @github_location = "http://github.rc/lachypoo/Haikuary/raw/master/public/haiku_audio/"
    @list_many_haiku = @list_many_haiku.not_vetoed
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
        bad = BadHaiku.create(description: @haiku.description, author: @haiku.author, syllable_estimate: SyllableCounter::Count.new.get_syllables(@haiku.description) )
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
    @single_haiku = Haiku.find_by_id(params[:id])
  end

  def haiku_params
    params.require(:haiku).permit(:description, :author)
  end
end
