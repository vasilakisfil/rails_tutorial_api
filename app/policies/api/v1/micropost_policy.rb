class Api::V1::MicropostPolicy < Api::V1::ApplicationPolicy
  attr_reader :user, :record

  def update?
    return true if record.user.id == user.id
  end

  class Scope < Api::V1::ApplicationPolicy::Scope
  end
end



