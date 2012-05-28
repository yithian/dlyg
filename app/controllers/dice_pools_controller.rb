class DicePoolsController < ApplicationController
  respond_to :html, :xml
  
  def roll
    @strength = 0
    @pain = 0
    discipline_strength = 0
    exhaustion_strength = 0
    madness_strength = 0
    pain_strength = 0
    
    pool = DiceRoller::DicePool.new(0, params[:discipline].to_i)
    discipline = pool.roll_pool.six_result.sort
    discipline_strength = 0

    discipline.each do |d|
      if d <= 3
        @strength += 1
        discipline_strength += 1
      end
    end
    
    pool.num_six = params[:exhaustion].to_i
    exhaustion = pool.roll_pool.six_result.sort
    exhaustion_strength = 0
    
    exhaustion.each do |e|
      if e <= 3
        @strength += 1
        exhaustion_strength += 1
      end
    end
    
    pool.num_six = params[:madness].to_i
    madness = pool.roll_pool.six_result.sort
    madness_strength = 0
    
    madness.each do |m|
      if m <= 3
        @strength += 1
        madness_strength += 1
      end
    end
    
    pool.num_six = params[:pain].to_i
    pain = pool.roll_pool.six_result.sort
    pain_strength = 0
    
    pain.each do |p|
      if p <= 3
        pain_strength += 1
      end
    end
    
    successes = {discipline_strength => :discipline, exhaustion_strength => :exhaustion, madness_strength => :exhaustion, pain_strength => :pain}
    
    @wins = successes[successes.keys.max]
    
    dominant = {discipline.sort.reverse => :discipline, exhaustion.sort.reverse => :exhaustion, madness.sort.reverse => :madness, pain.sort.reverse => :pain}
    
    @dominating = dominant[dominant.keys.max]
    
    respond_to do |format|
      format.js
    end
  end
end
