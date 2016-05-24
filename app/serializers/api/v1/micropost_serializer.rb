class Api::V1::MicropostSerializer < Api::V1::BaseSerializer
  attributes(*Micropost.attribute_names.map(&:to_sym))

  belongs_to :user, serializer: Api::V1::UserSerializer

  def picture
    object.picture.url
  end
end

