class Api::V1::FollowersController < Api::V1::BaseController
  def index
    if params[:user_id]
      followers = User.find(params[:user_id]).followers
    else
      followers = User.all
    end

    followers = followers.where(id: params['ids']) if params['ids']

    if params[:page]
      followers = followers.page(params[:page])
      if params[:per_page]
        followers = followers.per_page(params[:per_page])
      end
    end

    render(
      json: ActiveModel::ArraySerializer.new(
        followers,
        each_serializer: Api::V1::FollowerSerializer,
        root: 'followers',
        meta: meta_attributes(followers)
      )
    )
  end

  def show
    user = User.find_by(id: params[:id])
    return api_error(status: 404) if user.nil?
    #authorize user

    render json: Api::V1::FollowerSerializer.new(user).to_json
  end

  def create
    user = User.new(create_params)
    return api_error(status: 422, errors: user.errors) unless user.valid?

    user.save!

    render(
      json: Api::V1::FollowerSerializer.new(user).to_json,
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
      json: Api::V1::FollowerSerializer.new(user).to_json,
      status: 200,
      location: api_v1_user_path(user.id),
      serializer: Api::V1::FollowerSerializer
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
     params.require(:follower).permit(
       :email, :password, :password_confirmation, :first_name, :last_name
     )
  end

  def update_params
    create_params
  end
end

