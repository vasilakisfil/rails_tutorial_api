class Api::V1::MicropostsController < Api::V1::BaseController
  before_action :load_resource

  def index
    auth_microposts = policy_scope(@microposts)

    render(
      json: auth_microposts.collection,
      each_serializer: Api::V1::MicropostSerializer,
      #meta: meta_attributes(microposts)
    )
  end

  def show
    auth_micropost = authorize_with_permissions(@micropost)

    render json: auth_micropost.record, serializer: Api::V1::MicropostSerializer.new(micropost)
  end

  def create
    auth_micropost = authorize_with_permissions(@micropost, :create?)

    if @micropost.save
      render json: auth_micropost.record, serializer: Api::V1::MicropostSerializer,
        status: 201
    else
      invalid_resource!(@micropost.errors)
    end
  end

  def update
    auth_micropost = authorize_with_permissions(@micropost)

    if !@micropost.update_attributes(update_permitted_params)
      invalid_resource!(@micropost.errors)
    end

    render json: auth_micropost, serializer: Api::V1::MicropostSerializer
  end

  def destroy
    auth_micropost = authorize_with_permissions(@micropost)

    if !@micropost.destroy
      return api_error(status: 500)
    end

    render json: auth_micropost.record, serializer: Api::V1::UserSerializer
  end

  private

  def load_resource
    case params[:action].to_sym
    when :index
      @micropost = paginage(apply_filters(Micropost.all, index_permitted_params))
    when :show, :update, :destroy
      @micropost = Micropost.find(params[:id])
    when :create
      @micropost = Micropost.new(create_permitted_params)
    end
  end


  def index_params
    params
  end

  def create_params
     params.require(:micropost).permit(
       :content, :picture, :user_id
     )
  end

  def update_params
    create_params
  end
end

