class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_locale_params
  
  def set_locale
    I18n.locale = params[:locale] || session[:send_params][:locale] || I18n.default_locale
    params[:locale] = I18n.locale
  end
  
  def set_locale_params
    if request.post? || request.put?
      if request.url != request.referrer
        session[:send_params] = Rails.application.routes.recognize_path(request.referrer)
      else
        session[:send_params]
      end
    else
      session[:send_params] = params
    end
  end
end
