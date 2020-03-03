class SubtaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true # Anyone can view a subtask?
  end

  def update?
    record.task.trip.user == user
  end

  def destroy?
    record.task.trip.user == user
  end
end
