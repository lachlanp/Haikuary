class HaikusController < ApplicationController
  before_filter :load_resource, only: [ :show ]

  def index
    @haikus = Haiku.not_generated.order(id: :desc).page(params[:page]).per_page(20)
    respond_with @haikus
  end

  def show
  end

  def new
    @haiku = Haiku.new
    respond_with @haiku
  end

  def create
    @haiku = Haiku.create(haiku_params)
    respond_with @haiku
  end

  def random
    @haiku = HaikuMaker::Base.new.result
    @haiku ||= Haiku.new(description: "Empty database\nWhat happened to me, I'm lost\n without my data.")
    respond_with @haiku
  end

private

  def load_resource
    @haiku = Haiku.find(params[:id])
  end

  def haiku_params
    params.require(:haiku).permit(:description, :author)
  end
end
