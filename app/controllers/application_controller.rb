class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  check_authorization :unless => :devise_controller?

  protect_from_forgery
end
