# the GamesController is where the meat of Dlyg lives. It
# handles basically everything to do with a game: rolling
# dice, inviting/uninviting players, etc

class GamesController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_game, :only => [:new, :show, :edit, :update, :destroy, :roll_dice, :cast_shadow, :shed_light, :invite, :uninvite]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_with @games
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @dice_pool = DiceRoller::DicePool.new

    respond_with @game, @dice_pool
  end

  # GET /games/new
  # GET /games/new.json
  def new
    respond_with @game
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])
    @game.gm = current_user

    flash[:notice] = 'Game was successfully created.' if @game.save

    respond_with @game
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    # if the gm is changed, add the old one to the list of players
    if params[:game][:gm_id] and params[:game][:gm_id] != @game.gm.id
      char = Character.create(:game_id => params[:id], :player_id => @game.gm.id)
      Play.create(:game_id => params[:id], :user_id => @game.gm.id, :character_id => char.id)
    end
  
    flash[:notice] = 'Game was successfully updated.' if @game.update_attributes(params[:game])

    respond_with @game
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      #format.json { head :no_content }
    end
  end
  
  # POST /games/1/roll_dice
  def roll_dice
    name = @game.plays.collect { |p| p.character_name if p.user == current_user }
    @result = @game.roll(params[:discipline].to_i, params[:exhaustion].to_i, params[:madness].to_i, params[:pain].to_i, name.first)

    respond_to do |format|
      format.js
    end
  end
  
  # PUT /games/1/cast_shadow
  def cast_shadow
    @game.cast_shadow(params[:despair_coins].to_i)
    @game.save
    
    respond_to do |format|
      format.js
    end
  end
  
  # PUT /games/1/cast_shadow
  def shed_light
    @game.shed_light(params[:hope_coins].to_i)
    @game.save
    
    respond_to do |format|
      format.js
    end
  end
  
  # PUT /games/1/invite
  def invite
    @email = params[:email]
    user = User.find_by_email(@email)
    user = User.invite!(:email => @email) unless user

    unless @game.players.include?(user)
      char = Character.create(:name => '', :game_id => @game.id, :player_id => user.id)
      Play.create(:user_id => user.id, :game_id => @game.id, :character_id => char.id)
    end
    
    #@game.players << user unless @game.players.include?(user)
    
    respond_to do |format|
      format.js
    end
  end
  
  # PUT /games/1/uninvite
  def uninvite
    email = params[:email]
    user = User.find_by_email(email)
    @id = user.id
    
    @game.players.delete(user)
    Character.find_by_player_id_and_game_id(user.id, @game.id).delete
    
    respond_to do |format|
      format.js
    end
  end

  private

  # sets the game variable as a before_filter
  def find_game
    if params[:action] == "new"
      @game = Game.new
    else
      @game = Game.find_by_id(params[:id])
    end
  end
end
