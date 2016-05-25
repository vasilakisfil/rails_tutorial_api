class Api::V1::MicropostsController < Api::V1::BaseController
  before_action :load_resource

  def index
    auth_microposts = policy_scope(@microposts)

    render(
      json: auth_microposts.collection,
      each_serializer: Api::V1::MicropostSerializer,
      include: ['*']
      #meta: meta_attributes(microposts)
    )
  end

  def show
    auth_micropost = authorize_with_permissions(@micropost)

    render json: auth_micropost.record, serializer: Api::V1::MicropostSerializer,
      include: ['*']
  end

  def create
    auth_micropost = authorize_with_permissions(@micropost, :create?)

    if @micropost.save
      render json: auth_micropost.record, serializer: Api::V1::MicropostSerializer,
        status: 201, include: ['*']
    else
      invalid_resource!(@micropost.errors)
    end
  end

  def update
    auth_micropost = authorize_with_permissions(@micropost)

    if @micropost.update_attributes(update_params)
      render json: auth_micropost.record, serializer: Api::V1::MicropostSerializer,
        include: ['*']
    else
      invalid_resource!(@micropost.errors)
    end
  end

  def destroy
    auth_micropost = authorize_with_permissions(@micropost)

    if !@micropost.destroy
      return api_error(status: 500)
    end

    render json: auth_micropost.record, serializer: Api::V1::UserSerializer,
      include: ['*']
  end

  private

  def load_resource
    params[:page] = params[:page].to_i if params[:page]
    params[:per_page] = params[:per_page].to_i if params[:per_page]

    case params[:action].to_sym
    when :index
      @microposts = paginate(apply_filters(Micropost.all, index_params))
    when :show, :update, :destroy
      @micropost = Micropost.find(params[:id])
    when :create
      @micropost = Micropost.new(create_params)
    end
  end


  def index_params
    params
  end

  def create_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, {
      only: [:content, :picture]
    }).merge(user_id: current_user.id)
  end

  def update_params
    create_params
  end
end

