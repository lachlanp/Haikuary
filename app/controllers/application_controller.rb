class ApplicationController < ActionController::Base
  before_filter :ensure_domain
  protect_from_forgery

  APP_DOMAIN = 'www.haikudetat.com'
  def ensure_domain
    if Rails.env == 'production' && request.env['HTTP_HOST'] != APP_DOMAIN
      redirect_to "http://#{APP_DOMAIN}#{request.path}", :status => 301
  end
end
