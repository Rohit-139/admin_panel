# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.type == "Customer"

      can [:show, :destroy ], Customer, user_id: user
      can :manage, Enroll#, user_id: user.id

    elsif user.type == "Instructor"

      can [:destroy], Instructor
      can [:manage], Program, user_id: user.id

    end
  end
end
