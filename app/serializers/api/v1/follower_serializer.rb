class Api::V1::FollowerSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :name,  :activated, :created_at, :updated_at

  has_many :microposts
  has_many :following
  has_many :followers

end
