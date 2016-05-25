class Api::V1::FollowingController < Api::V1::BaseController
  before_action :load_resource

  #collection
  def index
    auth_following = policy_scope(@following)

    render(
      json: auth_following.collection,
      each_serializer: Api::V1::UserSerializer,
      meta: meta_attributes(auth_following.collection)
    )
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

  def load_resource
    case params[:action].to_sym
    when :index
      @following = paginate(
        apply_filters(User.find(params[:user_id]).following, index_params)
      )
    end
  end

  def index_params
    params[:id] = params[:following_id] if params[:following_id]
    params
  end
end
