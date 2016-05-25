class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes(*User.attribute_names.map(&:to_sym))
end
