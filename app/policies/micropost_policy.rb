class MicropostPolicy < ApplicationPolicy
  def show?
    return true
  end

  def create?
    return true if user.admin?
    return true if record.user_id == user.id
  end

  def update?
    return true if user.admin?
    return true if record.user_id == user.id
  end

  def destroy?
    return true if user.admin?
    return true if record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
