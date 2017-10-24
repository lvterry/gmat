class UsersController < ApplicationController
  def update_mobile
    render 'users/update_mobile'
  end

  def update
    user = User.find(params[:id])
    temp_users = TempUser.where(mobile: params[:user][:mobile])
    temp_users.each do |temp_user|
      unless user.user_group_ids.include?(temp_user.user_group_id)
        user.user_groups << UserGroup.find(temp_user.user_group_id)
      end
      temp_user.destroy
    end
    render json: { result: user.update(user_params) }
  end

  private

  def user_params
    params.require(:user).permit(:mobile)
  end
end