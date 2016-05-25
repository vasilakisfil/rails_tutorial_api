class Api::V1::FollowersController < Api::V1::BaseController
  before_action :load_resource

  #collection
  def index
    auth_followers = policy_scope(@followers)

    render(
      json: auth_followers.collection,
      each_serializer: Api::V1::UserSerializer,
      meta: meta_attributes(auth_followers.collection)
    )
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

  def load_resource
    return invalid_resource!('missing user_id') if params[:user_id].blank?

    case params[:action].to_sym
    when :index
      @followers = paginate(
        apply_filters(User.find(params[:user_id]).followers, index_params)
      )
    end
  end

  def index_params
    params[:id] = params[:follower_id] if params[:follower_id]
    params
  end
end
