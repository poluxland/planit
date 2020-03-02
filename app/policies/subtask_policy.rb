class SubtaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def create?
      return true # Anyone can view a subtask?
    end

    def update?
      record.user == user
    end

    def destroy?
      record.user == user
    end
  end
end
