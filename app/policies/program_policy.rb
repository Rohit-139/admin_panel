class ProgramPolicy < ApplicationPolicy

  def index?
    user.instructor?
  end

  def show?
    user.instructor?
  end

  def create?
    user.instructor?
  end

  def update?
    user.instructor?
  end

  def destroy?
    user.instructor?
  end

end
