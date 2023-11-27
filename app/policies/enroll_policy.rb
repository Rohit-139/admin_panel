class EnrollPolicy < ApplicationPolicy

  def index?
    user.customer?
  end

  def show?
    user.customer?
  end

  def create?
    user.customer?
  end

  def update?
    user.customer?
  end

  def destroy?
    user.customer?
  end

end
