class InstructorPolicy < ApplicationPolicy

  def destroy?
    user.instructor?
  end

end
