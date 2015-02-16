class Api::V1::UserPolicy < Api::V1::ApplicationPolicy
  attr_reader :user, :record

  class Scope < Api::V1::ApplicationPolicy::Scope
  end
end
