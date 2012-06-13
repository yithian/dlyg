# this controller is only to route users to 'static'
# pages

class StaticController < ApplicationController
  skip_authorization_check

  # GET /about
  def about
  end
end
