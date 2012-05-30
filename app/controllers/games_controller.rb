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
    @degree, @wins, @dominating, @discipline, @exhaustion, @madness, @pain = @game.roll(params[:discipline].to_i, params[:exhaustion].to_i, params[:madness].to_i, params[:pain].to_i)
    @game.save
    
    @discipline = @discipline.join(', ')
    @exhaustion = @exhaustion.join(', ')
    @madness = @madness.join(', ')
    @pain = @pain.join(', ')

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
    
    @game.players << User.find_by_email(@email)
    @game.save!
    
    respond_to do |format|
      format.js
    end
  end
  
  # PUT /games/1/uninvite
  def uninvite
    @email = params[:email]
    user = User.find_by_email(@email)
    @id = user.id
    
    @game.players.delete(user)
    
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
