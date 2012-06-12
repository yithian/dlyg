# PlayController exists pretty much just to have route
# shortcuts to destroy a Play. There are a couple other
# actions here just in case they may see future use as
# well.

class PlaysController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_play, :only => [:update, :destroy]

  # POST /games/1/play/1
  def create
    @play = Play.new(params[:play])
    @play.save

    respond_with @play.game
  end

  # PUT /games/1/play/1
  def update
    @play.update_attributes(params[:play])

    respond_with @play.game
  end

  # DELETE /games/1/play/1
  def destroy
    game = @play.game
    @play.destroy

    respond_to do |format|
      format.html { redirect_to game }
    end
  end

  private

  # set up a variable as a before_filter
  def find_play
    @play = Play.find_by_id(params[:id])
  end
end
