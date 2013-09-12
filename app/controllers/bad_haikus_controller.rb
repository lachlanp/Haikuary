class BadHaikusController < ApplicationController
  before_filter :authenticate_user!
  def index
    @list_many_haiku = BadHaiku.order('id DESC').page(params[:page]).per_page(20)
  end

  def update
    bad = BadHaiku.find(params[:id])
    bad.description = params[:bad_haiku][:description]
    bad.save
    flash[:notice] = "Haiku updated"
    redirect_to bad_haikus_path
  end

  def convert
    bad = BadHaiku.find(params[:id])
    haiku = Haiku.new(description: bad.description, author: bad.author)
    if haiku.save
      bad.destroy
    end
    render "shared/success", locals: {notice: "Haiku successfully resubmitted", id: bad.id}
  end

  def destroy
    bad = BadHaiku.find(params[:id])
    bad.destroy
    render "shared/success", locals: {notice: "Badhaiku successfully destroyed", id: bad.id}
  end

  private
end
