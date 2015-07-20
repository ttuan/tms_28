class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new

    if user.supervisor?
      can :manage, :all
    else
      can :show, User do |user|
        !user.supervisor?
      end
      can [:edit, :update], User, id: user.id
    end
  end
end
