class MicropostPolicy < ApplicationPolicy
  def create?
    return Admin.new(record) if user && user.admin?
    return Regular.new(record) if user
    return Guest.new(record)
  end

  def show?
    return Admin.new(record) if user.try(:admin?)
    return Owner.new(record) if user.try(:id) == record.user_id
    return Regular.new(record) if user
    return Guest.new(record)
  end

  def update?
    raise Pundit::NotAuthorizedError unless user

    return Admin.new(record) if user.try(:admin?)
    return Owner.new(record) if user.try(:id) == record.try(:user_id)
    raise Pundit::NotAuthorizedError
  end

  def destroy?
    return Admin.new(record) if user.try(:admin?)
    return Owner.new(record) if user.try(:id) == record.user_id
  end

  class Scope < Scope
    def resolve
      return Admin.new(scope, User) if user.try(:admin?)
      return Regular.new(scope, User) if user
      return Guest.new(scope, User)
    end
  end

  class Admin < DefaultPermissions
  end

  class Owner < Admin
  end

  class Regular < Owner
  end

  class Guest < Regular
  end
end
