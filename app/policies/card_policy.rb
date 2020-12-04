# Pundit policy describing what the current user can do with a Card object
class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user && user.is_admin?
  end

  def update?
    user && user.is_admin?
  end
end
