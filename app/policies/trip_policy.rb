class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def new?
    true
  end

  def confirmation?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def auto_create?
    true
  end

  def loading?
    true
  end

  def finished?
    true
  end

  def background_create?
    true
  end

  def share_ref?
    true
  end
end
