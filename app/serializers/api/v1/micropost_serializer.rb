class Api::V1::MicropostSerializer < Api::V1::BaseSerializer
  attributes :id, :content, :created_at, :updated_at

  has_one :user
end

