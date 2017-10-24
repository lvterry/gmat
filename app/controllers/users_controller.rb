class UsersController < ApplicationController
  include UserHelper

  def update_mobile
    render 'users/update_mobile'
  end

  def update
    user = User.find(params[:id])
    add_groups_to_user(user, params[:user][:mobile])
    render json: { result: user.update(user_params) }
  end

  private

  def user_params
    params.require(:user).permit(:mobile)
  end
end