class Api::V1::Links::FollowersController < Api::V1::BaseController
  before_filter :authenticate_user!

  #collection
  def index
    followers = User.find(params[:user_id]).followers

    followers = paginate(followers)

    render(
      json: ActiveModel::ArraySerializer.new(
        followers,
        each_serializer: Api::V1::UserSerializer,
        root: 'followers',
        meta: meta_attributes(followers)
      )
    )
  end

  #collection
  def update
    authorize User.find(params[:user_id])

    User.find(params[:user_id]).followers = params[:follower_ids]

    head status: 204
  end

  #member
  def show
    if User.find(params[:user_id]).followers.find_by(id: params[:id])
      return head status: 204
    else
      return head status: 404
    end
  end

  #member
  def create
    authorize User.find(params[:user_id])

    return head(status: 304) if User.find(params[:user_id]).followers.find_by(id: params[:id])

    User.find(params[:id]).follow(User.find(params[:user_id]))

    head status: 204
  end

  #member
  def destroy
    authorize User.find(params[:user_id])

    unless User.find(params[:user_id]).followers.find_by(id: params[:id])
      return head(status: 304)
    end

    User.find(params[:id]).unfollow(User.find(params[:user_id]))

    head status: 204
  end
end
