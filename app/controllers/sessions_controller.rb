class SessionsController < ApplicationController
  respond_to :html, :xml

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sessions }
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @session = Session.find(params[:id])
    
    @dice_pool = DiceRoller::DicePool.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    @session = Session.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session }
    end
  end

  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(params[:session])

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully created.' }
        format.json { render json: @session, status: :created, location: @session }
      else
        format.html { render action: "new" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sessions/1
  # PUT /sessions/1.json
  def update
    @session = Session.find(params[:id])

    respond_to do |format|
      if @session.update_attributes(params[:session])
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session = Session.find(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to sessions_url }
      format.json { head :no_content }
    end
  end
  
  # POST /sessions/1/roll_dice
  def roll_dice
    @strength = 0
    @pain = 0
    discipline_strength = 0
    exhaustion_strength = 0
    madness_strength = 0
    pain_strength = 0
    
    # count strength of player pools
    pool = DiceRoller::DicePool.new(0, params[:discipline].to_i)
    @discipline = pool.roll_pool.six_result.sort.reverse
    discipline_strength = 0

    @discipline.each do |d|
      if d <= 3
        @strength += 1
        discipline_strength += 1
      end
    end
    
    pool.num_six = params[:exhaustion].to_i
    @exhaustion = pool.roll_pool.six_result.sort.reverse
    exhaustion_strength = 0
    
    @exhaustion.each do |e|
      if e <= 3
        @strength += 1
        exhaustion_strength += 1
      end
    end
    
    pool.num_six = params[:madness].to_i
    @madness = pool.roll_pool.six_result.sort.reverse
    madness_strength = 0
    
    @madness.each do |m|
      if m <= 3
        @strength += 1
        madness_strength += 1
      end
    end
    
    # count strength of pain
    pool.num_six = params[:pain].to_i
    @pain = pool.roll_pool.six_result.sort.reverse
    pain_strength = 0
    
    @pain.each do |p|
      if p <= 3
        pain_strength += 1
      end
    end
    
    # determine who wins
    if @strength > pain_strength
      @wins = :player
    else
      @wins = :pain
      @strength = pain_strength
    end
    
    # determine which pool is dominant
    dominant = {@discipline => :discipline, @exhaustion => :exhaustion, @madness => :madness, @pain => :pain}
    
    @dominating = dominant[dominant.keys.max]
    
    respond_to do |format|
      format.js
    end
  end
end
