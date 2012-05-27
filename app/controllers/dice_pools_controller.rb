class DicePoolsController < ApplicationController
  respond_to :html, :xml
  
  def roll
    pool = DiceRoller::DicePool.new(0, params[:discipline].to_i)
    @discipline = pool.roll_pool.six_result
    
    pool.num_six = params[:exhaustion].to_i
    @exhaustion = pool.roll_pool.six_result
    
    pool.num_six = params[:madness].to_i
    @madness = pool.roll_pool.six_result
    
    respond_to do |format|
      format.js
    end
  end
end
