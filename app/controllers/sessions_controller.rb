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
    @session = Session.find(params[:id])
    
    @degree = 0
    discipline_degree = 0
    exhaustion_degree = 0
    madness_degree = 0
    pain_degree = 0
    
    # count degree of player pools
    pool = DiceRoller::DicePool.new(0, params[:discipline].to_i)
    @discipline = pool.roll_pool.six_result.sort.reverse

    @discipline.each do |d|
      if d <= 3
        @degree += 1
        discipline_degree += 1
      end
    end
    
    pool.num_six = params[:exhaustion].to_i
    @exhaustion = pool.roll_pool.six_result.sort.reverse
    
    @exhaustion.each do |e|
      if e <= 3
        @degree += 1
        exhaustion_degree += 1
      end
    end
    
    pool.num_six = params[:madness].to_i
    @madness = pool.roll_pool.six_result.sort.reverse
    
    @madness.each do |m|
      if m <= 3
        @degree += 1
        madness_degree += 1
      end
    end
    
    # count degree of pain
    pool.num_six = params[:pain].to_i
    @pain = pool.roll_pool.six_result.sort.reverse
    
    @pain.each do |p|
      if p <= 3
        pain_degree += 1
      end
    end
    
    # determine who wins
    if @degree > pain_degree
      @wins = :player
    else
      @wins = :pain
      @degree = pain_degree
    end
    
    # determine which pool is dominant
    # there is some trickery here: the order of assignment is important.
    # due to the hierarchy of tie-breakers, "tied" elements assigned later
    # in the hash will overwrite earlier elements. so later elements
    # "beat" earlier ones
    dominant = {@pain => :pain, @exhaustion => :exhaustion, @madness => :madness, @discipline => :discipline }
    
    @dominating = dominant[dominant.keys.max]
    
    # bump despair count if pain is dominant
    if @dominating == :pain
      @session.despair += 1
      @session.save
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  # PUT /sessions/1/cast_shadow
  def cast_shadow
    @session = Session.find(params[:id])
    
    @session.cast_shadow(1)
    @session.save
    
    respond_to do |format|
      format.js
    end
  end
  
  # PUT /sessions/1/cast_shadow
  def shed_light
    @session = Session.find(params[:id])
    
    @session.shed_light(1)
    @session.save
    
    respond_to do |format|
      format.js
    end
  end
end
