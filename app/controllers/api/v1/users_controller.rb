class Api::V1::UsersController < Api::V1::BaseController
  before_action :load_resource

  def index
    auth_users = policy_scope(@users)

    render(
      json: auth_users.collection,
      each_serializer: Api::V1::UserSerializer
      # meta: meta_attributes(auth_users)
    )
  end

  def show
    auth_user = authorize_with_permissions(@user)

    render json: auth_user.record, serializer: Api::V1::UserSerializer
  end

  def create
    auth_user = authorize_with_permissions(@user, :create?)

    if @user.save
      render json: auth_user.record, serializer: Api::V1::UserSerializer,
        status: 201
    else
      invalid_resource!(@user.errors)
    end
  end

  def update
    auth_user = authorize_with_permissions(@user)

    if !@user.update_attributes(update_params)
      invalid_resource!(@user.errors)
    end

    render json: auth_user, serializer: Api::V1::UserSerializer
  end

  def destroy
    auth_user = authorize_with_permissions(@user)

    if !@user.destroy
      return api_error(status: 500)
    end

    render json: auth_user.record, serializer: Api::V1::UserSerializer
  end

  private

  def load_resource
    case params[:action].to_sym
    when :index
      @users = apply_filters(User.all, index_params)
    when :show, :update, :destroy
      @user = User.find(params[:id])
    when :create
      @user = User.new(create_params)
    end
  end

  def index_params
    params.permit(:email, :name)
  end

  def create_params
    prms = ActiveModelSerializers::Deserialization.jsonapi_parse(params, {
      only: [:email, :name, :password]
    })

    return prms.merge(password_confirmation: prms[:password])
  end

  def update_params
    create_params
  end
end
