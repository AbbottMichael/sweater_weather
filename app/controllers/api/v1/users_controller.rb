class Api::V1::UsersController < ApplicationController

  def create
    new_user = User.new(user_params)
    if new_user.save
      api_key = new_user.api_keys.create! token: SecureRandom.hex
      render json: UserSerializer.new(new_user), status: :created
    else
      render json: {error: "#{new_user.errors.full_messages.to_sentence}"}, status: :bad_request
    end
  end

  private

  def user_params
    return (render json: { error: 'Must send correct details in the body'}, status: :bad_request) if params[:user].nil?
    user = params[:user]
    user[:email] = user[:email].downcase if !user[:email].nil?
    user[:password] = params[:password]
    user[:password_confirmation] = params[:password_confirmation]
    params.require(:user).
    permit(:email, :password, :password_confirmation)
  end

  # def user_params
  #   x = ActionDispatch::Request.new(response)
  #   params.require(:user).
  #   permit(:email, :password, :password_confirmation)
  # end

  # def user_params
  #   # (render json: { error: 'Must send correct details in the body'}, status: :bad_request)
  #   return if JSON.parse(params[:_json])
  #   params[:body] = JSON.parse(params[:_json])
  #   params.require(:body).
  #   permit(:email, :password, :password_confirmation)
  # end

  # def user_params
  #   # params.require(:_json).
  #   params.permit(:email, :password, :password_confirmation)
  # end

end
