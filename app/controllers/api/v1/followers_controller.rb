class Api::V1::FollowersController < Api::V1::BaseController
  def index
    return api_error(status: 422, errors: []) if params[:user_id].blank?

    followers = User.find(params[:user_id]).followers
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
    follower = User.find_by(id: params[:id])
    return api_error(status: 404) if follower.nil?
    #authorize user

    render json: Api::V1::FollowerSerializer.new(follower).to_json
  end
=begin
  def create
    return api_error(status: 422, errors: []) if params[:user_id].blank?
    follower = User.find(params[:id])
    user = User.find(params[:user_id])

    follower.follow(user)

    render(
      json: Api::V1::FollowerSerializer.new(follower).to_json,
      status: 201,
      location: api_v1_follower_path(follower.id)
    )
  end

  def destroy
    follower = User.find_by(id: params[:id])
    return api_error(status: 404) if follower.nil?
    #authorize user

    if !follower.destroy
      return api_error(status: 500)
    end

    head status: 204
  end
=end

end

