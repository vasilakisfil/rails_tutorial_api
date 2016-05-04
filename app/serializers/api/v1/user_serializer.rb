class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes(*User.attribute_names.map(&:to_sym))

  has_many :microposts
  has_many :following
  has_many :followers
end
