class Api::V1::UsersController < Api::V1::BaseController
  def index
    users = User.all

    users = users.where(id: params['ids']) if params['ids']

    if params[:page]
      users = users.page(params[:page])
      if params[:per_page]
        users = users.per_page(params[:per_page])
      end
    end

    render(
      json: ActiveModel::ArraySerializer.new(
        users,
        each_serializer: Api::V1::UserSerializer,
        root: 'users',
        meta: meta_attributes(users)
      )
    )
  end

  def show
    user = User.find_by(id: params[:id])
    return api_error(status: 404) if user.nil?
    #authorize user

    render json: Api::V1::UserSerializer.new(user).to_json
  end

  def create
    user = User.new(create_params)
    return api_error(status: 422, errors: user.errors) unless user.valid?

    user.save!

    render(
      json: Api::V1::UserSerializer.new(user).to_json,
      status: 201,
      location: api_v1_user_path(user.id)
    )
  end

  def update
    user = User.find_by(id: params[:id])
    return api_error(status: 404) if user.nil?
    #authorize user

    if !user.update_attributes(update_params)
      return api_error(status: 422, errors: user.errors)
    end

    render(
      json: Api::V1::UserSerializer.new(user).to_json,
      status: 200,
      location: api_v1_user_path(user.id),
      serializer: Api::V1::UserSerializer
    )
  end

  def destroy
    user = User.find_by(id: params[:id])
    return api_error(status: 404) if user.nil?
    #authorize user

    if !user.destroy
      return api_error(status: 500)
    end

    head status: 204
  end

  private

  def create_params
     params.require(:user).permit(
       :email, :password, :password_confirmation, :name
     )
  end

  def update_params
    create_params
  end
end
