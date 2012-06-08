class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    # actions only GMs can do
    can :invite, Game, :gm_id => user.id
    can :uninvite, Game, :gm_id => user.id
    can :manage, Game, :gm_id => user.id
    can :cast_shadow, Game, :gm_id => user.id
    can :destroy, Result do |r|
      r.game.gm_id == user.id
    end
    can :manage, Play do |p|
      p.game.gm_id == user.id
    end
    
    # actions players can do
    can :shed_light, Game do |g|
      g.players.each.collect.include?(user)
    end
    can :roll_dice, Game do |g|
      g.players.each.collect.include?(user)
    end
    can :update, Play, :user_id => user.id
    can :destroy, Play, :user_id => user.id
    
    # all logged-in users
    can :create, Game if user.id
    
    # anyone else
    can :read, :all

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
