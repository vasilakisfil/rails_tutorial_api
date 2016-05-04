class Api::V1::MicropostSerializer < Api::V1::BaseSerializer
  attributes(*Micropost.attribute_names.map(&:to_sym))

  has_one :user

  def picture
    object.picture.url
  end
end

