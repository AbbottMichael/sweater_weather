class Api::V1::UsersController < ApplicationController

  def create
    user = user_params
    user[:email] = user[:email].downcase!
    new_user = User.new(user)
  end

  private

  def user_params
    params.
    require(:user).
    permit(:email, :password, :password_confirmation)
  end
end
