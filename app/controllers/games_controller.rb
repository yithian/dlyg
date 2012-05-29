class GamesController < ApplicationController
  respond_to :html, :xml

  load_and_authorize_resource

  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    
    @dice_pool = DiceRoller::DicePool.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])
    @game.gm = current_user

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end
  
  # POST /games/1/roll_dice
  def roll_dice
    @game = Game.find(params[:id])
    
    @degree, @wins, @dominating, @discipline, @exhaustion, @madness, @pain = @game.roll(params[:discipline].to_i, params[:exhaustion].to_i, params[:madness].to_i, params[:pain].to_i,)
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
    @game = Game.find(params[:id])
    
    @game.cast_shadow(params[:despair_coins].to_i)
    @game.save
    
    respond_to do |format|
      format.js
    end
  end
  
  # PUT /games/1/cast_shadow
  def shed_light
    @game = Game.find(params[:id])
    
    @game.shed_light(params[:hope_coins].to_i)
    @game.save
    
    respond_to do |format|
      format.js
    end
  end
end
