class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  check_authorization :unless => :devise_controller?

  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end
end
