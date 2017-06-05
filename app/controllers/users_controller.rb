class UsersController < ApplicationController
  def update_mobile
    render 'users/update_mobile'
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to root_path
    else

    end
  end

  private

  def user_params
    params.require(:user).permit(:mobile)
  end
end