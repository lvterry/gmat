class TempUsersController < ApplicationController

  layout 'mobile'

  def create
    @temp_user = TempUser.create temp_user_params
    redirect_to temp_user_path(@temp_user)
  end

  def show
    @temp_user = TempUser.find params[:id]
    @user_group = UserGroup.find @temp_user.user_group_id
  end

  private

  def temp_user_params
    params.require(:temp_user)
      .permit(:name, :mobile, :user_group_id)
  end

end
