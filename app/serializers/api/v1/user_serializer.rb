class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes(*User.attribute_names.map(&:to_sym))

  link(:microposts){
    href api_v1_microposts_path(user_id: object.id)
  }
end
