class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user.nil?
      render json: {error: "User does not exist"}, status: :not_found
    elsif user.authenticate(session_params[:password])
      render json: UserSerializer.new(user), status: :created
    else
      render json: {error: "#{user.errors.full_messages.to_sentence}"}, status: :bad_request
    end
  end

  private

  def session_params
    params.require(:session).
    permit(:email, :password)
  end
end
