class Api::V1::Links::FollowingController < Api::V1::BaseController
  before_filter :authenticate_user!

  #collection
  def index
    following = User.find(params[:user_id]).following

    following = paginate(following)

    render(
      json: ActiveModel::ArraySerializer.new(
        following,
        each_serializer: Api::V1::UserSerializer,
        root: 'following',
        meta: meta_attributes(following)
      )
    )
  end

  #collection
  def update
    authorize User.find(params[:user_id])

    User.find(params[:user_id]).following = params[:following_ids]

    head status: 204
  end

  #member
  def show
    if User.find(params[:user_id]).following.find_by(id: params[:id])
      return head status: 204
    else
      return head status: 404
    end
  end

  #member
  def create
    authorize User.find(params[:user_id])

    return head(status: 304) if User.find(params[:user_id]).following.find_by(id: params[:id])

    User.find(params[:user_id]).follow(User.find(params[:id]))

    head status: 204
  end

  #member
  def destroy
    authorize User.find(params[:user_id])

    unless User.find(params[:user_id]).following.find_by(id: params[:id])
      return head(status: 304)
    end

    User.find(params[:user_id]).unfollow(User.find(params[:id]))

    head status: 204
  end
end
