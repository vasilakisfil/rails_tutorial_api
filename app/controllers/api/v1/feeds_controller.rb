class Api::V1::FeedsController < Api::V1::BaseController
  before_action :load_resource

  def show
    auth_microposts_feed = policy_scope(@microposts_feed)

    render(
      json: auth_microposts_feed.collection,
      each_serializer: Api::V1::MicropostSerializer,
      #meta: meta_attributes(microposts)
    )
  end

  def load_resource
    case params[:action].to_sym
    when :show
      @microposts_feed = paginate(apply_filters(
        User.find(params[:user_id]).feed, index_params
      ))
    end
  end

  def index_params
    params.except(:user_id)
  end
end
