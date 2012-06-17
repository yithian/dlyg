# the character controller only has actions to show and alter existing
# characters. new ones are created via GamesController#invite

class CharactersController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_character

  # GET /characters/1
  # GET /characters/1.json
  def show
    respond_with @character
  end

  # GET /characters/1/edit
  def edit
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    flash[:notice] = 'Character was successfully updated.' if @character.update_attributes(params[:character])

    respond_with @character.game, @character
  end
  
  private
  
  # set up the @character variable
  def find_character
    @character = Character.find(params[:id])
  end
end
