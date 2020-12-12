class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    user ||= User.new

    if user&.class == User
      can :crud, User, id: user.id
      can :read, Category
      can :read, Subcategory
      can :crud, Order, user_id: user.id
      can :start_execute, Order
      can :confirm, Order, user_id: user.id
      can :show_user, User
    elsif user&.class == Superuser
      can :manage, User
      can :manage, Order
      can :manage, Category
      can :manage, Subcategory

    end
  end
end
