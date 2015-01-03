class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Monban::ControllerHelpers

  def current_user
    super || Guest.new
  end

  def location
    if Rails.env.development?
      @location ||= Geocoder.search("50.70.167.161").first
    else
      @location ||= request.location
    end
    @location
  end
end
