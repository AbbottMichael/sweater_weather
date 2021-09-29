class Api::V1::SessionsController < ApplicationController

  def create
    begin
      if session_params[:email].nil? || session_params[:password].nil?
        return (render json: {error: "Must provide an email and a password"}, status: :bad_request)
      end
    rescue => e
      return (render json: {error: "Must provide login details in the body"}, status: :bad_request)
    end

    user = User.find_by(email: session_params[:email].downcase)

    if user.nil?
      render json: {error: "The information does not match any records"}, status: :not_found
    elsif user.authenticate(session_params[:password])
      render json: UserSerializer.new(user), status: :ok
    else
      render json: {error: "The information does not match any records"}, status: :not_found
    end
  end

  private

  def session_params
    params.require(:session).
      permit(:email, :password)
  end
end
