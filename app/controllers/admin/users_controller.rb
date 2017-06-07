class Admin::UsersController < AdminController

  def index
    @users = User.all
  end

  def edit
    @user = User.find params[:id]
    @difficulties = Label.where(category: '难度')
    @subjects = Label.where(category: '题型')
    @books = Label.where(category: '来源')
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = '保存成功'
    redirect_to edit_admin_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:valid_to, {:label_ids => []})
  end

end
