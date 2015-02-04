class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.find_by(email: create_params[:email])
    if user && user.authenticate(create_params[:password])
      self.current_user = user
      data = {
        token: current_user.authentication_token,
        user_email: current_user.email,
        user_id: current_user.id
      }

      render json: data, status: 201
    else
      return api_error(status: 401)
    end
  end

  private
  def create_params
    params.require(:user).permit(:email, :password)
  end
end


