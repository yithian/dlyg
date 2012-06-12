# Game helper

module GameHelper
  # returns an ajax link to recall a scar for a given dice pool
  def recall_link(game, result, pool)
    pools = {'discipline' => result.discipline, 'exhaustion' => result.exhaustion, 'madness' => result.madness}
    
    escape_javascript(link_to "Recall a scar", recall_game_result_path(game, result, :pool => pool), :method => :put, :remote => true) unless pools[pool].empty?
  end
end
