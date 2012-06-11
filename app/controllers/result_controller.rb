# ResultController literally exists just so GMs can
# easily remove rolls from their games' history.

class ResultController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_result

  # DELETE /games/1/results/1
  # DELETE /games/1/results/1.json
  def destroy
    @game = @result.game
    @result.destroy

    respond_to do |format|
      format.html { redirect_to @game }
      format.json { head :no_content }
    end
  end
  
  # PUT /games/1/result/1/recall
  def recall
    former_domminating = @result.dominating
    
    @result.recall!(params[:pool])
    
    if former_domminating == 'pain' and @result.dominating != 'pain'
      game = @result.game
      game.despair -= 1
      game.save
    end

    respond_to do |format|
      format.js
    end
  end
  
  private
  
  # set the result variable as a before_filter
  def find_result
    @result = Result.find_by_id(params[:id])
  end
end
