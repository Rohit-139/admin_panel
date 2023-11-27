class CustomerPolicy < ApplicationPolicy

  def show?
    user.customer?
  end

  def destroy?
    user.customer?
  end

end
