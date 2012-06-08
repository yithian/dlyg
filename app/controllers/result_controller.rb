# ResultController literally exists just so GMs can
# easily remove rolls from their games' history.

class ResultController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result = Result.find(params[:id])
    @game = @result.game
    @result.destroy

    respond_to do |format|
      format.html { redirect_to @game }
      format.json { head :no_content }
    end
  end
end
