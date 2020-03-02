class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def create?
      return true # Anyone can view a task?
    end

    def update?
      record.user == user
    end

    def destroy?
      record.user == user
    end
  end
end
