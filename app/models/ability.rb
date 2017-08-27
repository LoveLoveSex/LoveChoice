class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user && user.administrator?
      can :access, :rails_admin
      can :manage, :all
    end

    if user && user.semi_administrator?
      can :update, Hotel, user_id_to_manage: user.id
      can :read, Hotel
    end

    if user && user.normal?
      can :read, Hotel
    end

  end
end
