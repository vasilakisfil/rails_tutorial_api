class Api::V1::BaseController < ApplicationController
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  #before_filter :authenticate_user!
  #after_filter :sign_out_user

  #rescue_from ActiveRecord::RecordNotFound, with: :not_found
  #rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def render_unauthorized
    response.headers['WWW-Authenticate'] = "Token realm=Application"
    render json: { error: 'Bad credentials' }, status: 401
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: {errors: errors}.to_json, status: status
  end

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def user_not_authorized
    render_unauthorized
  end

  def sign_out_user
    sign_out :user
  end

  def meta_attributes(object)
    return {} if params[:page].blank?
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end
end
