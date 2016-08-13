# the character controller only has actions to show and alter existing
# characters. new ones are created via GamesController#invite

class CharactersController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_action :find_character

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
    flash[:notice] = 'Character was successfully updated.' if @character.update_attributes(character_params)

    respond_with @character.game, @character
  end

  private

  # set up the @character variable
  def find_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:game_id, :player_id, :name, :concept, :keeping_awake, :just_happened, :surface, :beneath, :path, :discipline, :exhaustion, :madness, :e_talent, :m_talent, :fight, :flight)
  end
end
