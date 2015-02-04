class Api::V1::FeedController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    return api_error(status: 422, errors: []) if params[:user_id].blank?

    feed_microposts = User.find_by(id: params[:user_id]).feed

    if params[:page]
      feed_microposts = feed_microposts.page(params[:page])
      if params[:per_page]
        feed_microposts = feed_microposts.per_page(params[:per_page])
      end
    end

    render(
      json: ActiveModel::ArraySerializer.new(
        feed_microposts,
        each_serializer: Api::V1::MicropostSerializer,
        root: 'feeds',
        meta: meta_attributes(feed_microposts)
      )
    )
  end
end

